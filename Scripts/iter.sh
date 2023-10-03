#!/bin/bash
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input rank/part-00000 -input outdegree/part-00000 -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/join/mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/join/reducer.py -output ./norm_rank
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input test.txt -input norm_rank/part-00000 -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/reducer.py -output ./join_compute_join
hdfs dfs -rm -r ./rank
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input join_compute_join/part-00000 -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/compute_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/compute_reducer.py -output ./inter_rank
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input inter_rank/part-00000 -input teleport_set/part-00000 -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/topic_compute_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/topic_compute_reducer.py -output ./rank
# hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input inter_rank/part-00000 -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/final_compute_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/final_compute_reducer.py -output ./rank
hdfs dfs -mv inter_rank/part-00000 inter_rank/inter_rank
hdfs dfs -copyToLocal -f inter_rank/inter_rank ./.
hdfs dfs -rm -r ./norm_rank
hdfs dfs -rm -r ./join_compute_join
hdfs dfs -rm -r ./inter_rank