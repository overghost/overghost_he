/*
  1. Création d'un utilisateur
*/

GRANT ALL PRIVILEGES ON HELdB_GESPERSO.* TO 'sv'@'localhost' IDENTIFIED BY 'MOVI83seb';

-- Création

CREATE USER 'login'@'hote' [IDENTIFIED BY 'mot_de_passe'];


-- Suppression

DROP USER 'login'@'hote';

RENAME USER 'max'@'localhost' TO 'maxime'@'localhost';

SET PASSWORD FOR 'thibault'@'194.28.12.%' = PASSWORD('basket8');
