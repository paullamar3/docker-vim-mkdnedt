#!/bin/bash
#
# 

if [ -n "$1" ]
then 
  git config --global user.name "$1"
fi

if [ -n "$2" ]
then 
  git config --global user.email "$2"
fi

if [ -n "$3" ]
then
  if [ ! -d "mkdn/$3" ]
  then
    git clone /home/gitit/data/wikidata/.git "mkdn/$3"
  fi
fi

exec vim

