
--Gucian Student
--need 10
SELECt * FRom PostGradUser

INSERT INTO PostGradUser (email,password) VALUES ('zaki','00000')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'julia','ramzy','undergrade','EMS','ein shams',2.4)

INSERT INTO PostGradUser (email,password) VALUES ('mariam','mohamed')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'Rana','ali','undergrade','met','al rehab',2.0)

INSERT INTO PostGradUser (email,password) VALUES ('ramy','hany')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'omar','mohamed','undergrade','Iet','maadi',3.0)

INSERT INTO PostGradUser (email,password) VALUES ('ahmed','abdelrahman')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'Osama','Talaat','undergrade','met','ein shams',2.5)

INSERT INTO PostGradUser (email,password) VALUES ('ziad','khaled')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'youssef','amr','undergrade','met','5th settlement',3.2)

INSERT INTO PostGradUser (email,password) VALUES ('osama','nasser')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'jamila','ali','undergrade','Iet','ein shams',3.4)

INSERT INTO PostGradUser (email,password) VALUES ('omar','kamal')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'Yara','hossam','undergrade','EMS','Nasr city',2.4)

INSERT INTO PostGradUser (email,password) VALUES ('Mustafa','abuelfadl')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'marwan','fathy','undergrade','Iet','Madinaty City',2.9)

INSERT INTO PostGradUser (email,password) VALUES ('Ammar','ali')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'Amir','Younes','undergrade','met','Maadi',2.2)

INSERT INTO PostGradUser (email,password) VALUES ('reda','ahmed')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,type,faculty,address,gpa) VALUES 
(@VAriable,'amr','zaki','undergrade','Iet','Heliopolis',3.0)

--NonGucian Student
--need 10
INSERT INTO PostGradUser (email,password) VALUES ('yasmeen','salma')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'Rania','ali','grade','mecha','helwan',2.5)

INSERT INTO PostGradUser (email,password) VALUES ('Malek','ayman')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'jana','Haitham','grade','met','Nasr city',2.1)

INSERT INTO PostGradUser (email,password) VALUES ('Rana','Gamal')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'Ramy','osman','grade','Iet','Maadi',2.0)

INSERT INTO PostGradUser (email,password) VALUES ('Ebrahim','Hussein')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'Ahmed','Nasser','grade','mecha','Nasr city',3.0)

INSERT INTO PostGradUser (email,password) VALUES ('ali','ashraf')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'Nour','Elmasry','grade','met','helwan',2.9)

INSERT INTO PostGradUser (email,password) VALUES ('Islam','youssef')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'ayman','amir','grade','mecha','Madinaty city',2.1)

INSERT INTO PostGradUser (email,password) VALUES ('amr','marwan')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'ramy','ashour','grade','mecha','al rehab city',2.3)

INSERT INTO PostGradUser (email,password) VALUES ('Ziad','omar')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'hazem','yaseen','grade','Iet','Heliopolis',3.5)

INSERT INTO PostGradUser (email,password) VALUES ('Mazen','Mohamed')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'Mohannad','sameh','grade','mecha','Maadi',2.0)

INSERT INTO PostGradUser (email,password) VALUES ('Akram','kareem')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastname,type,faculty,address,gpa) VALUES 
(@VAriable,'Nariman','Hussein','grade','met','al rehab city',2.5)

--SuperVisors
--need 10
INSERT INTO PostGradUser (email,password) VALUES ('Malak','ss10')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'zaky','Hanafy','Iet')


INSERT INTO PostGradUser (email,password) VALUES ('sshh','878')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'zaky','islam','met')


INSERT INTO PostGradUser (email,password) VALUES ('sfssd','ss10')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'ali','Hanafy','Mecha')



INSERT INTO PostGradUser (email,password) VALUES ('rrrd','21y7')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'ali','eslam','iet')



INSERT INTO PostGradUser (email,password) VALUES ('habsbx','21y7')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'ali','salem','met')



INSERT INTO PostGradUser (email,password) VALUES ('ushiaxn','892us')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'ahmed','salem','mecha')


INSERT INTO PostGradUser (email,password) VALUES ('hsahxb','892us')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'hamed','salem','met')


INSERT INTO PostGradUser (email,password) VALUES ('yuwqs','1b2shh')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'hamed','ali','business')



INSERT INTO PostGradUser (email,password) VALUES ('shxh','uhsn')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'rola','ali','Pharmacy')



INSERT INTO PostGradUser (email,password) VALUES ('utqwu','7h3s')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'salma','ahmed','BI')



INSERT INTO PostGradUser (email,password) VALUES ('hsbs','7hde')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,'yara','ahmed','met')


