"""Script for fill in with data tables."""

import sqlite3
from random import randint
from faker import Faker
from project.create_tables import database

STATUS_ROWS = 3
USERS_ROWS = 15
TASKS_ROWS = 30


def data_generate() -> tuple[list[tuple], list[tuple], list[tuple]]:
    """Generate data for tables."""
    fake = Faker()

    # for status table
    for_status_table = [("new",), ("in progress",), ("completed",)]

    # for users table
    for_users_table = []
    for _ in range(USERS_ROWS):
        for_users_table.append((fake.name(), fake.email()))

    # for tasks table
    for_tasks_table = []
    for _ in range(TASKS_ROWS):
        for_tasks_table.append(
            (
                fake.sentence(),
                fake.text(),
                randint(1, STATUS_ROWS),
                randint(1, USERS_ROWS),
            )
        )

    return for_status_table, for_users_table, for_tasks_table


def fill_tables(
    for_status_table: list[tuple],
    for_users_table: list[tuple],
    for_tasks_table: list[tuple],
) -> None:
    """Fill in with data tables."""

    with sqlite3.connect(database) as db:
        cur = db.cursor()
        try:
            # fill status table
            cur.executemany("INSERT INTO status (name) VALUES(?)", for_status_table)

            # fill users table
            cur.executemany(
                "INSERT INTO users (fullname,email) VALUES(?,?)", for_users_table
            )

            # fill tasks table
            cur.executemany(
                "INSERT INTO tasks (title,description,status_id,user_id) VALUES(?,?,?,?)",
                for_tasks_table,
            )
            db.commit()
        except sqlite3.Error as e:
            print(e)
        finally:
            db.rollback()
            cur.close()


if __name__ == "__main__":
    for_status, for_users, for_tasks = data_generate()
    fill_tables(for_status, for_users, for_tasks)
