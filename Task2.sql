Enter password: *******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 18
Server version: 8.0.45 MySQL Community Server - GPL

Copyright (c) 2000, 2026, Oracle and/or its affiliates.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> use StudentDB;
Database changed
mysql> select * from students;
+----+-------+------+--------+-----------+
| id | name  | age  | gender | city      |
+----+-------+------+--------+-----------+
|  1 | Rahul |   20 | Male   | Mumbai    |
|  2 | Priya |   21 | Female | Pune      |
|  3 | Amit  |   19 | Male   | Delhi     |
|  4 | Sneha |   22 | Female | Bangalore |
|  5 | Karan |   20 | Male   | Chennai   |
+----+-------+------+--------+-----------+
5 rows in set (0.03 sec)

mysql> SELECT
    ->     s.id,
    ->     s.name AS Student_Name,
    ->     c.name AS Course_Name,
    ->     e.grade
    -> FROM students s
    -> JOIN enrollments e
    -> ON s.id = e.student_id
    -> JOIN courses c
    -> ON c.id = e.course_id
    -> ORDER BY c.name;
+----+--------------+----------------+-------+
| id | Student_Name | Course_Name    | grade |
+----+--------------+----------------+-------+
|  2 | Priya        | Data Analytics |    88 |
|  3 | Amit         | Data Analytics |    45 |
|  5 | Karan        | Data Analytics |    30 |
|  1 | Rahul        | Python         |    78 |
|  3 | Amit         | Python         |    35 |
|  4 | Sneha        | Python         |    89 |
|  1 | Rahul        | SQL            |    85 |
|  2 | Priya        | SQL            |    92 |
|  4 | Sneha        | SQL            |    95 |
+----+--------------+----------------+-------+
9 rows in set (0.01 sec)

mysql> SELECT
    ->     c.name AS Course_Name,
    ->     AVG(e.grade) AS Average_Grade
    -> FROM courses c
    -> JOIN enrollments e
    -> ON c.id = e.course_id
    -> GROUP BY c.name;
+----------------+---------------+
| Course_Name    | Average_Grade |
+----------------+---------------+
| SQL            |       90.6667 |
| Python         |       67.3333 |
| Data Analytics |       54.3333 |
+----------------+---------------+
3 rows in set (0.01 sec)

mysql> SELECT
    ->     s.id,
    ->     s.name,
    ->     AVG(e.grade) AS Average_Grade
    -> FROM students s
    -> JOIN enrollments e
    -> ON s.id = e.student_id
    -> GROUP BY s.id, s.name
    -> ORDER BY Average_Grade DESC
    -> LIMIT 3;
+----+-------+---------------+
| id | name  | Average_Grade |
+----+-------+---------------+
|  4 | Sneha |       92.0000 |
|  2 | Priya |       90.0000 |
|  1 | Rahul |       81.5000 |
+----+-------+---------------+
3 rows in set (0.00 sec)

mysql> SELECT
    ->     COUNT(*) AS Failed_Students
    -> FROM enrollments
    -> WHERE grade < 40;
+-----------------+
| Failed_Students |
+-----------------+
|               2 |
+-----------------+
1 row in set (0.00 sec)

mysql> SELECT
    ->     c.name AS Course_Name,
    ->     MAX(e.grade) AS Highest_Grade
    -> FROM courses c
    -> JOIN enrollments e
    -> ON c.id = e.course_id
    -> GROUP BY c.name;
+----------------+---------------+
| Course_Name    | Highest_Grade |
+----------------+---------------+
| SQL            |            95 |
| Python         |            89 |
| Data Analytics |            88 |
+----------------+---------------+
3 rows in set (0.00 sec)

mysql>
mysql> SELECT
    ->     c.name AS Course_Name,
    ->     MIN(e.grade) AS Lowest_Grade
    -> FROM courses c
    -> JOIN enrollments e
    -> ON c.id = e.course_id
    -> GROUP BY c.name;
+----------------+--------------+
| Course_Name    | Lowest_Grade |
+----------------+--------------+
| SQL            |           85 |
| Python         |           35 |
| Data Analytics |           30 |
+----------------+--------------+
3 rows in set (0.00 sec)

mysql> SELECT
    ->     c.name AS Course_Name,
    ->     COUNT(e.student_id) AS Total_Students
    -> FROM courses c
    -> LEFT JOIN enrollments e
    -> ON c.id = e.course_id
    -> GROUP BY c.name;
+----------------+----------------+
| Course_Name    | Total_Students |
+----------------+----------------+
| SQL            |              3 |
| Python         |              3 |
| Data Analytics |              3 |
+----------------+----------------+
3 rows in set (0.00 sec)

mysql>