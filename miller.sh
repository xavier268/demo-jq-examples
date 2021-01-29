#!/bin/bash

echo "Demo using miller to process a CSV file"
echo "Using $( mlr --version)"
SECONDS=0
CSV="test.csv"
echo "----------------------------------"

echo "--- Headers ---"
head -n 1 $CSV

echo "--- Head of original file ---"
head $CSV

echo "--- Extract Model column ---"
head $CSV | mlr --csv cut -f Model 

echo "--- Extract sorted Brand and Model ---"
head -n 30 $CSV | mlr --csv cut -f Brand,Model then sort -f Brand,Model

echo "--- Bar charts ---"
head -n 50 $CSV | mlr --csv --opprint --barred bar --auto  -f Mileage then sort -f Mileage

echo "--- List abnormal values ---"
cat $CSV | mlr --csv --opprint --barred filter '(! is_numeric($Price) )|| (! is_numeric($EngineV))' 

echo "--- stats1 ---"
cat $CSV | mlr --csv --opprint --barred stats1 -a mean,mode,antimode,stddev,min,max,p5,p95 -f Mileage
cat $CSV | mlr --csv --opprint --barred stats1 -a mean,mode,antimode,stddev,min,max -f Year -g Brand
cat $CSV | mlr --csv --opprint --barred put 'if(is_numeric($Price)){}else{$Price=0}' then stats1 -a mean,mode,antimode,stddev,min,max -f Price -g Brand,Year then head -n 10
cat $CSV | mlr --csv --opprint --barred put 'if(is_numeric($Price)){}else{$Price=0}' then stats1 -a min,mean,max,count -f Price -g Brand,Model,Year then sort -nr Price_mean then head -n 10
cat $CSV | mlr --csv --opprint --barred put 'if(is_numeric($Price)){}else{$Price=0}' then stats1 -a min,mean,max,count -f Price -g Brand then sort -nr Price_mean

echo "--- csv to json ---"
head $CSV | mlr --c2j cat

echo "----------------------------------"
echo "Elapsed $SECONDS seconds"

