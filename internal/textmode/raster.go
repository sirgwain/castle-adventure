package textmode

import (
	"image"
	"image/draw"
	"image/png"
	"os"
)

// Draw composites the screen into dst at its origin using f. The window
// renderer draws the same glyph masks; this is for screenshots and tests.
func Draw(dst *image.RGBA, s *Screen, f *Font) {
	for row := 1; row <= s.Rows; row++ {
		for col := 1; col <= s.Cols; col++ {
			c := s.At(row, col)
			r := image.Rect((col-1)*f.W, (row-1)*f.H, col*f.W, row*f.H)
			draw.Draw(dst, r, image.NewUniform(c.BG), image.Point{}, draw.Src)
			if c.R != ' ' {
				draw.DrawMask(dst, r, image.NewUniform(c.FG), image.Point{}, f.Glyph(c.R), image.Point{}, draw.Over)
			}
		}
	}
}

// SavePNG writes the screen to a PNG file.
func SavePNG(path string, s *Screen, f *Font) error {
	img := image.NewRGBA(image.Rect(0, 0, s.Cols*f.W, s.Rows*f.H))
	Draw(img, s, f)
	out, err := os.Create(path)
	if err != nil {
		return err
	}
	if err := png.Encode(out, img); err != nil {
		out.Close()
		return err
	}
	return out.Close()
}
