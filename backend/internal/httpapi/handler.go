package httpapi

import (
	"log"
	"net/http"
	"time"

	"gas-pulse/backend/internal/cache"
	"gas-pulse/backend/internal/gold"
	"gas-pulse/backend/internal/oil"
	"gas-pulse/backend/internal/price"
	"gas-pulse/backend/internal/stock"

	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

const oilHistoryCacheKey = "oil:history"

type Handler struct {
	prices   *price.Service
	stocks   *stock.Service
	gold     *gold.Service
	oil      *oil.Service
	cache    cache.HistoryCache
	useRedis bool
	redisTTL time.Duration
	upgrader websocket.Upgrader
}

type HandlerDeps struct {
	Prices   *price.Service
	Stocks   *stock.Service
	Gold     *gold.Service
	Oil      *oil.Service
	Cache    cache.HistoryCache
	UseRedis bool
	RedisTTL time.Duration
}

func NewHandler(deps HandlerDeps) *Handler {
	ttl := deps.RedisTTL
	if ttl <= 0 {
		ttl = 30 * time.Second
	}
	return &Handler{
		prices:   deps.Prices,
		stocks:   deps.Stocks,
		gold:     deps.Gold,
		oil:      deps.Oil,
		cache:    deps.Cache,
		useRedis: deps.UseRedis,
		redisTTL: ttl,
		upgrader: websocket.Upgrader{
			CheckOrigin: func(*http.Request) bool {
				// Development API. Restrict origins before exposing it publicly.
				return true
			},
		},
	}
}

func (h *Handler) Register(e *echo.Echo) {
	e.GET("/health", h.health)
	e.GET("/api/price", h.currentPrice)
	e.GET("/api/history", h.history)
	e.GET("/ws/price", h.priceStream)
	e.GET("/api/stocks", h.currentStocks)
	e.GET("/ws/stocks", h.stockStream)
	e.GET("/api/gold", h.currentGold)
	e.GET("/api/gold/history", h.goldHistory)
	e.GET("/ws/gold", h.goldStream)
	e.GET("/api/oil", h.currentOil)
	e.GET("/api/oil/history", h.oilHistory)
	e.GET("/ws/oil", h.oilStream)
}

func (h *Handler) currentStocks(c echo.Context) error {
	return c.JSON(http.StatusOK, h.stocks.Current())
}

func (h *Handler) health(c echo.Context) error {
	return c.JSON(http.StatusOK, map[string]string{"status": "ok"})
}

func (h *Handler) stockStream(c echo.Context) error {
	connection, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return err
	}
	defer connection.Close()

	updates, unsubscribe := h.stocks.Subscribe()
	defer unsubscribe()
	if err := connection.WriteJSON(h.stocks.Current()); err != nil {
		return nil
	}

	disconnected := make(chan struct{})
	go func() {
		defer close(disconnected)
		for {
			if _, _, err := connection.ReadMessage(); err != nil {
				return
			}
		}
	}()

	heartbeat := time.NewTicker(30 * time.Second)
	defer heartbeat.Stop()
	for {
		select {
		case snapshot, ok := <-updates:
			if !ok {
				return nil
			}
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteJSON(snapshot); err != nil {
				return nil
			}
		case <-heartbeat.C:
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteMessage(websocket.PingMessage, nil); err != nil {
				return nil
			}
		case <-disconnected:
			return nil
		case <-c.Request().Context().Done():
			return nil
		}
	}
}

func (h *Handler) currentPrice(c echo.Context) error {
	return c.JSON(http.StatusOK, h.prices.Current())
}

func (h *Handler) history(c echo.Context) error {
	return c.JSON(http.StatusOK, h.prices.History())
}

func (h *Handler) currentGold(c echo.Context) error {
	return c.JSON(http.StatusOK, h.gold.Current())
}

func (h *Handler) goldHistory(c echo.Context) error {
	return c.JSON(http.StatusOK, h.gold.History())
}

func (h *Handler) currentOil(c echo.Context) error {
	return c.JSON(http.StatusOK, h.oil.Current())
}

