package httpapi

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"testing"
	"time"

	"gas-pulse/backend/internal/price"
	"gas-pulse/backend/internal/stock"

	"github.com/labstack/echo/v4"
)

func TestCurrentPrice(t *testing.T) {
	e := echo.New()
	service := price.New(2.853, time.Minute, 1)
	NewHandler(service, stock.New(time.Minute, 1)).Register(e)
	request := httptest.NewRequest(http.MethodGet, "/api/price", nil)
	recorder := httptest.NewRecorder()

	e.ServeHTTP(recorder, request)

	if recorder.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusOK)
	}
	var got price.Tick
	if err := json.Unmarshal(recorder.Body.Bytes(), &got); err != nil {
		t.Fatal(err)
	}
	if got.Symbol != price.Symbol {
		t.Fatalf("symbol = %q, want %q", got.Symbol, price.Symbol)
	}
}

func TestCurrentStocks(t *testing.T) {
	e := echo.New()
	prices := price.New(2.853, time.Minute, 1)
	stocks := stock.New(time.Minute, 1)
	NewHandler(prices, stocks).Register(e)
	request := httptest.NewRequest(http.MethodGet, "/api/stocks", nil)
	recorder := httptest.NewRecorder()

	e.ServeHTTP(recorder, request)

	if recorder.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusOK)
	}
	var got stock.Snapshot
	if err := json.Unmarshal(recorder.Body.Bytes(), &got); err != nil {
		t.Fatal(err)
	}
	if got.Market != "TSE-DEMO" || len(got.Quotes) != 6 {
		t.Fatalf("unexpected snapshot: %#v", got)
	}
}
