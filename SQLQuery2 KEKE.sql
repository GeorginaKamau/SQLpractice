Use [Keke Campus]

/*DDL COMMANDS* CREATE*/

CREATE TABLE Students1(
StudentID INT Primary key,
StudentName Char(15),
Gender CHAR(1),
DOB Date
);
INSERT INTO Students1
VALUES (5222, 'Ishmael', 'M', '07-28-1995')

update Students1 set StudentName='Joy' where StudentID=5965

SELECT * FROM Students1