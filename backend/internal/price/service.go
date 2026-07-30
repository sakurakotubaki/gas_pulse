package price

import (
	"context"
	"math"
	"math/rand"
	"sync"
	"time"
)

const (
	Symbol         = "NGAS/USD"
	defaultHistory = 120
)

type Tick struct {
	Symbol    string  `json:"symbol"`
	Price     float64 `json:"price"`
	Timestamp int64   `json:"timestamp"`
	Status    string  `json:"status"`
}

type Service struct {
	mu          sync.RWMutex
	current     Tick
	history     []Tick
	subscribers map[chan Tick]struct{}
	rng         *rand.Rand
	interval    time.Duration
	now         func() time.Time
}

func New(initialPrice float64, interval time.Duration, seed int64) *Service {
	if initialPrice <= 0 {
		initialPrice = 2.853
	}
	if interval <= 0 {
		interval = time.Minute
	}
	now := time.Now()
	initial := Tick{
		Symbol:    Symbol,
		Price:     round(initialPrice),
		Timestamp: now.UnixMilli(),
		Status:    "EQUAL",
	}
	return &Service{
		current:     initial,
		history:     []Tick{initial},
		subscribers: make(map[chan Tick]struct{}),
		rng:         rand.New(rand.NewSource(seed)),
		interval:    interval,
		now:         time.Now,
	}
}

// Run updates and broadcasts the simulated market price at the configured interval.
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

func (s *Service) UpdateNow() Tick {
	s.mu.Lock()
	previous := s.current.Price
	change := (s.rng.Float64()*2 - 1) * 0.025
	if s.rng.Float64() < 0.08 {
		change += (s.rng.Float64()*2 - 1) * 0.075
	}
	next := math.Max(1.5, math.Min(6.0, previous+change))
	status := "EQUAL"
	if next > previous {
		status = "UP"
	} else if next < previous {
		status = "DOWN"
	}
	tick := Tick{
		Symbol:    Symbol,
		Price:     round(next),
		Timestamp: s.now().UnixMilli(),
		Status:    status,
	}
	s.current = tick
	s.history = append(s.history, tick)
	if len(s.history) > defaultHistory {
		s.history = append([]Tick(nil), s.history[len(s.history)-defaultHistory:]...)
	}

	for subscriber := range s.subscribers {
		select {
		case subscriber <- tick:
		default:
			// A slow client receives the newest snapshot on its next connection/read.
		}
	}
	s.mu.Unlock()
	return tick
}

func (s *Service) Current() Tick {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return s.current
}

func (s *Service) History() []Tick {
	s.mu.RLock()
	defer s.mu.RUnlock()
	return append([]Tick(nil), s.history...)
}

func (s *Service) Subscribe() (<-chan Tick, func()) {
	ch := make(chan Tick, 1)
	s.mu.Lock()
	s.subscribers[ch] = struct{}{}
	s.mu.Unlock()

	var once sync.Once
	cancel := func() {
		once.Do(func() {
			s.mu.Lock()
			delete(s.subscribers, ch)
			close(ch)
			s.mu.Unlock()
		})
	}
	return ch, cancel
}

func round(value float64) float64 {
	return math.Round(value*1000) / 1000
}
