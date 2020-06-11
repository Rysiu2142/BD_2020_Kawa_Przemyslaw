--DLL's for Sequences
CREATE SEQUENCE Oceny_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE SEQUENCE Ksiazki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Autorzy-arm
CREATE SEQUENCE Autorzy_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE KsiazkiAutorzy_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

------------------------------------------------------------------------------------------------
-- DLL's for Sequence Gatunki-arm
CREATE SEQUENCE KsiazkiGatunki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE Gatunki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
-------------------------------------------------------------------------------------------------
-- DDL's for Sequence film-side
CREATE SEQUENCE Filmy_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE FilmyKategoria_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE Kategoria_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;
CREATE SEQUENCE OcenyFilmu_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1  NOCACHE NOCYCLE;

-----------------------------------------------------------------
-- DDL for Procedure CREATE (INSERT)
-------------------------------------------------------------------done
CREATE OR REPLACE PACKAGE T_OCENA AS 

PROCEDURE ST_OCENA(
  Ocena_1 in OCENY.Ocena%TYPE,
  idksiazka in OCENY.idksiazka%TYPE
  );
END T_OCENA;
/


CREATE OR REPLACE PACKAGE BODY T_OCENA AS

PROCEDURE ST_OCENA(
  Ocena_1 in OCENY.Ocena%TYPE,
  idksiazka in OCENY.idksiazka%TYPE
  ) AS
  Ocena_2 OCENY.Ocena%TYPE;
BEGIN
	Ocena_2:=Ocena_1;
  if( Ocena_1 > 10 ) THEN
        Ocena_2:=10;
  end if;
  if( Ocena_1 < 0 ) THEN
        Ocena_2:=0;
  end if; 
	INSERT INTO OCENY 
	VALUES 
	(
	OCENY_SEQ.nextval,
	Ocena_2,
	idksiazka
	);
END ST_OCENA;
END T_OCENA;
/



-------------------------------------------------------------------done
CREATE OR REPLACE PACKAGE T_Ksiazke AS  

PROCEDURE ST_Ksiazki
(tytul_in in Ksiazki.Tytul%TYPE,
 data_wydania in Ksiazki.rok_wydania%TYPE,
 OrginalnyJezyk in Ksiazki.OrginalnyJezyk%TYPE,
 nrks out SYS_REFCURSOR);
PROCEDURE ST_KG
(idgatunek in KsiazkiGatunki.idgatunek%TYPE,
 idksiazka in KsiazkiGatunki.idksiazka%TYPE);
PROCEDURE ST_KA
(idautor IN KsiazkiAutorzy.idautor%TYPE,
 idksiazka IN KsiazkiAutorzy.idksiazka%TYPE);
END T_Ksiazke;
/
CREATE OR REPLACE PACKAGE BODY T_Ksiazke AS  

PROCEDURE ST_Ksiazki
(
 tytul_in in Ksiazki.Tytul%TYPE,
 data_wydania in Ksiazki.rok_wydania%TYPE,
 OrginalnyJezyk in Ksiazki.OrginalnyJezyk%TYPE,
 nrks out SYS_REFCURSOR
) AS
tytul_low varchar2(255) :=lower(tytul_in);
BEGIN
	INSERT INTO Ksiazki 
	VALUES (
	Ksiazki_SEQ.nextval,
	tytul_in,
	data_wydania,
	OrginalnyJezyk
	);
	OPEN nrks FOR
	SELECT idksiazka FROM Ksiazki WHERE tytul_low=tytul;
END ST_Ksiazki;

PROCEDURE ST_KG
(
 idgatunek in KsiazkiGatunki.idgatunek%TYPE
, idksiazka in KsiazkiGatunki.idksiazka%TYPE
)
AS
BEGIN
	INSERT INTO KsiazkiGatunki
	VALUES (
	KsiazkiGatunki_SEQ.nextval,
	idgatunek,
	idksiazka);
END ST_KG;

