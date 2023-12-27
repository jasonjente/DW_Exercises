drop database if exists footballDW;

go
create database footballDW;
go
use footballDW
go

CREATE TABLE GAME_DATA (
 game_id INT,
 game_date DATE,
 home_club_id INT,
 home_club_name VARCHAR(100),
 home_club_goals INT,
 away_club_id INT,
 away_club_name VARCHAR(100),
 away_club_goals INT,
 winner INT,
 competition_id VARCHAR(10),
 competition_name VARCHAR(100),
 country_name VARCHAR(100),
 player_club_id INT,
 player_id INT,
 player_name VARCHAR(100),
 yellow_cards INT,
 red_cards INT,
 goals INT,
 assists INT,
 minutes_played INT,
 date_of_birth DATE,
 position VARCHAR(50)
);
BULK INSERT GAME_DATA
FROM '/assignments/assignment_1/sql/data/footballData.txt'
WITH (FIRSTROW = 2, FIELDTERMINATOR = '|', ROWTERMINATOR = '\n');