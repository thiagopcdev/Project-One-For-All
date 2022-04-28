## Projeto One For All!

### Habilidades

  * Modelar um banco de dados

  * Identificar entidades , atributos e relacionamentos
  
  * Aplicar a 1ª, 2ª e 3ª Forma Normal

  * Criar tabelas
  
  * Lidar com VIEWs

  * Alterar tabelas existentes

  * Criar reações dinâmicas com TRIGGERS

---

No projeto ***One For All***, você eu usei **uma** tabela para revisar e consolidar **todos** os principais conceitos vistos sobre SQL.

Recebi uma tabela não normalizada, a qual eu normalizei e populei, para poder executar queries sobre ela com o intuito de encontrar as informações solicitadas.

---

### Requisitos do projeto

#### Desafio 1

* Crie um banco com o nome de **`SpotifyClone`**.

* Providencie as queries necessárias para criar tabelas normalizadas que atendam aos requisitos descritos na seção anterior;

* Providencie as queries necessárias para popular as tabelas de acordo com os dados listados na seção anterior;

* Crie um arquivo de configurações `desafio1.json`, que mapeará em qual tabela e coluna se encontram as informações necessárias para a avaliação automatizada deste desafio. As configurações devem possuir o seguinte formato:

~~~sql
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
~~~


#### Desafio 2

Crie uma `VIEW` chamada `estatisticas_musicais` que exiba três colunas:

1. A primeira coluna deve exibir a quantidade total de canções. Dê a essa coluna o alias "**cancoes**".

2. A segunda coluna deve exibir a quantidade total de artistas e deverá ter o alias "**artistas**".

3. A terceira coluna deve exibir a quantidade de álbuns e deverá ter o alias "**albuns**".

~~~sql
  CREATE VIEW estatisticas_musicais AS
    SELECT
      (SELECT COUNT(song_id) FROM SpotifyClone.songs) AS `cancoes`,
      (SELECT COUNT(art_id) FROM SpotifyClone.artists) AS `artistas`,
      (SELECT COUNT(alb_id) FROM SpotifyClone.albums) AS `albuns`;
~~~

## Desafio 3

Crie uma `VIEW` chamada `historico_reproducao_usuarios`. Essa `VIEW` deverá ter apenas duas colunas:

1. A primeira coluna deve possuir o alias "**usuario**" e exibir o nome da pessoa usuária.

2. A segunda coluna deve possuir o alias "**nome**" e exibir o nome da canção ouvida pela pessoa com base no seu histórico de reprodução.

~~~sql
  CREATE VIEW historico_reproducao_usuarios AS
    SELECT
      u.user_name AS `usuario`,
      s.song_name AS `nome`
    FROM
      SpotifyClone.users u
    JOIN SpotifyClone.historic h ON h.user_id = u.user_id
    JOIN SpotifyClone.songs s ON s.song_id = h.song_id
    ORDER BY `usuario`, `nome`;
~~~

## Desafio 4

Crie uma `VIEW` com o nome `top_3_artistas` que deve mostrar somente as três pessoas artistas mais populares no banco `SpotifyClone`, possuindo as seguintes colunas:

1. A primeira coluna deve possuir o alias "**artista**" e exibir o nome da pessoa artista.

2. A segunda coluna deve ter o alias "**seguidores**" e exibir a quantidade de pessoas que estão seguindo aquela pessoa artista.

Seu resultado deve estar ordenado em ordem decrescente, baseando-se na quantidade de seguidores. Em caso de empate, ordene os resultados pelo nome da pessoa artista em ordem alfabética.

~~~sql
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
~~~

## Desafio 5

Estamos fazendo um estudo das músicas mais tocadas e precisamos saber quais são as duas músicas mais tocadas no momento. Crie uma `VIEW` chamada `top_2_hits_do_momento` que possua duas colunas:

1. A primeira coluna deve possuir o alias "**cancao**" e exibir o nome da canção.

2. A segunda coluna deve possuir o alias "**reproducoes**" e exibir a quantidade de pessoas que já escutaram a canção em questão.

Seu resultado deve estar ordenado em ordem decrescente, baseando-se no número de reproduções. Em caso de empate, ordene os resultados pelo nome da canção em ordem alfabética. Queremos apenas o top 2 de músicas mais tocadas.

~~~sql
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
~~~

