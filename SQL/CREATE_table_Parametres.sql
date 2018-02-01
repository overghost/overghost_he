/*
  1. Création d'une table recencent les paramètres importants à retenir
*/

CREATE TABLE IF NOT EXISTS Parametres (
  CP_Parametre              INT(11) AUTO_INCREMENT,
  Bloc                     INT(2)
  CP_Orientation            INT(11),
  PRIMARY KEY (CP_Parametre)
) ENGINE=INNODB;

ALTER TABLE Parametres
ADD Bloc                     INT(2);

DROP TABLE Parametres;