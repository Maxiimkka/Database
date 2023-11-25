---Задание 8

SELECT * FROM TIMETABLE

SELECT RoomNumber
FROM TIMETABLE
WHERE DayOfWeek = 'Понедельник' AND ClassNumber = 1;

SELECT DISTINCT RoomNumber
FROM TIMETABLE
WHERE DayOfWeek = 'Вторник';

SELECT T1.Teacher, T1.DayOfWeek, T1.ClassNumber + 1 AS FreeClassNumber
FROM TIMETABLE T1
LEFT JOIN TIMETABLE T2 ON T1.Teacher = T2.Teacher
    AND T1.DayOfWeek = T2.DayOfWeek
    AND T1.ClassNumber + 1 = T2.ClassNumber
WHERE T2.id IS NULL;


SELECT T1.GroupName, T1.DayOfWeek, T1.ClassNumber + 1 AS FreeClassNumber
FROM TIMETABLE T1
LEFT JOIN TIMETABLE T2 ON T1.GroupName = T2.GroupName
    AND T1.DayOfWeek = T2.DayOfWeek
    AND T1.ClassNumber + 1 = T2.ClassNumber
WHERE T2.id IS NULL;
