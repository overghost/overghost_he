/*
  1. Création du dictionnaire contenant les différentes civilités
  2. Création de la table historiant les modifications
  3. Création d'un trigger UPDATE
  4. Création d'un trigger DELETE
*/

CREATE TABLE IF NOT EXISTS D_Civilite (
  CP_Civilite               INT(11) AUTO_INCREMENT,
  Titre_court               VARCHAR(10),
  Titre_long                VARCHAR(30),
  Genre                     ENUM('F','H'),
  Modification_donnee       TIMESTAMP,
  PRIMARY KEY (CP_Civilite)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS D_Civilite_hist (
  CP_Civilite               INT(11) AUTO_INCREMENT,
  Titre_court               VARCHAR(10),
  Titre_long                VARCHAR(30),
  Genre                     ENUM('F','H'),
  Modification_donnee       TIMESTAMP,
  User_hist                 VARCHAR(20),
  Event_hist                VARCHAR(6),
  PRIMARY KEY (CP_Civilite, Modification_donnee)
) ENGINE=INNODB;

DELIMITER |
CREATE TRIGGER after_update_d_civilite AFTER UPDATE
  ON D_Civilite FOR EACH ROW
  BEGIN
    INSERT INTO d_Civilite_hist (
      CP_Civilite,
      Titre_court,
      Titre_long,
      Genre,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Civilite,
      OLD.Titre_court,
      OLD.Titre_long,
      OLD.Genre,
      NOW(),
      CURRENT_USER(),
      'UPDATE');
  END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER after_delete_d_civilite AFTER DELETE
  ON D_Civilite FOR EACH ROW
  BEGIN
    INSERT INTO d_Civilite_hist (
      CP_Civilite,
      Titre_court,
      Titre_long,
      Genre,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Civilite,
      OLD.Titre_court,
      OLD.Titre_long,
      OLD.Genre,
      NOW(),
      CURRENT_USER(),
      'DELETE');
  END |
DELIMITER ;