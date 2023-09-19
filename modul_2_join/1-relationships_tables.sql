--1.1. Создать таблицу author с полями author_id, name_author
CREATE TABLE author (
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
    );

--1.2. Добавить авторов в существующую таблицу
INSERT INTO author (name_author)
VALUE ("Булгаков М.А."), 
    ("Достоевский Ф.М."), 
    ("Есенин С.А."), 
    ("Пастернак Б.Л.");

--1.3. Задание stepik.org/lesson/308885/step/8?thread=solutions&unit=291011
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT, 
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (genre_id)  REFERENCES genre (genre_id) 
    );

--1.4. Действия при удалении записи главной таблицы.
CREATE TABLE book( 
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50),
    author_id INT,
    genre_id INT,
    price DECIMAL(8,2),
    amount INT,
    FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
    FOREIGN KEY (genre_id)  REFERENCES genre (genre_id)   ON DELETE SET NULL
    ); 
