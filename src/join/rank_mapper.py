#!/usr/bin/env python3
  
# import sys because we need to read and write data to STDIN and STDOUT
import sys
  
# reading entire line from STDIN (standard input)
for line in sys.stdin:
    if not line or line[0] == '#':
        continue
    node, rank = line.strip().split('\t', 1)
    print ('%s\tR:%s' % (node, rank))
