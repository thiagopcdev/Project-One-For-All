CREATE VIEW top_2_hits_do_momento AS
  SELECT
    s.song_name AS `cancao`,
    COUNT(*) AS `reproducoes`
  FROM
    SpotifyClone.songs s
  JOIN SpotifyClone.historic h ON h.song_id = s.song_id
  GROUP BY `cancao`
  ORDER BY `reproducoes` DESC, `cancao`
  LIMIT 2;
