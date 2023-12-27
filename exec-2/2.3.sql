CREATE VIEW TOTAL_WIN_STATS AS
WITH WIN_STATS AS (
SELECT
c.competition_name AS 'League_Name',
COUNT(DISTINCT CASE WHEN gs.winner = 1 THEN gs.game_id END) AS 'Home_Team_Wins',
COUNT(DISTINCT CASE WHEN gs.winner = 2 THEN gs.game_id END) AS 'Away_Team_Wins',
COUNT(DISTINCT CASE WHEN gs.winner = 0 THEN gs.game_id END) AS 'Draws'
FROM
GAME_STATS gs
JOIN
DIM_COMPETITION c ON gs.competition_key = c.competition_id
GROUP BY
c.competition_name
) SELECT 
g.League_Name AS 'League Name',
g.Home_Team_Wins as 'Home Team Wins',
g.Away_Team_Wins as 'Away Team Wins',
g.DRAWS as 'Draws'
FROM 
WIN_STATS g;
SELECT * FROM TOTAL_WIN_STATS ORDER BY 'League Name';