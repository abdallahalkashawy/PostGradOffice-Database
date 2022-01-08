
CREATE Table PostGradUser( 
    id int primary key identity,
    email varchar(50),
    password varchar(20))


CREATE Table Admin(
    id int primary key ,
    FOREIGN KEY (id) REFERENCES PostGradUser(id) ON DELETE CASCADE ON UPDATE CASCADE)


CREATE TABLE GucianStudent( 
    id int PRIMARY KEY ,
    Foreign KEY (id) REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    firstName varchar(10), 
    lastName varchar(10),  
    type varchar(10),
    faculty varchar(10) ,
    address varchar(50),
    GPA Decimal(9,2),
    undergradID varchar(10)
   )

CREATE TABLE NonGucianStudent( 
    id int PRIMARY KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    firstName varchar(10), 
    lastName varchar(10), 
    type varchar(10),
    faculty varchar(50) ,
    address varchar(50),
    GPA DECIMAL(9,2)
    )


CREATE Table GUCStudentPhoneNumber(
    id int,
    phone varchar(20),
    Primary key(id,phone),
    FOREIGN KEY (id) REFERENCES GUCianStudent ON DELETE CASCADE ON UPDATE CASCADE)


CREATE Table NonGUCStudentPhoneNumber(
    id int,
    phone varchar(20),
    Primary key(id,phone),
    FOREIGN KEY (id) REFERENCES NonGUCianStudent  ON DELETE CASCADE ON UPDATE CASCADE)

CReate Table Course (
    courseID int PRIMARY KEY IDENTITY,
    courseCode varchar(10),
    creditHrs int,
    fees decimal)



CREATE Table SuperVisor(
    id int PRIMARY KEY REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    first_name varchar(20),
    last_name varchar(20),
    faculty varchar(20))

CREATE Table Payment(
 id int PRIMARY KEY IDENTITY,
 amount decimal,
 no_Installments int,
 fundPercentage Decimal)


CREATE TABLE Examinar(
    id int primary key REFERENCES PostGradUser ON DELETE CASCADE ON UPDATE CASCADE,
    ExaminerName varchar(20),
    nationality bit,
    fieldOfWork varchar(20))


Create Table installments(
 date datetime,
 paymentID int,
 amount int,
 status BIT,
 PRIMARY KEY(date,paymentID),
 Foreign Key (paymentID) REFERENCES Payment(id) ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE NonGucianStudentPayForCourse(
     sid int,
     paymentNO int,
     cid int,
     Primary key (sid,paymentNO,cid),
     FOREIGN KEY (sid) REFeRENCES NonGucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (paymentNO) REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
     FOREIGN KEY (cid) REFERENCES Course ON DELETE CASCADE ON UPDATE CASCADE)


create TABLE NonGucianStudentTakeCourse (
    sid int , 
    cid int, 
    grade Decimal,
    PRIMARY KEY (sid,cid),
    FOREIGN KEY (sid) REFERENCES NonGucianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (cid) REFERENCES Course ON DELETE CASCADE ON UPDATE CASCADE)


CREATE TABLE Thesis(
   serialNumber int PRIMARY KEY IDENTITY,
   field varchar(20),
   type varchar(20),
   title varchar(20),
   startDate Datetime,
   endDate Datetime,
   defenseDate Datetime,
   grade Decimal,
   paymentId int ,
   Foreign KEy (paymentId)REFERENCES Payment ON DELETE CASCADE ON UPDATE CASCADE,
   years AS (YEAR(endDate) - YEAR(startDate)),
   noExtension int)



CREATE TABLE Defense(
      ThesisSerialNo int REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE, 
      DefenseDate Datetime , 
      DefenseLocation varchar(15),
      grade decimal,
      comments varchar(300),
      PRIMARY KEY (ThesisSerialNo,DefenseDate))


CREATE Table Publication(
   id int primary key identity,
   title varchar(50), 
   pubDate datetime, 
   host varchar(50), 
   place varchar(50), 
   accepted bit)


CREATE Table GUCianProgressReport(
    sid int ,
    progressReportNo int IDENTITY,
    Primary key(sid,progressReportNo),
    progressReportDate datetime,
    evaluation int,
    stateReport int,
    descriptionReport varchar(200),
    ThesisSerialNo int ,
    Foreign Key (ThesisSerialNo) REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    supid int,
    Foreign key (supid) REFERENCES SuperVisor ON DELETE CASCADE ON UPDATE CASCADE,
    Foreign key (sid) REFERENCES GUCianStudent )


CREATE Table NonGUCianProgressReport(
    sid int,
    progressReportNo int IDENTITY,
    Primary key(sid,progressReportNo),
    progressReportDate datetime,
    evaluation int,
    stateReport int,
    descriptionReport varchar(200),
    ThesisSerialNo int,
    supid int,
    FOReign key (sid) REFERENCES NonGUCianStudent ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (supid)  REFERENCES SuperVisor,
    FOREIGN KEY (ThesisSerialNo) REFERENCES THESis ON DELETE CASCADE ON UPDATE CASCADE)


CREATE Table GucianStudentRegisterThesis(
    sid int ,
    supid int ,
    serial_no int ,
    Primary Key(sid,supid,serial_no),
    FOREIGN KEY (sid) REFERENCES GucianStudent ,
    FOREIGN KEY (supid) REFERENCES SuperVisor ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (serial_no) REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE)


CREATE Table NonGucianStudentRegisterThesis(
    sid int ,
    supid int ,
    serial_no int ,
    Primary Key(sid,supid,serial_no),
    FOREIGN KEY (sid) REFERENCES NonGucianStudent ,
    FOREIGN KEY (supid) REFERENCES SuperVisor ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (serial_no) REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE ExaminerEvaluateDefense(
    Evaluatedate Datetime,
    serial_no int ,
    examinarID int ,
    PRIMARY KEY(EvaluateDate,examinarID,serial_no),
    FOREIGN KEY (serial_no,EvaluateDate) REFERENCES Defense(ThesisSerialNo,DefenseDate) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (examinarID) REFERENCES Examinar ON DELETE CASCADE ON UPDATE CASCADE)

CREATE TABLE ThesisHasPublication(
    serialNo int,
    pubid int,
    Primary key(serialNo,pubid),
    FOREIGN KEY (serialNo) REFERENCES Thesis ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (pubid) REFERENCES Publication ON DELETE CASCADE ON UPDATE CASCADE)
