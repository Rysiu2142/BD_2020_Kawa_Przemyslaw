--DLL's for Sequences
CREATE SEQUENCE "Oceny_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;

CREATE SEQUENCE "Ksiazki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;

CREATE SEQUENCE "Jezyki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Autorzy-arm
CREATE SEQUENCE "Autorzy_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;
CREATE SEQUENCE "KsiazkiAutorzy_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Gatunki-arm
CREATE SEQUENCE "Gatunki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;
CREATE SEQUENCE "KsiazkiGatunki_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;

-------------------------------------------------------------------------------------------------
-- DDL's for Sequence film-side
CREATE SEQUENCE "Filmy_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;
CREATE SEQUENCE "FilmyKategoria_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;
CREATE SEQUENCE "Kategoria_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;
CREATE SEQUENCE "OcenyFilmu_SEQ" MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START with 1 NOCACHE ORDER NOCYCLE;

--------------------------------------------------------------------------------------------------

--DLL for Oceny
CREATE TABLE "Oceny" (
  "idocena" NUMBER(*,0),
  "Ocena" int,
  "Krytyk" varchar(255 byte),
  "idksiazka" NUMBER(*,)
);

--DLL for Ksiazki
CREATE TABLE "Ksiazki" (
  "idksiazka" NUMBER(*,0),
  "Tytul" varchar(255 byte)
);

--DLL for Jezyki
CREATE TABLE "Jezyki" (
  "idjezyk" NUMBER(*,0),
  "nazwa" varchar(255 byte),
  "data_wydania" date,
  "idksiazka" NUMBER(*,)
);

--DLL for Autorzy
CREATE TABLE "Autorzy" (
  "idautor" NUMBER(*,0),
  "Imie" varchar(255 byte),
  "Nazwisko" varchar(255 byte),
  "urodzony" date,
  "zmarly" date
);

--DLL for KsiazkiAutorzy
CREATE TABLE "KsiazkiAutorzy" (
  "idKA" NUMBER(*,0),
  "idautor" NUMBER(*,),
  "idksiazka" NUMBER(*,)
);

--DLL for Gatunki
CREATE TABLE "Gatunki" (
  "idgatunek" NUMBER(*,0),
  "Nazwa" varchar(255 byte)
);

--DLL for KsiazkiGatunki
CREATE TABLE "KsiazkiGautnki" (
  "idKG" NUMBER(*,0),
  "idgatunek" NUMBER(*,),
  "idksiazka" NUMBER(*,)
);

--DLL for Filmy
CREATE TABLE "Filmy" (
  "idfilm" NUMBER(*,0),
  "Tytul" varchar(255 byte),
  "idksiazka" NUMBER(*,)
);

--DLL for OcenyFilmu
CREATE TABLE "OcenyFilmu" (
  "idocena" NUMBER(*,0),
  "Ocena" int,
  "Krytyk" varchar(255 byte),
  "idfilm" NUMBER(*,)
);

--DLL for Kategoria
CREATE TABLE "Kategoria" (
  "idkategoria" NUMBER(*,0),
  "Nazwa" varchar(255 byte)
);

--DLL for FilmyKategoria
CREATE TABLE "FilmyKategoria" (
  "idKG" NUMBER(*,0),
  "idfilm" NUMBER(*,),
  "idkategoria" NUMBER(*,)
);
--------------------------------------------------------------------------
--DLL's for Procedures
--------------------------------------------------------------------------

