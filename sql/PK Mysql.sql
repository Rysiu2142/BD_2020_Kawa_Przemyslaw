CREATE TABLE `Oceny` (
  `idocena` int PRIMARY KEY AUTO_INCREMENT,
  `Ocena` int,
  `Krytyk` varchar(255),
  `idksiazka` int NOT NULL
);

CREATE TABLE `Ksiazki` (
  `idksiazka` int PRIMARY KEY AUTO_INCREMENT,
  `Tytul` varchar(255)
);

CREATE TABLE `Jezyki` (
  `idjezyk` int PRIMARY KEY AUTO_INCREMENT,
  `nazwa` varchar(255),
  `data_wydania` date,
  `idksiazka` int NOT NULL
);

CREATE TABLE `Autorzy` (
  `idautor` int PRIMARY KEY AUTO_INCREMENT,
  `Imie` varchar(255),
  `Nazwisko` varchar(255),
  `urodzony` date,
  `zmarly` date
);

CREATE TABLE `KsiazkiAutorzy` (
  `idKA` int PRIMARY KEY AUTO_INCREMENT,
  `idautor` int NOT NULL,
  `idksiazka` int NOT NULL
);

CREATE TABLE `Gatunki` (
  `idgatunek` int PRIMARY KEY AUTO_INCREMENT,
  `Nazwa` varchar(255)
);

CREATE TABLE `KsiazkiGautnki` (
  `idKG` int PRIMARY KEY AUTO_INCREMENT,
  `idgatunek` int NOT NULL,
  `idksiazka` int NOT NULL
);

CREATE TABLE `Filmy` (
  `idfilm` int PRIMARY KEY AUTO_INCREMENT,
  `Tytul` varchar(255),
  `idksiazka` int NOT NULL
);

CREATE TABLE `OcenyFilmu` (
  `idocena` int PRIMARY KEY AUTO_INCREMENT,
  `Ocena` int,
  `Krytyk` varchar(255),
  `idfilm` int NOT NULL
);

CREATE TABLE `Kategoria` (
  `idkategoria` int PRIMARY KEY AUTO_INCREMENT,
  `Nazwa` varchar(255)
);

CREATE TABLE `FilmyKategoria` (
  `idKG` int PRIMARY KEY AUTO_INCREMENT,
  `idfilm` int NOT NULL,
  `idkategoria` int NOT NULL
);

ALTER TABLE `Oceny` ADD FOREIGN KEY (`idksiazka`) REFERENCES `Ksiazki` (`idksiazka`);

ALTER TABLE `KsiazkiAutorzy` ADD FOREIGN KEY (`idautor`) REFERENCES `Autorzy` (`idautor`);

ALTER TABLE `KsiazkiAutorzy` ADD FOREIGN KEY (`idksiazka`) REFERENCES `Ksiazki` (`idksiazka`);

ALTER TABLE `KsiazkiGautnki` ADD FOREIGN KEY (`idgatunek`) REFERENCES `Gatunki` (`idgatunek`);

ALTER TABLE `KsiazkiGautnki` ADD FOREIGN KEY (`idksiazka`) REFERENCES `Ksiazki` (`idksiazka`);

ALTER TABLE `FilmyKategoria` ADD FOREIGN KEY (`idfilm`) REFERENCES `Filmy` (`idfilm`);

ALTER TABLE `FilmyKategoria` ADD FOREIGN KEY (`idkategoria`) REFERENCES `Kategoria` (`idkategoria`);

ALTER TABLE `Jezyki` ADD FOREIGN KEY (`idksiazka`) REFERENCES `Ksiazki` (`idksiazka`);

ALTER TABLE `OcenyFilmu` ADD FOREIGN KEY (`idocena`) REFERENCES `Filmy` (`idfilm`);

ALTER TABLE `Filmy` ADD FOREIGN KEY (`idfilm`) REFERENCES `Ksiazki` (`idksiazka`);
