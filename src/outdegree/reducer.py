#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

current_node = None
current_count = 0
node = None

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, count = line.strip().split('\t')
    if current_node == node:
        current_count += int(count)
    else:
        if current_node:
            print ('%s\t%s' % (current_node, current_count))
        current_count = int(count)
        current_node = node
    
if current_node == node:
        print ('%s\t%s' % (current_node, current_count))
