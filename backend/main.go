package main

import (
	"context"
	"errors"
	"log"
	"net/http"
	"os"
	"os/signal"
	"strconv"
	"syscall"
	"time"

	"gas-pulse/backend/internal/httpapi"
	"gas-pulse/backend/internal/price"
	"gas-pulse/backend/internal/stock"

	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

func main() {
	interval := envDuration("PRICE_UPDATE_INTERVAL", time.Minute)
	initialPrice := envFloat("INITIAL_PRICE", 2.853)
	port := envString("PORT", "8080")

	ctx, stop := signal.NotifyContext(context.Background(), os.Interrupt, syscall.SIGTERM)
	defer stop()

	prices := price.New(initialPrice, interval, time.Now().UnixNano())
	stocks := stock.New(interval, time.Now().UnixNano()+1)
	go prices.Run(ctx)
	go stocks.Run(ctx)

	e := echo.New()
	e.HideBanner = true
	e.Use(middleware.Recover(), middleware.Logger())
	httpapi.NewHandler(prices, stocks).Register(e)

	go func() {
		log.Printf("gas price API listening on http://localhost:%s (update interval: %s)", port, interval)
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
