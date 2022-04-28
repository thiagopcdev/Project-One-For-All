DROP DATABASE IF EXISTS SpotifyClone;
CREATE DATABASE SpotifyClone;
USE SpotifyClone;

CREATE TABLE IF NOT EXISTS `artists` (
  `art_id` INT NOT NULL AUTO_INCREMENT,
  `art_name` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`art_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `services` (
  `svc_id` INT NOT NULL AUTO_INCREMENT,
  `svc_name` VARCHAR(50) NOT NULL,
  `svc_price` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`svc_id`))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `users` (
  `user_id` INT NOT NULL AUTO_INCREMENT,
  `user_name` VARCHAR(50) NOT NULL,
  `user_age` INT NOT NULL,
  `svc_id` INT NOT NULL,
  PRIMARY KEY (`user_id`),
  FOREIGN KEY (`svc_id`) REFERENCES `services` (`svc_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `albums` (
  `alb_id` INT NOT NULL AUTO_INCREMENT,
  `alb_name` VARCHAR(50) NOT NULL,
  `artist_id` INT NOT NULL,
  PRIMARY KEY (`alb_id`),
  FOREIGN KEY (`artist_id`) REFERENCES `artists` (`art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `songs` (
  `song_id` INT NOT NULL AUTO_INCREMENT,
  `song_name` VARCHAR(50) NOT NULL,
  `artist_id` INT NOT NULL,
  `album_id` INT NOT NULL,
  PRIMARY KEY (`song_id`),
  FOREIGN KEY (`artist_id`) REFERENCES `artists` (`art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`album_id`) REFERENCES `albums` (`alb_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `followers` (
  `user_id` INT NOT NULL,
  `artist_id` INT NOT NULL,
  CONSTRAINT PRIMARY KEY (`user_id`, `artist_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`artist_id`) REFERENCES `artists` (`art_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS `historic` (
  `user_id` INT NOT NULL,
  `song_id` INT NOT NULL,
  CONSTRAINT PRIMARY KEY (`user_id`, `song_id`),
  FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`song_id`) REFERENCES `songs` (`song_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

INSERT INTO artists (art_name)
VALUES
  ('Walter Phoenix'),
  ('Peter Strong'),
  ('Lance Day'),
  ('Freedie Shannon');
  
INSERT INTO services (svc_name, svc_price)
VALUES
  ('Gratuito', 0),
  ('Universitário', 5.99),
  ('Familiar', 7.99);

INSERT INTO users (user_name, user_age, svc_id)
VALUES
  ('Thati', 23, 1),
  ('Cintia', 35, 3),
  ('Bill', 20, 2),
  ('Roger', 45, 1);

INSERT INTO albums (alb_name, artist_id)
VALUES
  ('Envious', 1),
  ('Exuberant', 1),
  ('Hallowed Steam', 2),
  ('Incandescent', 3),
  ('Temporary Culture', 4);
  
INSERT INTO songs (song_name, artist_id, album_id)
VALUES
  ('Soul For Us', 1, 1),
  ('Reflections Of Magic', 1, 1),
  ('Dance With Her Own', 1, 1),
  ('Troubles Of My Inner Fire', 1,	2),
  ('Time Fireworks', 1, 2),
  ('Magic Circus',	2, 3),
  ('Honey, So Do I', 2, 3),
  ("Sweetie, Let's Go Wild",	2, 3),
  ('She Knows', 2,	3),
  ('Fantasy For Me', 3, 4),
  ('Celebration Of More', 3, 4),
  ('Rock His Everything', 3, 4),
  ('Home Forever', 3,	4),
  ('Diamond Power', 3,	4),
  ("Honey, Let's Be Silly", 3, 4),
  ('Thang Of Thunder',	4, 5),
  ('Words Of Her Life', 4,	5),
  ('Without My Streets', 4, 5);
  
INSERT INTO followers (user_id, artist_id)
VALUES
  (1, 1),
  (1, 4),
  (1, 3),
  (2, 1),
  (2, 3),
  (3, 2),
  (3, 1),
  (4, 4);

INSERT INTO historic (user_id, song_id)
VALUES
  (1, 1),
  (1, 6),
  (1, 14),
  (1, 16),
  (2, 13),
  (2, 17),
  (2, 2),
  (2, 15),
  (3, 4),
  (3, 16),
  (3, 6),
  (4, 3),
  (4, 18),
  (4, 11);
