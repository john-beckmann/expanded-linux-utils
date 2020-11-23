#!/bin/bash
# Made by John Beckmann
# Find what process is running at a specified port.

PORT=$1

lsof -i :$PORT || printf "\nNo processes were found listening to port $PORT"

printf "\n\n"
