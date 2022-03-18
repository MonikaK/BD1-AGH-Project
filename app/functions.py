import psycopg2
from app.form import *

DB_URL = "postgres://rqmhbtfj:3dgDfhNxPrEcuzYA5t2_jhquPGp7XGZj@abul.db.elephantsql.com:5432/rqmhbtfj"

def execute_command(query):
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"{query};")
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")


def search_data(query):
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"{query};")
                records = cursor.fetchall()
        return records
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")

def select_all(table):
    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"SELECT * from {table};")
                records = cursor.fetchall()
        return records
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")
        
def is_filled(data):
   if data == None:
      return False
   if data == '':
      return False
   if data == []:
      return False
   if data == 0:
      return False
   return True

def insert(table, form):
    names = []
    values = []
    for field in form:
        if is_filled(field.data) and field.name not in ["submit","csrf_token", "choose"]:
            names.append(field.name)
            values.append("'" + str(field.data) + "'")
    names = ",".join(names)
    values = ",".join(values)

    try:
        conn = psycopg2.connect(DB_URL)
        with conn:
            with conn.cursor() as cursor:
                cursor.execute(f"INSERT INTO {table}({names}) VALUES ({values});")
    except (Exception, psycopg2.Error) as error:
        print ("Error while fetching data from PostgreSQL", error)
    finally:
        conn.close()
        print("conn closed")

def Forms_tuple():
    Forms = {
        "TypBiletu":TypBiletu(),
        "Film":Film(),
        "SalaKinowa":SalaKinowa(),
        "Miejscowosc":Miejscowosc(),
        "OsobaRezerwujaca":OsobaRezerwujaca(),
        "Repertuar":Repertuar(),
        "Rezerwacje":Rezerwacje(),
        "Sprzedaz":Sprzedaz(),
    }
    return Forms

def handling_forms(form, form_name):
    if form_name == "OsobaRezerwujaca":
        tmp = select_all("Miejscowosc")
        form.Miejscowosc_idMiejscowosc.choices= [(row[0],f"id: {row[0]} ; nazwa: {row[1]}; powiat: {row[2]}; gmina: {row[3]}") for row in tmp]
    
    if form_name == "Repertuar":
        tmp = select_all("Film")
        form.Film_idFilm.choices= [(row[0],f"id: {row[0]} ; tytuł: {row[1]}; reżyser: {row[2]}; rok: {row[3]}; wersja językowa: {row[4]}; napisy: {row[5]}; typ seansu: {row[6]}; czas trwania: {row[7]}") for row in tmp]

    if form_name == "Rezerwacje":
        tmp = select_all("Repertuar")
        form.Repertuar_idRepertuar.choices= [(row[0],f"id: {row[0]} ; id filmu: {row[1]}; data początku: {row[2]}; data końca: {row[3]}; godzina: {row[4]}") for row in tmp]
        tmp = select_all("SalaKinowa")
        form.SalaKinowa_idSalaKinowa.choices= [(row[0],f"id: {row[0]} ; id rzad: {row[1]}; miejsce: {row[2]}") for row in tmp]
        tmp = select_all("OsobaRezerwujaca")
        form.OsobaRezerwujaca_idOsobaRezerwujaca.choices= [(row[0],f"id: {row[0]} ; id miejscowosci: {row[1]}; imie: {row[2]}; nazwisko: {row[3]}") for row in tmp]
        

    if form_name == "Sprzedaz":
        tmp = select_all("Repertuar")
        form.Rezerwacje_Repertuar_idRepertuar.choices= [(row[0],f"id: {row[0]} ; id filmu: {row[1]}; data początku: {row[2]}; data końca: {row[3]}; godzina: {row[4]}") for row in tmp]
        tmp = select_all("Rezerwacje")
        form.Rezerwacje_idRezerwacje.choices= [(row[0],f"id: {row[0]} ; id repertuaru: {row[1]}; id sali kinowej: {row[2]}; id osoby rezerwującej: {row[3]}") for row in tmp]
        tmp = select_all("TypBiletu")
        form.TypBiletu_idTypBiletu.choices= [(row[0],f"id: {row[0]} ; typ biletu: {row[1]}") for row in tmp]