---task 1

USE UNIVER;
GO

-- Вывести список всех индексов в базе данных UNIVER
SELECT 
    OBJECT_NAME(object_id) AS TableName,
    name AS IndexName,
    type_desc AS IndexType
FROM sys.indexes;


-- Пример SELECT-запроса
SELECT *
FROM #TempTable
WHERE ID BETWEEN 100 AND 200;


-- Создать временную таблицу
CREATE TABLE #TempTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- Заполнить таблицу данными (пример)
INSERT INTO #TempTable (ID, Name)
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects;

SET SHOWPLAN_TEXT ON;

---task 2

-- Создать временную таблицу и заполнить данными (пример)
CREATE TABLE #LargeTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- Заполнить таблицу данными (пример)
INSERT INTO #LargeTable (ID, Name)
SELECT TOP 10000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects;

-- Создать некластеризованный неуникальный составной индекс
CREATE NONCLUSTERED INDEX IX_LargeTable_Index
ON #LargeTable (ID, Name);

SET SHOWPLAN_TEXT ON;

---task 2



-- Пример SELECT-запроса
SELECT *
FROM #LargeTable
WHERE ID BETWEEN 5000 AND 6000;



---task 3

-- Создать временную таблицу и заполнить данными (пример)
CREATE TABLE #LargeTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    OtherColumn1 INT,
    OtherColumn2 NVARCHAR(50),
    -- Добавьте другие столбцы, если необходимо
);

-- Заполнить таблицу данными (пример)
INSERT INTO #LargeTable (ID, Name, OtherColumn1, OtherColumn2)
SELECT TOP 10000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),
    100 + ROW_NUMBER() % 10,
    'Data ' + CAST(ROW_NUMBER() % 5 AS NVARCHAR(2))
FROM sys.objects;

-- Создать некластеризованный индекс покрытия
CREATE NONCLUSTERED INDEX IX_CoveringIndex
ON #LargeTable (ID, Name)
INCLUDE (OtherColumn1, OtherColumn2);

-- Пример SELECT-запроса
SELECT ID, Name, OtherColumn1
FROM #LargeTable
WHERE ID BETWEEN 5000 AND 6000;

SET SHOWPLAN_TEXT ON;

---task 4

-- Создать временную таблицу и заполнить данными (пример)
CREATE TABLE #SampleTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT
    -- Добавьте другие столбцы, если необходимо
);

-- Заполнить таблицу данными (пример)
INSERT INTO #SampleTable (ID, Name, Age)
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),
    20 + ROW_NUMBER() % 10
FROM sys.objects;

-- Создать некластеризованный фильтруемый индекс
CREATE NONCLUSTERED INDEX IX_FilteredIndex
ON #SampleTable (Age)
WHERE Age >= 25;

-- Пример SELECT-запроса
SELECT ID, Name
FROM #SampleTable
WHERE Age >= 30;

SET SHOWPLAN_TEXT ON;

---task 5

-- Создать временную таблицу и заполнить данными (пример)
CREATE TABLE #SampleTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
    -- Добавьте другие столбцы, если необходимо
);

-- Заполнить таблицу данными (пример)
INSERT INTO #SampleTable (ID, Name)
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects;

-- Создать некластеризованный индекс
CREATE NONCLUSTERED INDEX IX_NonClusteredIndex
ON #SampleTable (ID);

-- Оценка уровня фрагментации индекса
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


-- Увеличение фрагментации индекса
UPDATE #SampleTable
SET ID = ID + 10000
WHERE ID % 2 = 0;


-- Оценка уровня фрагментации индекса
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


-- Реорганизация индекса
ALTER INDEX IX_NonClusteredIndex ON #SampleTable REORGANIZE;


-- Оценка уровня фрагментации индекса после реорганизации
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


-- Перестройка индекса
ALTER INDEX IX_NonClusteredIndex ON #SampleTable REBUILD;


	-- Оценка уровня фрагментации индекса после перестройки
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


---task 6

-- Создать таблицу
CREATE TABLE dbo.SampleTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- Вставить данные в таблицу
INSERT INTO dbo.SampleTable (ID, Name)
VALUES (1, 'Name1'),
       (2, 'Name2'),
       (3, 'Name3'),
       -- Вставьте больше данных
       (1000, 'Name1000');

-- Создать некластеризованный индекс с параметром FILLFACTOR
CREATE NONCLUSTERED INDEX IX_NonClusteredIndex
ON dbo.SampleTable (ID)
WITH (FILLFACTOR = 70); -- Установите желаемое значение FILLFACTOR

-- Выполнить запрос для просмотра информации о индексе
SELECT
    OBJECT_NAME(i.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent,
    fill_factor
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'dbo.SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;
