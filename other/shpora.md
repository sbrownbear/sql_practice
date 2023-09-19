## Перечисление базовых команд. Теоритическую базу по SQL можно посмотреть в репозитории [здесь](https://github.com/sbrownbear/qa/blob/main/5-SQL_for_testing.md).

__SELECT__ - возвращает информацию из таблицы 

`SELECT * FROM table_name;`

__DISTINCT__ - возвращает только неповторяющиеся данные из таблицы

`SELECT DISTINCT col_name1, col_name2 FROM table_name;`

__INSERT INTO__ - добавление данных в таблицу 

`INSERT INTO table_name (col_name1, col_name2, col_name3) VALUES (value1, value2, value3);`

__UPDATE__ - команда для обновления данных таблицы 

`UPDATE table_name SET col_name1 = value1, col_name2 = value2, ... WHERE condition;`

__ORDER BY ASC__ - сортировка по возрастанию

__ORDER BY DESC__ - сортировка по убыванию

`SELECT * FROM user ORDER BY name DESC;`

__LIKE__ - специальные символы в шаблонах. __%__ - любое кол-во символов (включая 0), _ - ровно один символ. 

`WHERE col_name LIKE «%Blond%»;`

__GROUP BY__ - группировка, используется с агрегатными функциями __(COUNT, MAX, MIN, SUM, AVG)__

`SELECT col_name1, col_name2, … FROM table_name GROUP BY col_namex;`

__HAVING__ - используется вместе с группировкой, WHERE использовать нельзя

`SELECT COUNT(course_id), dept_name FROM course GROUP BY dept_name HAVING COUNT(course_id >1);`

__JOIN__ - используется для связи двух и более таблиц с помощью общих атрибутов внутри них

`SELECT col_name1, col_name2, … FROM table_name1 JOIN table_name2 ON table_name1.col_namex = table2.col_namex;`

__DELETE__ - используется для удаления данных из таблицы. 

`DELETE FROM table_name;`

__TRUNCATE__ - операция мгновенного удаления всех строк в таблице. 

`TRUNCATE TABLE table_name;`

__DROP__ - удалить всю таблицу целиком.

`DROP TABLE table_name;`

__Агрегатные функции__ – математические функции __SUM__ возвращает сумму; __COUNT__ количество строк; __AVG__ среднее значение; __MIN__ наименьшее значение; __MAX__ наибольшее значение; __NVL (1, 2)__ если значение 1 пустое, берет 2; __VAR__ отличающееся значение
