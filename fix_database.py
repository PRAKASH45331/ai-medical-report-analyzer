import os
import sqlite3

# Remove old database
if os.path.exists('database.db'):
    os.remove('database.db')
    print("Old database removed")

# Create fresh database
DATABASE = "database.db"
with sqlite3.connect(DATABASE) as conn:
    conn.execute("""
        CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT UNIQUE,
            password TEXT,
            role TEXT DEFAULT 'user'
        )
    """)
    conn.execute("""
        CREATE TABLE reports (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            summary TEXT,
            created_at TEXT
        )
    """)
    conn.commit()
    print("New database created successfully")
