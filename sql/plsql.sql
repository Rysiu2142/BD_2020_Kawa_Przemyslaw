--DLL's for Sequences
CREATE SEQUENCE Oceny_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

CREATE SEQUENCE Ksiazki_SEQ MINVALUE 1 MAXVALUE 999999 START with 1 INCREMENT BY 1 NOCACHE NOCYCLE;

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

-----------------------------------------------------------------
-- DDL for Procedure CREATE (INSERT)
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_OCENA AS

PROCEDURE ST_OCENA(
  Ocena_1 in OCENY.Ocena%TYPE,
  Krytyk in OCENY.Krytyk%TYPE,
  idksiazka in OCENY.idksiazka%TYPE
  );
END T_OCENA;
/


CREATE OR REPLACE PACKAGE BODY T_OCENA AS

PROCEDURE ST_OCENA(
  Ocena_1 in OCENY.Ocena%TYPE,
  Krytyk in OCENY.Krytyk%TYPE,
  idksiazka in OCENY.idksiazka%TYPE
  ) AS
  Ocena_2 OCENY.Ocena%TYPE;
BEGIN
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
	Ocena_2,Krytyk,
	idksiazka
	);
END ST_OCENA;
END T_OCENA;
/

-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_GATUNEK AS

FUNCTION gatunek_p(
nazwa_1 in GATUNKI.Nazwa%TYPE
) RETURN NUMBER;

PROCEDURE ST_Gatunek
(
 Nazwa in GATUNKI.Nazwa%TYPE
 );

PROCEDURE usun(
idgatunek_1 in GATUNKI.idgatunek%TYPE );
PROCEDURE getGatuneki(
GATUNKI_o OUT SYS_REFCURSOR);

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
  
  PROCEDURE ST_Gatunek(
  Nazwa in GATUNKI.Nazwa%TYPE
  ) AS
  BEGIN
	INSERT INTO Gatunki
	VALUES (
	Gatunki_SEQ.nextval,
	Nazwa);
END ST_Gatunek;

	PROCEDURE usun(
	idgatunek_1 in GATUNKI.idgatunek%TYPE 
	) AS
	gat GATUNKI%ROWTYPE;
	BEGIN
		select * into gat from GATUNKI where idgatunek=idgatunek_1;
		delete from GATUNKI where idgatunek=idgatunek_1;
		DBMS_OUTPUT.PUT_LINE(gat.idgatunek);
	END usun;
	
	PROCEDURE getGatuneki(
GATUNKI_o OUT SYS_REFCURSOR)
OPEN GATUNKI_o FOR
SELECT * from GATUNKI;
END T_GATUNEK;
	/
	
	CREATE OR REPLACE TRIGGER gatunek_male
	BEFORE INSERT ON GATUNKI
	FOR EACH ROW
	BEGIN
		:new.Nazwa:=lower(:new.Nazwa);
	END;
	/
	ALTER TRIGGER gatunek_male ENABLE;
	
-----------------------------------------------------------------  
CREATE OR REPLACE PACKAGE T_KG AS  
    
PROCEDURE ST_KG
(
 idgatunek in KsiazkiGatunki.idgatunek%TYPE
, idksiazka in KsiazkiGatunki.idksiazka%TYPE
);
END T_KG;
/
CREATE OR REPLACE PACKAGE BODY T_KG AS

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
	idgatunek_in,
	idksiazka_in);
END ST_KG;
END T_KG;
/
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_Ksiazke AS  
PROCEDURE ST_Ksiazki
(
 tytul_in in Ksiazki.Tytul%TYPE,
 data_wydania in Ksiazki.data_wydania%TYPE,
 OrginalnyJezyk in Ksiazki.OrginalnyJezyk%TYPE
) ;
END T_Ksiazke;
/
CREATE OR REPLACE PACKAGE BODY T_Ksiazke AS  
PROCEDURE ST_Ksiazki
(
 tytul_in in Ksiazki.Tytul%TYPE
) AS
BEGIN
	INSERT INTO Ksiazki 
	VALUES (
	Ksiazki_SEQ.nextval,
	tytul_in,
	data_wydania,
	OrginalnyJezyk
	);
END ST_Ksiazki;
END T_Ksiazke;
/
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_Autor AS
FUNCTION autor_p(
imie_1 in Autorzy.Imie%TYPE
) RETURN NUMBER;

PROCEDURE ST_Autorzy
(
 imie IN Autorzy.Imie%TYPE,
 nazwisko IN Autorzy.Nazwisko%TYPE,
 urodz IN Autorzy.urodzony%TYPE,
 zmarl IN Autorzy.zmarly%TYPE
);
END T_Autor;
/
CREATE OR REPLACE PACKAGE BODY T_Autor AS

FUNCTION autor_p(
imie_1 in Autorzy.Imie%TYPE
) RETURN NUMBER IS
	suma NUMBER :=0;
BEGIN
	SELECT COUNT(*) INTO suma FROM Autorzy WHERE Imie=imie_1;
	RETURN suma;
END autor_p;

