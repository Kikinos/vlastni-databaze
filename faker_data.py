# Skript pro generování falešných dat pro sportovní databázi (kluby, hráči, zápasy, soutěže...)
# Používá knihovnu Faker pro generování realistických českých dat.
# Výstupem je SQL soubor s INSERT příkazy pro všechny tabulky.

from faker import Faker
import random
from datetime import datetime, timedelta

fake = Faker("cs_CZ")
random.seed(42)

# === PARAMETRY POČTŮ ===
NUM_MESTO = 10
NUM_ADRESA = 20
NUM_KLUB = 10
NUM_KATEGORIE = 5
NUM_HRAC = 50
NUM_STADION = 10
NUM_SOUTEZ = 5
NUM_ZAPAS = 20

# === Pomocná funkce pro generování náhodného data ===
def random_date(start_year=2023, end_year=2025):
    start_date = datetime(start_year, 1, 1)
    end_date = datetime(end_year, 12, 31)
    return fake.date_between(start_date=start_date, end_date=end_date).strftime("%Y-%m-%d")

# === GENEROVÁNÍ DAT ===

# Města
mesta = [(i, fake.city()) for i in range(1, NUM_MESTO + 1)]

# Adresy
adresy = [
    (i, fake.street_name(), str(fake.building_number()), fake.postcode(), random.choice(mesta)[0])
    for i in range(1, NUM_ADRESA + 1)
]

# Kategorie (např. mládež, ženy, dospělí)
kategorie = [
    (i, fake.word().capitalize(), random.choice(range(1980, 2015)))
    for i in range(1, NUM_KATEGORIE + 1)
]

# Kluby
kluby = [
    (i, fake.company(), random.choice(mesta)[0])
    for i in range(1, NUM_KLUB + 1)
]

# Stadiony
stadiony = [
    (i, random.choice(mesta)[0], random.choice(adresy)[0])
    for i in range(1, NUM_STADION + 1)
]

# Soutěže
souteze = [
    (i, f"{fake.word().capitalize()} Cup", random.choice(['liga', 'turnaj', 'pohár']), random.choice(kategorie)[0])
    for i in range(1, NUM_SOUTEZ + 1)
]

# Hráči
hraci = []
for i in range(1, NUM_HRAC + 1):
    pohlavi = random.choice(['M', 'F'])
    if pohlavi == 'M':
        jmeno = fake.first_name_male()
        prijmeni = fake.last_name_male()
    else:
        jmeno = fake.first_name_female()
        prijmeni = fake.last_name_female()

    datum_narozeni = fake.date_of_birth(minimum_age=10, maximum_age=40).strftime("%Y-%m-%d")
    id_klub = random.choice(kluby)[0]
    id_kategorie = random.choice(kategorie)[0]
    hraci.append((i, jmeno, prijmeni, datum_narozeni, pohlavi, id_klub, id_kategorie))

# Zápasy
zapasy = []
for i in range(1, NUM_ZAPAS + 1):
    id_soutez = random.choice(souteze)[0]
    id_stadion = random.choice(stadiony)[0]
    domaci, hoste = random.sample(kluby, 2)
    datum = random_date()
    cas = fake.time(pattern="%H:%M:%S")
    skore_domaci = random.randint(0, 5)
    skore_hoste = random.randint(0, 5)
    zapasy.append((i, id_soutez, id_stadion, domaci[0], hoste[0], datum, cas, skore_domaci, skore_hoste))

# === GENEROVÁNÍ SQL INSERTŮ ===

sql_lines = []

def insert_lines(table, columns, values_list):
    sql_lines.append(f"-- {table}")
    for values in values_list:
        val_str = ", ".join(f"'{v}'" if isinstance(v, str) else str(v) for v in values)
        sql_lines.append(f"INSERT INTO {table} ({', '.join(columns)}) VALUES ({val_str});")
    sql_lines.append("")

# Vkládání tabulek v pořadí podle cizích klíčů
insert_lines("Mesto", ["id_mesto", "nazev"], mesta)
insert_lines("Adresa", ["id_adresa", "ulice", "cislo_popisne", "psc", "id_mesto"], adresy)
insert_lines("Kategorie", ["id_kategorie", "nazev", "rocnik_od"], kategorie)
insert_lines("Klub", ["id_klub", "nazev", "id_mesto"], kluby)
insert_lines("Stadion", ["id_stadion", "id_mesto", "id_adresa"], stadiony)
insert_lines("Soutez", ["id_soutez", "nazev", "typ", "id_kategorie"], souteze)
insert_lines("Hrac", ["id_hrac", "jmeno", "prijmeni", "datum_narozeni", "pohlavi", "id_klub", "id_kategorie"], hraci)
insert_lines("Zapas", ["id_zapas", "id_soutez", "id_stadion", "id_domaci_klub", "id_hoste_klub", "datum", "cas", "skore_domaci", "skore_hoste"], zapasy)

# === ULOŽENÍ DO SOUBORU ===
sql_file_path = "sport_demo_data.sql"
with open(sql_file_path, "w", encoding="utf-8") as f:
    f.write("\n".join(sql_lines))

print(f"✅ SQL dump uložen do souboru: {sql_file_path}")
