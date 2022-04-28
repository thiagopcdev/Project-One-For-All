DELIMITER $$
CREATE FUNCTION quantidade_musicas_no_historico(userId int)
RETURNS INT READS SQL DATA
BEGIN
  DECLARE qnt INT;
  SELECT COUNT(*) AS `quantidade_musicas_no_historico`
  FROM SpotifyClone.historic
  WHERE user_id = userId INTO qnt;
  RETURN qnt;
END $$
DELIMITER ;
