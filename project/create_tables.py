"""Script for create tables for a database."""

from sqlite3 import Error, connect
import os

base_dir = os.path.dirname(__file__)
database = f"{base_dir}/data_base.sqlite"
create_tables_sql = f"{base_dir}/create_tables.sql"


def create_tables(database_path: str, create_tables_sql_path: str) -> None:
    """Creating tables."""
    with open(create_tables_sql_path, "r", encoding="utf-8") as f:
        sql = f.read()
    with connect(database_path) as db:
        cur = db.cursor()
        try:
            cur.executescript(sql)
            db.commit()
        except Error as e:
            print(e)
        finally:
            db.rollback()
            cur.close()


if __name__ == "__main__":
    create_tables(database, create_tables_sql)