PROCEDURE ST_KA
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
END ST_KA;
END T_Ksiazke;
/
------------------------------------------------------------------- done
CREATE OR REPLACE TRIGGER tytul_male  
	BEFORE INSERT ON Ksiazki
	FOR EACH ROW
	BEGIN
		:new.Tytul := lower( :new.Tytul );
	END;
	/
	ALTER TRIGGER tytul_male ENABLE;
	
----------------------------------------------------------------- done
CREATE OR REPLACE PACKAGE T_Autor AS

FUNCTION autor_pow(
imie_1 in Autorzy.Imie%TYPE,
nazwisko_1 Autorzy.Nazwisko%TYPE
) RETURN NUMBER;

PROCEDURE ST_Autorzy
(
 imie IN Autorzy.Imie%TYPE,
 nazwisko IN Autorzy.Nazwisko%TYPE,  
 urodzony IN VARCHAR2,
 zmarly IN VARCHAR2
);
END T_Autor;
/

CREATE OR REPLACE PACKAGE BODY T_Autor AS

FUNCTION autor_pow(
imie_1 in Autorzy.Imie%TYPE,
nazwisko_1 Autorzy.Nazwisko%TYPE
) RETURN NUMBER IS
	suma NUMBER :=0;
BEGIN
	SELECT COUNT(*) INTO suma FROM Autorzy WHERE Imie=imie_1 AND Nazwisko=nazwisko_1;
	RETURN suma;
END autor_pow;

PROCEDURE ST_Autorzy
(
imie IN Autorzy.Imie%TYPE,
 nazwisko IN Autorzy.Nazwisko%TYPE,  
 urodzony IN VARCHAR2,
 zmarly IN VARCHAR2

) AS
BEGIN
	INSERT INTO Autorzy 
	VALUES (
	Autorzy_SEQ.nextval,
	imie,
	nazwisko,
	TO_DATE(urodzony, 'RRRR-MM-DD'),
	TO_DATE(zmarly, 'RRRR-MM-DD')
	);
END ST_Autorzy;
END T_Autor;
/

-----------------------------------------------------------------
-- Stworz Fimy 
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_Film AS
PROCEDURE ST_Filmy
(
 tytul_in IN Filmy.Tytul%TYPE,
 idksiazka_in IN Filmy.idksiazka%TYPE,
 nrfil out SYS_REFCURSOR
);

PROCEDURE ST_FK
(
 idfilm IN FilmyKategoria.idfilm%TYPE,
 idkategoria IN FilmyKategoria.idkategoria%TYPE
);
Function Check_Book (idksiazka_1 IN Filmy.idksiazka%TYPE) RETURN NUMBER;
END T_Film;

 /

CREATE OR REPLACE PACKAGE BODY T_Film AS
PROCEDURE ST_Filmy
(
 tytul_in IN Filmy.Tytul%TYPE,
 idksiazka_in IN Filmy.idksiazka%TYPE,
 nrfil out SYS_REFCURSOR
) AS
BEGIN	
	INSERT INTO Filmy 
	VALUES (
	Filmy_SEQ.nextval,
	tytul_in,
	idksiazka_in);
	OPEN nrfil FOR
	SELECT idfilm FROM Filmy WHERE tytul_in=tytul;
END ST_Filmy;

PROCEDURE ST_FK
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
END ST_FK;

Function Check_Book (
idksiazka_1 IN Filmy.idksiazka%TYPE
) RETURN NUMBER IS
	suma NUMBER:=0;
	BEGIN
		SELECT COUNT(*) INTO suma FROM ksiazki WHERE idksiazka_1=idksiazka;
		RETURN suma;
	END Check_Book;

END T_Film;
/

-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_OF AS

PROCEDURE ST_OcenyFilmu
(
 ocena_1 IN OcenyFilmu.Ocena%TYPE,
 idfilmu IN OcenyFilmu.idfilm%TYPE
);
END T_OF;
/
CREATE OR REPLACE PACKAGE BODY T_OF AS

PROCEDURE ST_OcenyFilmu
(
 ocena_1 IN OcenyFilmu.Ocena%TYPE, 
 idfilmu IN OcenyFilmu.idfilm%TYPE
) AS
	Ocena_2 OCENY.Ocena%TYPE;
