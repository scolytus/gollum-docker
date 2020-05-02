#!/bin/bash

for i in $(seq 1 300); do
  curl -s -w "%{time_connect}:%{time_starttransfer}:%{time_total}\n" -o /dev/null "http://localhost:8080/Home?${i}"
done

