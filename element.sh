#!/bin/bash
# Script that prints on screen information about a chemical element
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

# case empty argument
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

# case not empty
# try to query by atomic_number
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
if [[ -z $ATOMIC_NUMBER ]]
then

fi