--Thesis
-- need 30
INSERT INTO THESIS 
(field,type,title,startdate,enddate,defensedate,grade,noExtension,paymentID) 
VALUES
('Electro Magnatics','Master','magnetic Field','10-10-2020','10-10-2021','3-3-2004',40.4,7,1),
('Magnatics','Phd','elcrictic Field','6-12-2019','4-3-2021','6-7-2004',30.4,9,2),
('fluids','Master','pascal rule','7-9-1999','6-10-2022','5-3-2001',80.4,5,3),
('mechanics','PHD','forces','12-6-1990','4-10-1994','7-8-1992',19.5,6,4),
('Thermodynamics','Master','Engines','12-10-2015','7-10-2022','6-4-2007',60.7,4,5),

('Electro Magnatics','PHD','magnetic Field','10-10-2000','10-10-2004','3-3-2004',50,7,6),
('Magnatics','Master','elcrictic Field','6-12-2001','4-3-2005','6-7-2004',60,9,7),
('fluids','PHD','pascal rule','7-9-1999','6-10-2002','5-3-2001',90.4,5,8),
('mechanics','Master','forces','12-6-1990','4-10-1994','7-8-1992',30.5,6,9),
('Thermodynamics','PHD','Engines','12-10-2005','7-10-2008','6-4-2007',80.7,4,10),

('Electro Magnatics','PHD','magnetic Field','10-10-2000','10-10-2004','3-3-2004',70.4,7,11),
('Magnatics','Master','elcrictic Field','6-12-2001','4-3-2005','6-7-2004',50,9,12),
('fluids','PHD','pascal rule','7-9-1999','6-10-2002','5-3-2001',90.4,5,13),
('mechanics','Master','forces','12-6-1990','4-10-1994','7-8-1992',40.5,6,14),
('Thermodynamics','PHD','Engines','12-10-2005','7-10-2008','6-4-2007',90.7,4,15),

('Electro Magnatics','Master','magnetic Field','10-10-2000','10-10-2004','3-3-2004',30.4,7,16),
('Magnatics','Phd','elcrictic Field','6-12-2001','4-3-2005','6-7-2004',40.4,9,17),
('fluids','Master','pascal rule','7-9-1999','6-10-2002','5-3-2001',50.4,5,18),
('mechanics','PHD','forces','12-6-1990','4-10-1994','7-8-1992',20.5,6,19),
('Thermodynamics','Master','Engines','12-10-2005','7-10-2008','6-4-2007',40.7,4,20),

('Electro Magnatics','PHD','magnetic Field','10-10-2000','10-10-2004','3-3-2004',55.4,7,21),
('Magnatics','Master','elcrictic Field','6-12-2001','4-3-2005','6-7-2004',67.4,9,22),
('fluids','PHD','pascal rule','7-9-1999','6-10-2002','5-3-2001',95.4,5,23),
('mechanics','Master','forces','12-6-1990','4-10-1994','7-8-1992',70.5,6,24),
('Thermodynamics','PHD','Engines','12-10-2005','7-10-2008','6-4-2007',60.7,4,25),

('Electro Magnatics','Master','magnetic Field','10-10-2000','10-10-2004','3-3-2004',20.4,7,26),
('Magnatics','Phd','elcrictic Field','6-12-2001','4-3-2005','6-7-2004',70.4,9,27),
('fluids','Master','pascal rule','7-9-1999','6-10-2002','5-3-2001',55.4,5,28),
('mechanics','PHD','forces','12-6-1990','4-10-1994','7-8-1992',90.5,6,29),
('Thermodynamics','Master','Engines','12-10-2005','7-10-2008','6-4-2007',30.7,4,30)


--Gucian Progress Report
Insert Into GUCianProgressReport(sid,stateReport,progressReportDate,evaluation,ThesisSerialNo,descriptionReport,supid) Values
(1,2,'4-4-2000',3,1,'gamed',21),
(2,4,'5-6-2001',5,2,'gamed',22),
(3,3,'5-12-2000',1,3,'gamed',23),
(4,5,'12-4-2001',2,4,'gamed',24),
(5,6,'10-11-2001',3,5,'gamed',25)
--NonGucian Progress Report
Insert Into NonGUCianProgressReport(sid,stateReport,progressReportDate,evaluation,ThesisSerialNo,descriptionReport,supid) Values
(11,2,'4-4-2000',3,6,'gamed',26),
(12,4,'8-1-2001',1,7,'gamed',27),
(13,5,'1-8-2000',5,8,'gamed',28),
(14,7,'4-5-2000',2,9,'gamed',29),
(15,6,'4-4-2001',3,10,'gamed',30)


