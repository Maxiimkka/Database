---task 1


DECLARE @charVariable CHAR(10) = 'Hello';
DECLARE @varcharVariable VARCHAR(20) = 'World';
DECLARE @datetimeVariable DATETIME;
DECLARE @timeVariable TIME;
DECLARE @intVariable INT;
DECLARE @smallintVariable SMALLINT;
DECLARE @tinyintVariable TINYINT;
DECLARE @numericVariable NUMERIC(12, 5);


	SET @datetimeVariable = GETDATE();  
	SET @timeVariable = CONVERT(TIME, GETDATE());      
	SET @intVariable = 42;              
   SELECT @smallintVariable = 123;       
   SELECT @tinyintVariable = 5;          
   SELECT @numericVariable = 123.45678;   

SELECT 
    @charVariable AS 'CHAR Variable', 
    @varcharVariable AS 'VARCHAR Variable',
    @datetimeVariable AS 'DATETIME Variable',
    @timeVariable AS 'TIME Variable',
    @intVariable AS 'INT Variable',
    @smallintVariable AS 'SMALLINT Variable',
    @tinyintVariable AS 'TINYINT Variable',
    @numericVariable AS 'NUMERIC Variable';


PRINT 'CHAR Variable: ' + @charVariable;
PRINT 'VARCHAR Variable: ' + @varcharVariable;

---task 2


DECLARE @TotalCapacity INT;
SELECT @TotalCapacity = SUM(AUDITORIUM_CAPACITY)
FROM AUDITORIUM;


IF @TotalCapacity > 200
BEGIN
    DECLARE @AverageCapacity FLOAT;
    SELECT @AverageCapacity = AVG(AUDITORIUM_CAPACITY)
    FROM AUDITORIUM;

    DECLARE @LessThanAverage INT;
    SELECT @LessThanAverage = COUNT(*)
    FROM AUDITORIUM
    WHERE AUDITORIUM_CAPACITY < @AverageCapacity;

    DECLARE @PercentageLessThanAverage FLOAT;
    SET @PercentageLessThanAverage = 100.0 * @LessThanAverage / COUNT(*);

   
    PRINT 'Общая вместимость аудиторий: ' +	CONVERT(VARCHAR(10),@TotalCapacity);
    PRINT 'Средняя вместимость аудиторий: ' + CAST(@AverageCapacity AS VARCHAR(10));
    PRINT 'Количество аудиторий с вместимостью меньше средней: ' + CAST(@LessThanAverage AS VARCHAR(10));
    PRINT 'Процент аудиторий с вместимостью меньше средней: ' + CAST(@PercentageLessThanAverage AS VARCHAR(10)) + '%';
END
ELSE
BEGIN
    PRINT 'Общая вместимость аудиторий составляет ' + CAST(@TotalCapacity AS VARCHAR(10)) + ', что меньше 200.';
END

---task 3

PRINT 'Число обработанных строк (@@ROWCOUNT): ' + CAST(@@ROWCOUNT AS VARCHAR(10));
PRINT 'Версия SQL Server (@@VERSION): ' + @@VERSION;
PRINT 'Системный идентификатор процесса (@@SPID): ' + CAST(@@SPID AS VARCHAR(10));
PRINT 'Код последней ошибки (@@ERROR): ' + CAST(@@ERROR AS VARCHAR(10));
PRINT 'Имя сервера (@@SERVERNAME): ' + @@SERVERNAME;
PRINT 'Уровень вложенности транзакции (@@TRANCOUNT): ' + CAST(@@TRANCOUNT AS VARCHAR(10));



DECLARE @FetchStatus INT;
DECLARE @Variable INT;
SET @FetchStatus = @@FETCH_STATUS;
PRINT 'Результат считывания строк результирующего набора (@@FETCH_STATUS): ' + CAST(@FetchStatus AS VARCHAR(10));

DECLARE @NestLevel INT;
SET @NestLevel = @@NESTLEVEL;
PRINT 'Уровень вложенности текущей процедуры (@@NESTLEVEL): ' + CAST(@NestLevel AS VARCHAR(10));


---task 4

DECLARE @t FLOAT = 5; 
DECLARE @x FLOAT = 3;  
DECLARE @z FLOAT;

