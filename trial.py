# lines = '''0	0.0
# 0	0.045454545454545456
# 1	0.0
# 1	0.09090909090909091
# 1	0.045454545454545456
# 1	0.045454545454545456
# 1	0.045454545454545456
# 1	0.045454545454545456
# 1	0.045454545454545456
# 1	0.030303030303030304
# 2	0.09090909090909091
# 2	0.0
# 3	0.0
# 3	0.030303030303030304
# 3	0.030303030303030304
# 4	0.09090909090909091
# 4	0.0
# 4	0.045454545454545456
# 4	0.045454545454545456
# 4	0.045454545454545456
# 4	0.045454545454545456
# 4	0.09090909090909091
# 5	0.030303030303030304
# 5	0.0
# 6	0.0
# 7	0.0
# 8	0.0
# 9	0.0
# 10	0.0'''

# current_node = None
# current_node_rank = 0.0

# for line in lines.split('\n'):
#     node, rank = line.strip().split('\t')
#     # print(node, rank)
#     if current_node == node:
#         current_node_rank += float(rank)
#     else:
#         if current_node:
#             pass
#             print ('%s\t%s' % (current_node, current_node_rank))
#         current_node = node
#         current_node_rank = float(rank)
    
# if current_node == node:
#     print ('%s\t%s' % (current_node, current_node_rank))

with open('join_compute/current_total', 'w') as file:
    file.write(str(11))