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

   
    PRINT '����� ����������� ���������: ' +	CONVERT(VARCHAR(10),@TotalCapacity);
    PRINT '������� ����������� ���������: ' + CAST(@AverageCapacity AS VARCHAR(10));
    PRINT '���������� ��������� � ������������ ������ �������: ' + CAST(@LessThanAverage AS VARCHAR(10));
    PRINT '������� ��������� � ������������ ������ �������: ' + CAST(@PercentageLessThanAverage AS VARCHAR(10)) + '%';
END
ELSE
BEGIN
    PRINT '����� ����������� ��������� ���������� ' + CAST(@TotalCapacity AS VARCHAR(10)) + ', ��� ������ 200.';
END

---task 3

PRINT '����� ������������ ����� (@@ROWCOUNT): ' + CAST(@@ROWCOUNT AS VARCHAR(10));
PRINT '������ SQL Server (@@VERSION): ' + @@VERSION;
PRINT '��������� ������������� �������� (@@SPID): ' + CAST(@@SPID AS VARCHAR(10));
PRINT '��� ��������� ������ (@@ERROR): ' + CAST(@@ERROR AS VARCHAR(10));
PRINT '��� ������� (@@SERVERNAME): ' + @@SERVERNAME;
PRINT '������� ����������� ���������� (@@TRANCOUNT): ' + CAST(@@TRANCOUNT AS VARCHAR(10));



DECLARE @FetchStatus INT;
DECLARE @Variable INT;
SET @FetchStatus = @@FETCH_STATUS;
PRINT '��������� ���������� ����� ��������������� ������ (@@FETCH_STATUS): ' + CAST(@FetchStatus AS VARCHAR(10));

DECLARE @NestLevel INT;
SET @NestLevel = @@NESTLEVEL;
PRINT '������� ����������� ������� ��������� (@@NESTLEVEL): ' + CAST(@NestLevel AS VARCHAR(10));


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

PRINT '�������� ���������� z: ' + CAST(@z AS VARCHAR(20));

DECLARE @FullName NVARCHAR(100) = '�������� ������� ����������';
DECLARE @ShortName NVARCHAR(100);
DECLARE @FirstName NVARCHAR(50);
DECLARE @MiddleName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);

SELECT @LastName = LEFT(@FullName, CHARINDEX(' ', @FullName) - 1);
SELECT @FirstName = SUBSTRING(@FullName, CHARINDEX(' ', @FullName) + 1, CHARINDEX(' ', @FullName, CHARINDEX(' ', @FullName) + 1) - CHARINDEX(' ', @FullName) - 1);
SELECT @MiddleName = RIGHT(@FullName, LEN(@FullName) - CHARINDEX(' ', @FullName, CHARINDEX(' ', @FullName) + 1));


SELECT @ShortName = @LastName + ' ' + LEFT(@FirstName, 1) + '. ' + LEFT(@MiddleName, 1) + '.';

PRINT '����������� ��� ��������: ' + @ShortName;

DECLARE @NextMonthDate DATE = DATEADD(MONTH, 1, GETDATE());

SELECT
    NAME,
    BDAY,
    DATEDIFF(YEAR, BDAY, GETDATE()) AS Age
FROM STUDENT
WHERE MONTH(BDAY) = MONTH(@NextMonthDate);

DECLARE @ExamDate DATE = '2023-11-15';  
DECLARE @GroupName NVARCHAR(50) = '������ 101';  

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
    PRINT '� ���� ������ ��� ���������� � ���������.';
END
ELSE IF @GroupCount < 5
BEGIN
    PRINT '����� ' + CAST(@GroupCount AS NVARCHAR(10)) + ' �����.';
END
ELSE
BEGIN
    PRINT '� ���� ������ ���� ���������� � ��������� ��������� � �����.';
END

---task 6 

USE UNIVER;


SELECT
    s.IDSTUDENT,
    s.NAME,
    NOTE AS Grade,
    CASE
        WHEN NOTE >= 9 THEN '�������'
        WHEN NOTE >= 7 THEN '������'
        WHEN NOTE >= 5 THEN '�����������������'
        ELSE '�������������������'
    END AS GradeDescription
FROM STUDENT s,PULPIT p
JOIN PROGRESS ON IDSTUDENT = PROGRESS.IDSTUDENT
WHERE P.PULPIT = '����';


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

    SET @ErrorMessage = '��������� ������ � �����: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = '��������� �� ������: ' + ERROR_MESSAGE();
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = '������ � ������: ' + CAST(ERROR_LINE() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = '��������� � �������: ' + ISNULL(ERROR_PROCEDURE(), '�� ���������');
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = '������� ����������� ������: ' + CAST(ERROR_SEVERITY() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;

    SET @ErrorMessage = '����� ������: ' + CAST(ERROR_STATE() AS NVARCHAR(10));
    SELECT @ErrorMessage AS ErrorMessage;
END CATCH;


