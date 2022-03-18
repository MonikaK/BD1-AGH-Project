CREATE VIEW Repertuar_miesieczny AS 
SELECT CAST(EXTRACT(MONTH FROM datapoczatku) AS INT) AS Miesiac, 
      datapoczatku AS "Data początku", 
	  datakonca AS "Data końca"
		godzina, 
		film.czastrwania AS Czas_trwania,
		film.tytulfilmu AS Tytuł, 
		film.wersjajezykowa AS "Wersja językowa", 
		CASE film.napisy
		  WHEN TRUE THEN 'Wersja z napisami'
		  ELSE 'Brak napisów'
		END AS "Napisy",
		film.typseansu AS "2D/3D"
FROM repertuar, film
where repertuar.film_idfilm = film.idfilm
ORDER BY  extract(YEAR FROM datapoczatku), extract(MONTH FROM datapoczatku), godzina;


CREATE VIEW Rezerwacje_widok AS 
SELECT rez.idrezerwacje, o.imie, o.nazwisko, 
	   f.tytulFilmu AS Tytuł, 
	   r.godzina, s.rzad, s.miejsce, 
	   rez.dataSeansu AS "Data seansu", 
	   rez.cena, rez.potwierdzenie 
FROM (rezerwacje rez 
		JOIN osobarezerwujaca o ON rez.osobarezerwujaca_idosobarezerwujaca=o.idosobarezerwujaca
		JOIN salakinowa s ON rez.salakinowa_idsalakinowa=s.idsalakinowa) 
	JOIN (repertuar r JOIN film f ON r.film_idfilm=f.idfilm) 
	ON rez.repertuar_idrepertuar=r.idrepertuar;


CREATE VIEW Sprzedaz_widok AS
SELECT sp.idsprzedaz, o.imie, o.nazwisko, 
	   f.tytulFilmu AS Tytuł, 
	   r.godzina, s.rzad, s.miejsce, 
	   sp.dataSprzedazy AS "Data rezerwacji", 
	   sp.cena  
FROM sprzedaz sp 
		JOIN (((rezerwacje rez 
				JOIN osobarezerwujaca o ON rez.osobarezerwujaca_idosobarezerwujaca=o.idosobarezerwujaca) 
				JOIN salakinowa s ON rez.salakinowa_idsalakinowa=s.idsalakinowa)
		JOIN (repertuar r JOIN film f ON r.film_idfilm=f.idfilm) ON rez.repertuar_idrepertuar=r.idrepertuar) 
		ON sp.rezerwacje_idrezerwacje=rez.idrezerwacje;


CREATE OR REPLACE FUNCTION potwierdzsprzedaz() 
RETURNS trigger AS
$$
BEGIN
  UPDATE rezerwacje SET potwierdzenie = true WHERE rezerwacje.idrezerwacje = NEW.rezerwacje_idrezerwacje;
  RETURN NEW;
END;      
$$
LANGUAGE plpgsql; 

DROP TRIGGER PotwierdzenieSprzedazy ON sprzedaz;

CREATE TRIGGER PotwierdzenieSprzedazy 
AFTER INSERT 
ON Sprzedaz
FOR EACH ROW
EXECUTE PROCEDURE potwierdzsprzedaz();