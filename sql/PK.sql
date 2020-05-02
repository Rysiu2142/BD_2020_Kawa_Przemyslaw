CREATE TABLE "Oceny" (
  "idocena" NUMBER(*,0),
  "Ocena" int,
  "Krytyk" varchar(255 byte),
  "idksiazka" NUMBER(*,)
);

CREATE TABLE "Ksiazki" (
  "idksiazka" NUMBER(*,0),
  "Tytul" varchar(255 byte)
);

CREATE TABLE "Jezyki" (
  "idjezyk" NUMBER(*,0),
  "nazwa" varchar(255 byte),
  "data_wydania" date,
  "idksiazka" NUMBER(*,)
);

CREATE TABLE "Autorzy" (
  "idautor" NUMBER(*,0),
  "Imie" varchar(255 byte),
  "Nazwisko" varchar(255 byte),
  "urodzony" date,
  "zmarly" date
);

CREATE TABLE "KsiazkiAutorzy" (
  "idKA" NUMBER(*,0),
  "idautor" NUMBER(*,),
  "idksiazka" NUMBER(*,)
);

CREATE TABLE "Gatunki" (
  "idgatunek" NUMBER(*,0),
  "Nazwa" varchar(255 byte)
);

CREATE TABLE "KsiazkiGautnki" (
  "idKG" NUMBER(*,0),
  "idgatunek" NUMBER(*,),
  "idksiazka" NUMBER(*,)
);

CREATE TABLE "Filmy" (
  "idfilm" NUMBER(*,0),
  "Tytul" varchar(255 byte),
  "idksiazka" NUMBER(*,)
);

CREATE TABLE "OcenyFilmu" (
  "idocena" NUMBER(*,0),
  "Ocena" int,
  "Krytyk" varchar(255 byte),
  "idfilm" NUMBER(*,)
);

CREATE TABLE "Kategoria" (
  "idkategoria" NUMBER(*,0),
  "Nazwa" varchar(255 byte)
);

CREATE TABLE "FilmyKategoria" (
  "idKG" NUMBER(*,0),
  "idfilm" NUMBER(*,),
  "idkategoria" NUMBER(*,)
);

ALTER TABLE "Oceny" ADD FOREIGN KEY ("idksiazka") REFERENCES "Ksiazki" ("idksiazka");

ALTER TABLE "KsiazkiAutorzy" ADD FOREIGN KEY ("idautor") REFERENCES "Autorzy" ("idautor");

ALTER TABLE "KsiazkiAutorzy" ADD FOREIGN KEY ("idksiazka") REFERENCES "Ksiazki" ("idksiazka");

ALTER TABLE "KsiazkiGautnki" ADD FOREIGN KEY ("idgatunek") REFERENCES "Gatunki" ("idgatunek");

ALTER TABLE "KsiazkiGautnki" ADD FOREIGN KEY ("idksiazka") REFERENCES "Ksiazki" ("idksiazka");

ALTER TABLE "FilmyKategoria" ADD FOREIGN KEY ("idfilm") REFERENCES "Filmy" ("idfilm");

ALTER TABLE "FilmyKategoria" ADD FOREIGN KEY ("idkategoria") REFERENCES "Kategoria" ("idkategoria");

ALTER TABLE "Jezyki" ADD FOREIGN KEY ("idksiazka") REFERENCES "Ksiazki" ("idksiazka");

ALTER TABLE "OcenyFilmu" ADD FOREIGN KEY ("idocena") REFERENCES "Filmy" ("idfilm");

ALTER TABLE "Filmy" ADD FOREIGN KEY ("idfilm") REFERENCES "Ksiazki" ("idksiazka");
