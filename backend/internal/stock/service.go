package stock

import (
	"context"
	"math"
	"math/rand"
	"sync"
	"time"
)

type Direction string

const (
	Up    Direction = "UP"
	Down  Direction = "DOWN"
	Equal Direction = "EQUAL"
)

type Quote struct {
	Symbol        string    `json:"symbol"`
	Name          string    `json:"name"`
	Price         float64   `json:"price"`
	Change        float64   `json:"change"`
	ChangePercent float64   `json:"changePercent"`
	Direction     Direction `json:"direction"`
}

type Snapshot struct {
	Market    string  `json:"market"`
	Timestamp int64   `json:"timestamp"`
	Quotes    []Quote `json:"quotes"`
}

type instrument struct {
	symbol    string
	name      string
	openPrice float64
	price     float64
}

type Service struct {
	mu          sync.RWMutex
	instruments []instrument
	current     Snapshot
	subscribers map[chan Snapshot]struct{}
	rng         *rand.Rand
	interval    time.Duration
	now         func() time.Time
}

func New(interval time.Duration, seed int64) *Service {
	if interval <= 0 {
		interval = time.Minute
	}
	instruments := []instrument{
		{symbol: "7203", name: "TOYOTA", openPrice: 2850, price: 2850},
		{symbol: "6758", name: "SONY GROUP", openPrice: 3420, price: 3420},
		{symbol: "8306", name: "MUFG", openPrice: 1985, price: 1985},
		{symbol: "9984", name: "SOFTBANK G", openPrice: 4280, price: 4280},
		{symbol: "9983", name: "FAST RETAILING", openPrice: 48200, price: 48200},
		{symbol: "7974", name: "NINTENDO", openPrice: 12180, price: 12180},
	}
	service := &Service{
		instruments: instruments,
		subscribers: make(map[chan Snapshot]struct{}),
		rng:         rand.New(rand.NewSource(seed)),
		interval:    interval,
		now:         time.Now,
	}
	service.current = service.snapshot()
	return service
}

func (s *Service) Run(ctx context.Context) {
	ticker := time.NewTicker(s.interval)
	defer ticker.Stop()
	for {
		select {
		case <-ctx.Done():
			return
		case <-ticker.C:
			s.UpdateNow()
		}
	}
}

func (s *Service) UpdateNow() Snapshot {
	s.mu.Lock()
	for index := range s.instruments {
		item := &s.instruments[index]
		volatility := .004 + s.rng.Float64()*.008
		move := (s.rng.Float64()*2 - 1) * item.price * volatility
		if s.rng.Float64() < .06 {
			move *= 2.5
		}
		item.price = math.Max(item.openPrice*.75, math.Min(item.openPrice*1.25, item.price+move))
	}
	s.current = s.snapshot()
	for subscriber := range s.subscribers {
		select {
		case subscriber <- clone(s.current):
		default:
		}
	}
	result := clone(s.current)
	s.mu.Unlock()
	return result
}

func (s *Service) Current() Snapshot {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return clone(s.current)
}

func (s *Service) Subscribe() (<-chan Snapshot, func()) {
	ch := make(chan Snapshot, 1)
	s.mu.Lock()
	s.subscribers[ch] = struct{}{}
	s.mu.Unlock()

	var once sync.Once
	return ch, func() {
		once.Do(func() {
			s.mu.Lock()
			delete(s.subscribers, ch)
			close(ch)
			s.mu.Unlock()
		})
	}
}

func (s *Service) snapshot() Snapshot {
	quotes := make([]Quote, 0, len(s.instruments))
	for _, item := range s.instruments {
		change := item.price - item.openPrice
		direction := Equal
		if change > 0 {
			direction = Up
		} else if change < 0 {
			direction = Down
		}
		quotes = append(quotes, Quote{
			Symbol:        item.symbol,
			Name:          item.name,
			Price:         round(item.price),
			Change:        round(change),
			ChangePercent: round(change / item.openPrice * 100),
			Direction:     direction,
		})
	}
	return Snapshot{
		Market:    "TSE-DEMO",
		Timestamp: s.now().UnixMilli(),
		Quotes:    quotes,
	}
}

func clone(snapshot Snapshot) Snapshot {
	snapshot.Quotes = append([]Quote(nil), snapshot.Quotes...)
	return snapshot
}

func round(value float64) float64 {
	return math.Round(value*100) / 100
}
