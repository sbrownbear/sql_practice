-- 1. Вывести информацию о  книгах, цены которых меньше или равны средней цене книг на складе. Информацию вывести в отсортированном по убыванию цены виде. Среднее вычислить как среднее по цене книги
SELECT author, title, price 
    FROM book 
    WHERE price <= (SELECT AVG(price) FROM book)
    ORDER BY 3 DESC;

-- 2. Вывести информацию о тех книгах, цены которых превышают минимальную цену книги на складе не более чем на 150 рублей в отсортированном по возрастанию цены виде
SELECT author, title, price
    FROM book
    WHERE price - 150 <= (SELECT MIN(price) FROM book)
    ORDER BY price;

-- 3. Вывести информацию (автора, книгу и количество) о тех книгах, количество экземпляров которых в таблице book не дублируется
SELECT author, title, amount
    FROM book
    WHERE amount IN (SELECT amount FROM book
    GROUP BY amount HAVING COUNT(amount) = 1);

-- 4. Вывести информацию о книгах, цена которых меньше самой большой из минимальных цен, вычисленных для каждого автора
SELECT author, title, price
    FROM book
    WHERE price < ANY (SELECT MIN(price)
    FROM book
    GROUP BY author);

-- 5. Посчитать сколько и каких экземпляров книг нужно заказать поставщикам, чтобы на складе стало одинаковое количество экземпляров каждой книги, равное значению самого большего количества 
-- экземпляров одной книги на складе. Вывести название книги, ее автора, текущее количество экземпляров на складе и количество заказываемых экземпляров книг. Последнему столбцу присвоить имя Заказ. 
-- В результат не включать книги, которые заказывать не нужно.
SELECT title, author, amount, (SELECT MAX(amount) FROM book) - amount AS Заказ
    FROM book
    HAVING Заказ > 0;
    