
---task 2

SELECT AUDITORIUM_TYPENAME, max(AUDITORIUM_CAPACITY) as [Максимальная вместительность],
 min(AUDITORIUM_CAPACITY) as [Минимальная вместительность],
 avg(AUDITORIUM_CAPACITY) as [Средняя вместительность],
count(AUDITORIUM) as [Общее кол-во аудиторий],
 sum(AUDITORIUM_CAPACITY) as [Общая вместительность аудитории данного типа]
From AUDITORIUM_TYPE  join AUDITORIUM A on AUDITORIUM_TYPE.AUDITORIUM_TYPE = A.AUDITORIUM_TYPE
Group By AUDITORIUM_TYPENAME

---task 3

Select *
from (select case
                 when (PROGRESS.NOTE in (6, 7)) then '6-7'
                 when (PROGRESS.NOTE in (8, 9)) then '8-9'
                 when (PROGRESS.NOTE in (4, 5)) then '4-5'
                 when (PROGRESS.NOTE = 10) then '10'
                 end  [оценки],
             count(*) [количество]
      from PROGRESS
      group by case
                   when (PROGRESS.NOTE in (6, 7)) then '6-7'
                   when (PROGRESS.NOTE in (8, 9)) then '8-9'
                   when (PROGRESS.NOTE in (4, 5)) then '4-5'
                   when (PROGRESS.NOTE = 10) then '10'
                   end
     ) as a
order by case a.оценки
               when '6-7' then 3
               when '8-9' then 2
               when '4-5' then 4
               when '10' then 1
               end

---task 4

SELECT
    FACULTY.FACULTY_NAME AS 'Факультет',
    GROUPS.PROFESSION AS 'Специальность',
     (2014 - GROUPS.YEAR_FIRST ) AS 'Курс',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS 'Средняя оценка'
FROM
    FACULTY
    INNER JOIN GROUPS ON FACULTY.FACULTY = GROUPS.FACULTY
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
GROUP BY
    FACULTY.FACULTY_NAME,
    GROUPS.PROFESSION,
    GROUPS.YEAR_FIRST
ORDER BY
    'Средняя оценка' DESC;


---task 5
SELECT
    FACULTY.FACULTY_NAME AS 'Факультет',
    GROUPS.PROFESSION AS 'Специальность',
     (2014 - GROUPS.YEAR_FIRST ) AS 'Курс',
    ROUND(AVG(CAST(PROGRESS.NOTE AS FLOAT)), 2) AS 'Средняя оценка'
FROM
    FACULTY
    INNER JOIN GROUPS ON FACULTY.FACULTY = GROUPS.FACULTY
    INNER JOIN STUDENT ON GROUPS.IDGROUP = STUDENT.IDGROUP
    INNER JOIN PROGRESS ON STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
WHERE
    PROGRESS.SUBJECT IN ('КГ', 'ОАиП')
GROUP BY
    FACULTY.FACULTY_NAME,
    GROUPS.PROFESSION,
    GROUPS.YEAR_FIRST
ORDER BY
    'Средняя оценка' DESC;


---task 6

SELECT
GROUPS.PROFESSION AS 'Специальность',
P.SUBJECT AS 'Дисциплина', 
ROUND(AVG(CAST(NOTE AS FLOAT)), 2) AS 'Средняя оценка'
FROM GROUPS JOIN STUDENT S ON GROUPS.IDGROUP = S.IDGROUP AND GROUPS.FACULTY='ИДиП'
  JOIN PROGRESS P ON S.IDSTUDENT = P.IDSTUDENT
GROUP BY P.SUBJECT, GROUPS.PROFESSION
ORDER BY
    'Специальность', 'Дисциплина';

---task 7

SELECT
    SUBJECT AS 'Дисциплина',
    COUNT(*) AS 'Количество студентов'
FROM
    PROGRESS
WHERE
    NOTE IN (8, 9)
GROUP BY
    SUBJECT
HAVING
    COUNT(*) > 0
ORDER BY
    'Количество студентов' DESC, 'Дисциплина';


