import logging
from psycopg2 import DatabaseError
from connection import get_db_connection


def create_table(conn, sql_expression):
    c = conn.cursor()
    try:
        c.execute(sql_expression)
        conn.commit()
    except DatabaseError as err:
        logging.error(err)
        conn.rollback()
    finally:
        c.close()

def get_sql_sript(script):
    try:
        with open(script, 'r') as f:
            return f.read()
    except Exception as err:
        print(err)


if __name__ == '__main__':
    sql = get_sql_sript('create_table.sql')
    try:
        with get_db_connection() as conn:
            if conn is not None:
                create_table(conn, sql)
            else:
                logging.error('Error: can\'t create the database connection')
    except RuntimeError as err:
        logging.error(err)
