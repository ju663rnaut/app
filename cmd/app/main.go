package main

import (
	"fmt"
	"log"
	"net"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
)

const (
	host = "0.0.0.0"
	port = 8080
)

// HelloWorldHandler returns "hello world" in the response body
func HelloWorldHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "hello world")
}

func main() {
	router := mux.NewRouter()
	router.HandleFunc("/", HelloWorldHandler).Methods(http.MethodGet)

	addr := net.JoinHostPort(host, strconv.Itoa(port))
	log.Printf("Server is listening at: http://%s/", addr)
	log.Fatal(http.ListenAndServe(addr, router))
}
