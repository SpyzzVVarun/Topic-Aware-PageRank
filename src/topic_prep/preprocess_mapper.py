#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

LOCATION = "Sydney"

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    if "session_id" in line:
        continue
    if LOCATION in line.strip():
        word = line.strip().split(',')[2]
        print("%s\t%s" % (word, str(1)))
