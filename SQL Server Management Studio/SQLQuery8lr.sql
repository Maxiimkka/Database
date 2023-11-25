SELECT * FROM ���������
SELECT * FROM ����������
SELECT * FROM ����������_������
SELECT * FROM ����������_���������
SELECT * FROM �������������


---task 1

CREATE VIEW ������������� AS
SELECT
    TEACHER AS '���',
    TEACHER_NAME AS '��� �������������',
    GENDER AS '���',
    PULPIT AS '��� �������'
FROM TEACHER;


---task 2

CREATE VIEW ����������_������ AS
SELECT
    F.FACULTY_NAME AS '���������',
    COUNT(P.PULPIT) AS '���������� ������'
FROM FACULTY F
LEFT JOIN PULPIT P ON F.FACULTY = P.FACULTY
GROUP BY F.FACULTY_NAME;

---task 3

CREATE VIEW ��������� AS
SELECT
    AUDITORIUM AS '���',
    AUDITORIUM_NAME AS '������������ ���������'
FROM AUDITORIUM
WHERE AUDITORIUM_TYPE LIKE '��%';



---task 4

CREATE VIEW ����������_��������� AS
SELECT
    AUDITORIUM AS '���',
    AUDITORIUM_NAME AS '������������ ���������'
FROM AUDITORIUM
WHERE AUDITORIUM_TYPE LIKE '��%' 


---task 5

CREATE VIEW ���������� AS
SELECT TOP 100 PERCENT
    SUBJECT AS '���',
    SUBJECT_NAME AS '������������ ����������',
    PULPIT AS '��� �������'
FROM SUBJECT
ORDER BY SUBJECT_NAME;



---task 6

-- ������ ������������ �������������
DROP VIEW ����������_������;

-- �������� ����� ������������� � ������ SCHEMABINDING
CREATE VIEW ����������_������
WITH SCHEMABINDING
AS
SELECT
    FACULTY.FACULTY_NAME AS '���������',
    COUNT_BIG(*) AS '���������� ������'
FROM
    dbo.FACULTY
    INNER JOIN dbo.PULPIT ON FACULTY.FACULTY = PULPIT.FACULTY
GROUP BY
    FACULTY.FACULTY_NAME;


