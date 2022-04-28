DELIMITER $$
CREATE TRIGGER trigger_usuario_delete
BEFORE DELETE ON users FOR EACH ROW
BEGIN
  DELETE FROM followers WHERE OLD.user_id = user_id;
  DELETE FROM historic WHERE OLD.user_id = user_id;
END $$
DELIMITER ;
