CREATE VIEW historico_reproducao_usuarios AS
  SELECT
    u.user_name AS `usuario`,
    s.song_name AS `nome`
  FROM
    SpotifyClone.users u
  JOIN SpotifyClone.historic h ON h.user_id = u.user_id
  JOIN SpotifyClone.songs s ON s.song_id = h.song_id
  ORDER BY `usuario`, `nome`;
