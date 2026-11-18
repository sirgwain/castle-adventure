package main

import (
	"encoding/json"
	"errors"
	"strings"

	"github.com/sirgwain/castle-adventure/internal/game"
)

// storage holds small named blobs: files in the user's config directory on the
// desktop (storage_file.go), localStorage in the browser (storage_js.go).
type storage interface {
	Get(key string) ([]byte, error)
	Put(key string, data []byte) error
}

// saveStore keeps saved games and the high score as JSON.
type saveStore struct{ kv storage }

func newSaveStore() (*saveStore, error) {
	kv, err := newStorage()
	if err != nil {
		return nil, err
	}
	return &saveStore{kv: kv}, nil
}

// saveName turns the typed name ("SAVE GAME1") into a safe key.
func saveName(name string) (string, error) {
	var b strings.Builder
	for _, r := range strings.ToLower(name) {
		if (r >= 'a' && r <= 'z') || (r >= '0' && r <= '9') {
			b.WriteRune(r)
		}
	}
	if b.Len() == 0 {
		return "", errors.New("bad name")
	}
	return "saves/" + b.String() + ".json", nil
}

func (s *saveStore) Save(name string, data []byte) error {
	k, err := saveName(name)
	if err != nil {
		return err
	}
	return s.kv.Put(k, data)
}

func (s *saveStore) Load(name string) ([]byte, error) {
	k, err := saveName(name)
	if err != nil {
		return nil, err
	}
	return s.kv.Get(k)
}

// The high score written on the courtyard wall. CASTLE.RAN shipped with 750.
var defaultHighScore = game.HighScore{Name: "", Score: 750}

func (s *saveStore) HighScore() game.HighScore {
	b, err := s.kv.Get("highscore.json")
	if err != nil {
		return defaultHighScore
	}
	var h game.HighScore
	if json.Unmarshal(b, &h) != nil {
		return defaultHighScore
	}
	return h
}

func (s *saveStore) SetHighScore(h game.HighScore) error {
	b, err := json.MarshalIndent(h, "", "  ")
	if err != nil {
		return err
	}
	return s.kv.Put("highscore.json", b)
}
