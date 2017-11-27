/*
  1. Création du dictionnaire contenant les différents quadrimestres
  2. Création de la table historiant les modifications
  3. Création d'un trigger UPDATE
  4. Création d'un trigger DELETE
*/

CREATE TABLE IF NOT EXISTS D_Quadrimestre (
  CP_Quadrimestre           INT(11) AUTO_INCREMENT,
  Quadrimestre              INT(5),
  Q_francais                VARCHAR(30),
  Ordre                     INT(5),
  Modification_donnee       TIMESTAMP,
  PRIMARY KEY (CP_Quadrimestre)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS D_Quadrimestre_hist (
  CP_Quadrimestre           INT(11) AUTO_INCREMENT,
  Quadrimestre              INT(5),
  Q_francais                VARCHAR(30),
  Ordre                     INT(5),
  Modification_donnee       TIMESTAMP,
  User_hist                 VARCHAR(20),
  Event_hist                VARCHAR(6),
  PRIMARY KEY (CP_Quadrimestre, Modification_donnee)
) ENGINE=INNODB;

DELIMITER |
CREATE TRIGGER after_update_d_quadrimestre AFTER UPDATE
ON D_Quadrimestre FOR EACH ROW
BEGIN
    INSERT INTO D_Quadrimestre_hist (
      CP_Quadrimestre,
      Quadrimestre,
      Q_francais,
      Ordre,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Quadrimestre,
      OLD.Quadrimestre,
      OLD.Q_francais,
      OLD.Ordre,
      NOW(),
      CURRENT_USER(),
      'UPDATE');
  END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER after_delete_d_quadrimestre AFTER DELETE
  ON D_Quadrimestre FOR EACH ROW
  BEGIN
    INSERT INTO D_Quadrimestre_hist (
      CP_Quadrimestre,
      Quadrimestre,
      Q_francais,
      Ordre,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Quadrimestre,
      OLD.Quadrimestre,
      OLD.Q_francais,
      OLD.Ordre,
      NOW(),
      CURRENT_USER(),
      'DELETE');
  END |
DELIMITER ;