--Payments
insert into payment(amount,no_Installments,fundPercentage) VAlues
(6.3,2,1.2),(22,32,2),(12,74,2.6),
(7.3,3,2.8),(20.12,12,32),(3.6,4,1.6),
(8.3,5,3.5),(21,3,9.5),(3.3,6,4.7),
(9.3,4,1.8),(21.3,5,3.6),(22,2,4),
(10.3,1,2.9),(33.2,4,2.5),(20.3,2,2.5),
(20.3,2,2.5),(23,2,6.5),(20.3,2,2.5),
(5,2,2.5),(21,22,3),(22,5,6),
(7.9,3,5),(25,7,1),(21,3,4),
(10.3,8,4.3),(12,3,2.6),(23,6,2.5),
(12,3,6),(16,3,7),(29,1,5)


--Installments
Insert into installments(date,paymentID,amount,status) Values
('3-3-2003',1,3,'True'),
('5-8-2003',2,4,'True'),
('10-9-2003',3,4,'True'),
('12-12-2003',4,5,'False'),
('1-8-2003',5,2,'True'),
('12-1-2003',6,5,'False')


--Courses
INsert Into Course(courseCode,creditHrs,fees) VAlues
('332',5,2000),
('445',4,3000),
('765',3,1000),
('282',2,500),
('428',1,100),
('999',1.5,100)

--Defenses
INSERT INTO DEfense(ThesisSerialNo,DefenseDate,DefenseLocation,grade) Values
(1,'3-4-2015','maadi',1.2),
(2,'5-7-2015','madinaty',1.5),
(3,'12-4-2015','Nasr city',2.5),
(4,'7-7-2015','helwan',2.7),
(5,'5-11-2015','Heliopolis',3.5),
(6,'10-2-2015','maadi',3.7)

--repeat this 5 with changinging between brackets

INSERT INTO PostGradUser (email,password) VALUES ('sami','1223nn')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO examinar (id,ExaminerName,nationality,fieldOfWork) VALUES 
(@VAriable,'Ali','True','business')

INSERT INTO PostGradUser (email,password) VALUES ('dd','321m')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO examinar (id,ExaminerName,nationality,fieldOfWork) VALUES 
(@VAriable,'Ahmed','True','engineering')



INSERT INTO PostGradUser (email,password) VALUES ('ksak','12535')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO examinar (id,ExaminerName,nationality,fieldOfWork) VALUES 
(@VAriable,'Rana','True','Pharmacy')


INSERT INTO PostGradUser (email,password) VALUES ('jkjk','3178')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO examinar (id,ExaminerName,nationality,fieldOfWork) VALUES 
(@VAriable,'Alaa','True','business')



INSERT INTO PostGradUser (email,password) VALUES ('qwijej','12gfhg')
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO examinar (id,ExaminerName,nationality,fieldOfWork) VALUES 
(@VAriable,'Wael','True','engineering')

--Gucian Register Thesis
INsert INto GucianStudentRegisterThesis(sid,serial_no,supid) Values (1,1,21),(2,2,22),(3,3,23),(4,4,24),(5,5,25)

--Non Gucain Register Thesis
INsert INto NonGucianStudentRegisterThesis(sid,serial_no,supid) Values (11,6,26),(12,7,27),(13,8,28),(14,9,29),(15,10,30)

--NonGucian Take Course
INSERT INTO NonGucianStudentTakeCourse(sid,cid,grade) Values (11,1,40),(12,2,60),(13,3,80),(14,4,90),(15,5,20)  

SELECT * FROM NonGucianStudentTakeCourse



--Publications
INsert INto Publication(title, pubDate , host , place , accepted) Values 
('facebook','12-5-2020','maadi','wadidegla','True'),
('poor','10-8-2022','mokattam','nasr','False'),
('rich','7-7-2021','nojom','newCairo','True'),
('homeless','10-8-2019','Egypt','Cairo','True'),
('teaching','6-5-2018','US','Kentaki','False')


--THesis has Publication

INSERT INTO ThesisHasPublication(serialNo,pubid) Values
(1,1),(2,2),(3,3),(4,4),(5,5)


--Examiner Evaluate Defense
INsert INto ExaminerEvaluateDefense (Evaluatedate,serial_no,examinarID)
Values ('3-4-2015',1,32),('5-7-2015',2,33),('12-4-2015',3,34)

--Non Gucian Pay for Course

INSERT INTO NonGucianStudentPayForCourse(sid,paymentNo,cid)
Values
(11,1,1),(12,2,2),(13,3,3)
