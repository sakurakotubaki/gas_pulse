package cache

import (
	"context"
	"encoding/json"
	"fmt"
	"log"
	"time"

	"github.com/redis/go-redis/v9"
)

// HistoryCache stores opaque JSON blobs for oil history responses.
type HistoryCache interface {
	Get(ctx context.Context, key string) ([]byte, bool)
	SetJSON(ctx context.Context, key string, value any, ttl time.Duration) error
}

// RedisCache implements HistoryCache with go-redis.
type RedisCache struct {
	client *redis.Client
}

// NewRedisCache dials Redis and pings once. On ping failure it logs and still
// returns a client so callers can fall back per-request.
func NewRedisCache(addr string) (*RedisCache, error) {
	if addr == "" {
		addr = "localhost:6379"
	}
	client := redis.NewClient(&redis.Options{Addr: addr})
	ctx, cancel := context.WithTimeout(context.Background(), 2*time.Second)
	defer cancel()
	if err := client.Ping(ctx).Err(); err != nil {
		log.Printf("redis ping failed (%s): %v; history will fall back to direct reads", addr, err)
	}
	return &RedisCache{client: client}, nil
}

func (c *RedisCache) Get(ctx context.Context, key string) ([]byte, bool) {
	raw, err := c.client.Get(ctx, key).Bytes()
	if err == redis.Nil {
		return nil, false
	}
	if err != nil {
		log.Printf("redis GET %s: %v", key, err)
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
		log.Printf("redis SET %s: %v", key, err)
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
