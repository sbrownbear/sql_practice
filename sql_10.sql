-- 1. Вывести название, жанр и цену тех книг, количество которых больше 8, в отсортированном по убыванию цены виде.
SELECT title, name_genre, price
FROM book JOIN genre ON genre.genre_id = book.genre_id
WHERE amount > 8
ORDER BY price DESC;

-- 2. Вывести все жанры, которые не представлены в книгах на складе.
SELECT name_genre FROM genre LEFT JOIN book
ON genre.genre_id = book.genre_id
WHERE title is NULL;

-- 3. Необходимо в каждом городе провести выставку книг каждого автора в течение 2020 года. Дату проведения выставки выбрать 
-- случайным образом. Создать запрос, который выведет город, автора и дату проведения выставки. Последний столбец назвать Дата. 
-- Информацию вывести, отсортировав сначала в алфавитном порядке по названиям городов, а потом по убыванию дат проведения выставок.
SELECT name_city, name_author, DATE_ADD('2020-01-01',INTERVAL FLOOR(RAND() * 365) DAY) AS Дата
FROM author
CROSS JOIN city
ORDER BY name_city, Дата DESC;

-- 4. Вывести информацию о книгах (жанр, книга, автор), относящихся к жанру, включающему слово «роман» в отсортированном по названиям книг виде.
SELECT name_genre, title, name_author
FROM (SELECT * FROM genre 
WHERE name_genre = 'Роман') AS genre
JOIN book USING(genre_id)
JOIN author USING(author_id)
ORDER BY title ASC;

-- 5. Посчитать количество экземпляров книг каждого автора из таблицы author. Вывести тех авторов, количество книг которых меньше 10, 
-- в отсортированном по возрастанию количества виде. Последний столбец назвать Количество.
SELECT name_author, SUM(amount) AS Количество
FROM author
LEFT JOIN book ON author.author_id=book.author_id
GROUP BY name_author
HAVING SUM(amount) < 10 OR Количество is Null
ORDER BY Количество

-- 6. Вывести в алфавитном порядке всех авторов, которые пишут только в одном жанре. Поскольку у нас в таблицах так занесены данные, 
-- что у каждого автора книги только в одном жанре, для этого запроса внесем изменения в таблицу book. Пусть у нас  книга Есенина «Черный 
-- человек» относится к жанру «Роман», а книга Булгакова «Белая гвардия» к «Приключениям» (эти изменения в таблицы уже внесены).
SELECT name_author 
FROM author
LEFT JOIN book
ON author.author_id = book.author_id
GROUP BY author.author_id
HAVING MIN(genre_id) = MAX(genre_id)
ORDER BY name_author;

-- 7. Вывести информацию о книгах (название книги, фамилию и инициалы автора, название жанра, цену и количество экземпляров книги), 
-- написанных в самых популярных жанрах, в отсортированном в алфавитном порядке по названию книг виде. Самым популярным считать жанр, 
-- общее количество экземпляров книг которого на складе максимально.
SELECT title, name_author, name_genre, price, amount
FROM author
INNER JOIN book 
ON author.author_id = book.author_id
INNER JOIN genre 
ON book.genre_id = genre.genre_id
WHERE book.genre_id IN 
    (SELECT genre_id
     FROM book
     GROUP BY genre_id
     HAVING SUM(amount) >= ALL(SELECT SUM(amount) FROM book GROUP BY genre_id))
ORDER BY title;

-- 8. Если в таблицах supply и book есть одинаковые книги, которые имеют равную цену, вывести их название и автора, а также посчитать 
-- общее количество экземпляров книг в таблицах supply и book, столбцы назвать Название, Автор и Количество.
SELECT book.title AS Название, name_author AS Автор, book.amount + supply.amount AS Количество
FROM book
JOIN author USING(author_id)
JOIN supply USING(title)
WHERE supply.price = book.price