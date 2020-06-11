INSERT INTO Ksiazki VALUES (Ksiazki_SEQ.nextval,'Diuna',1965,'Angielski');
INSERT INTO Ksiazki VALUES (Ksiazki_SEQ.nextval,'Diuna. Bitwa pod Corrinem',1965,'Angielski');
INSERT INTO Ksiazki VALUES (Ksiazki_SEQ.nextval,'Władca Pierścieni',1954,'Angielski');


INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,9,1);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,9,1);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,10,1);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,10,1);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,9,2);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,1,2);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,5,2);

INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,9,3);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,9,3);
INSERT INTO Oceny VALUES (Oceny_SEQ.nextval,10,3);


INSERT INTO Autorzy VALUES (Autorzy_SEQ.nextval,'Frank','Herbert',TO_DATE('1920/10/08','RRRR/MM/DD'),TO_DATE('1996/02/11','RRRR/MM/DD'));
INSERT INTO Autorzy VALUES (Autorzy_SEQ.nextval,'Brian','Herbert',TO_DATE('1947/06/29','RRRR/MM/DD'),NULL);
INSERT INTO Autorzy VALUES (Autorzy_SEQ.nextval,'Kevin','Anderson',TO_DATE('1962/03/27','RRRR/MM/DD'),NULL);
INSERT INTO Autorzy VALUES (Autorzy_SEQ.nextval,'John','Tolkien',TO_DATE('1892/01/03','RRRR/MM/DD'),TO_DATE('1973/09/02','RRRR/MM/DD'));

INSERT INTO GATUNKI VALUES(GATUNKI_SEQ.nextval,'fantastyka');
INSERT INTO Gatunki VALUES(GATUNKI_SEQ.nextval,'fantasy');
INSERT INTO GATUNKI VALUES(GATUNKI_SEQ.nextval,'sicience fiction');

INSERT INTO KsiazkiAutorzy VALUES(KsiazkiAutorzy_SEQ.nextval,1,1);
INSERT INTO KsiazkiAutorzy VALUES(KsiazkiAutorzy_SEQ.nextval,2,2);
INSERT INTO KsiazkiAutorzy VALUES(KsiazkiAutorzy_SEQ.nextval,3,2);
INSERT INTO KsiazkiAutorzy VALUES(KsiazkiAutorzy_SEQ.nextval,4,3);

INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,1,1);
INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,1,2);
INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,1,3);

INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,2,1);
INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,2,2);
INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,2,3);

INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,3,1);
INSERT INTO KsiazkiGatunki VALUES(KsiazkiGatunki_SEQ.nextval,3,2);

INSERT INTO Filmy VALUES(Filmy_SEQ.nextval,'Władca Pierścieni: Drużyna Pierścienia',3);
INSERT INTO Filmy VALUES(Filmy_SEQ.nextval,'Władca Pierścieni: Powrót Króla',3);

INSERT INTO OcenyFilmu VALUES (OcenyFilmu_SEQ.nextval,9,1);
INSERT INTO OcenyFilmu VALUES (OcenyFilmu_SEQ.nextval,8,1);
INSERT INTO OcenyFilmu VALUES (OcenyFilmu_SEQ.nextval,9,2);
INSERT INTO OcenyFilmu VALUES (OcenyFilmu_SEQ.nextval,10,2);

INSERT INTO Kategoria VALUES (Kategoria_SEQ.nextval,'Przygodowy');
INSERT INTO Kategoria VALUES (Kategoria_SEQ.nextval,'Fantasy');

INSERT INTO FilmyKategoria VALUES (FilmyKategoria_SEQ.nextval,1,1);
INSERT INTO FilmyKategoria VALUES (FilmyKategoria_SEQ.nextval,1,2);
INSERT INTO FilmyKategoria VALUES (FilmyKategoria_SEQ.nextval,2,1);
INSERT INTO FilmyKategoria VALUES (FilmyKategoria_SEQ.nextval,2,2);