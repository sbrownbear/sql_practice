-- 1. Создать таблицу fine
CREATE TABLE fine (
    fine_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30),
    number_plate VARCHAR(6),
    violation VARCHAR(50),
    sum_fine DECIMAL(8, 2),
    date_violation DATE,
    date_payment DATE)

-- 2. В таблицу fine добавить записи
INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
    VALUES('Баранов П.Е.', 'Р523ВТ', 'Превышение скорости(от 40 до 60)', null, '2020-02-14 ', null);
INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
    VALUES('Абрамова К.А.', 'О111АВ', 'Проезд на запрещающий сигнал', null, '2020-02-23', null);
INSERT INTO fine(name, number_plate, violation, sum_fine, date_violation, date_payment)
    VALUES('Яковлев Г.Р.', 'Т330ТТ', 'Проезд на запрещающий сигнал', null, '2020-03-03', null);

-- 3. Занести в таблицу fine суммы штрафов, которые должен оплатить водитель, в соответствии с данными из таблицы traffic_violation.
-- При этом суммы заносить только в пустые поля столбца sum_fine
UPDATE fine AS f, traffic_violation AS tv
    SET f.sum_fine = tv.sum_fine
    WHERE tv.violation = f.violation and f.sum_fine IS Null;

-- 4. Вывести фамилию, номер машины и нарушение только для тех водителей, которые на одной машине нарушили одно и то же правило 
-- два и более раз. При этом учитывать все нарушения, независимо от того оплачены они или нет. Информацию отсортировать в 
-- алфавитном порядке, сначала по фамилии водителя, потом по номеру машины и, наконец, по нарушению
SELECT name, number_plate, violation
    FROM fine
    GROUP BY name, number_plate, violation
    HAVING COUNT(number_plate) > 1
    ORDER BY name, number_plate, violation;

-- 5. В таблице fine увеличить в два раза сумму неоплаченных штрафов для отобранных на предыдущем шаге записей
UPDATE fine f, 
    (SELECT name, number_plate, violation
    FROM fine
    GROUP BY name, number_plate, violation
    HAVING COUNT(*) > 1) q_in
SET f.sum_fine = f.sum_fine * 2
WHERE (f.name, f.number_plate, f.violation) = 
    (q_in.name, q_in.number_plate, q_in.violation) AND
    f.date_payment IS Null;

-- 6. Водители оплачивают свои штрафы. В таблицу fine занести дату оплаты соответствующего штрафа из таблицы payment. Уменьшить начисленный штраф в таблице 
-- fine в два раза (только для тех штрафов, информация о которых занесена в таблицу payment), если оплата произведена не позднее 20 дней со дня нарушения
UPDATE fine f, payment p
SET f.date_payment = p.date_payment,
    f.sum_fine = IF(DATEDIFF(p.date_payment, f.date_violation) <= 20, f.sum_fine / 2, f.sum_fine)
WHERE (f.name, f.number_plate, f.violation, f.date_violation) = (p.name, p.number_plate, p.violation, p.date_violation);

-- 7. Создать новую таблицу back_payment, куда внести информацию о неоплаченных штрафах (Фамилию и инициалы водителя, 
-- номер машины, нарушение, сумму штрафа и дату нарушения) из таблицы fine
CREATE TABLE back_payment 
SELECT name, number_plate, violation, sum_fine, date_violation
    FROM fine
    WHERE date_payment is Null;