BEGIN
	Ocena_2:=Ocena_1;
  if( ocena_1 > 10 ) THEN
        ocena_2:=10;
  end if;
  if( ocena_1 < 0 ) THEN
        ocena_2:=0;
  end if; 
	INSERT INTO OcenyFilmu 
	VALUES (
	OcenyFilmu_SEQ.nextval,
	ocena_2,
	idfilmu
	);
END ST_OcenyFilmu;
END T_OF;
/


-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE F_Kategoria AS
PROCEDURE Fet_Kategoria(
idfilm_1 in FilmyKategoria.idfilm%TYPE, Kategorie OUT SYS_REFCURSOR);
END F_Kategoria;
/
 CREATE OR REPLACE PACKAGE BODY F_Kategoria AS
 PROCEDURE Fet_Kategoria(
 idfilm_1 in FilmyKategoria.idfilm%TYPE,
 Kategorie OUT SYS_REFCURSOR) AS
 BEGIN
	OPEN Kategorie FOR
	SELECT k.idkategoria,k.Nazwa 
	FROM  FilmyKategoria fk, Kategoria k
	WHERE fk.idfilm=idfilm_1 AND fk.idkategoria=k.idkategoria;
END Fet_Kategoria;
END F_Kategoria;
/
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE F_Gatunki AS
PROCEDURE Fet_Gatunki(idksiazka_1 in KsiazkiGatunki.idksiazka%TYPE,
Gatunki_out OUT SYS_REFCURSOR);
END F_Gatunki;
/
CREATE OR REPLACE PACKAGE BODY F_Gatunki AS
PROCEDURE Fet_Gatunki(idksiazka_1 in KsiazkiGatunki.idksiazka%TYPE,
Gatunki_out OUT SYS_REFCURSOR) AS
	BEGIN
		OPEN Gatunki_out FOR
		SELECT  g.idgatunek,g.Nazwa
		FROM KsiazkiGatunki kg , GATUNKI g
		WHERE idksiazka_1=kg.idksiazka AND kg.idgatunek=g.idgatunek;
	END Fet_Gatunki;
END F_Gatunki;
/
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE F_Autorzy AS
PROCEDURE Fet_Autorzy (
idksiazka_1 in KsiazkiAutorzy.idksiazka%TYPE,
Autorzy_out OUT SYS_REFCURSOR);
END F_Autorzy;
/
CREATE OR REPLACE PACKAGE BODY F_Autorzy AS
PROCEDURE Fet_Autorzy (
idksiazka_1 in KsiazkiAutorzy.idksiazka%TYPE,
Autorzy_out OUT SYS_REFCURSOR) AS
	BEGIN
		OPEN Autorzy_out FOR
		SELECT a.idautor,Imie,Nazwisko 
		FROM KsiazkiAutorzy ka, Autorzy a
		WHERE idksiazka_1=ka.idksiazka AND  ka.idautor=a.idautor;
	END Fet_Autorzy;
END F_Autorzy;
/
-----------------------------------------------------------------

CREATE OR REPLACE PACKAGE F_Ksiazki AS

PROCEDURE Fet_Ksiazki (Ksiazki_out OUT SYS_REFCURSOR);
PROCEDURE AVG_OCENA(idksiazka_1 in Ksiazki.idksiazka%TYPE,
					Ocena_out OUT SYS_REFCURSOR);
PROCEDURE usun_Ksiazke(idksiazka_1 in Ksiazki.idksiazka%TYPE);
FUNCTION czy_oceniona(
idksiazka_1 in Oceny.idksiazka%TYPE
) RETURN NUMBER;
END F_Ksiazki;
/
CREATE OR REPLACE PACKAGE BODY F_Ksiazki AS
PROCEDURE Fet_Ksiazki (Ksiazki_out OUT SYS_REFCURSOR) AS
BEGIN
	OPEN Ksiazki_out FOR
	SELECT idksiazka,Tytul,rok_wydania,OrginalnyJezyk
	FROM Ksiazki;
END Fet_Ksiazki;

