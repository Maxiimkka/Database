 USE ���������_MyBase;

 CREATE TABLE �������� (
 �������ID  INT PRIMARY KEY,
 ������� VARCHAR(255),
 ��� VARCHAR(255),
 �������� VARCHAR(255),
 ������ VARCHAR(255),
 ������� VARCHAR(20)
 );

 CREATE TABLE �������� (
 �������ID INT PRIMARY KEY,
 ��������_�������� VARCHAR(255)
 );

 CREATE TABLE �������_���������� (
 ���������ID INT PRIMARY KEY,
�������ID INT,
�������ID INT,
 �����_������ INT,
�����_������������_������� INT,
�����_������������_����� INT,
������ CHAR(1),
FOREIGN KEY (�������ID) REFERENCES ��������(�������ID),
FOREIGN KEY (�������ID) REFERENCES ��������(�������ID)
);

