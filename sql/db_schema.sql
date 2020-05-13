--DLL's for Sequences
CREATE SEQUENCE Oceny_SEQ MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

CREATE SEQUENCE "Ksiazki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

CREATE SEQUENCE "Jezyki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Autorzy-arm
CREATE SEQUENCE "Autorzy_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;
CREATE SEQUENCE "KsiazkiAutorzy_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Gatunki-arm
CREATE SEQUENCE "Gatunki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;
CREATE SEQUENCE "KsiazkiGatunki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

-------------------------------------------------------------------------------------------------
-- DDL's for Sequence film-side
CREATE SEQUENCE "Filmy_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;
CREATE SEQUENCE "FilmyKategoria_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;
CREATE SEQUENCE "Kategoria_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;
CREATE SEQUENCE "OcenyFilmu_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

--------------------------------------------------------------------------------------------------

--DLL for Oceny
CREATE TABLE Oceny (
  idocena NUMBER(*,0) NOT NULL,
  "Ocena" NUMBER(*,0),
  "Krytyk" varchar(255 byte) DEFAULT 'nie',
  "idksiazka" NUMBER(*,0)
);

ALTER TABLE Oceny ADD ( CONSTRAINT Oceny_pk PRIMARY KEY (idocena));

--DLL for Ksiazki
CREATE TABLE "Ksiazki" (
  "idksiazka" NUMBER(*,0) constraint Ksiazki_pk PRIMARY KEY,
  "Tytul" varchar(255 byte)
) TABLESPACE "USERS"
;

--DLL for Jezyki
CREATE TABLE "Jezyki" (
  "idjezyk" NUMBER(*,0) constraint Jezyki_pk PRIMARY KEY,
  "nazwa" varchar(255 byte),
  "data_wydania" date,
  "idksiazka" NUMBER(*,0)
) TABLESPACE "USERS"
;

--DLL for Autorzy
CREATE TABLE "Autorzy" (
  "idautor" NUMBER(*,0) constraint Autorzy_pk PRIMARY KEY,
  "Imie" varchar(255 byte),
  "Nazwisko" varchar(255 byte),
  "urodzony" date,
  "zmarly" date
) TABLESPACE "USERS"
;

--DLL for KsiazkiAutorzy
CREATE TABLE "KsiazkiAutorzy" (
  "idKA" NUMBER(*,0) constraint KsiazkiAutorzy_pk PRIMARY KEY,
  "idautor" NUMBER(*,0),
  "idksiazka" NUMBER(*,0)
) TABLESPACE "USERS"
;

--DLL for Gatunki
CREATE TABLE "Gatunki" (
  "idgatunek" NUMBER(*,0) constraint Gatunki_pk PRIMARY KEY,
  "Nazwa" varchar(255 byte)
) TABLESPACE "USERS"
;

--DLL for KsiazkiGatunki
CREATE TABLE "KsiazkiGatunki" (
  "idKG" NUMBER(*,0) constraint KsiazkiGautnki_pk PRIMARY KEY,
  "idgatunek" NUMBER(*,0),
  "idksiazka" NUMBER(*,0)
) TABLESPACE "USERS"
;

--DLL for Filmy
CREATE TABLE "Filmy" (
  "idfilm" NUMBER(*,0) constraint Filmy_pk PRIMARY KEY,
  "Tytul" varchar(255 byte),
  "idksiazka" NUMBER(*,0)
) TABLESPACE "USERS"
;

--DLL for OcenyFilmu
CREATE TABLE "OcenyFilmu" (
  "idocena" NUMBER(*,0) constraint OcenyFilmu_pk PRIMARY KEY,
  "Ocena" NUMBER(*,0),
  "Krytyk" varchar(255 byte),
  "idfilm" NUMBER(*,0)
) TABLESPACE "USERS"
;

--DLL for Kategoria
CREATE TABLE "Kategoria" (
  "idkategoria" NUMBER(*,0) constraint Kategoria_pk PRIMARY KEY,
  "Nazwa" varchar(255 byte)
) TABLESPACE "USERS"
;

