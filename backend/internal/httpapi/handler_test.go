package httpapi

import (
	"context"
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"sync"
	"testing"
	"time"

	"gas-pulse/backend/internal/gold"
	"gas-pulse/backend/internal/oil"
	"gas-pulse/backend/internal/price"
	"gas-pulse/backend/internal/stock"

	"github.com/labstack/echo/v4"
)

type memoryCache struct {
	mu   sync.Mutex
	data map[string][]byte
}

func newMemoryCache() *memoryCache {
	return &memoryCache{data: make(map[string][]byte)}
}

func (m *memoryCache) Get(_ context.Context, key string) ([]byte, bool) {
	m.mu.Lock()
	defer m.mu.Unlock()
	raw, ok := m.data[key]
	if !ok {
		return nil, false
	}
	return append([]byte(nil), raw...), true
}

func (m *memoryCache) SetJSON(_ context.Context, key string, value any, _ time.Duration) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return err
	}
	m.mu.Lock()
	m.data[key] = raw
	m.mu.Unlock()
	return nil
}

func testHandler(t *testing.T, useRedis bool, cacheStore *memoryCache) *echo.Echo {
	t.Helper()
	e := echo.New()
	NewHandler(HandlerDeps{
		Prices:   price.New(2.853, time.Minute, 1),
		Stocks:   stock.New(time.Minute, 1),
		Gold:     gold.New(2650.00, time.Minute, 2),
		Oil:      oil.New(78.50, time.Minute, 3),
		Cache:    cacheStore,
		UseRedis: useRedis,
		RedisTTL: 30 * time.Second,
	}).Register(e)
	return e
}

func TestCurrentPrice(t *testing.T) {
	e := testHandler(t, false, nil)
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
	e := testHandler(t, false, nil)
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

func TestCurrentGold(t *testing.T) {
	e := testHandler(t, false, nil)
	request := httptest.NewRequest(http.MethodGet, "/api/gold", nil)
	recorder := httptest.NewRecorder()

	e.ServeHTTP(recorder, request)

	if recorder.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusOK)
	}
	var got gold.Tick
	if err := json.Unmarshal(recorder.Body.Bytes(), &got); err != nil {
		t.Fatal(err)
	}
	if got.Symbol != gold.Symbol {
		t.Fatalf("symbol = %q, want %q", got.Symbol, gold.Symbol)
	}
}

func TestCurrentOil(t *testing.T) {
	e := testHandler(t, false, nil)
	request := httptest.NewRequest(http.MethodGet, "/api/oil", nil)
	recorder := httptest.NewRecorder()

	e.ServeHTTP(recorder, request)

	if recorder.Code != http.StatusOK {
		t.Fatalf("status = %d, want %d", recorder.Code, http.StatusOK)
	}
	var got oil.Tick
	if err := json.Unmarshal(recorder.Body.Bytes(), &got); err != nil {
		t.Fatal(err)
	}
	if got.Symbol != oil.Symbol {
		t.Fatalf("symbol = %q, want %q", got.Symbol, oil.Symbol)
	}
}

func TestOilHistoryCacheHeaders(t *testing.T) {
	t.Run("disabled", func(t *testing.T) {
		e := testHandler(t, false, nil)
		request := httptest.NewRequest(http.MethodGet, "/api/oil/history", nil)
		recorder := httptest.NewRecorder()
		e.ServeHTTP(recorder, request)
		if recorder.Header().Get("X-Cache") != "DISABLED" {
			t.Fatalf("X-Cache = %q, want DISABLED", recorder.Header().Get("X-Cache"))
		}
	})

	t.Run("bypass", func(t *testing.T) {
		store := newMemoryCache()
		e := testHandler(t, true, store)
		request := httptest.NewRequest(http.MethodGet, "/api/oil/history?no_cache=true", nil)
		recorder := httptest.NewRecorder()
		e.ServeHTTP(recorder, request)
		if recorder.Header().Get("X-Cache") != "BYPASS" {
			t.Fatalf("X-Cache = %q, want BYPASS", recorder.Header().Get("X-Cache"))
		}
		if len(store.data) != 0 {
			t.Fatal("bypass must not write cache")
		}
	})

	t.Run("miss then hit", func(t *testing.T) {
		store := newMemoryCache()
		e := testHandler(t, true, store)

		missReq := httptest.NewRequest(http.MethodGet, "/api/oil/history", nil)
		missRec := httptest.NewRecorder()
		e.ServeHTTP(missRec, missReq)
		if missRec.Header().Get("X-Cache") != "MISS" {
			t.Fatalf("first X-Cache = %q, want MISS", missRec.Header().Get("X-Cache"))
		}

		hitReq := httptest.NewRequest(http.MethodGet, "/api/oil/history", nil)
		hitRec := httptest.NewRecorder()
		e.ServeHTTP(hitRec, hitReq)
		if hitRec.Header().Get("X-Cache") != "HIT" {
			t.Fatalf("second X-Cache = %q, want HIT", hitRec.Header().Get("X-Cache"))
		}
	})
}
