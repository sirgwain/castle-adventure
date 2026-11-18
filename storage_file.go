//go:build !js

package main

import (
	"os"
	"path/filepath"
)

// dirStorage keeps each key as a file under dir.
type dirStorage struct{ dir string }

func newStorage() (storage, error) {
	base, err := os.UserConfigDir()
	if err != nil {
		return nil, err
	}
	dir := filepath.Join(base, "castle-adventure")
	if err := os.MkdirAll(filepath.Join(dir, "saves"), 0o755); err != nil {
		return nil, err
	}
	return dirStorage{dir: dir}, nil
}

func (d dirStorage) Get(key string) ([]byte, error) {
	return os.ReadFile(filepath.Join(d.dir, filepath.FromSlash(key)))
}

func (d dirStorage) Put(key string, data []byte) error {
	return os.WriteFile(filepath.Join(d.dir, filepath.FromSlash(key)), data, 0o644)
}
