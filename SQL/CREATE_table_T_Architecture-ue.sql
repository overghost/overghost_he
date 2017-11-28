/*
  1. Création de la table architecture ue
*/

CREATE TABLE IF NOT EXISTS T_Architecture_ue (
  CP_archiue               INT(11) AUTO_INCREMENT,
  Annee                    INT(4) DEFAULT 2017,
  Bloc                     INT(2),
  CP_Quadrimestre          INT(11),
  CP_Orientation           INT(11),
  Acronyme_ue              VARCHAR(30),
  Libelle_fr               VARCHAR(300),
  Volume_horaire           INT(11),
  Nombre_credits_q1        INT(11),
  Nombre_credits_q2        INT(11),
  Ponderation              INT(11),
  Obligatoire              TINYINT,
  Remediation              TINYINT,
  Numero_UE                INT(11),
  Mode_evaluation          VARCHAR(300),
  AA_a_choix               TINYINT,
  Calcul_automatique       TINYINT,
  Seuil_minimal_aa         INT(11),
  Nombre_maximum_echecs_aa INT(11),
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
  Acronyme_ue              VARCHAR(30),
  Libelle_fr               VARCHAR(300),
  Volume_horaire           INT(11),
  Nombre_credits_q1        INT(11),
  Nombre_credits_q2        INT(11),
  Ponderation              INT(11),
  Obligatoire              TINYINT,
  Remediation              TINYINT,
  Numero_UE                INT(11),
  Mode_evaluation          VARCHAR(300),
  AA_a_choix               TINYINT,
  Calcul_automatique       TINYINT,
  Seuil_minimal_aa         INT(11),
  Nombre_maximum_echecs_aa INT(11),
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
      Volume_horaire,
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
      OLD.Volume_horaire,
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
      Volume_horaire,
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
      OLD.Volume_horaire,
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