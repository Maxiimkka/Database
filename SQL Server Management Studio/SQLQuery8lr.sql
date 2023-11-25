SELECT * FROM Аудитории
SELECT * FROM Дисциплины
SELECT * FROM Количество_кафедр
SELECT * FROM Лекционные_аудитории
SELECT * FROM Преподаватель


---task 1

CREATE VIEW Преподаватель AS
SELECT
    TEACHER AS 'код',
    TEACHER_NAME AS 'имя преподавателя',
    GENDER AS 'пол',
    PULPIT AS 'код кафедры'
FROM TEACHER;


---task 2

CREATE VIEW Количество_кафедр AS
SELECT
    F.FACULTY_NAME AS 'факультет',
    COUNT(P.PULPIT) AS 'количество кафедр'
FROM FACULTY F
LEFT JOIN PULPIT P ON F.FACULTY = P.FACULTY
GROUP BY F.FACULTY_NAME;

---task 3

CREATE VIEW Аудитории AS
SELECT
    AUDITORIUM AS 'код',
    AUDITORIUM_NAME AS 'наименование аудитории'
FROM AUDITORIUM
WHERE AUDITORIUM_TYPE LIKE 'ЛК%';



---task 4

CREATE VIEW Лекционные_аудитории AS
SELECT
    AUDITORIUM AS 'код',
    AUDITORIUM_NAME AS 'наименование аудитории'
FROM AUDITORIUM
WHERE AUDITORIUM_TYPE LIKE 'ЛК%' 


---task 5

CREATE VIEW Дисциплины AS
SELECT TOP 100 PERCENT
    SUBJECT AS 'код',
    SUBJECT_NAME AS 'наименование дисциплины',
    PULPIT AS 'код кафедры'
FROM SUBJECT
ORDER BY SUBJECT_NAME;



---task 6

-- Удалим существующее представление
DROP VIEW Количество_кафедр;

-- Создадим новое представление с опцией SCHEMABINDING
CREATE VIEW Количество_кафедр
WITH SCHEMABINDING
AS
SELECT
    FACULTY.FACULTY_NAME AS 'факультет',
    COUNT_BIG(*) AS 'количество кафедр'
FROM
    dbo.FACULTY
    INNER JOIN dbo.PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
GROUP BY
    FACULTY.FACULTY_NAME;


