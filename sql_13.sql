-- 1. В таблице city для каждого города указано количество дней, за которые заказ может быть доставлен в этот 
-- город (рассматривается только этап Транспортировка). Для тех заказов, которые прошли этап транспортировки, вывести 
-- количество дней за которое заказ реально доставлен в город. А также, если заказ доставлен с опозданием, указать 
-- количество дней задержки, в противном случае вывести 0. В результат включить номер заказа (buy_id), а также 
-- вычисляемые столбцы Количество_дней и Опоздание. Информацию вывести в отсортированном по номеру заказа виде
SELECT buy_id, delta AS Количество_дней, 
IF(delta - days_delivery > 0, delta - days_delivery, 0) AS Опоздание 
FROM city
JOIN client USING(city_id)
JOIN buy USING(client_id)
JOIN (SELECT buy_id, DATEDIFF(date_step_end, date_step_beg) delta 
FROM buy_step JOIN step USING(step_id)
WHERE name_step = 'Транспортировка' AND date_step_end) temp USING(buy_id)
ORDER BY buy_id;

-- 2. Выбрать всех клиентов, которые заказывали книги Достоевского, информацию вывести в отсортированном по алфавиту виде. 
-- В решении используйте фамилию автора, а не его id
SELECT DISTINCT name_client FROM author
JOIN book ON (author.author_id=book.author_id) AND (author.name_author="Достоевский Ф.М.")
JOIN buy_book USING(book_id)
JOIN buy USING(buy_id)
JOIN client USING(client_id)
ORDER BY name_client;

-- 3. Вывести жанр (или жанры), в котором было заказано больше всего экземпляров книг, указать это количество. 
-- Последний столбец назвать Количество.
SELECT name_genre, SUM(bb.amount) AS Количество 
FROM book 
JOIN genre USING (genre_id)
JOIN buy_book bb USING (book_id)
GROUP BY name_genre
HAVING Количество >= ALL 
    (SELECT SUM(bb.amount) AS sum_amount
     FROM book JOIN buy_book bb USING (book_id)
     GROUP BY genre_id);

-- 4. Сравнить ежемесячную выручку от продажи книг за текущий и предыдущий годы. Для этого вывести год, месяц, сумму выручки 
-- в отсортированном сначала по возрастанию месяцев, затем по возрастанию лет виде. Название столбцов: Год, Месяц, Сумма
SELECT YEAR(buy_step.date_step_end) AS Год, MONTHNAME(buy_step.date_step_end) AS Месяц, SUM(book.price*buy_book.amount) AS Сумма
FROM buy_step JOIN buy_book USING (buy_id)
JOIN book USING (book_id)
WHERE step_id = 1 AND date_step_end IS NOT NULL
GROUP BY 1, 2
UNION ALL
SELECT YEAR(date_payment), MONTHNAME(date_payment), SUM(price*amount)
FROM buy_archive
GROUP BY 1, 2
ORDER BY 2, 1;

-- 5. Для каждой отдельной книги необходимо вывести информацию о количестве проданных экземпляров и их стоимости за текущий 
-- и предыдущий год. Вычисляемые столбцы назвать Количество и Сумма. Информацию отсортировать по убыванию стоимости.
SELECT title, SUM(kol) AS Количество, SUM(summ) AS Сумма 
FROM book JOIN (SELECT book_id, SUM(amount) AS kol, SUM(amount * price) AS summ 
FROM buy_archive 
GROUP BY book_id 
UNION SELECT book_id, SUM(buy_book.amount), SUM(buy_book.amount * book.price) 
FROM buy_book 
JOIN book USING(book_id) 
JOIN buy_step USING(buy_id) 
WHERE step_id = 1 AND date_step_end IS NOT Null 
GROUP BY book_id) query_1 USING(book_id) 
GROUP BY title 
ORDER BY Сумма DESC;