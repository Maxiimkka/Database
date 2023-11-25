 USE Кривенчук_MyBase;

 CREATE TABLE СТУДЕНТЫ (
 СтудентID  INT PRIMARY KEY,
 Фамилия VARCHAR(255),
 Имя VARCHAR(255),
 Отчество VARCHAR(255),
 Адресс VARCHAR(255),
 Телефон VARCHAR(20)
 );

 CREATE TABLE ПРЕДМЕТЫ (
 ПредметID INT PRIMARY KEY,
 Название_предмета VARCHAR(255)
 );

 CREATE TABLE УЧЕБНЫЕ_РЕЗУЛЬТАТЫ (
 РезультатID INT PRIMARY KEY,
СтудентID INT,
ПредметID INT,
 Объем_лекций INT,
Объем_практических_занятий INT,
Объем_лабораторных_работ INT,
Оценка CHAR(1),
FOREIGN KEY (СтудентID) REFERENCES СТУДЕНТЫ(СтудентID),
FOREIGN KEY (ПредметID) REFERENCES ПРЕДМЕТЫ(ПредметID)
);

