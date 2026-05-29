Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 12
Server version: 8.0.45 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database StudentManagement;
Query OK, 1 row affected (0.01 sec)

mysql> use StudentManagement;
Database changed
mysql> CREATE TABLE Students (
    ->     StudentID INT AUTO_INCREMENT PRIMARY KEY,
    ->     Name VARCHAR(50),
    ->     Gender VARCHAR(10),
    ->     Age INT,
    ->     Grade VARCHAR(10),
    ->     MathScore INT,
    ->     ScienceScore INT,
    ->     EnglishScore INT
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> INSERT INTO Students
    -> (Name, Gender, Age, Grade, MathScore, ScienceScore, EnglishScore)
    -> VALUES
    -> ('Rahul', 'Male', 20, 'A', 85, 78, 90),
    -> ('Sneha', 'Female', 21, 'A', 92, 88, 95),
    -> ('Amit', 'Male', 19, 'B', 70, 75, 68),
    -> ('Priya', 'Female', 22, 'A', 89, 91, 87),
    -> ('Rohan', 'Male', 20, 'C', 60, 65, 58),
    -> ('Anjali', 'Female', 21, 'B', 76, 80, 72),
    -> ('Karan', 'Male', 23, 'B', 81, 79, 84),
    -> ('Neha', 'Female', 20, 'A', 95, 93, 97),
    -> ('Vikram', 'Male', 22, 'C', 55, 61, 59),
    -> ('Pooja', 'Female', 19, 'B', 74, 77, 73);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT * FROM Students;
+-----------+--------+--------+------+-------+-----------+--------------+--------------+
| StudentID | Name   | Gender | Age  | Grade | MathScore | ScienceScore | EnglishScore |
+-----------+--------+--------+------+-------+-----------+--------------+--------------+
|         1 | Rahul  | Male   |   20 | A     |        85 |           78 |           90 |
|         2 | Sneha  | Female |   21 | A     |        92 |           88 |           95 |
|         3 | Amit   | Male   |   19 | B     |        70 |           75 |           68 |
|         4 | Priya  | Female |   22 | A     |        89 |           91 |           87 |
|         5 | Rohan  | Male   |   20 | C     |        60 |           65 |           58 |
|         6 | Anjali | Female |   21 | B     |        76 |           80 |           72 |
|         7 | Karan  | Male   |   23 | B     |        81 |           79 |           84 |
|         8 | Neha   | Female |   20 | A     |        95 |           93 |           97 |
|         9 | Vikram | Male   |   22 | C     |        55 |           61 |           59 |
|        10 | Pooja  | Female |   19 | B     |        74 |           77 |           73 |
+-----------+--------+--------+------+-------+-----------+--------------+--------------+
10 rows in set (0.01 sec)

mysql> SELECT * FROM Students
    -> WHERE Grade = 'A';
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
| StudentID | Name  | Gender | Age  | Grade | MathScore | ScienceScore | EnglishScore |
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
|         1 | Rahul | Male   |   20 | A     |        85 |           78 |           90 |
|         2 | Sneha | Female |   21 | A     |        92 |           88 |           95 |
|         4 | Priya | Female |   22 | A     |        89 |           91 |           87 |
|         8 | Neha  | Female |   20 | A     |        95 |           93 |           97 |
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
4 rows in set (0.01 sec)

mysql> SELECT * FROM Students
    -> WHERE MathScore > 80;
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
| StudentID | Name  | Gender | Age  | Grade | MathScore | ScienceScore | EnglishScore |
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
|         1 | Rahul | Male   |   20 | A     |        85 |           78 |           90 |
|         2 | Sneha | Female |   21 | A     |        92 |           88 |           95 |
|         4 | Priya | Female |   22 | A     |        89 |           91 |           87 |
|         7 | Karan | Male   |   23 | B     |        81 |           79 |           84 |
|         8 | Neha  | Female |   20 | A     |        95 |           93 |           97 |
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
5 rows in set (0.00 sec)

mysql> SELECT AVG(MathScore) AS AverageMathScore
    -> FROM Students;
+------------------+
| AverageMathScore |
+------------------+
|          77.7000 |
+------------------+
1 row in set (0.01 sec)

mysql> SELECT AVG(EnglishScore) AS AverageEnglishScore FROM Students;
+---------------------+
| AverageEnglishScore |
+---------------------+
|             78.3000 |
+---------------------+
1 row in set (0.00 sec)

mysql> SELECT AVG(ScienceScore) AS AverageScienceScore FROM Students;
+---------------------+
| AverageScienceScore |
+---------------------+
|             78.7000 |
+---------------------+
1 row in set (0.00 sec)

mysql> SELECT Name,
    ->        (MathScore + ScienceScore + EnglishScore) AS TotalScore
    -> FROM Students
    -> ORDER BY TotalScore DESC
    -> LIMIT 1;
+------+------------+
| Name | TotalScore |
+------+------------+
| Neha |        285 |
+------+------------+
1 row in set (0.00 sec)

mysql> SELECT Grade,
    ->        COUNT(*) AS TotalStudents
    -> FROM Students
    -> GROUP BY Grade;
+-------+---------------+
| Grade | TotalStudents |
+-------+---------------+
| A     |             4 |
| B     |             4 |
| C     |             2 |
+-------+---------------+
3 rows in set (0.01 sec)

mysql> SELECT Gender,
    ->        AVG(MathScore + ScienceScore + EnglishScore) AS AverageTotalScore
    -> FROM Students
    -> GROUP BY Gender;
+--------+-------------------+
| Gender | AverageTotalScore |
+--------+-------------------+
| Male   |          213.6000 |
| Female |          255.8000 |
+--------+-------------------+
2 rows in set (0.00 sec)

mysql> UPDATE Students
    -> SET Grade = 'A+'
    -> WHERE Name = ' Neha ' ;
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql> SELECT * FROM Students
    -> WHERE Name = 'Neha';
+-----------+------+--------+------+-------+-----------+--------------+--------------+
| StudentID | Name | Gender | Age  | Grade | MathScore | ScienceScore | EnglishScore |
+-----------+------+--------+------+-------+-----------+--------------+--------------+
|         8 | Neha | Female |   20 | A     |        95 |           93 |           97 |
+-----------+------+--------+------+-------+-----------+--------------+--------------+
1 row in set (0.00 sec)

mysql> UPDATE Students
    -> SET Grade = 'A+'
    -> WHERE Name = 'Rahul';
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql> SELECT * FROM Students
    -> WHERE Name = 'Rahul';
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
| StudentID | Name  | Gender | Age  | Grade | MathScore | ScienceScore | EnglishScore |
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
|         1 | Rahul | Male   |   20 | A+    |        85 |           78 |           90 |
+-----------+-------+--------+------+-------+-----------+--------------+--------------+
1 row in set (0.00 sec)

mysql>
