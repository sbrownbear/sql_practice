-- 1. Вывести все заказы Баранова Павла (id заказа, какие книги, по какой цене и в каком количестве он заказал) в отсортированном по номеру заказа и 
-- названиям книг виде
SELECT buy_id, title, price, buy_book.amount
FROM buy
JOIN client USING(client_id)
JOIN buy_book USING(buy_id)
JOIN book USING(book_id)
WHERE client.name_client='Баранов Павел'
ORDER BY buy_id, title;

-- 2. Посчитать, сколько раз была заказана каждая книга, для книги вывести ее автора (нужно посчитать, в каком количестве заказов фигурирует каждая книга). Вывести 
-- фамилию и инициалы автора, название книги, последний столбец назвать Количество. Результат отсортировать сначала по фамилиям авторов, а потом по названиям книг
SELECT name_author, title, COUNT(buy_id) AS Количество
FROM book LEFT JOIN buy_book USING(book_id)
JOIN author USING(author_id)
GROUP BY book_id   
ORDER BY name_author, title

-- 3. Вывести города, в которых живут клиенты, оформлявшие заказы в интернет-магазине. Указать количество заказов в каждый город, этот столбец 
-- назвать Количество. Информацию вывести по убыванию количества заказов, а затем в алфавитном порядке по названию городов
SELECT name_city, count(*) AS Количество 
FROM buy 
JOIN client
ON client.client_id=buy.client_id 
JOIN city
ON city.city_id=client.city_id
GROUP BY name_city;

-- 4. Вывести номера всех оплаченных заказов и даты, когда они были оплачены
SELECT buy_id, date_step_end FROM buy_step
WHERE step_id=1 AND date_step_end IS NOT NULL;

-- 5. Вывести информацию о каждом заказе: его номер, кто его сформировал (фамилия пользователя) и его стоимость (сумма произведений 
-- количества заказанных книг и их цены), в отсортированном по номеру заказа виде. Последний столбец назвать Стоимость
SELECT buy_id, name_client, SUM(buy_book.amount * book.price) AS Стоимость
FROM buy
    JOIN client USING(client_id)
    JOIN buy_book USING(buy_id)
    JOIN book USING(book_id)
GROUP BY buy_id
ORDER BY buy_id;