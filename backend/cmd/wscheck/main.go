package main

import (
	"log"
	"os"

	"github.com/gorilla/websocket"
)

func main() {
	url := "ws://localhost:8080/ws/price"
	if len(os.Args) > 1 {
		url = os.Args[1]
	}
	connection, _, err := websocket.DefaultDialer.Dial(url, nil)
	if err != nil {
		log.Fatal(err)
	}
	defer connection.Close()

	for {
		_, message, err := connection.ReadMessage()
		if err != nil {
			log.Fatal(err)
		}
		log.Printf("%s", message)
	}
}
