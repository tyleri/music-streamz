import os
import json
import sqlite3

# From: https://goo.gl/YzypOI
def singleton(cls):
  instances = {}
  def getinstance():
    if cls not in instances:
      instances[cls] = cls()
    return instances[cls]
  return getinstance

class DB(object):

  def __init__(self):
    self.conn = sqlite3.connect("music_streamz.db", check_same_thread=False)
    self.create_searches_table()

  def create_searches_table(self):
    try:
      self.conn.execute("""
        CREATE TABLE searches (
            q TEXT PRIMARY KEY NOT NULL,
            type TEXT NOT NULL,
            page INT NOT NULL,
            json TEXT NOT NULL
        );
      """)
    except Exception as e: print e


  # def delete_task_table(self):
  #   # TODO - Implement this to delete a task table
  #   pass

  def query_searches_table(self, q, type, page):
    cursor = self.conn.execute(
        """
          SELECT json FROM searches
          WHERE q = ? AND type = ? AND page = ?;
        """,
        (q, type, page)
    )

    return [row[0] for row in cursor]
    # for row in cursor:
    #   print "ID = ", row[0]
    #   print "NAME = ", row[1]
    #   print "ADDRESS = ", row[2], "\n"

  def insert_searches_table(self, q, type, page, json):
    """
    Demonstrates how to perform an insert operation.
    """
    self.conn.execute(
      """
        INSERT INTO searches (q, type, page, json)
        VALUES (?, ?, ?, ?);
      """,
      (q, type, page, json)
    )
    self.conn.commit()


  def example_create_table(self):
    """
    Demonstrates how to make a table. Silently error-handles
    (try-except) because the table might already exist.
    """
    try:
      self.conn.execute("""
        CREATE TABLE example
        (ID INT PRIMARY KEY NOT NULL,
        NAME TEXT NOT NULL,
        ADDRESS CHAR(50) NOT NULL);
      """)
    except Exception as e: print e

  def example_query(self):
    """
    Demonstrates how to execute a query.
    """
    cursor = self.conn.execute("""
      SELECT * FROM example;
    """)

    for row in cursor:
      print "ID = ", row[0]
      print "NAME = ", row[1]
      print "ADDRESS = ", row[2], "\n"

  def example_insert(self):
    """
    Demonstrates how to perform an insert operation.
    """
    self.conn.execute("""
      INSERT INTO example (ID,NAME,ADDRESS)
      VALUES (1, "Joe", "Ithaca, NY");
    """)
    self.conn.commit()


# Only <=1 instance of the DB driver
# exists within the app at all times
DB = singleton(DB)
