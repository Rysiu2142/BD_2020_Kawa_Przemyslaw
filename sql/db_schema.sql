--DLL's for Sequences
CREATE SEQUENCE "Oceny_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 CACHE 20 ORDER NOCYCLE;

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
CREATE TABLE "Oceny" (
  "idocena" NUMBER(*,0) constraint Ocenypk PRIMARY KEY,
  "Ocena" NUMBER(*,0),
  "Krytyk" varchar(255 byte) DEFAULT 'nie',
  "idksiazka" NUMBER(*,0)
) TABLESPACE "USERS" ;

--DLL for Ksiazki
CREATE TABLE "Ksiazki" (
  "idksiazka" NUMBER(*,0) constraint Ksiazkipk PRIMARY KEY,
  "Tytul" varchar(255 byte)
) TABLESPACE "USERS"
;

--DLL for Jezyki
CREATE TABLE "Jezyki" (
  "idjezyk" NUMBER(*,0) constraint Jezykipk PRIMARY KEY,
  "nazwa" varchar(255 byte),
  "data_wydania" date,
  "idksiazka" NUMBER(*,)
) TABLESPACE "USERS"
;

--DLL for Autorzy
CREATE TABLE "Autorzy" (
  "idautor" NUMBER(*,0) constraint Autorzypk PRIMARY KEY,
  "Imie" varchar(255 byte),
  "Nazwisko" varchar(255 byte),
  "urodzony" date,
  "zmarly" date
) TABLESPACE "USERS"
;

--DLL for KsiazkiAutorzy
CREATE TABLE "KsiazkiAutorzy" (
  "idKA" NUMBER(*,0) constraint KsiazkiAutorzypk PRIMARY KEY,
  "idautor" NUMBER(*,),
  "idksiazka" NUMBER(*,)
) TABLESPACE "USERS"
;

--DLL for Gatunki
CREATE TABLE "Gatunki" (
  "idgatunek" NUMBER(*,0) constraint Gatunkipk PRIMARY KEY,
  "Nazwa" varchar(255 byte)
) TABLESPACE "USERS"
;

--DLL for KsiazkiGatunki
CREATE TABLE "KsiazkiGautnki" (
  "idKG" NUMBER(*,0) constraint KsiazkiGautnkipk PRIMARY KEY,
  "idgatunek" NUMBER(*,),
  "idksiazka" NUMBER(*,)
) TABLESPACE "USERS"
;

--DLL for Filmy
CREATE TABLE "Filmy" (
  "idfilm" NUMBER(*,0) constraint Filmypk PRIMARY KEY,
  "Tytul" varchar(255 byte),
  "idksiazka" NUMBER(*,)
) TABLESPACE "USERS"
;

--DLL for OcenyFilmu
CREATE TABLE "OcenyFilmu" (
  "idocena" NUMBER(*,0) constraint OcenyFilmupk PRIMARY KEY,
  "Ocena" NUMBER(*,0),
  "Krytyk" varchar(255 byte),
  "idfilm" NUMBER(*,)
) TABLESPACE "USERS"
;

--DLL for Kategoria
CREATE TABLE "Kategoria" (
  "idkategoria" NUMBER(*,0) constraint Kategoriapk PRIMARY KEY,
  "Nazwa" varchar(255 byte)
) TABLESPACE "USERS"
;

--DLL for FilmyKategoria
CREATE TABLE "FilmyKategoria" (
  "idFK" NUMBER(*,0) constraint FilmyKategoriapk PRIMARY KEY, 
  "idfilm" NUMBER(*,),
  "idkategoria" NUMBER(*,)
) TABLESPACE "USERS"
;
--------------------------------------------------------------------------
--DLL's for Triggers auto_increment on insert
--------------------------------------------------------------------------
CREATE OR REPLACE TRIGGER Oceny_on_insert
  Before Insert ON Oceny
  FOR EACH ROW
  BEGIN
    SELECT Oceny_SEQ.nextval
    INTO :new.idocena
    FROM dual
  END;

CREATE OR REPLACE TRIGGER Ksiazki_on_insert
  Before Insert ON Ksiazki
  FOR EACH ROW
  BEGIN
    SELECT Ksiazki_SEQ.nextval
    INTO :new.idksiazka
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER Jezyki_on_insert
  Before Insert ON Jezyki
  FOR EACH ROW
  BEGIN
    SELECT Jezyki_SEQ.nextval
    INTO :new.idjezyk
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER Autorzy_on_insert
  Before Insert ON Autorzy
  FOR EACH ROW
  BEGIN
    SELECT Autorzy_SEQ.nextval
    INTO :new.idautor
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER KsiazkiAutorzy_on_insert
  Before Insert ON KsiazkiAutorzy
  FOR EACH ROW
  BEGIN
    SELECT KsiazkiAutorzy_SEQ.nextval
    INTO :new.idKA
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER Gatunki_on_insert
  Before Insert ON Gatunki
  FOR EACH ROW
  BEGIN
    SELECT Gatunki_SEQ.nextval
    INTO :new.idgatunek
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER KsiazkiGautnki_on_insert
  Before Insert ON KsiazkiGautnki
  FOR EACH ROW
  BEGIN
    SELECT KsiazkiGautnki_SEQ.nextval
    INTO :new.idKG
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER Filmy_on_insert
  Before Insert ON Filmy
  FOR EACH ROW
  BEGIN
    SELECT Filmy_SEQ.nextval
    INTO :new.idfilm
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER OcenyFilmu_on_insert
  Before Insert ON OcenyFilmu
  FOR EACH ROW
  BEGIN
    SELECT OcenyFilmu_SEQ.nextval
    INTO :new.idocena
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER Kategoria_on_insert
  Before Insert ON Kategoria
  FOR EACH ROW
  BEGIN
    SELECT Kategoria_SEQ.nextval
    INTO :new.idkategoria
    FROM dual
  END;
  
CREATE OR REPLACE TRIGGER FilmyKategoria_on_insert
  Before Insert ON FilmyKategoria
  FOR EACH ROW
  BEGIN
    SELECT FilmyKategoria_SEQ.nextval
    INTO :new.idFK
    FROM dual
  END;
  
-----------------------------------------------------------------