--DLL for FilmyKategoria
CREATE TABLE "FilmyKategoria" (
  "idFK" NUMBER(*,0) constraint FilmyKategoria_pk PRIMARY KEY, 
  "idfilm" NUMBER(*,0),
  "idkategoria" NUMBER(*,0)
) TABLESPACE "USERS"
;
--------------------------------------------------------------------------
--DLL's for Triggers auto_increment on insert
--------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER OCENY_ON_INSERT 
BEFORE INSERT ON Oceny 
FOR EACH ROW 
WHEN (new.idocena IS NULL) 
BEGIN
  select Oceny_SEQ.NEXTVAL
  INTO :new.
END;

CREATE OR REPLACE TRIGGER OCENY_ON_INSERT 
  BEFORE INSERT ON Oceny
  FOR EACH ROW
  BEGIN
    SELECT Oceny_SEQ.NEXTVAL 
    INTO :new.idocena 
    From dual;
  END;
/
CREATE OR REPLACE EDITIONABLE TRIGGER Ksiazki_on_insert
  Before Insert ON Ksiazki
  FOR EACH ROW
  BEGIN
    SELECT Ksiazki_SEQ.nextval
    INTO :new.idksiazka
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER Jezyki_on_insert
  Before Insert ON Jezyki
  FOR EACH ROW
  BEGIN
    SELECT Jezyki_SEQ.nextval
    INTO :new.idjezyk
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER Autorzy_on_insert
  Before Insert ON Autorzy
  FOR EACH ROW
  BEGIN
    SELECT Autorzy_SEQ.nextval
    INTO :new.idautor
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER KsiazkiAutorzy_on_insert
  Before Insert ON KsiazkiAutorzy
  FOR EACH ROW
  BEGIN
    SELECT KsiazkiAutorzy_SEQ.nextval
    INTO :new.idKA
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER Gatunki_on_insert
  Before Insert ON Gatunki
  FOR EACH ROW
  BEGIN
    SELECT Gatunki_SEQ.nextval
    INTO :new.idgatunek
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER KsiazkiGatunki_on_insert
  Before Insert ON KsiazkiGatunki
  FOR EACH ROW
  BEGIN
    SELECT KsiazkiGatunki_SEQ.nextval
    INTO :new.idKG
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER Filmy_on_insert
  Before Insert ON Filmy
  FOR EACH ROW
  BEGIN
    SELECT Filmy_SEQ.nextval
    INTO :new.idfilm
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER OcenyFilmu_on_insert
  Before Insert ON OcenyFilmu
  FOR EACH ROW
  BEGIN
    SELECT OcenyFilmu_SEQ.nextval
    INTO :new.idocena
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER Kategoria_on_insert
  Before Insert ON Kategoria
  FOR EACH ROW
  BEGIN
    SELECT Kategoria_SEQ.nextval
    INTO :new.idkategoria
    FROM dual
  END;
  
CREATE OR REPLACE EDITIONABLE TRIGGER FilmyKategoria_on_insert
  Before Insert ON FilmyKategoria
  FOR EACH ROW
  BEGIN
    SELECT FilmyKategoria_SEQ.nextval
    INTO :new.idFK
    FROM dual
  END;
  
ALTER TRIGGER "Oceny_on_insert" ENABLE;
ALTER TRIGGER "Ksiazki_on_insert" ENABLE;
ALTER TRIGGER "Jezyki_on_insert" ENABLE;
ALTER TRIGGER "Autorzy_on_insert" ENABLE;
ALTER TRIGGER "KsiazkiAutorzy_on_insert" ENABLE;
ALTER TRIGGER "OcenyFilmu_on_insert" ENABLE;
ALTER TRIGGER "Filmy_on_insert" ENABLE;
ALTER TRIGGER "Kategoria_on_insert" ENABLE;
ALTER TRIGGER "FilmyKategoria_on_insert" ENABLE;
ALTER TRIGGER "KsiazkiGatunki_on_insert" ENABLE;
ALTER TRIGGER "Gatunki_on_insert" ENABLE;
-----------------------------------------------------------------
-- DDL for Procedure CREATE (INSERT)
-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_OCENA"(  Ocena_in IN NUMBER, Krytyk_in IN VARCHAR, idksiazka_in IN NUMBER) AS
BEGIN
  if( ocena_in > 10 ) THEN
        ocena_in=10;
  end if;
  if( ocena_in < 0 ) THEN
        ocena_in=0;
  end if; 
	INSERT INTO OCENY (Ocena,
	Krytyk,
	idksiazka)
	VALUES (Ocena_in,Krytyk_in,idksiazka_in);
