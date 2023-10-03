#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

current_node = None
current_node_rank = None
current_node_to = list()

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, data = line.strip().split('\t')
    data_type, value = data.split(':')
    if current_node == node:
        if data_type == 'R':
            current_node_rank = value
        elif data_type == 'D':
            current_node_to.append(value)
    else:
        if current_node:
            print('%s\t%s' % (current_node, str(0.0)))
            if not current_node_rank:
                current_node_rank = "0.0"
            for nodei in current_node_to:
                print ('%s\t%s' % (nodei, current_node_rank))
        current_node = node
        current_node_rank = None
        current_node_to = list()    
        if data_type == 'R':
            current_node_rank = value
        elif data_type == 'D':
            current_node_to.append(value)
    
if current_node == node:
    print('%s\t%s' % (current_node, str(0.0)))
    if not current_node_rank:
        current_node_rank = "0.0"
    for nodei in current_node_to:
        print ('%s\t%s' % (nodei, current_node_rank))