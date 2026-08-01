package main

import (
	"context"
	"errors"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"strings"
	"syscall"
	"time"

	"gas-pulse/backend/internal/cache"
	"gas-pulse/backend/internal/gold"
	"gas-pulse/backend/internal/httpapi"
	"gas-pulse/backend/internal/oil"
	"gas-pulse/backend/internal/price"
	"gas-pulse/backend/internal/stock"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	interval := envDuration("PRICE_UPDATE_INTERVAL", time.Minute)
	initialPrice := envFloat("INITIAL_PRICE", 2.853)
	goldInitialPrice := envFloat("GOLD_INITIAL_PRICE", 2650.00)
	oilInitialPrice := envFloat("OIL_INITIAL_PRICE", 78.50)
	port := envString("PORT", "8080")
	useRedis := envBool("USE_REDIS", false)
	redisAddr := envString("REDIS_ADDR", "localhost:6379")
	redisTTL := envDuration("REDIS_TTL", 30*time.Second)

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	seed := time.Now().UnixNano()
	prices := price.New(initialPrice, interval, seed)
	stocks := stock.New(interval, seed+1)
	goldSvc := gold.New(goldInitialPrice, interval, seed+2)
	oilSvc := oil.New(oilInitialPrice, interval, seed+3)
	go prices.Run(ctx)
	go stocks.Run(ctx)
	go goldSvc.Run(ctx)
	go oilSvc.Run(ctx)

	var historyCache cache.HistoryCache
	if useRedis {
		redisCache, err := cache.NewRedisCache(redisAddr)
		if err != nil {
			log.Printf("redis init error: %v; continuing without cache", err)
		} else {
			historyCache = redisCache
			defer redisCache.Close()
		}
	}

	e := echo.New()
	e.HideBanner = true
	e.Use(middleware.Recover(), middleware.Logger())
	httpapi.NewHandler(httpapi.HandlerDeps{
		Prices:   prices,
		Stocks:   stocks,
		Gold:     goldSvc,
		Oil:      oilSvc,
		Cache:    historyCache,
		UseRedis: useRedis && historyCache != nil,
		RedisTTL: redisTTL,
	}).Register(e)

	go func() {
		log.Printf(
			"gas price API listening on http://localhost:%s (update interval: %s, use_redis: %v)",
			port,
			interval,
			useRedis && historyCache != nil,
		)
		if err := e.Start(":" + port); err != nil && !errors.Is(err, http.ErrServerClosed) {
			log.Fatalf("server error: %v", err)
		}
	}()

	<-ctx.Done()
	shutdownCtx, cancel := context.WithTimeout(context.Background(), 10*time.Second)
	defer cancel()
	if err := e.Shutdown(shutdownCtx); err != nil {
		log.Printf("shutdown error: %v", err)
	}
}

func envString(key, fallback string) string {
	if value := os.Getenv(key); value != "" {
		return value
	}
	return fallback
}

func envDuration(key string, fallback time.Duration) time.Duration {
	value := os.Getenv(key)
	if value == "" {
		return fallback
	}
	duration, err := time.ParseDuration(value)
	if err != nil || duration <= 0 {
		log.Printf("invalid %s=%q; using %s", key, value, fallback)
		return fallback
	}
	return duration
}

func envFloat(key string, fallback float64) float64 {
	value := os.Getenv(key)
	if value == "" {
		return fallback
	}
	number, err := strconv.ParseFloat(value, 64)
	if err != nil || number <= 0 {
		log.Printf("invalid %s=%q; using %.3f", key, value, fallback)
		return fallback
	}
	return number
}

func envBool(key string, fallback bool) bool {
	value := strings.TrimSpace(os.Getenv(key))
	if value == "" {
		return fallback
	}
	parsed, err := strconv.ParseBool(value)
	if err != nil {
		log.Printf("invalid %s=%q; using %v", key, value, fallback)
		return fallback
	}
	return parsed
}
