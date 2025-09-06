#!/bin/bash
set -e

ollama serve &

sleep 10

ollama pull $MODEL

wait