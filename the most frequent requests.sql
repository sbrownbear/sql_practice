-- 1. Выборка нечётных id
SELECT * FROM sample1 
WHERE id % 2 != 0;


-- 2. Выборка уникальных имен
SELECT DISTINCT name1 
FROM users;


-- 3. Средняя зарплата работников
SELECT AVG(salary) 
FROM workers;


-- 4. Способы получения количества записей в таблице
SELECT * FROM table1;

SELECT COUNT(*) 
FROM table1;

SELECT rows1 
FROM sysindexes 
WHERE id = OBJECT_ID(table1) 
AND indid < 2;


-- 5. Получите список сотрудников с зарплатой выше средней
SELECT * FROM workers
WHERE salary > (
    SELECT AVG (salary) 
    FROM workers);


-- 6. Подстановочные знаки. Используются вместе с LIKE. Фильтрует запрашиваемые данные
SELECT * FROM user WHERE name LIKE '%test%'; -- возврат пользователей, которые содержат «test»

SELECT * FROM user WHERE name LIKE 't_est'; -- начинаются на «t», заканчивается на «est»


-- 7. Псевдонимы Aliases. Временное имя таблицы или столбца. Существует на время запроса
SELECT very_long_column_name AS alias_name 
FROM table1;


-- 8. Переименование таблицы. ALTER TABLE можно добавлять, удалять, изменять столбцы, изменять название таблицы. 
ALTER TABLE first_table RENAME second_table;


-- 9. Найти дубли в поле email
SELECT email, COUNT(email) 
FROM customers
GROUP BY email
HAVING COUNT(email) > 1;


-- 10. Даны таблицы workers и departments. Найдите все департаменты без единого сотрудника
SELECT department_name
FROM workers w
RIGHT JOIN departments d 
ON (w.department_id = d.department_id)
WHERE first_name IS NULL;


-- 11. Замените в таблице зарплату работника на 1000, если она равна 900, и на 1500 в ост. случаях
UPDATE table1 SET salary =
CASE
WHEN salary = 900 THEN 1000
ELSE 1500 END;


-- 12. При выборке из таблицы прибавьте к дате 1 день
SELECT DATE_ADD(date1, 1 DAY1) AS new_date 
FROM table1;


-- 13. При выборке из таблицы пользователей создайте поле, которое будет включать в себя и имена, и зарплату
SELECT CONCAT(name1, salary) AS new_field 
FROM users;


-- 14. Self JOIN.Объединение клиентов из одного города.
SELECT A.CustomerName AS CustomerName1, B.CustomerName AS CustomerName2, A.City
FROM Customers A, Customers B
WHERE A.CustomerID <> B.CustomerID
AND A.City = B.City
ORDER BY A.City;


-- 15. INSERT INTO SELECT. Копирует данные из одной таблицы и вставляет их в другую. Типы данных в таблицах должны соответствовать.
INSERT INTO second_table
SELECT * FROM first_table
WHERE condition;
