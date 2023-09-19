-- 11. Найдите среднюю скорость ПК.
SELECT AVG(speed) AS avg_speed 
FROM PC;

-- 12. Найдите среднюю скорость ПК-блокнотов, цена которых превышает 1000 дол.
SELECT AVG(speed) AS avg_speed 
FROM laptop WHERE price > 1000;

-- 13. Найдите среднюю скорость ПК, выпущенных производителем A.
SELECT AVG(speed) AS avg_speed 
FROM PC JOIN product ON product.model = pc.model 
WHERE maker = 'A';

-- 14. Найдите класс, имя и страну для кораблей из таблицы Ships, имеющих не менее 10 орудий.
SELECT ships.class, name, country 
FROM classes JOIN ships ON classes.class = ships.class 
WHERE numGuns >= 10;

-- 15. Найдите размеры жестких дисков, совпадающих у двух и более PC. Вывести: HD
SELECT HD FROM PC GROUP BY HD HAVING COUNT(*) >= 2;

-- 16. Найдите пары моделей PC, имеющих одинаковые скорость и RAM. В результате каждая пара указывается только один раз, т.е. (i,j), но не (j,i), Порядок вывода: модель с большим номером, модель с меньшим номером, скорость и RAM.
SELECT DISTINCT pc_1.model, pc_2.model, pc_1.speed, pc_1.ram 
FROM pc pc_1, pc pc_2 
WHERE pc_1.speed = pc_2.speed AND pc_1.ram = pc_2.ram AND pc_1.model > pc_2.model;

-- 17. Найдите модели ПК-блокнотов, скорость которых меньше скорости каждого из ПК. Вывести: type, model, speed
SELECT DISTINCT type, product.model, speed 
FROM product JOIN laptop ON product.model = laptop.model 
WHERE speed < ALL (SELECT speed FROM PC);

-- 18. Найдите производителей самых дешевых цветных принтеров. Вывести: maker, price
SELECT Product.maker AS Maker, price 
FROM Printer, Product

WHERE 
Printer.model = Product.model 

AND Printer.price = 
	(SELECT MIN(price) FROM Printer WHERE Printer.color = 'y')
AND Printer.color = 'y'
GROUP BY maker, price;

-- 19. Для каждого производителя, имеющего модели в таблице Laptop, найдите средний размер экрана выпускаемых им ПК-блокнотов. Вывести: maker, средний размер экрана.
SELECT maker, AVG(screen) 
FROM laptop JOIN product ON product.model = laptop.model 
GROUP BY maker;

-- 20. Найдите производителей, выпускающих по меньшей мере три различных модели ПК. Вывести: Maker, число моделей ПК.
SELECT maker, count(model) 
FROM product WHERE type = 'pc' 
GROUP BY maker 
HAVING COUNT(model) >= 3;

