#!/bin/bash

# Clearing old files
file_list=$(hdfs dfs -ls | awk '{print $8}')
for file in $file_list; do
  hdfs dfs -rm -r "$file"
done

# Granting permissions
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/outdegree/mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/outdegree/reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/count_mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/count_reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/rank/mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/rank/reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join/mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join/reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/compute_mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/compute_reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/topic_compute_mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/topic_compute_reducer.py"
# chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/final_compute_mapper.py"
# chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/join_compute/final_compute_reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/count_mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/count_reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/preprocess_mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/preprocess_reducer.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/scam_mapper.py"
chmod +x "/home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/scam_reducer.py"

# Initializing
hdfs dfs -copyFromLocal /home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/data/test.txt ./.
hdfs dfs -copyFromLocal /home/hduser2/hadoop/hadoop-3.3.6/bda/trivago/data/test_teleport.txt ./.
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input test.txt -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/outdegree/mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/outdegree/reducer.py -output ./outdegree
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input test.txt -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/count_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/count_reducer.py -output ./count_nodes
hdfs dfs -mv count_nodes/part-00000 count_nodes/count_nodes
hdfs dfs -copyToLocal -f count_nodes/count_nodes ./.
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input test_teleport.txt -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/scam_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/scam_reducer.py -output ./teleport_set
# hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input test.txt -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/count_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/count_reducer.py -output ./teleport_set
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input teleport_set/part-00000 -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/count_mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/topic_prep/count_reducer.py -output ./topic_count_nodes
hdfs dfs -mv topic_count_nodes/part-00000 topic_count_nodes/topic_count_nodes
hdfs dfs -copyToLocal -f topic_count_nodes/topic_count_nodes ./.
hadoop jar ~/hadoop/hadoop-3.3.6/bda/jar/hadoop-streaming-3.3.6.jar -input test.txt -mapper ~/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/mapper.py -reducer ~/hadoop/hadoop-3.3.6/bda/trivago/src/rank_init/reducer.py -output ./rank
