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
	// create consumer
	consumer, err := client.Subscribe(pulsar.ConsumerOptions{
		Topic:            "test-topic",
		SubscriptionName: "sample-consumer",
		Type:             pulsar.Exclusive,
	})
	if err != nil {
		panic(err)
	}

	defer consumer.Close()
	// receive message
	msg, err := consumer.Receive(context.Background())
	if err != nil {
		panic(err)
	}

	consumer.Ack(msg)
	fmt.Printf("Received message: %#v -- content: '%s'\n", msg.ID(), string(msg.Payload()))
}
