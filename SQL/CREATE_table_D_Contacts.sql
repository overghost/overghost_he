/*
  1. Création du dictionnaire contenant les différents contacts
  2. Création de la table historiant les modifications
  3. Création d'un trigger UPDATE
  4. Création d'un trigger DELETE
*/

CREATE TABLE IF NOT EXISTS D_Contacts (
  CP_Contacts               INT(11) AUTO_INCREMENT,
  CP_Civilite               INT(11),
  Nom                       VARCHAR(70),
  Prenom                    VARCHAR(70),
  Adresse_1                 VARCHAR(300),
  Adresse_2                 VARCHAR(300),
  Adresse_3                 VARCHAR(300),
  Adresse_4                 VARCHAR(300),
  Code_postal               INT(6),
  Ville                     VARCHAR(100),
  Pays                      VARCHAR(100) DEFAULT 'BELGIQUE',
  Numero_contact_prive      VARCHAR(20),
  Numero_contact_pro        VARCHAR(20),
  e_mail_prive              VARCHAR(500),
  e_mail_pro                VARCHAR(500),
  Date_de_naissance         DATE,
  Type_contact              VARCHAR(50),
  Modification_donnee       TIMESTAMP,
  PRIMARY KEY (CP_Contacts),
  CONSTRAINT fk_civilite FOREIGN KEY (CP_Civilite)
  REFERENCES D_Civilite (CP_Civilite)
) ENGINE=INNODB;

CREATE TABLE IF NOT EXISTS D_Contacts_hist (
  CP_Contacts               INT(11) AUTO_INCREMENT,
  CP_Civilite               INT(11),
  Nom                       VARCHAR(70),
  Prenom                    VARCHAR(70),
  Adresse_1                 VARCHAR(300),
  Adresse_2                 VARCHAR(300),
  Adresse_3                 VARCHAR(300),
  Adresse_4                 VARCHAR(300),
  Code_postal               INT(6),
  Ville                     VARCHAR(100),
  Pays                      VARCHAR(100) DEFAULT 'BELGIQUE',
  Numero_contact_prive      VARCHAR(20),
  Numero_contact_pro        VARCHAR(20),
  e_mail_prive              VARCHAR(500),
  e_mail_pro                VARCHAR(500),
  Date_de_naissance         DATE,
  Type_contact              VARCHAR(50),
  Modification_donnee       TIMESTAMP,
  User_hist                 VARCHAR(20),
  Event_hist                VARCHAR(6),
  PRIMARY KEY (CP_Contacts, Modification_donnee)
) ENGINE=INNODB;

DELIMITER |
CREATE TRIGGER after_update_d_contacts AFTER UPDATE
  ON D_Contacts FOR EACH ROW
  BEGIN
    INSERT INTO D_Contacts_hist (
      CP_Contacts,
      CP_Civilite,
      Nom,
      Prenom,
      Adresse_1,
      Adresse_2,
      Adresse_3,
      Adresse_4,
      Code_postal,
      Ville,
      Pays,
      Numero_contact_prive,
      Numero_contact_pro,
      e_mail_prive,
      e_mail_pro,
      Date_de_naissance,
      Type_contact,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Contacts,
      OLD.CP_Civilite,
      OLD.Nom,
      OLD.Prenom,
      OLD.Adresse_1,
      OLD.Adresse_2,
      OLD.Adresse_3,
      OLD.Adresse_4,
      OLD.Code_postal,
      OLD.Ville,
      OLD.Pays,
      OLD.Numero_contact_prive,
      OLD.Numero_contact_pro,
      OLD.e_mail_prive,
      OLD.e_mail_pro,
      OLD.Date_de_naissance,
      OLD.Type_contact,
      NOW(),
      CURRENT_USER(),
      'UPDATE');
  END |
DELIMITER ;

DELIMITER |
CREATE TRIGGER after_delete_d_contacts AFTER DELETE
  ON D_Contacts FOR EACH ROW
  BEGIN
    INSERT INTO D_Contacts_hist (
      CP_Contacts,
      CP_Civilite,
      Nom,
      Prenom,
      Adresse_1,
      Adresse_2,
      Adresse_3,
      Adresse_4,
      Code_postal,
      Ville,
      Pays,
      Numero_contact_prive,
      Numero_contact_pro,
      e_mail_prive,
      e_mail_pro,
      Date_de_naissance,
      Type_contact,
      Modification_donnee,
      User_hist,
      Event_hist)
    VALUES (
      OLD.CP_Contacts,
      OLD.CP_Civilite,
      OLD.Nom,
      OLD.Prenom,
      OLD.Adresse_1,
      OLD.Adresse_2,
      OLD.Adresse_3,
      OLD.Adresse_4,
      OLD.Code_postal,
      OLD.Ville,
      OLD.Pays,
      OLD.Numero_contact_prive,
      OLD.Numero_contact_pro,
      OLD.e_mail_prive,
      OLD.e_mail_pro,
      OLD.Date_de_naissance,
      OLD.Type_contact,
      NOW(),
      CURRENT_USER(),
      'DELETE');
  END |
DELIMITER ;