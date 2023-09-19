--2.2. Выбрать все записи таблицы book
SELECT * FROM book;

--2.3. Выбрать авторов, название книг и цену из таблицы book
SELECT author, title, price 
FROM book;

--2.4. Выбрать авторов, название книг и цену из таблицы book
SELECT title AS Название, author AS Автор 
FROM book;

--2.4. Выбрать название книг, количество и стоимость упаковки (pack). 
-- Лист бумаги - 1 рубль, 65 копеек
SELECT title, amount, anount*1.65 AS pack 
FROM book;

--2.5. Выбрать название книг, автора, кол-во, и новую цену со скидкой 30% (new_price)
SELECT title, author, amount, ROUND(price*0.7, 2) AS new_price 
FROM book;

--2.6. Выбрать автора, название и новую цену.
-- Если булгаков, то поднять цену на 10%, Есенин - 5%
SELECT author, title,
ROUND(IF(author="Булгаков М.А.", price*1.1, 
        IF(author="Есенин С.А.", price*1.05, price)), 2)
        AS new_price
FROM book;

--2.7. Выбрать автора, название и 
-- цены тех книг, количество которых меньше 10
SELECT author, title, price
FROM book
WHERE amount < 10;

--2.8. Выбрать название, автора, цену и кол-во книг, 
-- цена которых меньше 500 или больше 600, а стоимость всех 
-- экземпляров книг больше или равна 5000
SELECT title, author, price, amount
FROM book
WHERE (price < 500 OR price > 600) 
        AND price * amount >=5000;

--2.9. Выбрать название и авторов с интервалом от 540.50 до 
--800 (включительно), а количество или 2, или 3, или 5, или 7 
SELECT title, author 
FROM book
WHERE price BETWEEN 540.50 AND 800 AND amount IN (2, 3, 5, 7);

--2.10. Выбрать автора и название книг с кол-вом 2-14 (включительно).
-- Сортировать по авторам (в обратном алф. порядке) и по названию (по алфовиту).
SELECT author, title 
FROM book
WHERE amount BETWEEN 2 AND 14
ORDER BY author DESC, title;
--ORDER BY 1 DESC, 2;

--2.11. Выбрать название и автора тех книг состоящих из двух и более слов,
-- инициалы автора содержат букву «С». Отсортировать по названию книги.
SELECT title, author 
FROM book
WHERE  author LIKE "%С.%" 
    AND title LIKE '%_ %'
ORDER BY title;

--2.11а. Выбрать названия книг, начинающихся с буквы «Б».
SELECT title FROM book
WHERE title LIKE 'Б%';

--2.11б. Выбрать название книг, состоящих ровно из 5 букв.
SELECT title FROM book 
WHERE title LIKE "_____"

--2.11в. Выбрать книги, название которых длиннее 5 символов.
SELECT title FROM book 
WHERE title LIKE "______%";
-- title LIKE "%______"
-- title LIKE "%______%"

--2.11г. Выбрать названия книг, которые содержат букву "и" как отдельное слово.
SELECT title FROM book 
WHERE   title LIKE "_% и _%" -- отбирает слово И внутри названия
    OR title LIKE "и _%" -- отбирает слово И в начале названия
    OR title LIKE "_% и" -- отбирает слово И в конце названия
    OR title LIKE "и" -- отбирает название, состоящее из одного слова И


--2.11д. Выбрать названия книг, которые состоят ровно из одного слова.
SELECT title FROM book 
WHERE title NOT LIKE "% %";