---task 1

SELECT
    FACULTY.FACULTY_NAME AS '���������',
    GROUPS.PROFESSION AS '�������������',
    PROGRESS.SUBJECT AS '����������',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
FROM
    FACULTY
    INNER JOIN GROUPS ON FACULTY.FACULTY = GROUPS.FACULTY
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    FACULTY.FACULTY = '����'
GROUP BY
    ROLLUP (FACULTY.FACULTY_NAME, GROUPS.PROFESSION, PROGRESS.SUBJECT)
ORDER BY
    FACULTY.FACULTY_NAME, GROUPS.PROFESSION, PROGRESS.SUBJECT;

---task 2

SELECT
    FACULTY.FACULTY_NAME AS '���������',
    GROUPS.PROFESSION AS '�������������',
    PROGRESS.SUBJECT AS '����������',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
FROM
    FACULTY
    INNER JOIN GROUPS ON FACULTY.FACULTY = GROUPS.FACULTY
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    FACULTY.FACULTY = '����'
GROUP BY
    CUBE (FACULTY.FACULTY_NAME, GROUPS.PROFESSION, PROGRESS.SUBJECT)
ORDER BY
    FACULTY.FACULTY_NAME, GROUPS.PROFESSION, PROGRESS.SUBJECT;

---task 3

SELECT * FROM (
    -- ������ ��� ���������� ����
    SELECT
        GROUPS.PROFESSION AS '�������������',
        PROGRESS.SUBJECT AS '����������',
        ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
    FROM
        GROUPS
        INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
        INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
    WHERE
        GROUPS.FACULTY = '����'
    GROUP BY
        GROUPS.PROFESSION, PROGRESS.SUBJECT

    UNION 

    -- ������ ��� ���������� ����
    SELECT
        GROUPS.PROFESSION AS '�������������',
        PROGRESS.SUBJECT AS '����������',
        ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
    FROM
        GROUPS
        INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
        INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
    WHERE
        GROUPS.FACULTY = '����'
    GROUP BY
        GROUPS.PROFESSION, PROGRESS.SUBJECT
) AS CombinedResults;

---task 4 

SELECT
    GROUPS.PROFESSION AS '�������������',
    PROGRESS.SUBJECT AS '����������',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
FROM
    GROUPS
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    GROUPS.FACULTY = '����'
GROUP BY
    GROUPS.PROFESSION, PROGRESS.SUBJECT

INTERSECT

SELECT
    GROUPS.PROFESSION AS '�������������',
    PROGRESS.SUBJECT AS '����������',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
FROM
    GROUPS
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    GROUPS.FACULTY = '����'
GROUP BY
    GROUPS.PROFESSION, PROGRESS.SUBJECT;

---task 5


SELECT
    GROUPS.PROFESSION AS '�������������',
    PROGRESS.SUBJECT AS '����������',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
FROM
    GROUPS
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    GROUPS.FACULTY = '����'
GROUP BY
    GROUPS.PROFESSION, PROGRESS.SUBJECT

EXCEPT


SELECT
    GROUPS.PROFESSION AS '�������������',
    PROGRESS.SUBJECT AS '����������',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS '������� ������'
FROM
    GROUPS
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    GROUPS.FACULTY = '����'
GROUP BY
    GROUPS.PROFESSION, PROGRESS.SUBJECT;



