-- 1. Для книг, которые уже есть на складе (в таблице book), но по другой цене, чем в поставке (supply), необходимо в таблице book 
-- увеличить количество на значение, указанное в поставке, и пересчитать цену. А в таблице supply обнулить количество этих книг.
UPDATE book b JOIN author a 
ON a.author_id=b.author_id JOIN supply s 
ON b.title=s.title AND a.name_author=s.author AND b.price<>s.price
SET b.amount=b.amount+s.amount,
s.amount=0,
b.price=(b.amount*b.price+s.amount*s.price)/(b.amount+s.amount);

-- 2. Включить новых авторов в таблицу author с помощью запроса на добавление, а затем вывести все данные из таблицы author.  
-- Новыми считаются авторы, которые есть в таблице supply, но нет в таблице author.
INSERT INTO author (name_author)
SELECT author
FROM supply
WHERE author NOT IN (SELECT name_author FROM author);

-- 3. Добавить новые книги из таблицы supply в таблицу book на основе сформированного выше запроса. Затем вывести для просмотра таблицу book.
INSERT INTO book(title, author_id, price, amount)
SELECT title, author_id, price, amount
FROM author JOIN supply
ON author.name_author = supply.author
WHERE amount <> 0;

-- 4. Занести для книги «Стихотворения и поэмы» Лермонтова жанр «Поэзия», а для книги «Остров сокровищ» Стивенсона - «Приключения». (Использовать два запроса).
UPDATE book SET genre_id = (SELECT genre_id 
    FROM genre WHERE name_genre = 'Поэзия')
    WHERE genre_id is null and book_id=10;

UPDATE book SET genre_id = (SELECT genre_id 
    FROM genre 
    WHERE name_genre = 'Приключения')
    WHERE genre_id is null and book_id=11;

-- 5. Удалить всех авторов и все их книги, общее количество книг которых меньше 20.
DELETE FROM author
WHERE author_id IN (SELECT author_id FROM book
    GROUP BY author_id
    HAVING sum(amount) < 20);

-- 6. Удалить все жанры, к которым относится меньше 4-х книг. В таблице book для этих жанров установить значение Null.
DELETE FROM genre
WHERE genre_id IN (SELECT genre_id FROM book
    GROUP BY genre_id
    HAVING count(genre_id)<3);

-- 7. Удалить всех авторов, которые пишут в жанре "Поэзия". Из таблицы book удалить все книги этих авторов. 
-- В запросе для отбора авторов использовать полное название жанра, а не его id.
DELETE FROM author 
USING author 
    JOIN book USING(author_id)
    JOIN genre USING(genre_id)
    WHERE name_genre='Поэзия';