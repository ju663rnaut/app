package main

import (
	"net/http"
	"net/http/httptest"
	"testing"
)

func TestHelloWorldHandler(t *testing.T) {
	w := httptest.NewRecorder()
	r, _ := http.NewRequest(http.MethodGet, "", nil)
	HelloWorldHandler(w, r)

	if got, want := w.Code, http.StatusOK; got != want {
		t.Errorf("invalid status code. Got: %d, want: %d", got, want)
	}

	if got, want := w.Body.String(), "hello world"; got != want {
		t.Errorf("invalid response body. Got: %s, want: %s", got, want)
	}
}
