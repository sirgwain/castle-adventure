package main

import (
	"encoding/json"
	"errors"
	"os"
	"path/filepath"
	"strings"

	"github.com/sirgwain/castle-adventure/internal/game"
)

// fileStore keeps saved games and the high score as JSON files in dir.
type fileStore struct{ dir string }

func newFileStore() (*fileStore, error) {
	base, err := os.UserConfigDir()
	if err != nil {
		return nil, err
	}
	dir := filepath.Join(base, "castle-adventure")
	if err := os.MkdirAll(filepath.Join(dir, "saves"), 0o755); err != nil {
		return nil, err
	}
	return &fileStore{dir: dir}, nil
}

// saveName turns the typed name ("SAVE GAME1") into a safe file name.
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
	return b.String() + ".json", nil
}

func (s *fileStore) Save(name string, data []byte) error {
	f, err := saveName(name)
	if err != nil {
		return err
	}
	return os.WriteFile(filepath.Join(s.dir, "saves", f), data, 0o644)
}

func (s *fileStore) Load(name string) ([]byte, error) {
	f, err := saveName(name)
	if err != nil {
		return nil, err
	}
	return os.ReadFile(filepath.Join(s.dir, "saves", f))
}

// The high score written on the courtyard wall. CASTLE.RAN shipped with 750.
var defaultHighScore = game.HighScore{Name: "", Score: 750}

func (s *fileStore) HighScore() game.HighScore {
	b, err := os.ReadFile(filepath.Join(s.dir, "highscore.json"))
	if err != nil {
		return defaultHighScore
	}
	var h game.HighScore
	if json.Unmarshal(b, &h) != nil {
		return defaultHighScore
	}
	return h
}

func (s *fileStore) SetHighScore(h game.HighScore) error {
	b, err := json.MarshalIndent(h, "", "  ")
	if err != nil {
		return err
	}
	return os.WriteFile(filepath.Join(s.dir, "highscore.json"), b, 0o644)
}
