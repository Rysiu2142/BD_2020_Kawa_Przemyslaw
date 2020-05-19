--DLL's for Sequences
CREATE SEQUENCE Oceny_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE SEQUENCE Ksiazki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE SEQUENCE Jezyki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Autorzy-arm
CREATE SEQUENCE Autorzy_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE KsiazkiAutorzy_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Gatunki-arm
CREATE SEQUENCE Gatunki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE KsiazkiGatunki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

-------------------------------------------------------------------------------------------------
-- DDL's for Sequence film-side
CREATE SEQUENCE Filmy_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE FilmyKategoria_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE Kategoria_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE OcenyFilmu_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1  NOCACHE NOCYCLE;

--------------------------------------------------------------------------------------------------

--DLL for Oceny
CREATE TABLE Oceny (
  idocena NUMBER(10) PRIMARY KEY,
  Ocena NUMBER(10),
  Krytyk varchar2(255) DEFAULT 'nie',
  idksiazka NUMBER(10)
);



--DLL for Ksiazki
CREATE TABLE Ksiazki (
  idksiazka NUMBER(10) PRIMARY KEY,
  Tytul varchar2(255)
);

--DLL for Jezyki
CREATE TABLE Jezyki (
  idjezyk NUMBER(10) PRIMARY KEY,
  nazwa varchar2(255),
  data_wydania date,
  idksiazka NUMBER(10)
);

--DLL for Autorzy
CREATE TABLE Autorzy (
  idautor NUMBER(10) PRIMARY KEY,
  Imie varchar2(255),
  Nazwisko varchar2(255),
  urodzony date,
  zmarly date
);

--DLL for KsiazkiAutorzy
CREATE TABLE KsiazkiAutorzy (
  idKA NUMBER(10) PRIMARY KEY,
  idautor NUMBER(10),
  idksiazka NUMBER(10)
);

--DLL for Gatunki
CREATE TABLE Gatunki (
  idgatunek NUMBER(10) PRIMARY KEY,
  Nazwa varchar2(255)
);

--DLL for KsiazkiGatunki
CREATE TABLE KsiazkiGatunki (
  idKG NUMBER(10) PRIMARY KEY,
  idgatunek NUMBER(10),
  idksiazka NUMBER(10)
);

--DLL for Filmy
CREATE TABLE Filmy (
  idfilm NUMBER(10) PRIMARY KEY,
  Tytul varchar2(255),
  idksiazka NUMBER(10)
);

--DLL for OcenyFilmu
CREATE TABLE OcenyFilmu (
  idocena NUMBER(10) PRIMARY KEY,
  Ocena NUMBER(10),
  Krytyk varchar2(255) DEFAULT 'nie',
  idfilm NUMBER(10)
);

--DLL for Kategoria
CREATE TABLE Kategoria (
  idkategoria NUMBER(10) PRIMARY KEY,
  Nazwa varchar2(255)
);

--DLL for FilmyKategoria
CREATE TABLE FilmyKategoria (
  idFK NUMBER(10) PRIMARY KEY, 
  idfilm NUMBER(10),
  idkategoria NUMBER(10)
);

-----------------------------------------------------------------
-- DDL for Procedure CREATE (INSERT)
-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_OCENA(
  Ocena in OCENY.Ocena%TYPE,
  Krytyk in OCENY.Krytyk%TYPE,
  idksiazka in OCENY.idksiazka%TYPE
  ) AS
BEGIN
  if( Ocena > 10 ) THEN
        Ocena=10;
  end if;
  if( Ocena < 0 ) THEN
        Ocena=0;
  end if; 
	INSERT INTO OCENY 
	VALUES 
	(
	OCENY_SEQ.nextval,
	Ocena,Krytyk,
	idksiazka
	);
END CREATE_OCENA

-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_GATUNEK AS

FUNCTION gatunek_p(
nazwa_1 in GATUNKI.Nazwa%TYPE
) RETURN NUMBER;

PROCEDURE CREATE_Gatunek
(
 Nazwa in GATUNKI.Nazwa%TYPE
 );
END T_GATUNEK;
/

CREATE OR REPLACE PACKAGE BODY T_GATUNEK AS