func (h *Handler) oilHistory(c echo.Context) error {
	noCache := c.QueryParam("no_cache") == "true"

	if !h.useRedis || h.cache == nil {
		c.Response().Header().Set("X-Cache", "DISABLED")
		return c.JSON(http.StatusOK, h.oil.History())
	}
	if noCache {
		c.Response().Header().Set("X-Cache", "BYPASS")
		return c.JSON(http.StatusOK, h.oil.History())
	}

	if raw, ok := h.cache.Get(c.Request().Context(), oilHistoryCacheKey); ok {
		c.Response().Header().Set("X-Cache", "HIT")
		return c.Blob(http.StatusOK, "application/json", raw)
	}

	ticks := h.oil.History()
	if err := h.cache.SetJSON(c.Request().Context(), oilHistoryCacheKey, ticks, h.redisTTL); err != nil {
		log.Printf("oil history cache set failed: %v", err)
	}
	c.Response().Header().Set("X-Cache", "MISS")
	return c.JSON(http.StatusOK, ticks)
}

func (h *Handler) goldStream(c echo.Context) error {
	connection, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return err
	}
	defer connection.Close()

	updates, unsubscribe := h.gold.Subscribe()
	defer unsubscribe()

	if err := connection.WriteJSON(h.gold.Current()); err != nil {
		return nil
	}

	disconnected := make(chan struct{})
	go func() {
		defer close(disconnected)
		for {
			if _, _, err := connection.ReadMessage(); err != nil {
				return
			}
		}
	}()

	heartbeat := time.NewTicker(30 * time.Second)
	defer heartbeat.Stop()

	for {
		select {
		case tick, ok := <-updates:
			if !ok {
				return nil
			}
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteJSON(tick); err != nil {
				return nil
			}
		case <-heartbeat.C:
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteMessage(websocket.PingMessage, nil); err != nil {
				return nil
			}
		case <-disconnected:
			return nil
		case <-c.Request().Context().Done():
			return nil
		}
	}
}

func (h *Handler) oilStream(c echo.Context) error {
	connection, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return err
	}
	defer connection.Close()

	updates, unsubscribe := h.oil.Subscribe()
	defer unsubscribe()

	if err := connection.WriteJSON(h.oil.Current()); err != nil {
		return nil
	}

	disconnected := make(chan struct{})
	go func() {
		defer close(disconnected)
		for {
			if _, _, err := connection.ReadMessage(); err != nil {
				return
			}
		}
	}()

	heartbeat := time.NewTicker(30 * time.Second)
	defer heartbeat.Stop()

	for {
		select {
		case tick, ok := <-updates:
			if !ok {
				return nil
			}
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteJSON(tick); err != nil {
				return nil
			}
		case <-heartbeat.C:
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteMessage(websocket.PingMessage, nil); err != nil {
				return nil
			}
		case <-disconnected:
			return nil
		case <-c.Request().Context().Done():
			return nil
		}
	}
}

func (h *Handler) priceStream(c echo.Context) error {
	connection, err := h.upgrader.Upgrade(c.Response(), c.Request(), nil)
	if err != nil {
		return err
	}
	defer connection.Close()

	updates, unsubscribe := h.prices.Subscribe()
	defer unsubscribe()

	if err := connection.WriteJSON(h.prices.Current()); err != nil {
		return nil
	}

	disconnected := make(chan struct{})
	go func() {
		defer close(disconnected)
		for {
			if _, _, err := connection.ReadMessage(); err != nil {
				return
			}
		}
	}()

	heartbeat := time.NewTicker(30 * time.Second)
	defer heartbeat.Stop()

	for {
		select {
		case tick, ok := <-updates:
			if !ok {
				return nil
			}
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteJSON(tick); err != nil {
				return nil
			}
		case <-heartbeat.C:
			_ = connection.SetWriteDeadline(time.Now().Add(5 * time.Second))
			if err := connection.WriteMessage(websocket.PingMessage, nil); err != nil {
				return nil
			}
		case <-disconnected:
			return nil
		case <-c.Request().Context().Done():
			return nil
		}
	}
}
