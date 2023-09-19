--3.2. Выбрать уникальные элементы столбца amount таблицы book
SELECT DISTINCT amount
FROM book;

-- Вариант второй
SELECT amount
FROM book
GROUP BY amount;

--3.3. Посчитать, количество различных книг и количество экземпляров книг каждого автора.
SELECT author AS Автор, 
COUNT(author) AS Различных_книг, 
SUM(amount) AS Количество_экземпляров
FROM book
GROUP BY author;

--3.3а. Посчитать, сколько экземпляров книг каждого автора хранится на складе.
SELECT author, SUM(amount)
FROM book
GROUP BY author;

--3.4. Выбрать автора и посчитать минимальную, максимальную и среднюю цену книг каждого автора.
SELECT author, MIN(price) AS Минимальная_цена, 
            MAX(price) AS Максимальная_цена, 
            AVG(price) AS Средняя_цена
FROM book
GROUP BY author;

--3.5. Вычислить суммарную стоимость книг, вычислить налог 
-- на добавленную стоимость 18% и стоимость книг без.
SELECT author, SUM(price * amount) AS Стоимость, 
        ROUND(SUM(price * amount) * 0.18/ (1+0.18), 2) AS НДС, 
        ROUND(SUM(price * amount)/ (1+0.18), 2) AS Стоимость_без_НДС
FROM book
GROUP BY author;

--3.6. Вывести цену самой дешевой книги, дорогой книги и среднюю цену уникальных книг на складе.
SELECT MIN(price) AS Минимальная_цена,
        MAX(price) AS Максимальная_цена,
        ROUND(AVG(price), 2) AS Средняя_цена
FROM book;

--3.7. Вывести среднюю цену и суммарную стоимость тех книг, количество 
-- экземпляров которых принадлежит интервалу от 5 до 14, включительно
SELECT ROUND(AVG(price), 2) AS Средняя_цена,
        ROUND(SUM(price*amount), 2) AS Стоимость
FROM book
WHERE amount BETWEEN 5 AND 14;

--3.8. Вывести стоимость всех экземпляров каждого автора без учета книг «Идиот» и 
-- «Белая гвардия» и суммарная стоимость книг более 5000 руб
SELECT author, SUM(price*amount) AS Стоимость
FROM book
WHERE title <> "Белая гвардия" AND title <> "Идиот"
GROUP BY author
HAVING SUM(price*amount) > 5000
ORDER BY SUM(price*amount) DESC;

--3.8а. максимальную и минимальную цену книг каждого автора, кроме 
-- Есенина, количество экземпляров книг которого больше 10.
-- Вариант первый (предпочтительнее)
SELECT author,
    MIN(price) AS Минимальная_цена,
    MAX(price) AS Максимальная_цена
FROM book
WHERE author <> 'Есенин С.А.'
GROUP BY author
HAVING SUM(amount) > 10;

-- Вариант второй (не рекомендуется)
SELECT author,
    MIN(price) AS Минимальная_цена,
    MAX(price) AS Максимальная_цена
FROM book
GROUP BY author
HAVING SUM(amount) > 10 AND author <> 'Есенин С.А.';