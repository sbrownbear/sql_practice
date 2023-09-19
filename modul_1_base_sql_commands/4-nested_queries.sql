-- Вывести информацию о самых дешевых книгах, хранящихся на складе
SELECT title, author, price, amount
FROM book
WHERE price = (
        SELECT MIN(price) 
        FROM book
        );
-- Результат:
-- title | author           | price  | amount 
-- Идиот | Достоевский Ф.М. | 460.00 | 10

--4.2. Выбрать информацию (автора, название и цену) о книгах, 
-- цены которых меньше или равны средней цене книг на складе.
SELECT author, title, price
FROM book
WHERE price <= (SELECT
            AVG(price)
            FROM book)
ORDER BY price DESC;

-- 4.3. Вывести информацию о книгах, цены которых превышают 
-- минимальную цену книги на складе не более чем на 150 рублей
-- Отсортировать по возрастанию цены.
SELECT author, title, price
FROM book
WHERE price - 150 <= (
        SELECT MIN(price)
        FROM book)
ORDER BY price;

-- Вывести информацию о книгах тех авторов, общее 
-- количество экземпляров книг которых не менее 12.
SELECT title, author, amount, price
FROM book
WHERE author IN (
        SELECT author
        FROM book
        GROUP BY author
        HAVING SUM(amount) >= 12
        );

--4.4. Вывести информацию (автора, книгу и количество) о тех книгах, 
-- количество экземпляров которых в таблице book не дублируется
SELECT author, title, amount
FROM book
WHERE amount IN (
        SELECT amount
        FROM book
        GROUP BY amount
        HAVING COUNT(amount) = 1
        );

-- 4.5. Вывести информацию о книгах, цена которых меньше самой 
-- большой из минимальных цен, вычисленных для каждого автора.
SELECT author, title, price
FROM book
WHERE price < ANY (
        SELECT MIN(price)
        FROM book
        GROUP BY author
        );

-- 4.5а. Вывести информацию о тех книгах, количество которых меньше 
-- самого маленького среднего количества книг каждого автора.
SELECT title, author, amount, price
FROM book
WHERE amount < ALL (
        SELECT AVG(amount) 
        FROM book 
        GROUP BY author 
        );

-- 4.5б. Вывести информацию о тех книгах, количество которых меньше 
-- самого большого среднего количества книг каждого автора.
SELECT title, author, amount, price
FROM book
WHERE amount < ANY (
        SELECT AVG(amount) 
        FROM book 
        GROUP BY author 
        );

--4.6. Задание stepik.org/lesson/297514/step/6?unit=279274
SELECT title, author, amount, (
            SELECT MAX(amount) 
            FROM book) - amount AS Заказ
FROM book
HAVING Заказ > 0;