#!/bin/bash

PSQL="psql -U freecodecamp -d periodic_table -t -X -c"
# Checks if the script was called with an argument.
if [[ $1 ]]
then
  # Checks if the argument is a number.
  if [[ $1 =~ ^[0-9]+$ ]]
  then
    DATA=$($PSQL "SELECT * FROM elements JOIN properties USING (atomic_number) JOIN types USING (type_id) WHERE atomic_number=$1")
    # Checks if the query has a result.
    if [[ -z $DATA ]]
    then
      echo "I could not find that element in the database."
    else
      #I give IFS a value of "| " in order to take the space as a separator also, ther variables were getting spaces at the end.
      echo $DATA | while IFS="| " read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING BOILING TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."        
      done
    fi
  else
    DATA=$($PSQL "SELECT * FROM elements JOIN properties USING (atomic_number) JOIN types USING (type_id) WHERE symbol='$1' OR name='$1'")
    # Checks if the query has a result.
    if [[ -z $DATA ]]
    then
        echo "I could not find that element in the database."
    else
      # I give IFS a value of "| " in order to take the space as a separator also, ther variables were getting spaces at the end.
      echo $DATA | while IFS="| " read TYPE_ID ATOMIC_NUMBER SYMBOL NAME ATOMIC_MASS MELTING BOILING TYPE
      do
        echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING celsius and a boiling point of $BOILING celsius."        
      done
    fi
  fi
  
else
  # If the test for the existance of the variable $1 fail.
  echo "Please provide an element as an argument."
fi
