#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

b = 0.85
N = 0
S = 0.0
inTopic = False
current_node = None
rank = 0.0

with open("/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/topic_count_nodes", 'r') as file:
    sys.stdin = file
    for line in sys.stdin:
        N = int(line)

with open("/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/current_total", 'r') as file:
    sys.stdin = file
    for line in sys.stdin:
        S = float(line)

# Reset sys.stdin to the original standard input (usually the console)
sys.stdin = sys.__stdin__

# reading entire line from STDIN (standard input)
for line in sys.stdin:
    node, data = line.strip().split('\t')
    data_type, value = data.strip().split(":")
    if current_node == node:
        if data_type == 'D':
            inTopic = True
        else:
            rank = float(value)
    else:
        if current_node:
            print ('%s\t%s' % (current_node, str(rank + inTopic*(1-S)/N)))
        current_node = node
        if data_type == 'D':
            inTopic = True
            rank = 0.0
        else:
            inTopic = False
            rank = float(value)
    
if current_node == node:
    print ('%s\t%s' % (current_node, str(rank + inTopic*(1-S)/N)))