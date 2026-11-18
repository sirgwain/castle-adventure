//go:build js

package main

import (
	"errors"
	"syscall/js"
)

// webStorage keeps each key in the browser's localStorage.
type webStorage struct{ ls js.Value }

const keyPrefix = "castle-adventure/"

func newStorage() (storage, error) {
	ls := js.Global().Get("localStorage")
	if !ls.Truthy() {
		return nil, errors.New("localStorage is not available")
	}
	return webStorage{ls: ls}, nil
}

func (w webStorage) Get(key string) (b []byte, err error) {
	defer func() {
		if r := recover(); r != nil { // e.g. storage blocked by the browser
			b, err = nil, errors.New("localStorage is not available")
		}
	}()
	v := w.ls.Call("getItem", keyPrefix+key)
	if v.IsNull() {
		return nil, errors.New("not found")
	}
	return []byte(v.String()), nil
}

func (w webStorage) Put(key string, data []byte) (err error) {
	defer func() {
		if r := recover(); r != nil { // e.g. quota exceeded or storage blocked
			err = errors.New("could not save")
		}
	}()
	w.ls.Call("setItem", keyPrefix+key, string(data))
	return nil
}
