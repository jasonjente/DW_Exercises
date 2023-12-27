CREATE VIEW TOP_SCORRERS_GR AS
WITH GOAL_SCORRERS AS (
SELECT
p.player_name,
cl.club_name,
SUM(gs.goals) AS Total_Goals,
RANK() OVER (PARTITION BY cl.club_name ORDER BY SUM(gs.goals) DESC) AS Rank
FROM
GAME_STATS gs
JOIN
DIM_COMPETITION c ON gs.competition_key = c.competition_id and
c.competition_name = 'super-league-1'
JOIN 
DIM_CLUB cl ON gs.player_club_id = cl.club_id
JOIN 
DIM_PLAYER p ON gs.player_key = p.player_id
GROUP BY
p.player_name, cl.club_name
)
SELECT
g.club_name AS 'Team Name',
g.player_name AS 'Top Scorer',
g.Total_Goals
FROM
GOAL_SCORRERS g
WHERE
g.Rank = 1;