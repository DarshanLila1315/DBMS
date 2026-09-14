-- 1. Players who belong to teams located in 'Mumbai'
SELECT P.*
FROM PLAYER P
JOIN TEAM T ON P.TEAM_ID = T.TEAM_ID
JOIN STADIUM S ON T.HOME_STADIUM_ID = S.Stadium_id
WHERE S.Stadium_city = 'Mumbai';

-- 2. Display all teams and their players (include teams with no players)
SELECT T.TEAM_ID, T.TEAM_NAME, P.PLAYER_ID, P.PLAYER_FIRST_NAME, P.PLAYER_LAST_NAME
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
ORDER BY T.TEAM_ID;

-- 3. Players along with team wins and stadium city
SELECT P.PLAYER_ID, P.PLAYER_FIRST_NAME, P.PLAYER_LAST_NAME,
       T.TEAM_NAME, T.TEAM_WINS, S.Stadium_city
FROM PLAYER P
JOIN TEAM T ON P.TEAM_ID = T.TEAM_ID
LEFT JOIN STADIUM S ON T.HOME_STADIUM_ID = S.Stadium_id;

-- 4. Team name and number of players in each team
SELECT T.TEAM_NAME, COUNT(P.PLAYER_ID) AS PlayerCount
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY PlayerCount DESC;

-- 5. Team name, coach, and number of bowlers in each team
SELECT T.TEAM_NAME, T.TEAM_COACH,
       SUM(CASE WHEN UPPER(P.PLAYER_ROLE) = 'BOWLER' THEN 1 ELSE 0 END) 
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME, T.TEAM_COACH;

-- 6. Team name with count of Batsmen, Bowlers, and All-rounders
SELECT T.TEAM_NAME,
       SUM(CASE WHEN UPPER(P.PLAYER_ROLE) = 'BATSMAN' THEN 1 ELSE 0 END) AS Batsmen,
       SUM(CASE WHEN UPPER(P.PLAYER_ROLE) = 'BOWLER' THEN 1 ELSE 0 END) AS Bowlers,
       SUM(CASE WHEN UPPER(P.PLAYER_ROLE) LIKE '%ALL-ROUND%' OR UPPER(P.PLAYER_ROLE) = 'ALL-ROUNDER' THEN 1 ELSE 0 END) AS AllRounders
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME
ORDER BY T.TEAM_NAME;

-- 7. Stadiums where a home team has won more than 10 matches
SELECT DISTINCT S.Stadium_id, S.Stadium_name, S.Stadium_city
FROM STADIUM S
JOIN TEAM T ON T.HOME_STADIUM_ID = S.Stadium_id
WHERE T.TEAM_WINS > 10;

-- 8. Team name and number of players whose matches played is greater than 25
SELECT T.TEAM_NAME,
       SUM(CASE WHEN ISNULL(P.PLAYER_MATCHES_PLAYED,0) > 25 THEN 1 ELSE 0 END) 
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

-- 9. Team name and total number of players having jersey number greater than 30
SELECT T.TEAM_NAME,
       SUM(CASE WHEN ISNULL(P.PLAYER_JERSEY_NUMBER,0) > 30 THEN 1 ELSE 0 END) 
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

-- 10. Team name and total matches played by its players
SELECT T.TEAM_NAME,
       SUM(ISNULL(P.PLAYER_MATCHES_PLAYED,0))
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

-- Part – B:
-- 11. Display stadium city and total number of teams in each city.
SELECT S.Stadium_city, COUNT(T.TEAM_ID) AS TeamsCount
FROM STADIUM S
LEFT JOIN TEAM T ON T.HOME_STADIUM_ID = S.Stadium_id
GROUP BY S.Stadium_city;

-- 12. Display team name and average matches played by players in each team.
SELECT T.TEAM_NAME, AVG(CAST(P.PLAYER_MATCHES_PLAYED AS FLOAT)) AS AvgMatchesPlayed
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

-- 13. Display team name and maximum matches played by any player in each team.
SELECT T.TEAM_NAME, MAX(P.PLAYER_MATCHES_PLAYED) AS MaxMatchesPlayed
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

-- 14. Display team name and minimum matches played by any player in each team.
SELECT T.TEAM_NAME, MIN(P.PLAYER_MATCHES_PLAYED) AS MinMatchesPlayed
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

-- 15. Display stadium name and total number of players playing under teams of that stadium.
SELECT S.Stadium_name, COUNT(P.PLAYER_ID) AS TotalPlayers
FROM STADIUM S
LEFT JOIN TEAM T ON T.HOME_STADIUM_ID = S.Stadium_id
LEFT JOIN PLAYER P ON P.TEAM_ID = T.TEAM_ID
GROUP BY S.Stadium_name;

-- Part – C:
-- 16. Display teams having more all-rounders than bowlers.
SELECT T.TEAM_NAME
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME
HAVING SUM(CASE WHEN UPPER(P.PLAYER_ROLE) LIKE '%ALL-ROUND%' OR UPPER(P.PLAYER_ROLE) = 'ALL-ROUNDER' THEN 1 ELSE 0 END) 
     > SUM(CASE WHEN UPPER(P.PLAYER_ROLE) = 'BOWLER' THEN 1 ELSE 0 END);

-- 17. Display teams where difference between max and min player matches is greater than 5.
SELECT T.TEAM_NAME,
       COALESCE(MAX(P.PLAYER_MATCHES_PLAYED),0) - COALESCE(MIN(P.PLAYER_MATCHES_PLAYED),0) AS MatchesDiff
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME
HAVING COALESCE(MAX(P.PLAYER_MATCHES_PLAYED),0) - COALESCE(MIN(P.PLAYER_MATCHES_PLAYED),0) > 5;

-- 18. Display stadium city and total wins of teams in that city.
SELECT S.Stadium_city, COALESCE(SUM(T.TEAM_WINS),0) AS TotalWins
FROM STADIUM S
LEFT JOIN TEAM T ON T.HOME_STADIUM_ID = S.Stadium_id
GROUP BY S.Stadium_city;

-- 19. Display team name and total number of players for each role (grouped by role).
SELECT T.TEAM_NAME, COALESCE(P.PLAYER_ROLE,'Unknown') AS PLAYER_ROLE, COUNT(P.PLAYER_ID) AS RoleCount
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME, COALESCE(P.PLAYER_ROLE,'Unknown')
ORDER BY T.TEAM_NAME, PLAYER_ROLE;

-- 20. Display team name and total number of players whose name starts with 'A'
SELECT T.TEAM_NAME,
       SUM(CASE WHEN UPPER(P.PLAYER_FIRST_NAME) LIKE 'A%' THEN 1 ELSE 0 END) AS PlayersStartingWithA
FROM TEAM T
LEFT JOIN PLAYER P ON T.TEAM_ID = P.TEAM_ID
GROUP BY T.TEAM_NAME;

