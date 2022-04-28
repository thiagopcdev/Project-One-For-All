CREATE VIEW top_3_artistas AS
  SELECT
    a.art_name AS `artista`,
    COUNT(f.artist_id) AS `seguidores`
  FROM
    SpotifyClone.artists a
  JOIN SpotifyClone.followers f ON f.artist_id = a.art_id
  GROUP BY `artista`
  ORDER BY `seguidores` DESC, `artista`
  LIMIT 3;
