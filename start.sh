#!/bin/bash
python3 -m http.server ${PORT:-10000} &
exec hermes gateway run
