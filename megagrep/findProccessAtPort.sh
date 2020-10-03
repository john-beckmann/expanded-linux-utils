#!/bin/bash
# Made by John Beckmann
# Find what process is running at a specified port.

PORT=$1

printf "\n"

lsof -i :$PORT || \
printf "No processes were found listening to port $PORT..."

printf "\n\n"
