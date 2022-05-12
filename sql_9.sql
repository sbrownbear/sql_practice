-- 1. Создать таблицу author
CREATE TABLE author( 
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50));

-- 2. Заполнить таблицу author
INSERT INTO author (name_author)
    VALUES('Булгаков М.А.'), ('Достоевский Ф.М.'), ('Есенин С.А.'), ('Пастернак Б.Л.');

-- 3. Перепишите запрос на создание таблицы book, чтобы ее структура соответствовала структуре, показанной на логической схеме (таблица genre уже создана, порядок 
-- следования столбцов - как на логической схеме в таблице book, genre_id - внешний ключ). Для genre_id ограничение о недопустимости пустых значений не задавать.
CREATE TABLE book (
    book_id INT PRIMARY KEY AUTO_INCREMENT, 
    title VARCHAR(50), 
    author_id INT NOT NULL, 
    genre_id INT, 
    price DECIMAL(8,2), 
    amount INT, 
    FOREIGN KEY (author_id) REFERENCES author (author_id),
    FOREIGN KEY (genre_id) REFERENCES genre (genre_id));

-- 4. Создать таблицу book той же структуры, что и на предыдущем шаге. Будем считать, что при удалении автора из таблицы author, должны удаляться все записи о книгах 
-- из таблицы book, написанные этим автором. А при удалении жанра из таблицы genre для соответствующей записи book установить значение Null в столбце genre_id.
DROP TABLE IF EXISTS author;
DROP TABLE IF EXISTS genre;
DROP TABLE IF EXISTS book;

CREATE TABLE author
(
    author_id INT PRIMARY KEY AUTO_INCREMENT,
    name_author VARCHAR(50)
);

CREATE TABLE genre
(
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    name_genre VARCHAR(30)
);

CREATE TABLE book (
      book_id INT PRIMARY KEY AUTO_INCREMENT,
      title VARCHAR(50),
      author_id INT,
      genre_id INT,
      price DECIMAL(8,2),
      amount INT,
      FOREIGN KEY (author_id) REFERENCES author (author_id) ON DELETE CASCADE,
      FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE SET NULL);

