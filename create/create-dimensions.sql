CREATE TABLE DIM_DATE (
 date_key INT PRIMARY KEY IDENTITY(1,1),
 game_date DATE,
year as YEAR(game_date) PERSISTED,
month as MONTH (game_date) PERSISTED
);

CREATE TABLE DIM_CLUB (
 club_id INT PRIMARY KEY,
 club_name VARCHAR(100)
);

CREATE TABLE DIM_PLAYER (
 player_id INT PRIMARY KEY,
 player_name VARCHAR(100),
 date_of_birth DATE,
 position VARCHAR(50)
);

CREATE TABLE DIM_COMPETITION (
 competition_id VARCHAR(10) PRIMARY KEY,
 competition_name VARCHAR(100),
 country_name VARCHAR(100)
);

-- Populate dimensions
INSERT INTO DIM_DATE (game_date)
SELECT DISTINCT game_date FROM GAME_DATA;

INSERT INTO DIM_CLUB (club_id, club_name)
	SELECT DISTINCT home_club_id, home_club_name FROM GAME_DATA
UNION
	SELECT DISTINCT away_club_id, away_club_name FROM GAME_DATA;

INSERT INTO DIM_PLAYER (player_id, player_name, date_of_birth, position)
SELECT DISTINCT player_id, player_name, date_of_birth, position FROM GAME_DATA;

INSERT INTO DIM_COMPETITION (competition_id, competition_name, country_name)
SELECT DISTINCT competition_id, competition_name, country_name FROM GAME_DATA;