IF @t > @x
    SET @z = SIN(@t) * SIN(@t);
ELSE IF @t < @x
    SET @z = 4 * (@t + @x);
ELSE
    SET @z = 1 - EXP(@x - 2);

PRINT 'Значение переменной z: ' + CAST(@z AS VARCHAR(20));

DECLARE @FullName NVARCHAR(100) = 'Макейчик Татьяна Леонидовна';
DECLARE @ShortName NVARCHAR(100);
DECLARE @FirstName NVARCHAR(50);
DECLARE @MiddleName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);

SELECT @LastName = LEFT(@FullName, CHARINDEX(' ', @FullName) - 1);
SELECT @FirstName = SUBSTRING(@FullName, CHARINDEX(' ', @FullName) + 1, CHARINDEX(' ', @FullName, CHARINDEX(' ', @FullName) + 1) - CHARINDEX(' ', @FullName) - 1);
SELECT @MiddleName = RIGHT(@FullName, LEN(@FullName) - CHARINDEX(' ', @FullName, CHARINDEX(' ', @FullName) + 1));


SELECT @ShortName = @LastName + ' ' + LEFT(@FirstName, 1) + '. ' + LEFT(@MiddleName, 1) + '.';

PRINT 'Сокращенное ФИО студента: ' + @ShortName;

DECLARE @NextMonthDate DATE = DATEADD(MONTH, 1, GETDATE());

SELECT
    NAME,
    BDAY,
    DATEDIFF(YEAR, BDAY, GETDATE()) AS Age
FROM STUDENT
WHERE MONTH(BDAY) = MONTH(@NextMonthDate);

DECLARE @ExamDate DATE = '2023-11-15';  
DECLARE @GroupName NVARCHAR(50) = 'Группа 101';  

SELECT
    @GroupName AS GroupName,
    DATENAME(WEEKDAY, @ExamDate) AS ExamDayOfWeek;

---task 5

USE UNIVER;

DECLARE @GroupCount INT;


SELECT @GroupCount = COUNT(*)
FROM STUDENT
GROUP BY IDGROUP;


IF @GroupCount = 0
BEGIN
    PRINT 'В базе данных нет информации о студентах.';
END
ELSE IF @GroupCount < 5
BEGIN
    PRINT 'Всего ' + CAST(@GroupCount AS NVARCHAR(10)) + ' групп.';
END
ELSE
BEGIN
    PRINT 'В базе данных есть информация о множестве студентов и групп.';
END

---task 6 

USE UNIVER;


SELECT
    s.IDSTUDENT,
    s.NAME,
    NOTE AS Grade,
    CASE
        WHEN NOTE >= 9 THEN 'Отлично'
        WHEN NOTE >= 7 THEN 'Хорошо'
        WHEN NOTE >= 5 THEN 'Удовлетворительно'
        ELSE 'Неудовлетворительно'
    END AS GradeDescription
FROM STUDENT s,PULPIT p
JOIN PROGRESS ON IDSTUDENT = PROGRESS.IDSTUDENT
WHERE P.PULPIT = 'ИСиТ';


---task 7


CREATE TABLE #TempTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(50),
    Value INT
);


DECLARE @Counter INT = 1;


WHILE @Counter <= 10
BEGIN
    INSERT INTO #TempTable (ID, Name, Value)
    VALUES (@Counter, 'Name ' + CAST(@Counter AS NVARCHAR(2)), @Counter);
    
    SET @Counter = @Counter + 1;
END;


SELECT * FROM #TempTable;


DROP TABLE #TempTable;

---task 8








---task 9

BEGIN TRY
    
    SELECT 10 / 0;
END TRY
BEGIN CATCH
    
    DECLARE @ErrorMessage NVARCHAR(500);

    SET @ErrorMessage = 'Произошла ошибка с кодом: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = 'Сообщение об ошибке: ' + ERROR_MESSAGE();
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = 'Ошибка в строке: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = 'Процедура с ошибкой: ' + ISNULL(ERROR_PROCEDURE(), 'Не применимо');
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = 'Уровень серьезности ошибки: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = 'Метка ошибки: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;
END CATCH;


