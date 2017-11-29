/*
  1. Création de la table architecture ue
*/

CREATE TABLE IF NOT EXISTS T_Architecture_ue (
  CP_archiue               INT(11) AUTO_INCREMENT,
  Annee                    INT(4) DEFAULT 2017,
  Bloc                     INT(2),
  CP_Quadrimestre          INT(11),
  CP_Orientation           INT(11),
  Acronyme_ue              VARCHAR(30) DEFAULT "A INTRODUIRE",
  Libelle_fr               VARCHAR(300) DEFAULT "A INTRODUIRE",
  Volume_horaire_q1        DOUBLE DEFAULT 0,
  Volume_horaire_q2        DOUBLE DEFAULT 0,
  Nombre_credits_q1        DOUBLE DEFAULT 0,
  Nombre_credits_q2        DOUBLE DEFAULT 0,
  Ponderation              DOUBLE DEFAULT 0,
  Obligatoire              TINYINT DEFAULT 0,
  Remediation              TINYINT DEFAULT 0,
  Numero_UE                INT(11) DEFAULT 0,
  Mode_evaluation          VARCHAR(300),
  AA_a_choix               TINYINT DEFAULT 0,
  Calcul_automatique       TINYINT DEFAULT 0,
  Seuil_minimal_aa         INT(11) DEFAULT 20,
  Nombre_maximum_echecs_aa INT(11) DEFAULT 0,
  Modification_donnee      TIMESTAMP,
  PRIMARY KEY (CP_archiue),
  CONSTRAINT fk_quadri FOREIGN KEY (CP_Quadrimestre) REFERENCES D_Quadrimestre (CP_Quadrimestre),
  CONSTRAINT fk_ori FOREIGN KEY (CP_Orientation) REFERENCES D_Orientation (CP_Orientation)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS T_Architecture_ue_hist (
  CP_archiue               INT(11) AUTO_INCREMENT,
  Annee                    INT(4) DEFAULT 2017,
  Bloc                     INT(2),
  CP_Quadrimestre          INT(11),
  CP_Orientation           INT(11),
  Acronyme_ue              VARCHAR(30) DEFAULT "A INTRODUIRE",
  Libelle_fr               VARCHAR(300) DEFAULT "A INTRODUIRE",
  Volume_horaire_q1        DOUBLE DEFAULT 0,
  Volume_horaire_q2        DOUBLE DEFAULT 0,
  Nombre_credits_q1        DOUBLE DEFAULT 0,
  Nombre_credits_q2        DOUBLE DEFAULT 0,
  Ponderation              DOUBLE DEFAULT 0,
  Obligatoire              TINYINT DEFAULT 0,
  Remediation              TINYINT DEFAULT 0,
  Numero_UE                INT(11) DEFAULT 0,
  Mode_evaluation          VARCHAR(300),
  AA_a_choix               TINYINT DEFAULT 0,
  Calcul_automatique       TINYINT DEFAULT 0,
  Seuil_minimal_aa         INT(11) DEFAULT 20,
  Nombre_maximum_echecs_aa INT(11) DEFAULT 0,
  Modification_donnee       TIMESTAMP,
  User_hist                 VARCHAR(20),
  Event_hist                VARCHAR(6),
  PRIMARY KEY (CP_archiue, Modification_donnee)
) ENGINE=INNODB;

DELIMITER |
CREATE TRIGGER after_update_T_Architecture_ue AFTER UPDATE
  ON T_Architecture_ue FOR EACH ROW
  BEGIN
    INSERT INTO T_Architecture_ue_hist (
      CP_archiue,
      Annee,
      Bloc,
      CP_Quadrimestre,
      CP_Orientation,
      Acronyme_ue,
      Libelle_fr,
      Volume_horaire_q1,
      Volume_horaire_q2,
      Nombre_credits_q1,
      Nombre_credits_q2,
      Ponderation,
      Obligatoire,
      Remediation,
      Numero_UE,
      Mode_evaluation,
      AA_a_choix,
      Calcul_automatique,
      Seuil_minimal_aa,
      Nombre_maximum_echecs_aa,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_archiue,
      OLD.Annee,
      OLD.Bloc,
      OLD.CP_Quadrimestre,
      OLD.CP_Orientation,
      OLD.Acronyme_ue,
      OLD.Libelle_fr,
      OLD.Volume_horaire_q1,
      OLD.Volume_horaire_q2,
      OLD.Nombre_credits_q1,
      OLD.Nombre_credits_q2,
      OLD.Ponderation,
      OLD.Obligatoire,
      OLD.Remediation,
      OLD.Numero_UE,
      OLD.Mode_evaluation,
      OLD.AA_a_choix,
      OLD.Calcul_automatique,
      OLD.Seuil_minimal_aa,
      OLD.Nombre_maximum_echecs_aa,
      NOW(),
      CURRENT_USER(),
      'UPDATE');
  END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER after_delete_T_Architecture_ue AFTER DELETE
  ON T_Architecture_ue FOR EACH ROW
  BEGIN
    INSERT INTO T_Architecture_ue_hist (
      CP_archiue,
      Annee,
      Bloc,
      CP_Quadrimestre,
      CP_Orientation,
      Acronyme_ue,
      Libelle_fr,
      Volume_horaire_q1,
      Volume_horaire_q2,
      Nombre_credits_q1,
      Nombre_credits_q2,
      Ponderation,
      Obligatoire,
      Remediation,
      Numero_UE,
      Mode_evaluation,
      AA_a_choix,
      Calcul_automatique,
      Seuil_minimal_aa,
      Nombre_maximum_echecs_aa,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_archiue,
      OLD.Annee,
      OLD.Bloc,
      OLD.CP_Quadrimestre,
      OLD.CP_Orientation,
      OLD.Acronyme_ue,
      OLD.Libelle_fr,
      OLD.Volume_horaire_q1,
      OLD.Volume_horaire_q2,
      OLD.Nombre_credits_q1,
      OLD.Nombre_credits_q2,
      OLD.Ponderation,
      OLD.Obligatoire,
      OLD.Remediation,
      OLD.Numero_UE,
      OLD.Mode_evaluation,
      OLD.AA_a_choix,
      OLD.Calcul_automatique,
      OLD.Seuil_minimal_aa,
      OLD.Nombre_maximum_echecs_aa,
      NOW(),
      CURRENT_USER(),
      'DELETE');
  END |
DELIMITER ;