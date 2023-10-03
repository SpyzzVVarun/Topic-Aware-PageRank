#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

b = 0.85
total = 0.0
current_node = None
current_node_rank = 0.0

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, rank = line.strip().split('\t')
    if current_node == node:
        current_node_rank += b*float(rank)
    else:
        if current_node:
            print ('%s\t%s' % (current_node, current_node_rank))
            total += float(current_node_rank)
        current_node = node
        current_node_rank = b*float(rank)
    
if current_node == node:
    print ('%s\t%s' % (current_node, current_node_rank))
    total += float(current_node_rank)

with open('/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/current_total', 'w') as file:
    file.write(str(total))