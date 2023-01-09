#!/bin/bash
# Script that prints on screen information about a chemical element
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"
ONE=$1
# case empty argument
if [[ -z $ONE ]]
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
elif [[ -z $SYMBOL ]]
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")  
elif [[ -z $NAME ]]
  then
  ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
else
  # case input $1 is not found
  echo "I could not find that element in the database."
fi
