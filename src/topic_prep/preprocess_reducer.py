#!/usr/bin/env python3
  
# import sys because we need to read and write data to STDIN and STDOUT
import sys
current_node = None
  
# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, _ = line.strip().split('\t', 1)
    if current_node == node:
        continue
    else:
        if current_node:
            print ('%s\t%s' % (current_node, str(1)))
        current_node = node

if current_node == node:
    print ('%s\t%s' % (current_node, str(1)))