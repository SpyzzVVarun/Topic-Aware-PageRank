#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

current_node = None
current_node_outdeg = None
current_node_rank = None

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, data = line.strip().split('\t')
    data_type, value = data.split(':')
    # print(node, data_type, value)
    if current_node == node:
        if data_type == 'D':
            current_node_outdeg = value
        elif data_type == 'R':
            current_node_rank = value
    else:
        if current_node:
            try:
                print ('%s\t%s' % (current_node, str(float(current_node_rank) / float(current_node_outdeg))))
            except:
                print ('%s\t%s' % (current_node, str(0.0)))
        current_node = node
        if data_type == 'D':
            current_node_outdeg = value
        elif data_type == 'R':
            current_node_rank = value
    
if current_node == node:
    try:
        print ('%s\t%s' % (current_node, str(float(current_node_rank) / float(current_node_outdeg))))
    except:
        print ('%s\t%s' % (current_node, str(0.0)))