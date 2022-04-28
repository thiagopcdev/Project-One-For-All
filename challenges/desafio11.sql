CREATE VIEW cancoes_premium AS
  SELECT
    s.song_name AS `nome`,
    COUNT(*) AS `reproducoes`
  FROM
    SpotifyClone.songs s
  JOIN SpotifyClone.historic h ON h.song_id = s.song_id
  WHERE h.user_id IN (SELECT user_id FROM SpotifyClone.users WHERE svc_id IN (2,3)) 
  GROUP BY `nome`
  ORDER BY `nome`;
