// Package speaker imitates the IBM PC speaker: square-wave tones for BASIC's
// SOUND and BEEP, and its PLAY music language.
package speaker

import (
	"encoding/binary"
	"math"
	"strconv"
	"strings"
	"unicode"
)

// SampleRate of the generated audio (16-bit signed little-endian stereo).
const SampleRate = 44100

// TicksPerSecond is the PC timer rate SOUND durations are counted in.
const TicksPerSecond = 18.2

// Volume of the square wave, 0-1. The real speaker was loud; this is gentler.
const Volume = 0.12

// Note is one tone (Freq 0 = silence) lasting Seconds.
type Note struct {
	Freq    float64
	Seconds float64
}

// Sound is SOUND freq, ticks.
func Sound(freq, ticks float64) []Note { return []Note{{freq, ticks / TicksPerSecond}} }

// Beep is BASIC's BEEP: 800 Hz for a quarter second.
func Beep() []Note { return []Note{{800, 0.25}} }

// PCM renders notes as 16-bit stereo samples.
func PCM(notes []Note) []byte {
	var out []byte
	var phase float64
	for _, n := range notes {
		count := int(n.Seconds * SampleRate)
		for i := 0; i < count; i++ {
			v := 0.0
			if n.Freq > 0 {
				phase += n.Freq / SampleRate
				phase -= math.Floor(phase)
				v = Volume
				if phase >= 0.5 {
					v = -Volume
				}
				// soften the first and last millisecond to avoid clicks
				edge := min(i, count-1-i)
				if edge < SampleRate/1000 {
					v *= float64(edge) / (SampleRate / 1000)
				}
			}
			s := int16(v * math.MaxInt16)
			out = binary.LittleEndian.AppendUint16(out, uint16(s))
			out = binary.LittleEndian.AppendUint16(out, uint16(s))
		}
	}
	return out
}

// noteIndex is each note's semitone within an octave.
var noteIndex = map[byte]int{'C': 0, 'D': 2, 'E': 4, 'F': 5, 'G': 7, 'A': 9, 'B': 11}

// Play parses a BASIC PLAY string ("MB O3 L24 C D E F# G#").
//
// Supported: notes A-G with # or + (sharp) and - (flat) and an optional
// length, On (octave 0-6; octave 3 starts at middle C), Ln (note length),
// Tn (tempo in quarter notes per minute), Pn (pause), MN/ML/MS (normal,
// legato, staccato) and MF/MB (ignored: everything plays in the background).
func Play(s string) []Note {
	s = strings.ToUpper(s)
	octave, length, tempo, art := 4, 4, 120, 7.0/8
	var notes []Note
	i := 0
	num := func() (int, bool) {
		j := i
		for j < len(s) && unicode.IsDigit(rune(s[j])) {
			j++
		}
		if j == i {
			return 0, false
		}
		n, _ := strconv.Atoi(s[i:j])
		i = j
		return n, true
	}
	dur := func(l int) float64 { return (4.0 / float64(l)) * (60.0 / float64(tempo)) }
	for i < len(s) {
		c := s[i]
		i++
		switch {
		case c == 'O':
			if n, ok := num(); ok {
				octave = min(n, 6)
			}
		case c == 'L':
			if n, ok := num(); ok && n > 0 {
				length = n
			}
		case c == 'T':
			if n, ok := num(); ok && n >= 32 {
				tempo = n
			}
		case c == 'P':
			if n, ok := num(); ok && n > 0 {
				notes = append(notes, Note{0, dur(n)})
			}
		case c == 'M' && i < len(s):
			switch s[i] {
			case 'N':
				art = 7.0 / 8
			case 'L':
				art = 1
			case 'S':
				art = 3.0 / 4
			}
			i++
		case noteIndex[c] != 0 || c == 'C':
			semi := noteIndex[c]
			if i < len(s) && (s[i] == '#' || s[i] == '+') {
				semi++
				i++
			} else if i < len(s) && s[i] == '-' {
				semi--
				i++
			}
			l := length
			if n, ok := num(); ok && n > 0 {
				l = n
			}
			freq := 261.63 * math.Pow(2, float64(octave-3)+float64(semi)/12)
			d := dur(l)
			notes = append(notes, Note{freq, d * art}, Note{0, d * (1 - art)})
		}
	}
	return notes
}

// Seconds is how long notes take to play.
func Seconds(notes []Note) float64 {
	t := 0.0
	for _, n := range notes {
		t += n.Seconds
	}
	return t
}
