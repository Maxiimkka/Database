-- Task 1
declare SNAMES CURSOR for SELECT SUBJECT from SUBJECT
							where SUBJECT.PULPIT like '%ИСиТ%';
declare @tv char(20), @t char(300)='';
	open SNAMES;
	FETCH SNAMES into @tv;
	print 'Краткие названия';
	while @@FETCH_STATUS = 0
		begin 
		set @t = rtrim(@tv)+',' + @t;
		FETCH SNAMES into @tv;
		end;
	    print @t;
	close SNAMES;

-- Task 2 
Declare THNSIPPM_SUBJ cursor local
for  select SUBJECT	from SUBJECT where SUBJECT.PULPIT = N'ТНХСиППМ';
declare @sb nchar(20);
	open THNSIPPM_SUBJ;
	fetch THNSIPPM_SUBJ into @sb;
	print '1 >>>' + @sb;
	go
declare @sb nchar(20);
	fetch THNSIPPM_SUBJ into @sb;
	print '2 >>>' + @sb;
	go

Declare ISIT_SUBJ cursor global
for  select SUBJECT	from SUBJECT where SUBJECT.PULPIT = N'ИСиТ';
	open  ISIT_SUBJ;
declare @sb nchar(20);
	fetch  ISIT_SUBJ into @sb;
	print '1 >>>' + @sb;
	go
declare @sb nchar(20);
	fetch  ISIT_SUBJ into @sb;
	print '2 >>>' + @sb;
	go
	close ISIT_SUBJ
	deallocate ISIT_SUBJ;

-- Task 3
declare @ids int, @gr int, @name nchar(50), @bday date;
declare STDENTS_A1999 CURSOR LOCAL STATIC --DYNAMIC
for select IDSTUDENT, IDGROUP, NAME, BDAY
FROM STUDENT
WHERE BDAY > CAST('1999-01-01' AS date);
open STDENTS_A1999
fetch STDENTS_A1999 INTO @ids, @gr, @name, @bday;
PRINT  N'Количество строк : ' + cast(@@CURSOR_ROWS as varchar(5)); 
update STUDENT set BDAY = cast('1998-01-01' as date) where IDSTUDENT = 1018;
DELETE STUDENT where STUDENT.NAME = N'Дворянинкин Максим Анатольевич';
INSERT STUDENT(IDGROUP, NAME, BDAY) VALUES (29, N'Дворянинкин Максим Анатольевич', cast('1999-09-09' as date));
while @@FETCH_STATUS = 0
begin
print cast(@ids as varchar(5)) + ' ' + cast(@gr as varchar(5)) + ' ' + @name + ' ' + cast(@bday as varchar(15)) + '.';
fetch STDENTS_A1999 INTO @ids, @gr, @name, @bday;
end;
close STDENTS_A1999;

-- Task 4
DECLARE @tc int = 0, @fk nchar(10), @fk_full nchar(55);
declare PRIMER1 cursor local dynamic scroll
for 
select ROW_NUMBER() over (order by FACULTY) N,
FACULTY.FACULTY, FACULTY.FACULTY_NAME
FROM FACULTY;
OPEN PRIMER1;
FETCH first from PRIMER1 into @tc, @fk, @fk_full;
print N'Первая строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH last from PRIMER1 into @tc, @fk, @fk_full;
print N'последняя строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH ABSOLUTE 3 from PRIMER1 into @tc, @fk, @fk_full;
print N'Третья строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH next from PRIMER1 into @tc, @fk, @fk_full;
print N'Следующая строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH prior from PRIMER1 into @tc, @fk, @fk_full;
print N'Предыдущая строка : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH absolute -2 from PRIMER1 into @tc, @fk, @fk_full;
print N'Вторая строка с конца : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);
FETCH relative -1 from PRIMER1 into @tc, @fk, @fk_full;
print N'Relative -1 : ' + cast(@tc as varchar(3)) +' ' + rtrim(@fk) + ' ' + rtrim(@fk_full);

-- Task 5
DECLARE @one INT, @two NCHAR(10), @thr DATE, @fur INT, @stid INT = 1012;
DECLARE PRIMER2 CURSOR LOCAL DYNAMIC FOR
    SELECT PROGRESS.IDSTUDENT, PROGRESS.SUBJECT, PROGRESS.PDATE, PROGRESS.NOTE
    FROM PROGRESS
    INNER JOIN STUDENT ON PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
    INNER JOIN GROUPS ON GROUPS.IDGROUP = STUDENT.IDGROUP
    WHERE PROGRESS.NOTE < 4
	FOR UPDATE;
DECLARE PRIMER3 CURSOR LOCAL DYNAMIC FOR
    SELECT * FROM PROGRESS
    WHERE IDSTUDENT = @stid;

OPEN PRIMER2;
FETCH NEXT FROM PRIMER2 INTO @one, @two, @thr, @fur;

WHILE @@FETCH_STATUS = 0
BEGIN
    DELETE FROM PROGRESS WHERE CURRENT OF PRIMER2;
    FETCH NEXT FROM PRIMER2 INTO @one, @two, @thr, @fur;
END;

CLOSE PRIMER2;
DEALLOCATE PRIMER2;

OPEN PRIMER3;
FETCH NEXT FROM PRIMER3 INTO @one, @two, @thr, @fur;

WHILE @@FETCH_STATUS = 0
BEGIN
    UPDATE PROGRESS SET NOTE = NOTE + 1 WHERE CURRENT OF PRIMER3;
    FETCH NEXT FROM PRIMER3 INTO @one, @two, @thr, @fur;
END;

CLOSE PRIMER3;
DEALLOCATE PRIMER3;

SELECT * FROM PROGRESS;