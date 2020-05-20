

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
  Tytul varchar2(255),
  data_wydania date,
  OrginalnyJezyk varchar2(255)
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




ALTER TABLE Oceny ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE KsiazkiAutorzy ADD FOREIGN KEY (idautor) REFERENCES Autorzy (idautor);

ALTER TABLE KsiazkiAutorzy ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE KsiazkiGatunki ADD FOREIGN KEY (idgatunek) REFERENCES Gatunki (idgatunek);

ALTER TABLE KsiazkiGatunki ADD FOREIGN KEY (idksiazka) REFERENCES Ksiazki (idksiazka);

ALTER TABLE FilmyKategoria ADD FOREIGN KEY (idfilm) REFERENCES Filmy (idfilm);

ALTER TABLE FilmyKategoria ADD FOREIGN KEY (idkategoria) REFERENCES Kategoria (idkategoria);

ALTER TABLE OcenyFilmu ADD FOREIGN KEY (idocena) REFERENCES Filmy (idfilm);

ALTER TABLE Filmy ADD FOREIGN KEY (idfilm) REFERENCES Ksiazki (idksiazka);










	