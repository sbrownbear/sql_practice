--5.2. Создать таблицу supply с полями supply_id, title, author, price, amount
CREATE TABLE supply (
    supply_id INT PRIMARY KEY AUTO_INCREMENT
    title VARCHAR(50)
    author VARCHAR(30)
    price DECIMAL(8, 2)
    amount INT
)

--5.3. Занесите в таблицу supply четыре записи
INSERT INTO supply(supply_id, title, author, price, amount)
VALUES ('1', 'Лирика', 'Пастернак Б.Л.', '518.99', '2'),
        ('2', 'Черный человек', 'Есенин С.А.', '570.20', '6'),
        ('3', 'Белая гвардия', 'Булгаков М.А.', '540.50', '7'),
        ('4', 'Идиот', 'Достоевский Ф.М.', '360.80', '3')

--5.4. Добавить из таблицы supply в таблицу book, все книги, 
-- кроме книг, написанных Булгаковым М.А. и Достоевским Ф.М.
INSERT INTO book(title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author <> "Булгаков М.А." AND author <> "Достоевский Ф.М.";

--5.5. Занести из таблицы supply в таблицу book только 
-- те книги, авторов которых нет в  book.
INSERT INTO book (title, author, price, amount)
SELECT title, author, price, amount
FROM supply
WHERE author NOT IN (
    SELECT author
    FROM book
    );

--5.6. Уменьшить на 10% цену тех книг в таблице book, количество 
-- которых принадлежит интервалу от 5 до 10, включая границы.
UPDATE book
SET price = price*0.9
WHERE amount BETWEEN 5 AND 10;

--5.7. В таблице book необходимо скорректировать значение для покупателя 
-- в столбце buy таким образом, чтобы оно не превышало количество 
-- экземпляров книг, указанных в столбце amount. А цену тех книг, 
-- которые покупатель не заказывал, снизить на 10%.
UPDATE book
SET buy = IF(buy > amount, amount, buy);
UPDATE book
SET price = IF(buy = 0, price * 0.9, price);

--5.8. Задание stepik.org/lesson/305012/step/8?unit=287020
UPDATE book, supply
SET book.amount = book.amount + supply.amount, book.price = (book.price + supply.price)/2
WHERE book.title = supply.title AND book.author = supply.author;

--5.9. Удалить из таблицы supply книги тех авторов, общее количество 
-- экземпляров книг которых в таблице book превышает 10.
DELETE FROM supply
WHERE author IN (
    SELECT author
    FROM book
    GROUP BY author
    HAVING SUM(amount) >= 10
    );

--5.10. Задание stepik.org/lesson/305012/step/10?unit=287020
CREATE TABLE ordering AS
SELECT author, title, (
    SELECT ROUND(AVG(amount))
    FROM book) AS amount
FROM book
WHERE amount < (SELECT ROUND(AVG(amount))
FROM book);