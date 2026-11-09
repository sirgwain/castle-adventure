package speaker

import (
	"math"
	"testing"
)

func TestPlayHarp(t *testing.T) {
	// the harp's tune from the original
	notes := Play("MB O3 L24 C D E F# G# A# O4 C O3 A# G# F# E D C6")
	var tones []float64
	for _, n := range notes {
		if n.Freq > 0 {
			tones = append(tones, n.Freq)
		}
	}
	if len(tones) != 13 {
		t.Fatalf("%d notes, want 13", len(tones))
	}
	if math.Abs(tones[0]-261.63) > 0.1 || math.Abs(tones[6]-523.26) > 0.2 {
		t.Errorf("O3 C = %.2f Hz, O4 C = %.2f Hz", tones[0], tones[6])
	}
	if math.Abs(tones[3]-369.99) > 0.5 { // F#3 (BASIC octave 3 = middle-C octave)
		t.Errorf("F# = %.2f Hz", tones[3])
	}
	// L24 at tempo 120: 1/6 of a quarter note each; the last C6 is longer
	if got := Seconds(notes); math.Abs(got-(12*(4.0/24)*0.5+(4.0/6)*0.5)) > 1e-9 {
		t.Errorf("tune lasts %.3f s", got)
	}
}

func TestPCM(t *testing.T) {
	b := PCM(Sound(440, 18.2)) // one second
	if len(b) != SampleRate*4 {
		t.Fatalf("%d bytes, want %d", len(b), SampleRate*4)
	}
	if len(PCM(Play("P4"))) == 0 {
		t.Error("a pause produced no samples")
	}
}
