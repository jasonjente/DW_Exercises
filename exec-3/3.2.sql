CREATE VIEW PLAYER_STATISTICS_VIEW AS
 WITH PLAYER_STATS AS (
 SELECT
 p.player_name AS 'Player_Name',
 SUM(gs.goals) AS 'Player_Goals',
 SUM(gs.minutes_played) AS 'Minutes_Played',
CASE 
 WHEN SUM(gs.minutes_played) = 0 THEN 0
 ELSE CAST(SUM(gs.goals) AS FLOAT) / SUM(gs.minutes_played)
 END AS 'Goals_Per_Minute',
SUM(
CASE
WHEN 
gs.home_club_key = cl.club_id
THEN
gs.assists
WHEN 
gs.away_club_key = cl.club_id
THEN
gs.assists
ELSE
0
END) AS 'Player_Assists', 
SUM(
CASE
WHEN 
cl.club_id = gs.home_club_key 
THEN
1
WHEN 
cl.club_id = gs.away_club_key 
THEN
1
ELSE
0
END) AS 'Games_Played', 
(CAST(
SUM(
CASE
WHEN 
cl.club_id = gs.home_club_key 
THEN
gs.goals
WHEN 
cl.club_id = gs.away_club_key 
THEN
gs.goals
ELSE
0
END)AS FLOAT) / NULLIF(
SUM(
CASE
WHEN 
cl.club_id = gs.home_club_key 
THEN
gs.home_club_goals
WHEN 
cl.club_id = gs.away_club_key 
THEN
gs.away_club_goals
ELSE
0
END), 0)) AS 'Goal_Participation', 
(CAST((
SUM(
CASE 
WHEN 
cl.club_id = gs.home_club_key 
THEN 
gs.goals 
WHEN
cl.club_id = gs.away_club_key 
THEN 
gs.goals 
ELSE 
0 
END) + 
SUM(
CASE
WHEN 
cl.club_id = gs.home_club_key 
THEN
gs.assists
WHEN 
cl.club_id = gs.away_club_key 
THEN
gs.assists
ELSE
0
END)) AS FLOAT) / NULLIF(
SUM(
CASE
WHEN 
cl.club_id = gs.home_club_key 
THEN
gs.home_club_goals
WHEN 
cl.club_id = gs.away_club_key 
THEN
gs.away_club_goals
ELSE
0
END), 0)) AS 'Game_Participation',
 SUM(gs.yellow_cards) AS 'Yellow_Cards',
 SUM(gs.red_cards) AS 'Red_Cards',
 SUM(gs.home_club_goals) as 'home',
 SUM(gs.away_club_goals) as 'away'
 FROM
 GAME_STATS gs
 JOIN
 DIM_COMPETITION c ON gs.competition_key = c.competition_id and country_name = 'Greece'
 JOIN
 DIM_PLAYER p ON gs.player_key = p.player_id
 JOIN 
 DIM_CLUB cl ON gs.home_club_key = cl.club_id
 GROUP BY
 p.player_name
 )
SELECT 
 ps.Player_Name AS 'Player Name',
 ps.Player_Goals as 'Player Goals',
 ps.Minutes_Played as 'Minutes Played',
 ps.Goals_Per_Minute as 'Goals per Minute',
 ps.Yellow_Cards as 'Yellow Cards',
 ps.Red_Cards as 'Red Cards',
 ps.Goal_Participation as 'Goal Participation',
 ps.Game_Participation as 'Game Participation'
FROM 
 PLAYER_STATS ps;