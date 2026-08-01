package oil

import (
	"testing"
	"time"
)

func TestUpdateNowBroadcastsAndStoresTick(t *testing.T) {
	service := New(78.50, time.Minute, 1)
	updates, unsubscribe := service.Subscribe()
	defer unsubscribe()

	got := service.UpdateNow()

	select {
	case broadcast := <-updates:
		if broadcast != got {
			t.Fatalf("broadcast = %#v, want %#v", broadcast, got)
		}
	case <-time.After(time.Second):
		t.Fatal("timed out waiting for oil price update")
	}
	if got.Symbol != Symbol {
		t.Fatalf("symbol = %q, want %q", got.Symbol, Symbol)
	}
	if len(service.History()) != 2 {
		t.Fatalf("history length = %d, want 2", len(service.History()))
	}
}

func TestHistoryReturnsCopy(t *testing.T) {
	service := New(78.50, time.Minute, 1)
	history := service.History()
	history[0].Price = 99

	if service.History()[0].Price == 99 {
		t.Fatal("History exposed internal storage")
	}
}

func TestUpdateNowClampsToBounds(t *testing.T) {
	service := New(minPrice, time.Minute, 7)
	service.current.Price = minPrice
	for i := 0; i < 1000; i++ {
		tick := service.UpdateNow()
		if tick.Price < minPrice || tick.Price > maxPrice {
			t.Fatalf("price = %v, want within [%v, %v]", tick.Price, minPrice, maxPrice)
		}
	}

	service.current.Price = maxPrice
	for i := 0; i < 1000; i++ {
		tick := service.UpdateNow()
		if tick.Price < minPrice || tick.Price > maxPrice {
			t.Fatalf("price = %v, want within [%v, %v]", tick.Price, minPrice, maxPrice)
		}
	}
}
