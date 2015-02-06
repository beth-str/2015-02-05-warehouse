require 'sqlite3'
DATABASE = SQLite3::Database.new("warehouse.db")


DATABASE.execute("CREATE TABLE IF NOT EXISTS products (
                 id INTEGER PRIMARY KEY,
                 isbn INTEGER NOT NULL,
                 title TEXT UNIQUE,
                 author TEXT,
                 description TEXT NOT NULL,
                 cost INTEGER,
                 price INTEGER NOT NULL,
                 quantity INTEGER CHECK(quantity >= 0),
                 FOREIGN KEY (category_id) REFERENCES category(id),
                 FOREIGN KEY (location_id) REFERENCES location(id)")

DATABASE.execute("CREATE TABLE IF NOT EXISTS categories (
               id INTEGER PRIMARY KEY,
               genre TEXT NOT NULL")

DATABASE.execute("CREATE TABLE IF NOT EXISTS locations (
                id INTEGER PRIMARY KEY,
                city TEXT UNIQUE NOT NULL")


DATABASE.results_as_hash = true