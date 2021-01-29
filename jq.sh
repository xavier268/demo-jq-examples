#!/bin/bash
echo "Demo using mlr then jq to process a CSV file"
echo "Using $( jq --version)"
echo "Using $( jq --version)"
SECONDS=0
CSV="test.csv"


echo "===== Testing csv to json conversion ===="
head $CSV | mlr --c2j cat 

echo "==== Basic processing, pretty printing ...===="
head $CSV | mlr --c2j cat | jq
echo
head $CSV | mlr --c2j cat | jq ."Brand"
echo 
head $CSV | mlr --c2j cat | jq ."Brand",."Price"
echo
head $CSV | mlr --c2j cat | jq '{ marque : .Brand , prix : .Price } '
echo
head $CSV | mlr --c2j cat | jq '[{ marque : .Brand , prix : .Price }] '
echo "Slurping tests ..."
head $CSV | mlr --c2j cat | jq -s 
echo
head $CSV | mlr --c2j cat | jq -s 'map( .Brand )'



echo "------- Elased $SECONDS seconds -------"
