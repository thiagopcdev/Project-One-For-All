DELIMITER $$
CREATE PROCEDURE albuns_do_artista(IN artName VARCHAR(50))
BEGIN
  SELECT
    a.art_name AS `artista`,
    al.alb_name AS `album`
  FROM
    SpotifyClone.artists a
  JOIN SpotifyClone.albums al ON al.artist_id = a.art_id
  WHERE a.art_name = artName
  ORDER BY `album`;
END $$
DELIMITER ;
