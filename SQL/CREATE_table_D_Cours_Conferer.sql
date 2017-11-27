/*
  1. Création du dictionnaire contenant les différentes Cours à Conférer
  2. Création de la table historiant les modifications
  3. Création d'un trigger UPDATE
  4. Création d'un trigger DELETE
*/

CREATE TABLE IF NOT EXISTS D_Cours_Conferer (
  CP_Cconf                  INT(11) AUTO_INCREMENT,
  Cconf                     VARCHAR(500),
  Fonction                  ENUM('MA','MFP','CC','CT','ERROR','DIRPRES','DIRCAT','PI'),
  Titre_requis              VARCHAR(2000),
  Decret                    VARCHAR(10),
  Mise_a_jour_decret        DATETIME,
  Annexe                    VARCHAR(5),
  Modification_donnee       TIMESTAMP,
  PRIMARY KEY (CP_Cconf)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS D_Cours_Conferer_hist (
  CP_Cconf                  INT(11) AUTO_INCREMENT,
  Cconf                     VARCHAR(500),
  Fonction                  ENUM('MA','MFP','CC','CT','ERROR','DIRPRES','DIRCAT','PI'),
  Titre_requis              VARCHAR(2000),
  Decret                    VARCHAR(10),
  Mise_a_jour_decret        DATETIME,
  Annexe                    VARCHAR(5),
  Modification_donnee       TIMESTAMP,
  User_hist                 VARCHAR(20),
  Event_hist                VARCHAR(6),
  PRIMARY KEY (CP_Cconf, Modification_donnee)
) ENGINE=INNODB;

DELIMITER |
CREATE TRIGGER after_update_d_cours_conferer AFTER UPDATE
  ON D_Cours_Conferer FOR EACH ROW
  BEGIN
    INSERT INTO D_Cours_Conferer_hist (
      CP_Cconf,
      Cconf,
      Fonction,
      Titre_requis,
      Decret,
      Mise_a_jour_decret,
      Annexe,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Cconf,
      OLD.Cconf,
      OLD.Fonction,
      OLD.Titre_requis,
      OLD.Decret,
      OLD.Mise_a_jour_decret,
      OLD.Annexe,
      NOW(),
      CURRENT_USER(),
      'UPDATE');
  END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER after_delete_d_cours_conferer AFTER DELETE
  ON D_Cours_Conferer FOR EACH ROW
  BEGIN
    INSERT INTO D_Cours_Conferer_hist (
      CP_Cconf,
      Cconf,
      Fonction,
      Titre_requis,
      Decret,
      Mise_a_jour_decret,
      Annexe,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Cconf,
      OLD.Cconf,
      OLD.Fonction,
      OLD.Titre_requis,
      OLD.Decret,
      OLD.Mise_a_jour_decret,
      OLD.Annexe,
      NOW(),
      CURRENT_USER(),
      'DELETE');
  END |
DELIMITER ;