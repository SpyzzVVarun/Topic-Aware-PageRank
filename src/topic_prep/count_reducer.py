#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

count = 0

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, _ = line.strip().split('\t')
    count += 1
    
print ('%s' % (count))

