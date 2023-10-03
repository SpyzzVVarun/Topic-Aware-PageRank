#!/usr/bin/env python3

# import sys because we need to read and write data to STDIN and STDOUT
import sys

b = 0.85
N = 0
S = 0.0

with open("/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/count_nodes", 'r') as file:
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
    node, rank = line.strip().split('\t')
    print ('%s\t%s' % (node, str(float(rank) + (1-S)/N)))