#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
echo $($PSQL "TRUNCATE teams, games") 

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # CHECK IF EXIST
    WINNER_EXIST="$($PSQL "SELECT name FROM teams WHERE name='$WINNER'")"
    # IF NOT EXIST  
    if [[ -z $WINNER_EXIST ]]
    then
      INSERT_WINNER_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$WINNER')")
      # IF INSERT SUCCESSFUL
      if [[ $INSERT_WINNER_RESULT == "INSERT 0 1" ]]
      then
        echo $WINNER WINNER ADDED TO TEAMS
      fi
    fi

    # CHECK IF EXIST  
    OPPONENT_EXIST="$($PSQL "SELECT name FROM teams WHERE name='$OPPONENT'")"
    # IF NOT EXIST  
    if [[ -z $OPPONENT_EXIST ]]
    then
      # INSERT TO DATABASE
      INSERT_OPPONENT_RESULT=$($PSQL "INSERT INTO teams(name) VALUES('$OPPONENT')")
      # IF INSERT SUCCESSFUL
      if [[ $INSERT_OPPONENT_RESULT == "INSERT 0 1" ]]
      then
        echo $OPPONENT OPPONENT ADDED TO TEAMS
      fi
    fi
  fi

done

cat games.csv | while IFS="," read YEAR ROUND WINNER OPPONENT WINNER_GOALS OPPONENT_GOALS
do
  if [[ $YEAR != year ]]
  then
    # GET WINNER ID
    WINNER_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$WINNER'")
    # GET OPPONENT ID
    OPPONENT_ID=$($PSQL "SELECT team_id FROM teams WHERE name='$OPPONENT'")
    # CHECK IF EXIST  
    GAME_EXIST=$($PSQL "SELECT * FROM games WHERE year='$YEAR' AND round='$ROUND' AND winner_id='$WINNER_ID' AND opponent_id='$OPPONENT_ID' AND winner_goals='$WINNER_GOALS' AND opponent_goals='$OPPONENT_GOALS'")
    # IF NOT EXIST  
    if [[ -z $GAME_EXIST ]]
    then
      # INSERT TO DATABASE
      GAME_RESULT=$($PSQL "INSERT INTO games(year,round,winner_id,opponent_id,winner_goals,opponent_goals) VALUES($YEAR,'$ROUND',$WINNER_ID,$OPPONENT_ID,$WINNER_GOALS,$OPPONENT_GOALS)")
      # IF INSERT SUCCESSFUL
      if [[ $GAME_RESULT == "INSERT 0 1" ]]
      then
        echo $YEAR $ROUND $WINNER_ID $OPPONENT_ID $WINNER_GOALS $OPPONENT_GOALS Game added
      fi
    fi
  fi
done
