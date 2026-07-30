package price

import (
	"testing"
	"time"
)

func TestUpdateNowBroadcastsAndStoresTick(t *testing.T) {
	service := New(2.853, time.Minute, 1)
	updates, unsubscribe := service.Subscribe()
	defer unsubscribe()

	got := service.UpdateNow()

	select {
	case broadcast := <-updates:
		if broadcast != got {
			t.Fatalf("broadcast = %#v, want %#v", broadcast, got)
		}
	case <-time.After(time.Second):
		t.Fatal("timed out waiting for price update")
	}
	if got.Symbol != Symbol {
		t.Fatalf("symbol = %q, want %q", got.Symbol, Symbol)
	}
	if len(service.History()) != 2 {
		t.Fatalf("history length = %d, want 2", len(service.History()))
	}
}

func TestHistoryReturnsCopy(t *testing.T) {
	service := New(2.853, time.Minute, 1)
	history := service.History()
	history[0].Price = 99

	if service.History()[0].Price == 99 {
		t.Fatal("History exposed internal storage")
	}
}