FUNCTION gatunek_p(
nazwa_1 in GATUNKI.Nazwa%TYPE
) RETURN NUMBER IS
  suma NUMBER:=0;
  BEGIN
    SELECT COUNT(*) INTO suma FROM GATUNKI WHERE Nazwa=nazwa_1;
    RETURN suma;
  END gatunek_p;
  
  PROCEDURE CREATE_Gatunek(
  Nazwa in GATUNKI.Nazwa%TYPE
  ) AS
  BEGIN
	INSERT INTO Gatunki
	VALUES (
	Gatunki_SEQ.nextval,
	Nazwa);
END CREATE_Gatunki
END T_GATUNEK;
	/
  
CREATE OR REPLACE PROCEDURE CREATE_KG
(
 idgatunek in KsiazkiGatunki.idgatunek%TYPE
, idksiazka in KsiazkiGatunki.idksiazka%TYPE
) AS
BEGIN
	INSERT INTO KsiazkiGatunki
	VALUES (
	KsiazkiGatunki_SEQ.nextval,
	idgatunek_in,
	idksiazka_in);
END CREATE_KG


-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_Ksiazki
(
 tytul_in in Ksiazki.Tytul%TYPE
) AS
BEGIN
	INSERT INTO Ksiazki 
	VALUES (
	Ksiazki_SEQ.nextval,
	tytul_in);
END CREATE_Ksiazki

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_Jezyki
(
 nazwa in  Jezyki.nazwa%TYPE,
 data_wyd in Jezyki.data_wydania%TYPE,
 idks in Jezyki.idksiazka%TYPE 
) AS
BEGIN
	INSERT INTO Jezyki 
	VALUES (
	Jezyki_SEQ.nextval,
	nazwa_in,
	data_wyd,
	idks);
END CREATE_Jezyki

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_Autorzy
(
 imie IN Autorzy.Imie%TYPE,
 nazwisko IN Autorzy.Nazwisko%TYPE,
 urodz IN Autorzy.urodzony%TYPE,
 zmarl IN Autorzy.zmarly%TYPE
) AS
BEGIN
	INSERT INTO Autorzy (
	VALUES (
	Autorzy_SEQ.nextval,
	imie,
	nazwsko,
	urodz,
	zmarl);
END CREATE_Autorzy

CREATE OR REPLACE PROCEDURE CREATE_KA
(
 idautor IN KsiazkiAutorzy.idautor%TYPE,
 idksiazka IN KsiazkiAutorzy.idksiazka%TYPE
) AS
BEGIN
	INSERT INTO KsiazkiAutorzy
	VALUES (
	KsiazkiAutorzy_SEQ.nextval,
	idautor,
	idksiazka);
END CREATE_KA

-----------------------------------------------------------------
-- Fimy i pochodne
-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_Filmy
(
 tytul IN Filmy.Tytul%TYPE,
 idksiazka IN Filmy.idksiazka%TYPE
) AS
BEGIN
	INSERT INTO Filmy 
	VALUES (
	Filmy_SEQ.nextval,
	tytul,
	ksiazka);
END CREATE_Filmy


-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_OcenyFilmu
(
 ocena IN OcenyFilmu.Ocena%TYPE
 krytyk IN OcenyFilmu.Krytyk%TYPE
 idfilmu IN OcenyFilmu.idfilm%TYPE
) AS
BEGIN
  if( ocena > 10 ) THEN
        ocena=10;
  end if;
  if( ocena < 0 ) THEN
        ocena=0;
  end if; 
	INSERT INTO OcenyFilmu 
	VALUES (
	OcenyFilmu_SEQ.nextval,
	ocena,
	krytyk,
	idfilmu
	);
END CREATE_OcenyFilmu

-----------------------------------------------------------------

CREATE OR REPLACE PROCEDURE CREATE_Kategoria
(
 Nazwa IN Kategoria.Nazwa%TYPE
) AS
BEGIN 
	INSERT INTO Kategoria
	VALUES (
	Kategoria_SEQ.nextval,
	Nazwa_in);
END CREATE_Kategoria

CREATE OR REPLACE PROCEDURE CREATE_FK
(
 idfilm IN FilmyKategoria.idfilm%TYPE,
 idkategoria IN FilmyKategoria.idkategoria%TYPE
) AS
BEGIN
	INSERT INTO FilmyKategoria
	VALUES (
	FilmyKategoria_SEQ.nextval,
	idfilm,
	idkategoria);
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










	