## Desafio 6

Tendo como base o valor dos planos e o plano que cada pessoa usuária cadastrada possui no banco, queremos algumas informações sobre o faturamento da empresa. Crie uma `VIEW` chamada `faturamento_atual` que deve exibir quatro dados:

1. A primeira coluna deve ter o alias "**faturamento_minimo**" e exibir o menor valor de plano existente para uma pessoa usuária.

2. A segunda coluna deve ter o alias "**faturamento_maximo**" e exibir o maior valor de plano existente para uma pessoa usuária.

3. A terceira coluna deve ter o alias "**faturamento_medio**" e exibir o valor médio dos planos possuídos por pessoas usuárias até o momento.

4. Por fim, a quarta coluna deve ter o alias "**faturamento_total**" e exibir o valor total obtido com os planos possuídos por pessuas usuárias.

Para cada um desses dados, por se tratarem de valores monetários, deve-se arredondar o faturamento usando apenas duas casas decimais.

~~~sql
  CREATE VIEW faturamento_atual AS
    SELECT
      ROUND(MIN(s.svc_price),2) AS `faturamento_minimo`,
      ROUND(MAX(s.svc_price),2) AS `faturamento_maximo`,
      ROUND(AVG(s.svc_price),2) AS `faturamento_medio`,
      ROUND(SUM(s.svc_price),2) AS `faturamento_total`
  FROM
    SpotifyClone.services s
  JOIN SpotifyClone.users u ON u.svc_id = s.svc_id;
~~~

## Desafio 7

Mostre uma relação de todos os álbuns produzidos por cada pessoa artista, com a quantidade de seguidores que ela possui, de acordo com os detalhes a seguir. Para tal, crie uma `VIEW` chamada `perfil_artistas`, com as seguintes colunas:

1. A primeira coluna deve exibir o nome da pessoa artista, com o alias "**artista**".

2. A segunda coluna deve exibir o nome do álbum, com o alias "**album**".

3. A terceira coluna deve exibir a quantidade de pessoas seguidoras que aquela pessoa artista possui e deve possuir o alias "**seguidores**".

Seus resultados devem estar ordenados de forma decrescente, baseando-se no número de pessoas seguidoras. Em caso de empate no número de pessoas, ordene os resultados pelo nome da pessoa artista em ordem alfabética e caso há artistas com o mesmo nome, ordene os resultados pelo nome do álbum alfabeticamente.

~~~sql
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
~~~

## Desafio 8

Crie uma trigger chamada `trigger_usuario_delete` que deve ser disparada sempre que uma pessoa usuária for excluída do banco de dados, refletindo essa exclusão em todas as tabelas que ela estiver.

~~~sql
  DELIMITER $$
  CREATE TRIGGER trigger_usuario_delete
  BEFORE DELETE ON users FOR EACH ROW
  BEGIN
    DELETE FROM followers WHERE OLD.user_id = user_id;
    DELETE FROM historic WHERE OLD.user_id = user_id;
  END $$
  DELIMITER ;
~~~

## Desafio 9

Crie uma procedure chamada `albuns_do_artista` que recebe como parâmetro o nome de uma pessoa artista e em retorno deve exibir as seguintes colunas:

1. O nome da pessoa artista, com o alias "**artista**".

2. O nome do álbum, com o alias "**album**".

Os resultados devem ser ordenados pelo nome do álbum em ordem alfabética.

~~~sql
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
~~~

## Desafio 10

Crie uma function chamada de `quantidade_musicas_no_historico` que exibe a quantidade de músicas que estão presentes atualmente no histórico de reprodução de uma pessoa usuária. Ao receber o código identificador da pessoa, exiba a quantidade de canções em seu histórico de reprodução.

~~~sql
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
~~~

## Desafio 11

Crie uma `VIEW` chamada `cancoes_premium` que exiba o nome e a quantidade de vezes que cada canção foi tocada por pessoas usuárias do plano familiar ou universitário, de acordo com os detalhes a seguir:

* A primeira coluna deve exibir o nome da canção, com o alias "**nome**";

* A segunda coluna deve exibir a quantidade de pessoas que já escutaram aquela canção, com o alias "**reproducoes**";

* Seus resultados devem estar agrupados pelo nome da canção e ordenados em ordem alfabética.

~~~sql
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
~~~
