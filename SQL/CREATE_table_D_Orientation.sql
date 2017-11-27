/*
  1. Création du dictionnaire contenant les différentes orientations
  2. Création de la table historiant les modifications
  3. Création d'un trigger UPDATE
  4. Création d'un trigger DELETE
*/

CREATE TABLE IF NOT EXISTS D_Orientation (
  CP_Orientation            INT(11) AUTO_INCREMENT,
  Site                      VARCHAR(30),
  Niveau_etudes             VARCHAR(50) DEFAULT 'Bachelier',
  Categorie_court           VARCHAR(30),
  Categorie                 VARCHAR(80),
  Orientation_rac           VARCHAR(20),
  Orientation               VARCHAR(200),
  Orientation_abrev         VARCHAR(10),
  Finalite_rac              VARCHAR(20),
  Finalite                  VARCHAR(200),
  Finalite_abrev            VARCHAR(10),
  Ordre                     INT(11),
  Modification_donnee       TIMESTAMP,
  PRIMARY KEY (CP_Orientation)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS D_Orientation_hist (
  CP_Orientation            INT(11) AUTO_INCREMENT,
  Site                      VARCHAR(30),
  Niveau_etudes             VARCHAR(50) DEFAULT 'Bachelier',
  Categorie_court           VARCHAR(30),
  Categorie                 VARCHAR(80),
  Orientation_rac           VARCHAR(20),
  Orientation               VARCHAR(200),
  Orientation_abrev         VARCHAR(10),
  Finalite_rac              VARCHAR(20),
  Finalite                  VARCHAR(200),
  Finalite_abrev            VARCHAR(10),
  Ordre                     INT(11),
  Modification_donnee       TIMESTAMP,
  User_hist                 VARCHAR(20),
  Event_hist                VARCHAR(6),
  PRIMARY KEY (CP_Orientation, Modification_donnee)
) ENGINE=INNODB;

DELIMITER |
CREATE TRIGGER after_update_d_orientation AFTER UPDATE
  ON D_Orientation FOR EACH ROW
  BEGIN
    INSERT INTO D_Orientation_hist (
      CP_Orientation,
      Site,
      Niveau_etudes,
      Categorie_court,
      Categorie,
      Orientation_rac,
      Orientation,
      Orientation_abrev,
      Finalite_rac,
      Finalite,
      Finalite_abrev,
      Ordre,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Orientation,
      OLD.Site,
      OLD.Niveau_etudes,
      OLD.Categorie_court,
      OLD.Categorie,
      OLD.Orientation_rac,
      OLD.Orientation,
      OLD.Orientation_abrev,
      OLD.Finalite_rac,
      OLD.Finalite,
      OLD.Finalite_abrev,
      OLD.Ordre,
      NOW(),
      CURRENT_USER(),
      'UPDATE');
  END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER after_delete_d_orientation AFTER DELETE
  ON D_Orientation FOR EACH ROW
  BEGIN
    INSERT INTO D_Orientation_hist (
      CP_Orientation,
      Site,
      Niveau_etudes,
      Categorie_court,
      Categorie,
      Orientation_rac,
      Orientation,
      Orientation_abrev,
      Finalite_rac,
      Finalite,
      Finalite_abrev,
      Ordre,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Orientation,
      OLD.Site,
      OLD.Niveau_etudes,
      OLD.Categorie_court,
      OLD.Categorie,
      OLD.Orientation_rac,
      OLD.Orientation,
      OLD.Orientation_abrev,
      OLD.Finalite_rac,
      OLD.Finalite,
      OLD.Finalite_abrev,
      OLD.Ordre,
      NOW(),
      CURRENT_USER(),
      'DELETE');
  END |
DELIMITER ;