PROCEDURE AVG_OCENA(idksiazka_1 in Ksiazki.idksiazka%TYPE
,Ocena_out OUT SYS_REFCURSOR) AS
BEGIN
	OPEN Ocena_out FOR
	SELECT AVG(Ocena) AS SRED
	FROM Oceny o
	WHERE idksiazka_1=o.idksiazka;
	
END AVG_OCENA;

PROCEDURE usun_Ksiazke(idksiazka_1 in Ksiazki.idksiazka%TYPE) AS
BEGIN 
	delete from OCENY where idksiazka_1=idksiazka;
	delete from KsiazkiGatunki where idksiazka_1=idksiazka;
	delete from KsiazkiAutorzy where idksiazka_1=idksiazka;
	UPDATE Filmy SET idksiazka=NULL WHERE idksiazka_1=idksiazka;
	delete from Ksiazki where idksiazka_1=idksiazka;
END usun_Ksiazke;

FUNCTION czy_oceniona(
idksiazka_1 in Oceny.idksiazka%TYPE
) RETURN NUMBER IS
	suma NUMBER:=0;
	BEGIN
		SELECT COUNT(*) INTO suma FROM OCENY WHERE idksiazka_1=idksiazka;
		RETURN suma;
	END czy_oceniona;
END F_Ksiazki;
/

-----------------------------------------------------------------

CREATE OR REPLACE PACKAGE S_WINGS AS
PROCEDURE WGatunki(Gatunki_out OUT SYS_REFCURSOR);
PROCEDURE WAutorzy(Autorzy_out OUT SYS_REFCURSOR);
PROCEDURE WKategorie(Kategorie_out OUT SYS_REFCURSOR);
END S_WINGS;
/
CREATE OR REPLACE PACKAGE BODY S_WINGS AS
PROCEDURE WGatunki(Gatunki_out OUT SYS_REFCURSOR) AS
BEGIN 
	OPEN Gatunki_out FOR
	SELECT idgatunek,Nazwa FROM GATUNKI;
END WGatunki;
	
PROCEDURE WAutorzy(Autorzy_out OUT SYS_REFCURSOR) AS
BEGIN 
	OPEN Autorzy_out FOR
	SELECT idautor,Imie,Nazwisko,urodzony,zmarly FROM Autorzy ;
END WAutorzy;

PROCEDURE WKategorie(Kategorie_out OUT SYS_REFCURSOR) AS
BEGIN 
	OPEN Kategorie_out FOR
	SELECT idkategoria,Nazwa FROM Kategoria;
END WKategorie; 
END S_WINGS;
/
-----------------------------------------------------------------
-- F_FILMY 
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE F_Filmy AS

PROCEDURE Fet_Film(Filmy_out OUT SYS_REFCURSOR);
PROCEDURE AVG_Film(idfilm_1 in Filmy.idfilm%TYPE,
					ocena_out OUT SYS_REFCURSOR);
PROCEDURE usun_Film(idfilm_1 in Filmy.idfilm%TYPE);
END F_Filmy;
/
CREATE OR REPLACE PACKAGE BODY F_Filmy AS
PROCEDURE Fet_Film(Filmy_out OUT SYS_REFCURSOR) AS
BEGIN
	OPEN Filmy_out FOR
	SELECT idfilm,f.Tytul,k.Tytul AS BOOK
	FROM Filmy f LEFT JOIN ksiazki k ON f.idksiazka=k.idksiazka;
END Fet_Film ;

PROCEDURE AVG_Film(idfilm_1 in Filmy.idfilm%TYPE,
					ocena_out OUT SYS_REFCURSOR) AS
BEGIN
	OPEN Ocena_out FOR
	SELECT AVG(Ocena) AS SREDF
	FROM OcenyFilmu o
	WHERE idfilm_1=o.idfilm;
END AVG_Film;

PROCEDURE usun_Film(idfilm_1 in Filmy.idfilm%TYPE) AS
BEGIN 
	delete from OCENYFilmu where idfilm_1=idfilm;
	delete from FilmyKategoria where idfilm_1=idfilm;
	delete from Filmy where idfilm_1=idfilm;
END usun_Film;
END F_Filmy;
/
