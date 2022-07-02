-- 1. Найдите номер модели, скорость и размер жесткого диска для всех ПК стоимостью менее 500 дол. Вывести: model, speed и hd
SELECT model, speed, hd FROM PC WHERE price < 500;

-- 2. Найдите производителей принтеров. Вывести: maker
SELECT maker FROM product WHERE type = 'printer' GROUP BY maker;

-- 3. Найдите номер модели, объем памяти и размеры экранов ПК-блокнотов, цена которых превышает 1000 дол.
SELECT model, ram, screen FROM Laptop WHERE price > 1000;

-- 4. Найдите все записи таблицы Printer для цветных принтеров.
SELECT * FROM printer WHERE color = 'y';

-- 5. Найдите номер модели, скорость и размер жесткого диска ПК, имеющих 12x или 24x CD и цену менее 600 дол.
SELECT model, speed, hd FROM PC WHERE (cd = '12x' OR cd = '24x') AND price < 600;

-- 6. Для каждого производителя, выпускающего ПК-блокноты c объёмом жесткого диска не менее 10 Гбайт, найти скорости таких ПК-блокнотов. Вывод: производитель, скорость.
SELECT DISTINCT maker, speed FROM laptop JOIN product ON product.model = laptop.model WHERE hd >= 10;

-- 7. Найдите номера моделей и цены всех имеющихся в продаже продуктов (любого типа) производителя B (латинская буква).
SELECT DISTINCT PC.model, price FROM PC JOIN product ON PC.model = product.model WHERE maker = 'B'
UNION
SELECT DISTINCT laptop.model, price FROM laptop JOIN product ON laptop.model = product.model WHERE maker = 'B'
UNION
SELECT DISTINCT printer.model, price FROM printer JOIN product ON printer.model = product.model WHERE maker = 'B';

-- 8. Найдите производителя, выпускающего ПК, но не ПК-блокноты.
SELECT DISTINCT maker FROM product WHERE type = 'pc' AND maker NOT IN (SELECT maker FROM product WHERE type = 'laptop');

-- 9. Найдите производителей ПК с процессором не менее 450 Мгц. Вывести: Maker
SELECT DISTINCT maker FROM product JOIN PC ON product.model = PC.model WHERE speed >= 450;

-- 10. Найдите модели принтеров, имеющих самую высокую цену. Вывести: model, price
SELECT model, price FROM printer WHERE price = (SELECT MAX(price) FROM printer);