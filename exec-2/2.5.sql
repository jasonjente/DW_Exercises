CREATE VIEW PREMIER_LEAGUE_GOALS_VIEW AS
WITH PREMIER_LEAGUE_GOALS AS (
SELECT
cl.club_name AS 'Team',
d.year AS 'Year',
d.month AS 'Month',
SUM(gs.goals) AS 'Total Goals'
FROM
GAME_STATS gs
JOIN
DIM_DATE d ON gs.date_key = d.date_key
JOIN
DIM_COMPETITION c ON gs.competition_key = c.competition_id
JOIN
DIM_CLUB cl ON gs.player_club_id = cl.club_id
WHERE
c.competition_name = 'premier-league'
GROUP BY CUBE(
cl.club_name,
d.year,
d.month)
)
SELECT
plg.Team,
plg.Year,
plg.Month,
plg.[Total Goals]
FROM 
PREMIER_LEAGUE_GOALS plg;
-- εναλλακτική λύση χωρίς την χρήση όψης
SELECT
 cl.club_name AS 'Team',
 d.year AS 'Year',
 d.month AS 'Month',
 SUM(gs.goals) AS 'Total Goals'
FROM
 GAME_STATS gs
JOIN
 DIM_DATE d ON gs.date_key = d.date_key
JOIN
 DIM_COMPETITION c ON gs.competition_key = c.competition_id
JOIN
 DIM_CLUB cl ON gs.player_club_id = cl.club_id
WHERE
 c.competition_name = 'premier-league'
GROUP BY CUBE(
 cl.club_name,
 d.year,
 d.month)
ORDER BY
 cl.club_name, d.year, d.month