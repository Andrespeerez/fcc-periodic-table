#!/bin/bash
# Script that prints on screen information about a chemical element
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
elif [[ $1 =~ ^[0-9]*$ ]]
then
  echo "Input is a number"
elif [[ $1 =~ ^[A-Z].$ ]]
then
  echo "Input is a symbol"
else
  echo "Input is a name"
fi

