#!/bin/bash

init="Scripts/init.sh"
iter="Scripts/iter.sh"
num_runs=3

bash "$init"

for ((i = 1; i <= num_runs; i++)); do
    echo "Running iteration $i"
    # Run the script
    bash "$iter"
done

echo "Script has been run $num_runs times."

hdfs dfs -copyToLocal -f ./rank ./output
