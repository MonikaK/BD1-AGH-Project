DROP TABLE IF EXISTS TypBiletu CASCADE;
CREATE TABLE TypBiletu (
  idTypBiletu SERIAL NOT NULL,
  typBiletu VARCHAR  NOT NULL ,
PRIMARY KEY(idTypBiletu));


DROP TABLE IF EXISTS SalaKinowa CASCADE;
CREATE TABLE SalaKinowa (
  idSalaKinowa SERIAL NOT NULL,
  rzad INTEGER    NOT NULL,
  miejsce INTEGER      NOT NULL,
PRIMARY KEY(idSalaKinowa));


DROP TABLE IF EXISTS Film CASCADE;
CREATE TABLE Film (
  idFilm SERIAL NOT NULL ,
  tytulFilmu VARCHAR    NOT NULL,
  Rezyser VARCHAR    NOT NULL,
  Rok INTEGER    NOT NULL,
  wersjaJezykowa VARCHAR    NOT NULL,
  napisy BOOL    NOT NULL,
  typSeansu Varchar    NOT NULL,
  czasTrwania INTEGER    NOT NULL,
  opis VARCHAR      NOT NULL,
PRIMARY KEY(idFilm));


DROP TABLE IF EXISTS Miejscowosc CASCADE;
CREATE TABLE Miejscowosc (
  idMiejscowosc SERIAL NOT NULL ,
  nazwa VARCHAR    NOT NULL,
  powiat VARCHAR    NOT NULL,
  gmina VARCHAR      NOT NULL,
PRIMARY KEY(idMiejscowosc));


DROP TABLE IF EXISTS OsobaRezerwujaca CASCADE;
CREATE TABLE OsobaRezerwujaca (
  idOsobaRezerwujaca SERIAL NOT NULL ,
  Miejscowosc_idMiejscowosc INTEGER   NOT NULL ,
  imie VARCHAR    NOT NULL,
  nazwisko VARCHAR    NOT NULL,
  email VARCHAR    NOT NULL,
  adres VARCHAR    NOT NULL,
  PESEL VARCHAR   NOT NULL,
  kodPocztowy VARCHAR    NOT NULL,
  poczta VARCHAR      NOT NULL,
PRIMARY KEY(idOsobaRezerwujaca)  ,
  FOREIGN KEY(Miejscowosc_idMiejscowosc)
    REFERENCES Miejscowosc(idMiejscowosc));


CREATE INDEX OsobaRezerwujaca_FKIndex1 ON OsobaRezerwujaca (Miejscowosc_idMiejscowosc);
CREATE INDEX IFK_Rel_10 ON OsobaRezerwujaca (Miejscowosc_idMiejscowosc);


DROP TABLE IF EXISTS Repertuar CASCADE;
CREATE TABLE Repertuar (
  idRepertuar SERIAL  NOT NULL ,
  Film_idFilm INTEGER   NOT NULL ,
  dataPoczatku DATE    NOT NULL,
  dataKonca DATE    NOT NULL,
  godzina TIME      NOT NULL,
PRIMARY KEY(idRepertuar)  ,
  FOREIGN KEY(Film_idFilm)
    REFERENCES Film(idFilm));


CREATE INDEX Repertuar_FKIndex1 ON Repertuar (Film_idFilm);
CREATE INDEX IFK_Rel_02 ON Repertuar (Film_idFilm);


DROP TABLE IF EXISTS Rezerwacje CASCADE;
CREATE TABLE Rezerwacje (
  idRezerwacje SERIAL  NOT NULL ,
  Repertuar_idRepertuar INTEGER   NOT NULL ,
  SalaKinowa_idSalaKinowa INTEGER   NOT NULL ,
  OsobaRezerwujaca_idOsobaRezerwujaca INTEGER   NOT NULL ,
  dataSeansu DATE    NOT NULL,
  cena INTEGER    NOT NULL,
  potwierdzenie BOOL      NOT NULL,
PRIMARY KEY(idRezerwacje, Repertuar_idRepertuar)      ,
  FOREIGN KEY(OsobaRezerwujaca_idOsobaRezerwujaca)
    REFERENCES OsobaRezerwujaca(idOsobaRezerwujaca),
  FOREIGN KEY(SalaKinowa_idSalaKinowa)
    REFERENCES SalaKinowa(idSalaKinowa),
  FOREIGN KEY(Repertuar_idRepertuar)
    REFERENCES Repertuar(idRepertuar));


CREATE INDEX Rezerwacje_FKIndex4 ON Rezerwacje (OsobaRezerwujaca_idOsobaRezerwujaca);
CREATE INDEX Rezerwacje_FKIndex5 ON Rezerwacje (SalaKinowa_idSalaKinowa);
CREATE INDEX Rezerwacje_FKIndex6 ON Rezerwacje (Repertuar_idRepertuar);


CREATE INDEX IFK_Rel_08 ON Rezerwacje (OsobaRezerwujaca_idOsobaRezerwujaca);
CREATE INDEX IFK_Rel_05 ON Rezerwacje (SalaKinowa_idSalaKinowa);
CREATE INDEX IFK_Rel_18 ON Rezerwacje (Repertuar_idRepertuar);


DROP TABLE IF EXISTS Sprzedaz CASCADE;
CREATE TABLE Sprzedaz (
  idSprzedaz SERIAL   NOT NULL ,
  Rezerwacje_Repertuar_idRepertuar INTEGER   NOT NULL ,
  Rezerwacje_idRezerwacje INTEGER   NOT NULL ,
  TypBiletu_idTypBiletu INTEGER   NOT NULL ,
  dataSprzedazy DATE    NOT NULL,
  cena INTEGER      NOT NULL,
PRIMARY KEY(idSprzedaz, Rezerwacje_Repertuar_idRepertuar, Rezerwacje_idRezerwacje, TypBiletu_idTypBiletu)    ,
  FOREIGN KEY(Rezerwacje_idRezerwacje, Rezerwacje_Repertuar_idRepertuar)
    REFERENCES Rezerwacje(idRezerwacje, Repertuar_idRepertuar),
  FOREIGN KEY(TypBiletu_idTypBiletu)
    REFERENCES TypBiletu(idTypBiletu));


CREATE INDEX Sprzedaz_FKIndex1 ON Sprzedaz (Rezerwacje_idRezerwacje, Rezerwacje_Repertuar_idRepertuar);
CREATE INDEX Sprzedaz_FKIndex2 ON Sprzedaz (TypBiletu_idTypBiletu);
CREATE INDEX IFK_Rel_19 ON Sprzedaz (Rezerwacje_idRezerwacje, Rezerwacje_Repertuar_idRepertuar);
CREATE INDEX IFK_Rel_09 ON Sprzedaz (TypBiletu_idTypBiletu);