"""Script for data manipulation."""

import sqlite3
import re
from project.create_tables import database, base_dir


def selected() -> str:
    """Data manipulation."""
    with open(f"{base_dir}/selected.sql", "r", encoding="utf-8") as f:
        sql = f.read()
        list_sql_command = [comm.strip() for comm in sql.split(";")]
        comments = re.findall(r"--[^.]+\.", sql)
    with sqlite3.connect(database) as db:
        cur = db.cursor()
        res = ""
        try:
            for command, comment in zip(list_sql_command, comments):
                cur.execute(command)
                output = cur.fetchall()
                if output:
                    res += f"{comment}\n"
                    res += f"{output}\n\n"
            db.commit()
            return res
        except sqlite3.Error as e:
            print(e)
        finally:
            db.rollback()
            cur.close()


if __name__ == "__main__":
    print(selected())
