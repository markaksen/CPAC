#!/bin/bash

cd "$1"
files=`ls `

for subject in $files

do 
    mkdir "$2"/"$subject"
done