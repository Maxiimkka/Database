---Задание 5

-- Создание таблицы "Employees"
CREATE TABLE Employees (
  ID INT,
  Firstname VARCHAR(50),
  Lastname VARCHAR(50)
);

-- Заполнение таблицы "Employees" данными
INSERT INTO Employees (ID, Firstname, Lastname)
VALUES (1, 'John', 'Smith'),
       (2, 'Mary', 'Johnson'),
       (3, 'David', 'Brown');

-- Создание таблицы "Salaries"
CREATE TABLE Salaries (
  ID INT,
  Salary INT
);

-- Заполнение таблицы "Salaries" данными
INSERT INTO Salaries (ID, Salary)
VALUES (2, 5000),
       (3, 6000),
       (4, 7000);

---Запрос, результат которого содержит данные левой (в операции FULL OUTER JOIN) таблицы и не содержит данные правой
SELECT Employees.ID, Employees.Firstname, Employees.Lastname
FROM Employees
LEFT JOIN Salaries ON Employees.ID = Salaries.ID
WHERE Salaries.ID IS NULL;

---Запрос, результат которого содержит данные правой таблицы и не содержащие данные левой
SELECT Salaries.ID, Salaries.Salary
FROM Employees
RIGHT JOIN Salaries ON Employees.ID = Salaries.ID
WHERE Employees.ID IS NULL;

---Запрос, результат которого содержит данные правой таблицы и левой таблицы
SELECT Employees.ID, Employees.Firstname, Employees.Lastname, Salaries.ID, Salaries.Salary
FROM Employees
FULL OUTER JOIN Salaries ON Employees.ID = Salaries.ID
WHERE Employees.ID IS NOT NULL OR Salaries.ID IS NOT NULL;