package main

import (
	"context"
	"fmt"

	"github.com/apache/pulsar-client-go/pulsar"
)

func main() {
	client, err := pulsar.NewClient(pulsar.ClientOptions{
		URL: "pulsar://localhost:6650",
	})
	if err != nil {
		panic(err)
	}

	defer client.Close()
	// create producer
	producer, err := client.CreateProducer(pulsar.ProducerOptions{
		Topic: "test-topic",
	})
	if err != nil {
		panic(err)
	}

	// publish message
	_, err = producer.Send(context.Background(), &pulsar.ProducerMessage{
		Payload: []byte("hello"),
	})
	if err != nil {
		panic(err)
	}

	defer producer.Close()
	fmt.Println("Published message")
}
