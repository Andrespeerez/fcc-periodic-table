#!/bin/bash
# Script that prints on screen information about a chemical element
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

# case empty argument
if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
fi

# case not empty
# try to query by atomic_number, symbol, and name
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
if [[ -z $ATOMIC_NUMBER ]]
then
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
  NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
else if [[ -z $SYMBOL ]]
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")  
else if [[ -z $NAME ]]
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
fi