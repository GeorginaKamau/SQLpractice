use university
/*DDL COMMANDS* CREATE*/
CREATE TABLE Students (

StudentID INT Primary Key,
StudentName Char(15),
Gender Char(1),
DOB Date

)

drop table Students

SELECT * FROM Students


INSERT INTO Students(

StudentID, StudentName, Gender, DOB)

VALUES(593,'YASMINE KIRI', 'F', '24-08-2000'),
(582,'MAY', 'F', '08-04-1999'),
(598,'JAYDEN', 'M', '20-03-2001'),
(599,'AIDEN', 'M', '10-06-2001'),
(590,'PRECIOUS', 'F', '26-08-2000'),
(539,'ELLEN', 'F', '18-12-2000'),
(878,'KIMBERLY', 'F', '06-10-2001'),
(596,'GINA', 'F', '25-09-2001'),
(545,'WALTER', 'M', '05-07-2000'),
(970,'COLLINS', 'M', '03-03-1999')