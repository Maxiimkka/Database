---task 1

USE UNIVER;
GO

-- ������� ������ ���� �������� � ���� ������ UNIVER
SELECT 
    OBJECT_NAME(object_id) AS TableName,
    name AS IndexName,
    type_desc AS IndexType
FROM sys.indexes;


-- ������ SELECT-�������
SELECT *
FROM #TempTable
WHERE ID BETWEEN 100 AND 200;


-- ������� ��������� �������
CREATE TABLE #TempTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- ��������� ������� ������� (������)
INSERT INTO #TempTable (ID, Name)
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects;

SET SHOWPLAN_TEXT ON;

---task 2

-- ������� ��������� ������� � ��������� ������� (������)
CREATE TABLE #LargeTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- ��������� ������� ������� (������)
INSERT INTO #LargeTable (ID, Name)
SELECT TOP 10000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects;

-- ������� ������������������ ������������ ��������� ������
CREATE NONCLUSTERED INDEX IX_LargeTable_Index
ON #LargeTable (ID, Name);

SET SHOWPLAN_TEXT ON;

---task 2



-- ������ SELECT-�������
SELECT *
FROM #LargeTable
WHERE ID BETWEEN 5000 AND 6000;



---task 3

-- ������� ��������� ������� � ��������� ������� (������)
CREATE TABLE #LargeTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    OtherColumn1 INT,
    OtherColumn2 NVARCHAR(50),
    -- �������� ������ �������, ���� ����������
);

-- ��������� ������� ������� (������)
INSERT INTO #LargeTable (ID, Name, OtherColumn1, OtherColumn2)
SELECT TOP 10000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),
    100 + ROW_NUMBER() % 10,
    'Data ' + CAST(ROW_NUMBER() % 5 AS NVARCHAR(2))
FROM sys.objects;

-- ������� ������������������ ������ ��������
CREATE NONCLUSTERED INDEX IX_CoveringIndex
ON #LargeTable (ID, Name)
INCLUDE (OtherColumn1, OtherColumn2);

-- ������ SELECT-�������
SELECT ID, Name, OtherColumn1
FROM #LargeTable
WHERE ID BETWEEN 5000 AND 6000;

SET SHOWPLAN_TEXT ON;

---task 4

-- ������� ��������� ������� � ��������� ������� (������)
CREATE TABLE #SampleTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Age INT
    -- �������� ������ �������, ���� ����������
);

-- ��������� ������� ������� (������)
INSERT INTO #SampleTable (ID, Name, Age)
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10)),
    20 + ROW_NUMBER() % 10
FROM sys.objects;

-- ������� ������������������ ����������� ������
CREATE NONCLUSTERED INDEX IX_FilteredIndex
ON #SampleTable (Age)
WHERE Age >= 25;

-- ������ SELECT-�������
SELECT ID, Name
FROM #SampleTable
WHERE Age >= 30;

SET SHOWPLAN_TEXT ON;

---task 5

-- ������� ��������� ������� � ��������� ������� (������)
CREATE TABLE #SampleTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
    -- �������� ������ �������, ���� ����������
);

-- ��������� ������� ������� (������)
INSERT INTO #SampleTable (ID, Name)
SELECT TOP 1000
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)),
    'Name ' + CAST(ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS NVARCHAR(10))
FROM sys.objects;

-- ������� ������������������ ������
CREATE NONCLUSTERED INDEX IX_NonClusteredIndex
ON #SampleTable (ID);

-- ������ ������ ������������ �������
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


-- ���������� ������������ �������
UPDATE #SampleTable
SET ID = ID + 10000
WHERE ID % 2 = 0;


-- ������ ������ ������������ �������
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


-- ������������� �������
ALTER INDEX IX_NonClusteredIndex ON #SampleTable REORGANIZE;


-- ������ ������ ������������ ������� ����� �������������
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


-- ����������� �������
ALTER INDEX IX_NonClusteredIndex ON #SampleTable REBUILD;


	-- ������ ������ ������������ ������� ����� �����������
SELECT 
    OBJECT_NAME(ps.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'tempdb..#SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;


---task 6

-- ������� �������
CREATE TABLE dbo.SampleTable
(
    ID INT PRIMARY KEY,
    Name NVARCHAR(100)
);

-- �������� ������ � �������
INSERT INTO dbo.SampleTable (ID, Name)
VALUES (1, 'Name1'),
       (2, 'Name2'),
       (3, 'Name3'),
       -- �������� ������ ������
       (1000, 'Name1000');

-- ������� ������������������ ������ � ���������� FILLFACTOR
CREATE NONCLUSTERED INDEX IX_NonClusteredIndex
ON dbo.SampleTable (ID)
WITH (FILLFACTOR = 70); -- ���������� �������� �������� FILLFACTOR

-- ��������� ������ ��� ��������� ���������� � �������
SELECT
    OBJECT_NAME(i.OBJECT_ID) AS TableName,
    i.name AS IndexName,
    ps.index_id,
    index_type_desc,
    avg_fragmentation_in_percent,
    fill_factor
FROM sys.dm_db_index_physical_stats (DB_ID(), OBJECT_ID(N'dbo.SampleTable'), NULL, NULL, NULL) ps
INNER JOIN sys.indexes i ON ps.OBJECT_ID = i.OBJECT_ID AND ps.index_id = i.index_id;
