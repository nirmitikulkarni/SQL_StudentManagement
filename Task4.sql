Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 8.0.45 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use studentmanagement4;
Database changed
mysql> CREATE TABLE students (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(100),
    ->     gender VARCHAR(10),
    ->     age INT
    -> );
Query OK, 0 rows affected (0.05 sec)

mysql> CREATE TABLE courses (
    ->     id INT PRIMARY KEY,
    ->     name VARCHAR(100)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql> CREATE TABLE enrollments (
    ->     enrollment_id INT PRIMARY KEY,
    ->     student_id INT,
    ->     course_id INT,
    ->     semester VARCHAR(20),
    ->     grade DECIMAL(5,2),
    ->     FOREIGN KEY (student_id) REFERENCES students(id),
    ->     FOREIGN KEY (course_id) REFERENCES courses(id)
    -> );
Query OK, 0 rows affected (0.04 sec)

mysql> INSERT INTO students VALUES
    -> (1,'Nirmiti','Female',20);
Query OK, 1 row affected (0.01 sec)

mysql> INSERT INTO students VALUES
    -> (1,'Aarav','Male',20),
    -> (2,'Ananya','Female',21),
    -> (3,'Rohan','Male',19),
    -> (1,'Aarav','Male',20),;
ERROR 1064 (42000): You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near '' at line 5
mysql> INSERT INTO students VALUES
    -> (2,'Prerana','Female',20);
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO students VALUES
    -> (3, 'Shreya','Female',20);
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO students VALUES
    -> (4, 'Harsh','Male',20);
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO students VALUES
    -> (5,'Pritam','Male',20);
Query OK, 1 row affected (0.00 sec)

mysql> INSERT INTO courses VALUES
    -> (101,'Database Systems'),
    -> (102,'Data Structures'),
    -> (103,'Machine Learning');
Query OK, 3 rows affected (0.01 sec)
Records: 3  Duplicates: 0  Warnings: 0

mysql> INSERT INTO enrollments VALUES
    -> (1,1,101,'Semester 1',85),
    -> (2,1,102,'Semester 1',78),
    -> (3,2,101,'Semester 1',92),
    -> (4,2,103,'Semester 2',95),
    -> (5,3,101,'Semester 1',65),
    -> (6,3,102,'Semester 2',75),
    -> (7,4,103,'Semester 1',88),
    -> (8,4,101,'Semester 2',90),
    -> (9,5,102,'Semester 1',55),
    -> (10,5,103,'Semester 2',60);
Query OK, 10 rows affected (0.01 sec)
Records: 10  Duplicates: 0  Warnings: 0

mysql> SELECT
    ->     s.gender,
    ->     AVG(e.grade) AS avg_grade
    -> FROM students s
    -> JOIN enrollments e
    -> ON s.id = e.student_id
    -> GROUP BY s.gender;
+--------+-----------+
| gender | avg_grade |
+--------+-----------+
| Female | 81.666667 |
| Male   | 73.250000 |
+--------+-----------+
2 rows in set (0.01 sec)

mysql> SELECT
    ->     c.name AS course,
    ->     ROUND(
    ->         SUM(CASE WHEN e.grade >= 40 THEN 1 ELSE 0 END)
    ->         * 100.0 / COUNT(*),2
    ->     ) AS pass_rate
    -> FROM enrollments e
    -> JOIN courses c
    -> ON e.course_id = c.id
    -> GROUP BY c.name
    ->
    -> ;
+------------------+-----------+
| course           | pass_rate |
+------------------+-----------+
| Database Systems |    100.00 |
| Data Structures  |    100.00 |
| Machine Learning |    100.00 |
+------------------+-----------+
3 rows in set (0.01 sec)

mysql> SELECT
    ->     s.name,
    ->     AVG(e.grade) AS avg_grade
    -> FROM students s
    -> JOIN enrollments e
    -> ON s.id = e.student_id
    -> GROUP BY s.id, s.name
    -> ORDER BY avg_grade DESC
    -> LIMIT 3;
+---------+-----------+
| name    | avg_grade |
+---------+-----------+
| Prerana | 93.500000 |
| Harsh   | 89.000000 |
| Nirmiti | 81.500000 |
+---------+-----------+
3 rows in set (0.01 sec)

mysql> SELECT
    ->     s.name,
    ->     COUNT(e.course_id) AS courses_enrolled
    -> FROM students s
    -> JOIN enrollments e
    -> ON s.id = e.student_id
    -> GROUP BY s.id, s.name
    -> HAVING COUNT(e.course_id) > 1;
+---------+------------------+
| name    | courses_enrolled |
+---------+------------------+
| Nirmiti |                2 |
| Prerana |                2 |
| Shreya  |                2 |
| Harsh   |                2 |
| Pritam  |                2 |
+---------+------------------+
5 rows in set (0.00 sec)

mysql> SELECT
    ->     e1.student_id,
    ->     s.name,
    ->     e1.grade AS grade_sem1,
    ->     e2.grade AS grade_sem2
    -> FROM enrollments e1
    -> JOIN enrollments e2
    -> ON e1.student_id = e2.student_id
    -> AND e2.semester = 'Semester 2'
    -> JOIN students s
    -> ON e1.student_id = s.id
    -> WHERE e1.semester = 'Semester 1'
    -> AND e2.grade > e1.grade;
+------------+---------+------------+------------+
| student_id | name    | grade_sem1 | grade_sem2 |
+------------+---------+------------+------------+
|          2 | Prerana |      92.00 |      95.00 |
|          3 | Shreya  |      65.00 |      75.00 |
|          4 | Harsh   |      88.00 |      90.00 |
|          5 | Pritam  |      55.00 |      60.00 |
+------------+---------+------------+------------+
4 rows in set (0.00 sec)

mysql> SELECT
    ->     s.name,
    ->     AVG(e.grade) AS avg_grade
    -> FROM students s
    -> JOIN enrollments e
    -> ON s.id = e.student_id
    -> GROUP BY s.id, s.name
    -> HAVING AVG(e.grade) = (
    ->     SELECT MAX(avg_marks)
    ->     FROM (
    ->         SELECT AVG(grade) AS avg_marks
    ->         FROM enrollments
    ->         GROUP BY student_id
    ->     ) x
    -> );
+---------+-----------+
| name    | avg_grade |
+---------+-----------+
| Prerana | 93.500000 |
+---------+-----------+
1 row in set (0.00 sec)

mysql>