PROCEDURE ST_Autorzy
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
END ST_Autorzy;
END T_Autor;
/
CREATE OR REPLACE TRIGGER autor_male
	BEFORE INSERT ON Autorzy
	FOR EACH ROW
	BEGIN
		:new.Imie:=lower(:new.Imie);
	END;
	/
	ALTER TRIGGER autor_male ENABLE;
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_KA AS
PROCEDURE ST_KA
(
 idautor IN KsiazkiAutorzy.idautor%TYPE,
 idksiazka IN KsiazkiAutorzy.idksiazka%TYPE
);
END T_KA;
CREATE OR REPLACE PACKAGE BODY T_KA AS
/
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
END T_KA;
/
-----------------------------------------------------------------
-- Fimy i pochodne
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_KA AS
PROCEDURE ST_Filmy
(
 tytul IN Filmy.Tytul%TYPE,
 idksiazka IN Filmy.idksiazka%TYPE
);
END T_KA;
/

CREATE OR REPLACE PACKAGE BODY T_KA AS
PROCEDURE ST_Filmy
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
END ST_Filmy;
END T_KA;
/

-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_OF AS

PROCEDURE ST_OcenyFilmu
(
 ocena IN OcenyFilmu.Ocena%TYPE
 krytyk IN OcenyFilmu.Krytyk%TYPE
 idfilmu IN OcenyFilmu.idfilm%TYPE
);
END T_OF;
/
CREATE OR REPLACE PACKAGE BODY T_OF AS

PROCEDURE ST_OcenyFilmu
(
 ocena_1 IN OcenyFilmu.Ocena%TYPE -- do poprawy
 krytyk IN OcenyFilmu.Krytyk%TYPE
 idfilmu IN OcenyFilmu.idfilm%TYPE
) AS
BEGIN
  if( ocena_1 > 10 ) THEN
        ocena_1:=10;
  end if;
  if( ocena_1 < 0 ) THEN
        ocena_1:=0;
  end if; 
	INSERT INTO OcenyFilmu 
	VALUES (
	OcenyFilmu_SEQ.nextval,
	ocena_1,
	krytyk,
	idfilmu
	);
END ST_OcenyFilmu;
END T_OF
/
-----------------------------------------------------------------


CREATE OR REPLACE PACKAGE T_Kategoria AS
FUNCTION Kategoria_p(
nazwa_1 in Kategoria.Nazwa%TYPE
) RETURN NUMBER;

PROCEDURE ST_Kategoria
(
 Nazwa IN Kategoria.Nazwa%TYPE
);
END T_Kategoria;
/
CREATE OR REPLACE PACKAGE BODY T_Kategoria AS
FUNCTION Kategoria_p(
nazwa_1 in Kategoria.Nazwa%TYPE
) RETURN NUMBER IS
	suma NUMBER :=0;
BEGIN
	SELECT COUNT(*) INTO suma FROM Autorzy WHERE Nazwa=nazwa_1;
	RETURN suma;
END Kategoria_p;

PROCEDURE ST_Kategoria
(
 Nazwa IN Kategoria.Nazwa%TYPE
) AS
BEGIN 
	INSERT INTO Kategoria
	VALUES (
	Kategoria_SEQ.nextval,
	Nazwa_in);
END ST_Kategoria;
END T_Kategoria;
/
CREATE OR REPLACE TRIGGER Kategoria_male
	BEFORE INSERT ON Kategoria
	FOR EACH ROW
	BEGIN
		:new.Nazwa:=lower(:new.Nazwa);
	END;
	/
	ALTER TRIGGER Kategoria_male ENABLE;
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE T_KF
PROCEDURE ST_FK
(
 idfilm IN FilmyKategoria.idfilm%TYPE,
 idkategoria IN FilmyKategoria.idkategoria%TYPE
);
END T_KF;
 /
CREATE OR REPLACE PACKAGE BODY T_KF
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
END T_KF;
/
-----------------------------------------------------------------
--  SELECTS
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE S_OCENY AS
PROCEDURE SE_OCENY(OCENY OUT SYS_REFCURSOR);

END S_OCENY;
/
CREATE OR REPLACE PACKAGE BODY S_OCENY AS
PROCEDURE SE_OCENY(OCENY OUT SYS_REFCURSOR) AS
BEGIN
OPEN OCENY FOR
SELECT idocena, Ocena, Krytyk FROM OCENY;
END SE_OCENY;
END S_OCENY;
/
-----------------------------------------------------------------
CREATE OR REPLACE PACKAGE F_Kategoria AS
PROCEDURE Fet_Kategoria(
idfilm in FilmyKategoria.idfilm%TYPE, Kategorie OUT SYS_REFCURSOR);
END F_Kategoria;
/
 CREATE OR REPLACE PACKAGE BODY F_Kategoria AS
 PROCEDURE Fet_Kategoria(
 idfilm_1 in FilmyKategoria.idfilm%TYPE,
 Kategorie OUT SYS_REFCURSOR) AS
 BEGIN
	OPEN Kategorie FOR
	SELECT k.Nazwa 
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
		SELECT  g.Nazwa
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
		SELECT Imie,Nazwisko 
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
	SELECT idksiazka,Tytul,data_wydania,OrginalnyJezyk
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