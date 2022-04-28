CREATE VIEW perfil_artistas AS
  SELECT
    a.art_name AS `artista`,
    al.alb_name AS `album`,
    COUNT(*) AS `seguidores`
  FROM
    SpotifyClone.artists a
  JOIN SpotifyClone.albums al ON al.artist_id = a.art_id
  JOIN SpotifyClone.followers f ON f.artist_id = al.artist_id
  GROUP BY `album`,`artista`
  ORDER BY `seguidores` DESC, `artista`;
