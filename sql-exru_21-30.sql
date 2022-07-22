-- 21. Найдите максимальную цену ПК, выпускаемых каждым производителем, у которого есть модели в таблице PC.
-- Вывести: maker, максимальная цена.
SELECT maker, MAX(price) FROM product JOIN pc ON product.model = pc.model
GROUP BY maker;

-- 22. Для каждого значения скорости ПК, превышающего 600 МГц, определите среднюю цену ПК с такой же 
-- скоростью. Вывести: speed, средняя цена.
SELECT speed, AVG(price) FROM pc WHERE speed > 600 GROUP BY speed;

-- 23. Найдите производителей, которые производили бы как ПК со скоростью не менее 750 МГц, так и 
-- ПК-блокноты со скоростью не менее 750 МГц. Вывести: Maker
SELECT maker FROM pc JOIN product ON pc.model = product.model WHERE speed >= 750 
AND maker IN (SELECT maker FROM laptop JOIN product ON laptop.model = product.model WHERE speed >= 750)
GROUP BY maker;

-- 24. Перечислите номера моделей любых типов, имеющих самую высокую цену по всей имеющейся в базе 
-- данных продукции.
with this_table as 
(
SELECT pc.model, price FROM pc join product on pc.model = pc.model
UNION
SELECT laptop.model, price FROM laptop join product on product.model = laptop.model
UNION
SELECT model, price FROM printer
)


SELECT model FROM (
SELECT * FROM this_table
) this_table_1 WHERE price = (
SELECT max(price) FROM this_table
);

-- 25. Найдите производителей принтеров, которые производят ПК с наименьшим объемом RAM и с самым 
-- быстрым процессором среди всех ПК, имеющих наименьший объем RAM. Вывести: Maker
SELECT DISTINCT maker FROM Product WHERE type = 'printer' AND maker IN (
SELECT maker FROM Product JOIN Pc ON Product.model = Pc.model WHERE
ram = (SELECT MIN(ram) FROM Pc) AND speed = (SELECT MAX(speed) FROM Pc WHERE ram = ( SELECT MIN(ram) FROM Pc)));

-- 26. Найдите среднюю цену ПК и ПК-блокнотов, выпущенных производителем A (латинская буква). Вывести: одна 
-- общая средняя цена.
SELECT avg(price) FROM(
SELECT price FROM pc WHERE model IN
(SELECT model FROM product WHERE maker='a' AND
TYPE='pc')
UNION ALL
SELECT price FROM laptop WHERE model IN
(SELECT model FROM product WHERE maker='a' AND
TYPE='laptop')
)AS prod;

-- 27. Найдите средний размер диска ПК каждого из тех производителей, которые выпускают и принтеры. 
-- Вывести: maker, средний размер HD.
SELECT maker, AVG(hd) avg_hd FROM pc JOIN product ON product.model = pc.model
WHERE maker IN(
SELECT DISTINCT maker FROM product WHERE TYPE = 'printer'
) GROUP BY maker;

-- 28. Используя таблицу Product, определить количество производителей, выпускающих по одной модели.
SELECT COUNT(maker) qty FROM (
SELECT maker FROM product GROUP BY maker HAVING COUNT(*) = 1
) this_table;

-- 29. В предположении, что приход и расход денег на каждом пункте приема фиксируется не чаще одного раза в 
-- день [т.е. первичный ключ (пункт, дата)], написать запрос с выходными данными (пункт, дата, приход, 
-- расход). Использовать таблицы Income_o и Outcome_o.
SELECT income_o.point, income_o.[date], inc, out FROM income_o LEFT JOIN outcome_o ON outcome_o.point = income_o.point AND outcome_o.[date] = income_o.[date]
UNION
SELECT outcome_o.point, outcome_o.[date], inc, out FROM income_o RIGHT JOIN outcome_o ON outcome_o.point = income_o.point AND outcome_o.[date] = income_o.[date];

-- 30. В предположении, что приход и расход денег на каждом пункте приема фиксируется произвольное число 
-- раз (первичным ключом в таблицах является столбец code), требуется получить таблицу, в которой каждому 
-- пункту за каждую дату выполнения операций будет соответствовать одна строка. Вывод: point, date, суммарный 
-- расход пункта за день (out), суммарный приход пункта за день (inc). Отсутствующие значения считать неопределенными (NULL).
SELECT point, [date], SUM(outs), SUM(incs) FROM(
SELECT point, [date], SUM(out) outs, null incs FROM outcome GROUP BY point, [date]
UNION
SELECT point, [date], null, SUM(inc) FROM income GROUP BY point, [date]
) this_table GROUP BY point, [date];

