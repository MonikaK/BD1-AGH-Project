from app import app
from flask import (
    flash, redirect, render_template, request, url_for
)

from app.form import *
from app.functions import *

@app.route('/')
def index():
    return render_template('index.html')


@app.route('/add/<form_name>', methods=["GET", "POST"])
def add(form_name):
    Forms = Forms_tuple()

    if form_name == 'none':
        return redirect(url_for('select_form', function='add'))

    form = Forms[form_name]
    
    handling_forms(form,form_name)
    if form.is_submitted():
        insert(form_name,form)
        flash('Dodano rekord do bazy')
        return redirect(url_for('index'))

    return render_template('form.html', form = form)


@app.route('/select/<form_name>', methods=["GET", "POST"])
def select(form_name):
    Forms = Forms_tuple()

    if form_name == 'none':
        return redirect(url_for('select_form', function='select'))
    
    form = Forms[form_name]
    records = select_all(form_name)

    return render_template('select.html', form = form, records= records)
           
@app.route('/select_form/<function>', methods=["GET", "POST"])
def select_form(function):
    form = select_table()
    Forms= Forms_tuple()
    if function == 'add':
        x = [key for key,value in Forms.items() if key!='SalaKinowa']
    else:
        x = [key for key,value in Forms.items()]

    form.nazwa.choices = x
    if form.is_submitted():
        result = request.form['nazwa']
        return redirect(url_for(function, form_name=result))
    return render_template('form.html', form = form)

@app.route('/data', methods=["GET", "POST"])  
@app.route('/data/<function>', methods=["GET", "POST"])
def data(function=0):
    names = []
    show = False
    records =[]
    if function:
        show = True

        if function == '1':
            names = ['id_osoba_rezerwująca', 'imię', 'nazwisko', 'PESEL', 'email', 'miejscowość', 'powiat', 'gmina', 'adres', 'kod pocztowy', 'poczta']
            records= search_data("SELECT o.idosobarezerwujaca, o.imie, o.nazwisko, o.pesel, o.email, m.nazwa AS miejscowosc, m.powiat, m.gmina, o.adres, o.kodpocztowy, o.poczta  FROM osobarezerwujaca o JOIN miejscowosc m ON o.miejscowosc_idmiejscowosc=m.idmiejscowosc;")    
        
        if function == '2':
            names = ['miesiąc', 'data początku', 'data końca', 'godzina', 'czas trwania', 'tytuł', 'wersja językowa', 'napisy', 'typ seansu']
            records= search_data("SELECT * FROM Repertuar_miesieczny")
        
        if function == '3':
            names = ['id_rezerwacje', 'imię', 'nazwisko', 'tytuł', 'godzina', 'rząd', 'miejsce', 'data seansu', 'cena', 'potwierdzenie']
            records= search_data("SELECT * from Rezerwacje_widok")
    
        if function == '4':
            names = ['id_sprzedaz', 'imię', 'nazwisko', 'tytuł', 'godzina', 'rząd', 'miejsce', 'data sprzedaży', 'cena']
            records= search_data("SELECT * FROM Sprzedaz_widok")

    return render_template('data.html', records=records, names=names, show=show)