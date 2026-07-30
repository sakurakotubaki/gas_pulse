package stock

import (
	"testing"
	"time"
)

func TestUpdateNowBroadcastsStockSnapshot(t *testing.T) {
	service := New(time.Minute, 1)
	updates, unsubscribe := service.Subscribe()
	defer unsubscribe()

	got := service.UpdateNow()

	if got.Market != "TSE-DEMO" {
		t.Fatalf("market = %q, want TSE-DEMO", got.Market)
	}
	if len(got.Quotes) != 6 {
		t.Fatalf("quotes = %d, want 6", len(got.Quotes))
	}
	select {
	case broadcast := <-updates:
		if len(broadcast.Quotes) != len(got.Quotes) {
			t.Fatalf("broadcast quotes = %d, want %d", len(broadcast.Quotes), len(got.Quotes))
		}
	case <-time.After(time.Second):
		t.Fatal("timed out waiting for stock update")
	}
}
