INSERT INTO TypBiletu(typBiletu) VALUES 
 ('normalny'),
 ('ulgowy'),
 ('grupowy normalny'),
 ('grupowy ulgowy');


INSERT INTO SalaKinowa(rzad, miejsce) VALUES
 (1, 1),
 (1, 2),
 (1, 3),
 (1, 4),
 (1, 5),
 (1, 6),
 (1, 7),
 (1, 8),
 (1, 9),
 (1, 10),
 (2, 1),
 (2, 2),
 (2, 3),
 (2, 4),
 (2, 5),
 (2, 6),
 (2, 7),
 (2, 8),
 (2, 9),
 (2, 10),
 (3, 1),
 (3, 2),
 (3, 3),
 (3, 4),
 (3, 5),
 (3, 6),
 (3, 7),
 (3, 8),
 (3, 9),
 (3, 10),
 (4, 1),
 (4, 2),
 (4, 3),
 (4, 4),
 (4, 5),
 (4, 6),
 (4, 7),
 (4, 8),
 (4, 9),
 (4, 10),
 (5, 1),
 (5, 2),
 (5, 3),
 (5, 4),
 (5, 5),
 (5, 6),
 (5, 7),
 (5, 8),
 (5, 9),
 (5, 10);


INSERT INTO Film(tytulFilmu, Rezyser, Rok, wersjaJezykowa, napisy, typSeansu, czasTrwania, opis) VALUES 
 ('All my life', 'Marc Meyers', 2020, 'polski', FALSE, '2D', 93, 'Plany weselne młodych zakochanych ulegają zmianie, kiedy u mężczyzny zostaje wykryty rak wątroby'),
 ('Ojciec', 'Florian Zeller', 2020, 'polski', FALSE, '2D', 97, 'Kobieta próbuje zaopiekować się ojcem wykazującym oznaki demencji, który mimo postępującej choroby pragnie pozostać samodzielny'),
 ('Zaułek koszmarów', 'Guillermo del Toro', 2021, 'angielski', TRUE, '2D', 150, 'Gdy charyzmatyczny Stanton Carlisle spotyka na swej drodze niezwykłe małżeństwo: widzącą przyszłość Zeenę i jej męża, byłego telepatę, Pete’a, postanawia odmienić swoje dotychczas pechowe życie'),
 ('Belfast', 'Kenneth Branagh', 2021, 'angielski', TRUE, '2D', 97, 'Życie młodego chłopca i jego robotniczej rodziny w burzliwych latach sześćdziesiątych XX w'),
 ('Diuna', 'Denis Villeneuve', 2021, 'angielski', TRUE, '3D', 155, 'Szlachetny ród Atrydów przybywa na Diunę, będącą jedynym źródłem najcenniejszej substancji we wszechświecie');


INSERT INTO Miejscowosc(nazwa, powiat, gmina) VALUES
 ('Kraków', 'krakowski', 'Kraków'),
 ('Chrzanów', 'chrzanowski', 'Chrzanów'),
 ('Płaza', 'chrzanowski', 'Chrzanów'),
 ('Kryspinów', 'krakowski', 'Liszki');


INSERT INTO OsobaRezerwujaca(Miejscowosc_idMiejscowosc, imie, nazwisko, email, adres, PESEL, kodPocztowy, poczta) VALUES
 (1, 'Katarzyna', 'Nowak', 'kasia.nowak@wp.pl', 'Klonowa 1', '98030509367', '30-002', 'Kraków'),
 (2, 'Dominik','Kowalski', 'd.kowalski@gmail.com', 'Zaciszna 5', '70012905276', '32-500', 'Chrzanów'),
 (2, 'Magdalena','Spyra', 'magda-spyra@interia.pl', 'Chrobrego 3', '89110309682', '32-500', 'Chrzanów'),
 (3, 'Robert', 'Kulczyk', 'r.kulczyk@wp.pl', 'Kolorowa 20', '00240407178', '32-552', 'Płaza'),
 (4, 'Agnieszka', 'Małek', 'aga_malek@gmail.com', 'Sienkiewicza 15', '03312006562', '32-060', 'Kryspinów'),
 (1, 'Adam', 'Zawadzki', 'adamzawadzki@wp.pl', 'Krakowska 2', '90052503071', '30-015', 'Kraków');


INSERT INTO Repertuar(Film_idFilm, dataPoczatku, dataKonca, godzina) VALUES
 (1, '2022-01-28', '2022-02-10', '16:50'),
 (2, '2021-12-01', '2021-12-15', '19:00'),
 (3, '2021-10-09', '2021-10-25', '15:20'),
 (4, '2022-02-10', '2022-02-24', '10:00'),
 (5, '2022-02-07', '2022-02-26', '14:05'),
 (3, '2021-10-09', '2021-10-25', '18:10'),
 (5, '2022-02-07', '2022-02-26', '18:30');


INSERT INTO Rezerwacje(Repertuar_idRepertuar, SalaKinowa_idSalaKinowa, OsobaRezerwujaca_idOsobaRezerwujaca, dataSeansu, cena, potwierdzenie) VALUES
 (3, 2, 6, '2021-10-15', 26, true),
 (4, 8, 1, '2022-02-18', 23, false),
 (1, 3, 2, '2022-02-03', 22, false),
 (5, 10, 5, '2022-02-11', 45, true),
 (2, 11, 4, '2021-12-05', 23, true),
 (7, 4, 3, '2022-02-25', 45, false);


INSERT INTO Sprzedaz(Rezerwacje_Repertuar_idRepertuar, Rezerwacje_idRezerwacje, TypBiletu_idTypBiletu, dataSprzedazy, cena) VALUES
 (3, 1, 1, '2021-10-15', 26),
 (5, 4, 2, '2022-02-11', 41),
 (2, 5, 1, '2021-12-05', 23);