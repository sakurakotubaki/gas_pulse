package cache

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"sync"
	"time"

	"github.com/redis/go-redis/v9"
)

const failureLogInterval = 30 * time.Second

// HistoryCache stores opaque JSON blobs for oil history responses.
type HistoryCache interface {
	Get(ctx context.Context, key string) ([]byte, bool)
	SetJSON(ctx context.Context, key string, value any, ttl time.Duration) error
}

// RedisCache implements HistoryCache with go-redis.
type RedisCache struct {
	client *redis.Client

	logMu    sync.Mutex
	lastFail time.Time
}

// NewRedisCache dials Redis and pings once. Ping failure closes the client and
// returns an error so callers can leave caching disabled.
func NewRedisCache(addr string) (*RedisCache, error) {
	if addr == "" {
		addr = "localhost:6379"
	}
	client := redis.NewClient(&redis.Options{Addr: addr})
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
	defer cancel()
	if err := client.Ping(ctx).Err(); err != nil {
		_ = client.Close()
		return nil, fmt.Errorf("redis ping %s: %w", addr, err)
	}
	return &RedisCache{client: client}, nil
}

func (c *RedisCache) Get(ctx context.Context, key string) ([]byte, bool) {
	raw, err := c.client.Get(ctx, key).Bytes()
	if err == redis.Nil {
		return nil, false
	}
	if err != nil {
		c.logFailure("GET", key, err)
		return nil, false
	}
	return raw, true
}

func (c *RedisCache) SetJSON(ctx context.Context, key string, value any, ttl time.Duration) error {
	raw, err := json.Marshal(value)
	if err != nil {
		return fmt.Errorf("marshal cache value: %w", err)
	}
	if err := c.client.Set(ctx, key, raw, ttl).Err(); err != nil {
		c.logFailure("SET", key, err)
		return err
	}
	return nil
}

func (c *RedisCache) Close() error {
	if c == nil || c.client == nil {
		return nil
	}
	return c.client.Close()
}

func (c *RedisCache) logFailure(op, key string, err error) {
	now := time.Now()
	c.logMu.Lock()
	defer c.logMu.Unlock()
	if !c.lastFail.IsZero() && now.Sub(c.lastFail) < failureLogInterval {
		return
	}
	c.lastFail = now
	log.Printf("redis %s %s: %v", op, key, err)
}
