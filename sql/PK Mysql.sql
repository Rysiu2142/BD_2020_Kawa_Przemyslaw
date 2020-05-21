-- DLL for Oceny
CREATE TABLE Oceny (
  idocena BIGINT PRIMARY KEY,
  Ocena BIGINT,
  Krytyk varchar(255) DEFAULT 'nie',
  idksiazka BIGINT
);



-- DLL for Ksiazki
CREATE TABLE Ksiazki (
  idksiazka BIGINT PRIMARY KEY,
  Tytul varchar(255),
  data_wydania datetime,
  OrginalnyJezyk varchar(255)
);



-- DLL for Autorzy
CREATE TABLE Autorzy (
  idautor BIGINT PRIMARY KEY,
  Imie varchar(255),
  Nazwisko varchar(255),
  urodzony datetime,
  zmarly datetime
);

-- DLL for KsiazkiAutorzy
CREATE TABLE KsiazkiAutorzy (
  idKA BIGINT PRIMARY KEY,
  idautor BIGINT,
  idksiazka BIGINT
);

-- DLL for Gatunki
CREATE TABLE Gatunki (
  idgatunek BIGINT PRIMARY KEY,
  Nazwa varchar(255)
);

-- DLL for KsiazkiGatunki
CREATE TABLE KsiazkiGatunki (
  idKG BIGINT PRIMARY KEY,
  idgatunek BIGINT,
  idksiazka BIGINT
);

-- DLL for Filmy
CREATE TABLE Filmy (
  idfilm BIGINT PRIMARY KEY,
  Tytul varchar(255),
  idksiazka BIGINT
);

-- DLL for OcenyFilmu
CREATE TABLE OcenyFilmu (
  idocena BIGINT PRIMARY KEY,
  Ocena BIGINT,
  Krytyk varchar(255) DEFAULT 'nie',
  idfilm BIGINT
);

-- DLL for Kategoria
CREATE TABLE Kategoria (
  idkategoria BIGINT PRIMARY KEY,
  Nazwa varchar(255)
);

-- DLL for FilmyKategoria
CREATE TABLE FilmyKategoria (
  idFK BIGINT PRIMARY KEY, 
  idfilm BIGINT,
  idkategoria BIGINT
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