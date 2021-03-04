-- clonedb
CREATE DATABASE lab14_normal WITH TEMPLATE lab14;
--create authors table
CREATE TABLE authors (id SERIAL PRIMARY KEY, name VARCHAR(255));
--copy authors into table
INSERT INTO authors(name) SELECT DISTINCT author FROM books;
--add author id column
ALTER TABLE books ADD COLUMN author_id INT;
-- set author key values based on curent name.
UPDATE books SET author_id=author.id FROM (SELECT * FROM authors) AS author WHERE books.author = author.name;
-- remove old author name column
ALTER TABLE books DROP COLUMN author;
--add foreign key constraint
ALTER TABLE books ADD CONSTRAINT fk_authors FOREIGN KEY (author_id) REFERENCES authors(id);
