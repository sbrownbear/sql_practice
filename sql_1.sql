-- 1. Сформулируйте SQL запрос для создания таблицы book, занесите его в окно кода
CREATE TABLE book(
    book_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(50),
    author VARCHAR(30),
    price DECIMAL(8, 2),
    amount INT
);
-- 2. Занесите новую строку в таблицу book
INSERT INTO book(book_id, title, author, price, amount)
    VALUES('1', 'Мастер и Маргарита', 'Булгаков М.А.', '670.99', '3');

-- 3. Занесите три последние записи в таблицу book
INSERT INTO book(book_id, title, author, price, amount) 
    VALUES ('2', 'Белая гвардия', 'Булгаков М.А.', '540.50', '5');
INSERT INTO book(book_id, title, author, price, amount) 
    VALUES ('3', 'Идиот', 'Достоевский Ф.М.', '460.00', '10');
INSERT INTO book(book_id, title, author, price, amount) 
    VALUES ('4', 'Братья Карамазовы', 'Достоевский Ф.М.', '799.01', '2');
