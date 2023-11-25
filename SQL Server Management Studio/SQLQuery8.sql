---������� 5

-- �������� ������� "Employees"
CREATE TABLE Employees (
  ID INT,
  Firstname VARCHAR(50),
  Lastname VARCHAR(50)
);

-- ���������� ������� "Employees" �������
INSERT INTO Employees (ID, Firstname, Lastname)
VALUES (1, 'John', 'Smith'),
       (2, 'Mary', 'Johnson'),
       (3, 'David', 'Brown');

-- �������� ������� "Salaries"
CREATE TABLE Salaries (
  ID INT,
  Salary INT
);

-- ���������� ������� "Salaries" �������
INSERT INTO Salaries (ID, Salary)
VALUES (2, 5000),
       (3, 6000),
       (4, 7000);

---������, ��������� �������� �������� ������ ����� (� �������� FULL OUTER JOIN) ������� � �� �������� ������ ������
SELECT Employees.ID, Employees.Firstname, Employees.Lastname
FROM Employees
LEFT JOIN Salaries ON Employees.ID = Salaries.ID
WHERE Salaries.ID IS NULL;

---������, ��������� �������� �������� ������ ������ ������� � �� ���������� ������ �����
SELECT Salaries.ID, Salaries.Salary
FROM Employees
RIGHT JOIN Salaries ON Employees.ID = Salaries.ID
WHERE Employees.ID IS NULL;

---������, ��������� �������� �������� ������ ������ ������� � ����� �������
SELECT Employees.ID, Employees.Firstname, Employees.Lastname, Salaries.ID, Salaries.Salary
FROM Employees
FULL OUTER JOIN Salaries ON Employees.ID = Salaries.ID
WHERE Employees.ID IS NOT NULL OR Salaries.ID IS NOT NULL;