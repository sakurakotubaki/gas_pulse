package httpapi

import (
	"net/http"
	"time"

	"gas-pulse/backend/internal/price"
	"gas-pulse/backend/internal/stock"

	"github.com/gorilla/websocket"
	"github.com/labstack/echo/v4"
)

type Handler struct {
	prices   *price.Service
	stocks   *stock.Service
	upgrader websocket.Upgrader
}

func NewHandler(prices *price.Service, stocks *stock.Service) *Handler {
	return &Handler{
		prices: prices,
		stocks: stocks,
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
