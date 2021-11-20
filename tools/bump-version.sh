#!/usr/bin/env bash

FILES=("galaxy.yml")

for f in "${FILES[@]}"
do
   : 
   sed "s/$1/$2/g" $f
done