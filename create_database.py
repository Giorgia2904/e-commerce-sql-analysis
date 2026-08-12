import sqlite3
import pandas as pd
from pathlib import Path

# Cartella che contiene i CSV
DATA_DIR = Path("e-commerce data")

# Nome del database SQLite
DB_PATH = Path("ecommerce.db")

# Connessione al database
conn = sqlite3.connect(DB_PATH)

# CSV da importare
tables = [
    "categories",
    "customers",
    "products",
    "orders",
    "order_items",
    "returns"
]

# Importazione dei CSV
for table in tables:
    file_path = DATA_DIR / f"{table}.csv"

    df = pd.read_csv(file_path)

    df.to_sql(
        table,
        conn,
        if_exists="replace",
        index=False
    )

    print(f"{table}: {len(df):,} rows imported")

conn.close()

print("\nDatabase created successfully.")