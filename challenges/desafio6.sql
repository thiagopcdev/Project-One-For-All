CREATE VIEW faturamento_atual AS
  SELECT
    ROUND(MIN(s.svc_price),2) AS `faturamento_minimo`,
    ROUND(MAX(s.svc_price),2) AS `faturamento_maximo`,
    ROUND(AVG(s.svc_price),2) AS `faturamento_medio`,
    ROUND(SUM(s.svc_price),2) AS `faturamento_total`
FROM
  SpotifyClone.services s
JOIN SpotifyClone.users u ON u.svc_id = s.svc_id;
