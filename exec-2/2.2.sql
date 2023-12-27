SELECT
 c.competition_name AS 'League Name',
 cl.club_name AS 'Team Name',
 SUM(gs.goals) AS 'Total Goals',
 SUM(gs.yellow_cards) AS 'Total Yellow Cards',
 SUM(gs.red_cards) AS 'Total Red Cards'
FROM
 GAME_STATS gs
JOIN
 DIM_COMPETITION c ON gs.competition_key = c.competition_id
JOIN
 DIM_CLUB cl ON gs.player_club_id = cl.club_id
GROUP BY
 c.competition_name, cl.club_name
ORDER BY
 c.competition_name, cl.club_name;