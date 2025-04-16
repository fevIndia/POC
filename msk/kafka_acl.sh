#!/bin/bash

BROKER="b-1.example.kafka.amazonaws.com:9094"
USER="your-username"
PASS="your-password"

# Create a Kafka topic
kafka-topics --create --topic "new-topic" --bootstrap-server $BROKER --replication-factor 2 --partitions 3

# Create ACL
kafka-acls --add --allow-principal User:$USER --operation All --topic new-topic --bootstrap-server $BROKER
