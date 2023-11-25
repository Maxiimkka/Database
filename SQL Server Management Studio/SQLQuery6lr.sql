---task 1 

	select PULPIT_NAME from PULPIT, FACULTY 
where PULPIT.FACULTY = FACULTY.FACULTY
  and FACULTY.FACULTY in (select PROFESSION.FACULTY
                         from PROFESSION
                         where PROFESSION_NAME LIKE ('%ÚÂıÌÓÎÓ„Ë%'))
                            

---task2

select PULPIT.PULPIT_NAME from PULPIT
join FACULTY on  PULPIT.FACULTY = FACULTY.FACULTY
  and FACULTY.FACULTY in (select PROFESSION.FACULTY
                        from PROFESSION
                        where PROFESSION_NAME LIKE ('%ÚÂıÌÓÎÓ„Ë%'))

---task 3

 select  distinct PULPIT_NAME from PULPIT
	 join FACULTY 
               on PULPIT.FACULTY = FACULTY.FACULTY
			 join PROFESSION 
			   on   FACULTY.FACULTY  = PROFESSION.FACULTY 
		where PROFESSION_NAME LIKE '%ÚÂıÌÓÎÓ„Ë%'

---task 4 

select distinct  AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from AUDITORIUM as a
where AUDITORIUM_CAPACITY =	 
(select top(1) AUDITORIUM_CAPACITY from AUDITORIUM as b
where  b.AUDITORIUM_TYPE= a.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc 
)
order by AUDITORIUM_CAPACITY desc 

---task 5

select * from FACULTY 
where not exists (select * from PULPIT where PULPIT.FACULTY = FACULTY.FACULTY);

---task 6

SELECT 
top(1)
(SELECT  AVG(NOTE) FROM PROGRESS WHERE [SUBJECT] = 'Œ¿Ëœ') AS 'Œ¿Ëœ',
(SELECT AVG(NOTE) FROM PROGRESS WHERE [SUBJECT] = ' √') AS ' √',
(SELECT  AVG(NOTE) FROM PROGRESS WHERE [SUBJECT] = '—”¡ƒ') AS '—”¡ƒ'
FROM PROGRESS;

---task 7

select [SUBJECT], IDSTUDENT , NOTE from PROGRESS a
	where NOTE >=all (select NOTE from PROGRESS
		where [SUBJECT] = a.[SUBJECT] )

---task 8

select SUBJECT, NOTE, IDSTUDENT from PROGRESS
	where NOTE =any (select NOTE from PROGRESS
		where IDSTUDENT=1019 and SUBJECT=' √')