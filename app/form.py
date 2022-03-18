from flask_wtf import FlaskForm
from wtforms import (
    StringField,
    SubmitField,
    BooleanField,
    IntegerField,
    DateField,
    SelectField,
    TimeField
)
from wtforms.validators import InputRequired

class TypBiletu(FlaskForm):
    typBiletu = StringField("typ biletu", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class SalaKinowa(FlaskForm):
    rzad = IntegerField("rząd", validators=[InputRequired()])
    miejsce = IntegerField("miejsce", validators=[InputRequired()])

class Film(FlaskForm):
    tytulFilmu = StringField("tytuł filmu", validators=[InputRequired()])
    Rezyser = StringField("reżyser", validators=[InputRequired()])
    Rok = IntegerField("rok produkcji", validators=[InputRequired()])
    wersjaJezykowa = StringField("wersja językowa", validators=[InputRequired()])
    napisy = BooleanField("napisy", validators=[InputRequired()])
    typSeansu = StringField("typ seansu", validators=[InputRequired()])
    czasTrwania = IntegerField("czas trwania", validators=[InputRequired()])
    opis = StringField("opis filmu", validators=[InputRequired()])
    submit = SubmitField("Dodaj")


class Miejscowosc(FlaskForm):
    nazwa = StringField("nazwa miejscowosci", validators=[InputRequired()])
    powiat = StringField("powiat", validators=[InputRequired()])
    gmina = StringField("gmina", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class OsobaRezerwujaca(FlaskForm):
    Miejscowosc_idMiejscowosc = SelectField("id_miejscowosc",coerce=int, validators=[InputRequired()])
    imie = StringField("imię", validators=[InputRequired()])
    nazwisko = StringField("nazwisko", validators=[InputRequired()])
    email = StringField("email", validators=[InputRequired()])
    adres = StringField("adres", validators=[InputRequired()])
    PESEL = StringField("PESEL", validators=[InputRequired()])
    kodPocztowy = StringField("kod pocztowy", validators=[InputRequired()])
    poczta = StringField("poczta", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Repertuar(FlaskForm):
    Film_idFilm = SelectField("id_repertuar",coerce=int, validators=[InputRequired()])
    dataPoczatku = DateField("data początku (rrrr-mm-dd)", validators=[InputRequired()])
    dataKonca = DateField("data końca (rrrr-mm-dd)", validators=[InputRequired()])
    godzina = TimeField("Godzina seansu", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Rezerwacje(FlaskForm):
    Repertuar_idRepertuar = SelectField("id_repertuar",coerce=int, validators=[InputRequired()])
    SalaKinowa_idSalaKinowa = SelectField("id_sala_kinowa",coerce=int, validators=[InputRequired()])
    OsobaRezerwujaca_idOsobaRezerwujaca = SelectField("id_osoba_rezerwujaca",coerce=int, validators=[InputRequired()])
    dataSeansu = DateField("data seansu (rrrr-mm-dd)", validators=[InputRequired()])
    cena = IntegerField("cena", validators=[InputRequired()])
    potwierdzenie = BooleanField("potwierdzenie zakupu", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class Sprzedaz(FlaskForm):
    Rezerwacje_Repertuar_idRepertuar = SelectField("id_repertuar",coerce=int, validators=[InputRequired()])
    Rezerwacje_idRezerwacje = SelectField("id_rezerwacje",coerce=int, validators=[InputRequired()])
    TypBiletu_idTypBiletu = SelectField("id_typ_biletu",coerce=int, validators=[InputRequired()])
    dataSprzedazy = DateField("data sprzedazy (rrrr-mm-dd)", validators=[InputRequired()])
    cena = IntegerField("cena", validators=[InputRequired()])
    submit = SubmitField("Dodaj")

class select_table(FlaskForm):
    nazwa = SelectField("nazwa tabeli",coerce=str)
    submit = SubmitField("wybierz")