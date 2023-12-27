SELECT 
 d.game_date, 
 hc.club_name AS Home_Team, 
 ac.club_name AS Away_Team, 
 gs.home_club_goals, 
 gs.away_club_goals
FROM 
 GAME_STATS gs
JOIN 
 DIM_DATE d ON gs.date_key = d.date_key
JOIN 
 DIM_CLUB hc ON gs.home_club_key = hc.club_id
JOIN 
 DIM_CLUB ac ON gs.away_club_key = ac.club_id
JOIN 
 DIM_COMPETITION c ON gs.competition_key = c.competition_id
WHERE 
c.competition_name = 'super-league-1'
ORDER BY 
 d.game_date ASC;