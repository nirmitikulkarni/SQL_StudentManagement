Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 9
Server version: 8.0.45 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> create database studentmanagement3;
Query OK, 1 row affected (0.03 sec)

mysql> use studentmanagement3;
Database changed
mysql> CREATE TABLE Students (
    ->     student_id INT PRIMARY KEY,
    ->     student_name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.07 sec)

mysql> CREATE TABLE Courses (
    ->     course_id INT PRIMARY KEY,
    ->     course_name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE Enrollments (
    ->     enrollment_id INT PRIMARY KEY,
    ->     student_id INT,
    ->     course_id INT,
    ->     grade INT,
    ->     FOREIGN KEY (student_id) REFERENCES Students(student_id),
    ->     FOREIGN KEY (course_id) REFERENCES Courses(course_id)
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> INSERT INTO Students VALUES (1, 'Nirmiti');
Query OK, 1 row affected (0.02 sec)

mysql> INSERT INTO Students VALUES (2, 'Shreya');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Students VALUES (3, 'Manasa');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO Students VALUES (4, 'Kashish');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO Students VALUES (5, 'Harsh');
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO Students VALUES (6, 'Pritam');
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO Courses VALUES
    -> (101, 'SQL'),
    -> (102, 'Python'),
    -> (103, 'Data Analytics');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO Enrollments VALUES
    -> (1, 1, 101, 85),
    -> (2, 1, 102, 78),
    -> (3, 2, 101, 92),
    -> (4, 2, 103, 88),
    -> (5, 3, 101, 35),
    -> (6, 3, 102, 45),
    -> (7, 4, 102, 95),
    -> (8, 4, 103, 89),
    -> (9, 5, 101, 60),
    -> (10, 5, 103, 70);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT c.course_name,
    ->        s.student_name,
    ->        e.grade
    -> FROM Enrollments e
    -> JOIN Students s ON e.student_id = s.student_id
    -> JOIN Courses c ON e.course_id = c.course_id
    -> WHERE (e.course_id, e.grade) IN (
    ->     SELECT course_id, MAX(grade)
    ->     FROM Enrollments
    ->     GROUP BY course_id
    -> );
+----------------+--------------+-------+
| course_name    | student_name | grade |
+----------------+--------------+-------+
| SQL            | Shreya       |    92 |
| Python         | Kashish      |    95 |
| Data Analytics | Kashish      |    89 |
+----------------+--------------+-------+
3 rows in set (0.02 sec)

mysql> SELECT c.course_name,
    ->        ROUND(
    ->            SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END) * 100.0
    ->            / COUNT(*), 2
    ->        ) AS pass_rate_percentage
    -> FROM Enrollments e
    -> JOIN Courses c ON e.course_id = c.course_id
    -> GROUP BY c.course_name;
+----------------+----------------------+
| course_name    | pass_rate_percentage |
+----------------+----------------------+
| SQL            |                75.00 |
| Python         |               100.00 |
| Data Analytics |               100.00 |
+----------------+----------------------+
3 rows in set (0.01 sec)

mysql> SELECT s.student_name,
    ->        AVG(e.grade) AS average_grade
    -> FROM Students s
    -> JOIN Enrollments e ON s.student_id = e.student_id
    -> GROUP BY s.student_id, s.student_name
    -> ORDER BY average_grade DESC
    -> LIMIT 1;
+--------------+---------------+
| student_name | average_grade |
+--------------+---------------+
| Kashish      |       92.0000 |
+--------------+---------------+
1 row in set (0.00 sec)

mysql> SELECT s.student_name,
    ->        COUNT(e.course_id) AS total_courses
    -> FROM Students s
    -> JOIN Enrollments e ON s.student_id = e.student_id
    -> GROUP BY s.student_id, s.student_name
    -> HAVING COUNT(e.course_id) > 1;
+--------------+---------------+
| student_name | total_courses |
+--------------+---------------+
| Nirmiti      |             2 |
| Shreya       |             2 |
| Manasa       |             2 |
| Kashish      |             2 |
| Harsh        |             2 |
+--------------+---------------+
5 rows in set (0.00 sec)

mysql> select * from student;
ERROR 1146 (42S02): Table 'studentmanagement3.student' doesn't exist
mysql> select * from students;
+------------+--------------+
| student_id | student_name |
+------------+--------------+
|          1 | Nirmiti      |
|          2 | Shreya       |
|          3 | Manasa       |
|          4 | Kashish      |
|          5 | Harsh        |
|          6 | Pritam       |
+------------+--------------+
6 rows in set (0.00 sec)

mysql>