END CREATE_OCENA

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_Gatunki"
(
 Nazwa_in IN VARCHAR

) AS
BEGIN
	INSERT INTO Gatunki (Nazwa)
	VALUES (Nazwa_in);
END CREATE_Gatunki
	
  
CREATE OR REPLACE PROCEDURE "CREATE_KG"
(
 idgatunek_in IN NUMBER
, idksiazka_in IN NUMBER
) AS
BEGIN
	INSERT INTO KsiazkiGatunki (idgatunek,idksiazka)
	VALUES (idgatunek_in,idksiazka_in);
END CREATE_KG


-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_Ksiazki"
(
 tytul_in IN VARCHAR
) AS
BEGIN
	INSERT INTO Ksiazki (Tytul)
	VALUES (tytul_in);
END CREATE_Ksiazki

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_Jezyki"
(
 nazwa_in IN VARCHAR,
 data_wyd IN DATE,
 idks IN NUMBER 
) AS
BEGIN
	INSERT INTO Jezyki (nazwa,data_wydania,idksiazka)
	VALUES (nazwa_in,data_wyd,idks);
END CREATE_Jezyki

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_Autorzy"
(
 imie_in IN VARCHAR,
 nazwisko_in IN VARCHAR,
 urodz IN date ,
 zmarl IN date
) AS
BEGIN
	INSERT INTO Autorzy (Imie,Nazwisko,urodzony,zmarly)
	VALUES (imie_in,nazwsko_in,urodz,zmarl);
END CREATE_Autorzy

CREATE OR REPLACE PROCEDURE "CREATE_KA"
(
 idautor_in IN NUMBER
, idksiazka_in IN NUMBER
) AS
BEGIN
	INSERT INTO KsiazkiAutorzy (idautorzy,idksiazka)
	VALUES (idgatunek_in,idksiazka_in);
END CREATE_KG

-----------------------------------------------------------------
-- Fimy i pochodne
-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_Filmy"
(
 tytul_in IN VARCHAR
 ksiazka_in IN VARCHAR
) AS
BEGIN
	INSERT INTO Filmy (Tytul,idksiazka)
	VALUES (tytul_in,ksiazka_in);
END CREATE_Ksiazki


-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_OcenyFilmu"
(
 ocena_in IN NUMBER
 krytyk IN VARCHAR
 idfilmu IN NUMBER
) AS
BEGIN
  if( ocena_in > 10 ) THEN
        ocena_in=10;
  end if;
  if( ocena_in < 0 ) THEN
        ocena_in=0;
  end if; 
	INSERT INTO OcenyFilmu (Ocena,Krytyk,idfilm)
	VALUES (tytul_in,ksiazka_in);
END CREATE_OcenyFilmu

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE "CREATE_Kategoria"
(
 Nazwa_in IN VARCHAR
) AS
BEGIN 
	INSERT INTO Kategoria (Nazwa)
	VALUES (Nazwa_in);
END CREATE_Kategoria

CREATE OR REPLACE PROCEDURE "CREATE_FK"
(
 idfilm_in IN NUMBER
, idkategoria_in IN NUMBER
) AS
BEGIN
	INSERT INTO FilmyKategoria (idfilm,idkategoria)
	VALUES (idfilm_in,idkategoria_in);
END CREATE_KG


ALTER TABLE Oceny ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE KsiazkiAutorzy ADD FOREIGN KEY (idautor) REFERENCES Autorzy (idautor);

ALTER TABLE KsiazkiAutorzy ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE KsiazkiGatunki ADD FOREIGN KEY (idgatunek) REFERENCES Gatunki (idgatunek);

ALTER TABLE KsiazkiGatunki ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE FilmyKategoria ADD FOREIGN KEY (idfilm) REFERENCES Filmy (idfilm);

ALTER TABLE FilmyKategoria ADD FOREIGN KEY (idkategoria) REFERENCES Kategoria (idkategoria);

ALTER TABLE Jezyki ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE OcenyFilmu ADD FOREIGN KEY (idocena) REFERENCES Filmy (idfilm);

ALTER TABLE Filmy ADD FOREIGN KEY (idfilm) REFERENCES Ksiazki (idksiazka);










	