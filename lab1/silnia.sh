#!/bin/bash
for j in $(seq 1 15);
do
let sum=1
for i in $(seq 1 $j);
do
    let "sum *= i"
done
echo "silnia $j jest równa:"$sum
done
  