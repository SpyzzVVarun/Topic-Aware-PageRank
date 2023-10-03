#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

current_node = None
count = 0

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, _ = line.strip().split('\t')
    if current_node == node:
        continue
    else:
        count += 1
        current_node = node
    
print ('%s' % (count))

