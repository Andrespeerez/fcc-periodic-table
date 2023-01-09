#!/bin/bash
# Script that prints on screen information about a chemical element
PSQL="psql --username=freecodecamp --dbname=periodic_table --no-align --tuples-only -c"

if [[ -z $1 ]]
then
  echo "Please provide an element as an argument."
  exit 0
# check atomic_number
elif [[ $1 =~ ^[0-9]*$ ]]
then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
  if [[ -z $GET_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
    exit 0
  fi
  GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
  GET_NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
  GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE atomic_number=$1")
  GET_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types ON types.type_id = properties.type_id WHERE atomic_number=$1")
  GET_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE atomic_number=$1")
  GET_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE atomic_number=$1")
# check symbol
elif [[ $1 =~ ^[A-Z]$ || $1 =~ ^[A-Z][a-z]$ ]]
then
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol='$1'")
  if [[ -z $GET_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
    exit 0
  fi
  GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol='$1'")
  GET_NAME=$($PSQL "SELECT name FROM elements WHERE symbol='$1'")
  GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol='$1'")
  GET_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types ON types.type_id = properties.type_id INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol='$1'")
  GET_MP=$($PSQL "SELECT melting_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol='$1'")
  GET_BP=$($PSQL "SELECT boiling_point_celsius FROM properties INNER JOIN elements ON properties.atomic_number = elements.atomic_number WHERE symbol='$1'")
# check name
else
  GET_ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name='$1'")
  if [[ -z $GET_ATOMIC_NUMBER ]]
  then
    echo "I could not find that element in the database."
    exit 0
  fi
  GET_SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name='$1'")
  GET_NAME=$($PSQL "SELECT name FROM elements WHERE name='$1'")
  GET_ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties WHERE name='$1'")
  GET_TYPE=$($PSQL "SELECT type FROM properties INNER JOIN types ON types.type_id = properties.type_id WHERE WHERE name='$1'")
  GET_MP=$($PSQL "SELECT melting_point_celsius FROM properties WHERE name='$1'")
  GET_BP=$($PSQL "SELECT boiling_point_celsius FROM properties WHERE name='$1'")
fi

# send message
echo "The element with atomic number $GET_ATOMIC_NUMBER is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_ATOMIC_MASS amu. $GET_NAME has a melting point of $GET_MP celsius and a boiling point of $GET_BP celsius."