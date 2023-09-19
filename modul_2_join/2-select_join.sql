--2.2. Вывести название, жанр и цену тех книг, кол-во которых больше 8, отсортировать по убыванию цены.
SELECT title, name_genre, price
FROM genre INNER JOIN book 
ON genre.genre_id = book.genre_id
WHERE amount > 8
ORDER BY price DESC;

--2.3. Вывести все жанры, которые не представлены в книгах на складе.
SELECT name_genre
FROM genre LEFT JOIN book
ON genre.genre_id = book.genre_id
WHERE book.title is NULL;

--2.4. Задание stepik.org/lesson/308886/step/4?unit=291012
SELECT name_city, name_author, 
DATE_ADD('2020-01-01',INTERVAL FLOOR(RAND() * 365) DAY) AS Дата
FROM author CROSS JOIN city
ORDER BY name_city, Дата DESC;

--2.5. Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, 
-- включающему слово «роман» в отсортированном по названиям книг виде.
SELECT name_genre, title, name_author
FROM book INNER JOIN author ON book.author_id = author.author_id
          INNER JOIN genre  ON book.genre_id = genre.genre_id
WHERE genre.name_genre = "Роман"
ORDER BY title;

--2.6. Посчитать количество экземпляров  книг каждого автора из таблицы author. Вывести тех авторов, 
-- количество книг которых меньше 10, в отсортированном по возрастанию количества виде.
SELECT name_author, SUM(amount) AS Количество
FROM author LEFT JOIN book 
ON author.author_id = book.author_id
GROUP BY name_author
HAVING SUM(amount) < 10 OR Количество is Null
ORDER BY Количество;

--2.7. Задание stepik.org/lesson/308886/step/7?unit=291012
SELECT name_author 
FROM book INNER JOIN author
ON author.author_id = book.author_id
GROUP BY name_author
HAVING COUNT(DISTINCT genre_id) = 1;

--2.8. Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, 
-- цену и количество экземпляров книги), написанных в самых популярных жанрах, в 
-- отсортированном в алфавитном порядке по названию книг виде. Самым популярным считать 
-- жанр, общее количество экземпляров книг которого на складе максимально.
SELECT title, name_author, name_genre, price, amount
FROM author INNER JOIN book ON author.author_id = book.author_id
INNER JOIN genre ON book.genre_id = genre.genre_id
WHERE book.genre_id IN 
    (SELECT genre_id
     FROM book
     GROUP BY genre_id
     HAVING SUM(amount) >= ALL(SELECT SUM(amount) FROM book GROUP BY genre_id)
     )
ORDER BY title;

--2.9. Если в таблицах supply и book есть одинаковые книги, которые имеют равную цену, 
-- вывести их название и автора, а также посчитать общее количество экземпляров книг 
-- в таблицах supply и book, столбцы назвать Название, Автор и Количество.
SELECT book.title AS Название, name_author AS Автор, book.amount + supply.amount AS Количество
FROM book
INNER JOIN author USING(author_id)
INNER JOIN supply USING(title)
WHERE supply.price = book.price;

