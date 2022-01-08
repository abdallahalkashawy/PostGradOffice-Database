--1a)Register to the website by using my name (First and last name), password, faculty, email, and
--address.
GO
CREATE PROC StudentRegister @first_name varchar(20), @last_name varchar(20), @password varchar(20), @faculty varchar(20),
@Gucian bit, @email varchar(50), @address varchar(50)
AS
DECLARE @VAriable int
IF(@Gucian = 'True')
BEGIN
INSERT INTO PostGradUser (email,password) VALUES (@email,@password)
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO GucianStudent (id,firstName,lastName,faculty,address) VALUES 
(@VAriable,@first_name,@last_name,@faculty,@address)
END
ELSE
BEGIN
INSERT INTO PostGradUser (email,password) VALUES (@email,@password)
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO NonGucianStudent (id,firstName,lastName,faculty,address) VALUES 
(@VAriable,@first_name,@last_name,@faculty,@address)
END




--1a) 2
GO
CREATE PROC SupervisorRegister @first_name varchar(20), @last_name varchar(20), @password varchar(20), @faculty varchar(20),
@email varchar(50)
AS
INSERT INTO PostGradUser (email,password) VALUES (@email,@password)
DECLARE @VAriable int
Set @VAriable = SCOPE_IDENTITY();
INSERT INTO superVisor (id,first_name,last_name,faculty) VALUES 
(@VAriable,@first_name,@last_name,@faculty)






--2a) login using my username and password.
GO;
CREATE PROC userLogin @ID int, @password varchar(20) ,@Success bit OUTPUT
AS
IF (EXISTS (SELECT * FROM PostGradUser Where id=@ID  AND password=@Password))
SET @Success ='True'
ELSE
SET @Success ='False'


--2b) add my mobile number(s).
GO;
CREATE PROC addMobile @ID int, @mobile_number varchar(20)
AS 
IF(EXISTS (SELECT * FROM GucianStudent WHERE id=@ID))
BEGIN
INSERT INTO GUCStudentPhoneNumber(id, phone) Values(@ID, @mobile_number)
END
ELSE IF(EXISTS (SELECT * FROM NonGucianStudent WHERE id=@ID))
BEGIN
INSERT INTO NonGUCStudentPhoneNumber(id, phone) Values(@ID, @mobile_number)
END

GO
--3a) List all supervisors in the system.
CREATE PROC AdminListSup
AS
SELECT * FROM SuperVisor

GO;

--3b) view the profile of any supervisor that contains all his/her information.



CREATE PROC AdminViewSupervisorProfile @supId int
AS
SELECT * 
FROM PostGradUser P Inner Join supervisor S ON(P.id=s.id) 
where S.id=@supId


--3c) List all Theses in the system.
GO
CREATE PROC AdminViewAllTheses
AS 
SELECT * FROM THesis




--3d List the number of on going theses.
GO
Create Proc AdminViewOnGoingTheses @thesesCount int OUTPUT
AS 
SELECt @thesesCount=Count(*)
FRom Thesis 
WHERE (CURRENT_TIMESTAMP BETWEEn startdate and enddate)

delete From THesis
SELECt * FROM Thesis
DECLARE @T INT
EXEC AdminViewOnGoingTheses @T OUTPUT
PRINT @T

--3e List all supervisors’ names currently supervising students, theses title, student name.
GO
create PROC AdminViewStudentThesisBySupervisor
AS
select S.first_name, S.last_Name ,T.title,(G.firstname +' '+G.lastName) AS studentName
FROM SuperVisor S,GucianStudentRegisterThesis GS,THesis T , GucianStudent G
WHERE S.id =GS.supid AND T.serialNumber =GS.serial_no AND G.id=GS.sid
UNION
select S.first_name, S.last_Name ,T.title,(G.firstname +' '+G.lastName) AS studentName
FROM SuperVisor S,NonGucianStudentRegisterThesis GS,THesis T , NonGucianStudent G
WHERE S.id =GS.supid AND T.serialNumber =GS.serial_no AND G.id=GS.sid
--3f List nonGucians names, course code, and respective grade.
GO
Create PROC AdminListNonGucianCourse @courseID int
AS
select s.firstName, s.lastName ,c.courseCode ,sc.grade
from NonGucianStudent s, NonGucianStudentTakeCourse sc,Course C
where s.id=SC.sid AND sc.cid = C.courseID AND c.courseID =@courseID

--3
-- g) Update the number of thesis extension by 1. ----->>>
GO
CREATE proc AdminUpdateExtension
@ThesisSerialNo int
as
    BEGIN
        if exists (select * from Thesis where serialNumber=@ThesisSerialNo)
            BEGIN
                if Exists (select * from Thesis where serialNumber=@ThesisSerialNo AND NoExtension IS NULL )
                    BEGIN
                        update Thesis set noExtension=1 where serialNumber=@ThesisSerialNo;
                    END
                ELSE
                    update Thesis set noExtension=noExtension+1 where serialNumber=@ThesisSerialNo;
            end
        else
            print 'thesis is Not found';
    end

go;



-- h) Issue a thesis payment. -------->>>>>>
create proc AdminIssueThesisPayment
@ThesisSerialNo int, @amount decimal, @noOfInstallments int, @fundPercentage decimal,
@Success bit output

AS
    BEGIN
        if exists (select * from Thesis where serialNumber=@ThesisSerialNo) --checking if there is thesis or not 
            BEGIN
                insert into Payment (amount, no_Installments, fundPercentage)
                values (@amount, @noOfInstallments, @fundPercentage);
                declare @pid INT;
                Set @pid = SCOPE_IDENTITY();
                UPDATE Thesis SET paymentID=@pid where serialNumber=@ThesisSerialNo;
                set @Success =  'True'
            end
        else
              set @Success =  'False'
    end

SELECt * FROm THesis
DECLARE @sucess bit
EXEC AdminIssueThesisPayment 1,2,3,4,@sucess OUTPUT
print @sucess
go;


-- i) view the profile of any student that contains all his/her information.---->>>>
-- AdminViewStudentProfile
-- We should views 2 types of students gucian and nongucian by checking the id is exists or not  



GO
CREATE PROC AdminViewStudentProfile @sid int
AS
if  EXISTS(
SELECT *
FROM GucianStudent S
where S.id=@sid)
BEGIN
SELECT S.id,S.firstName,S.lastName,S.type,S.faculty,S.address,S.GPA,S.undergradID,P.email,p.password
FROM GucianStudent S inner JOIN PostGradUser P ON S.id=p.id
where  S.id=@sid
END
else IF(EXISTS(
SELECT *
FROM NonGucianStudent S
where S.id=@sid))
BEGIN
SELECT S.id,S.firstName,S.lastName,S.type,S.faculty,S.address,S.GPA,P.email,p.password
FROM NonGucianStudent S inner JOIN PostGradUser P ON S.id=p.id
where S.id=@sid
END
ELSE print 'error not found'


GO;

--j) Issue installments as per the number of installments for a certain payment every six months starting from the entered date.
-- AdminIssueInstallPayment
create proc AdminIssueInstallPayment
@paymentID int, @InstallStartDate date
as

    if exists (select * from Payment where id=@paymentID)
        BEGIN
            DECLARE @numOFInstallments int;
            select @numOFInstallments=no_Installments from Payment where id=@paymentID;

            DECLARE @Counter INT
            DECLARE @CurrentDate datetime
            SET @Counter=0
            while(@Counter<@numOFInstallments)
                BEGIN
                    set @CurrentDate=dateadd(month, (@Counter)*6, @InstallStartDate);
                    insert into Installments (date, paymentId)
                    values (@CurrentDate, @paymentID);
                    SET @Counter=@Counter+1;
                END
        end
    else
        print 'Payment not found';

go;

--k) List the title(s) of accepted publication(s) per thesis.---->>>>>
-- AdminListAcceptPublication
create proc AdminListAcceptPublication
as 
    BEGIN
        select t.serialNumber,p.title
        from Publication p inner join ThesisHasPublication rel on(p.id=rel.pubid)
        inner join Thesis t on (rel.serialNo=t.serialNumber)
        where p.accepted='True'
        group by t.serialNumber,p.title
    end

go;


--l) Add courses and link courses to students.
-- AddCourse
create proc AddCourse
@courseCode varchar(20), @creditHours int, @fee decimal
as

insert into Course (Coursecode, creditHrs, fees) values (@courseCode, @creditHours, @fee);


go;
-- l) 2)
-- linkCourseStudent
create proc linkCourseStudent
@courseID int, @studentID INT
as
insert into NonGucianStudentTakeCourse (cid, sid) values (@courseID, @studentID)


go;

--l) 3)
-- addStudentCourseGrade
-- any adding to any thing we will use checking statement (if exists )
create proc addStudentCourseGrade
@courseID int, @studentID int, @grade decimal
as
    BEGIN
        if Exists(select * from NonGucianStudentTakeCourse where sid=@studentID and cid=@courseID)
            BEGIN
                update NonGucianStudentTakeCourse set grade=@grade where sid=@studentID and cid=@courseID;
            End
        else
            print 'Student not found';
    end
go;

--m) View examiners and supervisor(s) names attending a thesis defense taking place on a certain date.
-- ViewExamSupDefense ---->
create proc ViewExamSupDefense
@defenseDate datetime
as
    begin
        select (sup.first_Name +' '+sup.last_Name) AS superVisorName, e.ExaminerName 
        from ExaminerEvaluateDefense eed inner join NonGUCianProgressReport ngpr
        on(eed.serial_no=ngpr.ThesisSerialNo)
        inner join Supervisor sup on(ngpr.supid=sup.id)
        inner join Examinar e on (e.id=eed.examinarID)
        where eed.Evaluatedate = @defenseDate

        union

        select (sup.first_Name +' '+sup.last_Name) AS superVisorName, e.ExaminerName 
        from ExaminerEvaluateDefense eeD inner join GUCianProgressReport gpr
        on(eed.serial_no=gpr.ThesisSerialNo)
        inner join Supervisor sup on(gpr.supid=sup.id)
        inner join Examinar e on (e.id=eed.examinarID)
        where eed.Evaluatedate = @defenseDate;

    end

Go;

-----------------------------------------------------------------------------------------------------

--4
-- a) Evaluate a student’s progress report, and give evaluation value 0 to 3.
--->>>>
--4(a)checks first whether the evaluation value between 0 and 3 if not it will just print an Error saying that the value isnt between 0 and 3
--if it is then i check if the progress report belongs to gucian student or a non gucian student using simple if exists
--and then update the progress report eval on the progress report attributes satisfying the inputs of the proc
create proc EvaluateProgressReport
@supervisorID int, @thesisSerialNo int, @progressReportNo int, @evaluation int
AS
if(@evaluation not between 0 and 3)
  print  ('ERROR The evaluation value should be between 0 and 3')
else
  begin
  if exists(select * from GUCianProgressReport where GUCianProgressReport.ThesisSerialNo=@thesisSerialNo)
   begin
   update GUCianProgressReport
   set GUCianProgressReport.evaluation=@evaluation
   where GUCianProgressReport.supid=@supervisorID and GUCianProgressReport.ThesisSerialNo=@thesisSerialNo and GUCianProgressReport.progressReportNo=@progressReportNo
   end
  else
    if exists(select * from NonGUCianProgressReport where NonGUCianProgressReport.thesisSerialNo=@thesisSerialNo)
    begin
    update NonGUCianProgressReport
    set NonGUCianProgressReport.evaluation=@evaluation
    where NonGUCianProgressReport.supid=@supervisorID and NonGUCianProgressReport.ThesisSerialNo=@thesisSerialNo and NonGUCianProgressReport.progressReportNo=@progressReportNo
    end
    end;
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--4
--b)View all my students’s names and years spent in the thesis.

--4(b)first we want to join student with thesis so we will  creates aproc the gives two table as ouput one for all the gucian students registered with that supervisor
-- and the other table gives info about the non gucian students  all by:inner joining student  with student registered thesis on sid
--inner joing with supervisor on supid inner joining with thesis on serial no
go;
create proc ViewSupStudentsYears
@supervisorID int
AS
    Begin
        select GucianStudent.firstname,GucianStudent.lastname,Thesis.years
        from GucianStudent
        inner join GUCianStudentRegisterThesis on GucianStudent.id=GUCianStudentRegisterThesis.sid
        inner join Supervisor on Supervisor.id=GUCianStudentRegisterThesis.supid
        inner join Thesis on Thesis.serialNumber=GUCianStudentRegisterThesis.serial_no
        where Supervisor.id=@supervisorID
    UNION 
        select NonGucianStudent.firstname,NonGucianStudent.lastname,Thesis.years
        from NonGucianStudent
        inner join NonGUCianStudentRegisterThesis on NonGucianStudent.id=NonGUCianStudentRegisterThesis.sid
        inner join Supervisor on Supervisor.id=NonGUCianStudentRegisterThesis.supid
        inner join Thesis on Thesis.serialNumber=NonGUCianStudentRegisterThesis.serial_no
        where Supervisor.id=@supervisorID
end;

--4c View my profile and update my personal information.
GO
create PROC SupViewProfile  @supervisorID int
as
if (exists(
SELECT *
FROM Supervisor s1
where S1.id=@supervisorID))
BEGIN
SELECT *
FROM Supervisor s1
where S1.id=@supervisorID
END
ELSE print 'error not found'

--*
GO
create PROC UpdateSupProfile @supervisorID int,
@name varchar(20), 
@faculty varchar(20)
as 
if exists(
SELECT *
FROM Supervisor s1
where S1.id=@supervisorID)
BEGIN
UPDATE Supervisor 
SET
first_name=@name,
faculty=@faculty
WHere id = @supervisorID
END
ELSE
print 'error not found'

--4d View all publications of a student.
GO
CREATE PROC ViewAStudentPublications @StudentID int
as
SELECT S.id, pb.title,pb.pubDate,pb.host,pb.place,pb.accepted
from Publication pb, ThesisHasPublication thp, GucianStudentRegisterThesis gsr,GucianStudent s
where s.id=@StudentID and pb.id=thp.pubid and thp.serialNo=gsr.serial_no and gsr.sid =s.id 
union 
SELECT S.id, pb.title,pb.pubDate,pb.host,pb.place,pb.accepted
from Publication pb, ThesisHasPublication thp, NonGucianStudentRegisterThesis gsr,NonGucianStudent s
where s.id=@StudentID and pb.id=thp.pubid and thp.serialNo=gsr.serial_no and gsr.sid =s.id 


--4e Add defense for a thesis, for nonGucian students all courses’ grades should be greater than 50 percent.
GO
create Proc AddDefenseGucian @ThesisSerialNo int, @DefenseDate Datetime, @DefenseLocation varchar(15)
AS 
INSERT INTO Defense(ThesisSerialNo,DefenseDate,DefenseLocation) Values(@ThesisSerialNo,@DefenseDate,@DefenseLocation)
--*
Go
create Proc AddDefenseNonGucian @ThesisSerialNo int, @DefenseDate Datetime, @DefenseLocation varchar(15)
AS 
DEclare @grade decimal
SELECT @grade=max(grade)
from NonGucianStudentTakeCourse
if (@grade >50)
BEGIN
INSERT INTO Defense(ThesisSerialNo,DefenseDate,DefenseLocation) Values(@ThesisSerialNo,@DefenseDate,@DefenseLocation)
END
--4f Add examiner(s) for a defense.
GO
create Proc AddExaminer @ThesisSerialNo int,@DefenseDate Datetime,@ExaminerName varchar(20),@National bit,@fieldOfWork varchar(20)
as
DECLARE @id INT
IF (EXISTS (SELECt * FROm Examinar where  ExaminerName =@ExaminerName AND nationality = @National AND fieldOfWork = @fieldOfWork))
BEGIN
SELECt @id=id FROm Examinar where  ExaminerName =@ExaminerName AND nationality = @National AND fieldOfWork = @fieldOfWork
INSERT INTO ExaminerEvaluateDefense VALUES(@DefenseDate,@ThesisSerialNo,@id)
END
--4g Cancel a Thesis if the evaluation of the last progress report is zero.
go 
Alter proc CancelThesis @ThesisSerialNo int
as
DECLARE  @max INt 
if(EXISTS (SELECt * FROM GUCianProgressReport Where ThesisSerialNo= @ThesisSerialNo ))
    SELECT @max = max(progressReportNo) 
    FRom GUCianProgressReport
       if(EXISTS (SELECt * FROM GUCIANProgressReport Where progressReportNo=@max AND evaluation =0 AND ThesisSerialNo =@ThesisSerialNo))
             DELETE FROM THESis where serialNumber = @ThesisSerialNo 
ELSE IF(EXISTS (SELECt * FROM NonGUCianProgressReport Where ThesisSerialNo= @ThesisSerialNo ))  
    SELECT @max = max(progressReportNo) 
    FRom NonGUCianProgressReport
       if(EXISTS (SELECt * FROM GUCIANProgressReport Where progressReportNo=@max AND evaluation =0 AND ThesisSerialNo =@ThesisSerialNo))
             DELETE FROM THESis where serialNumber = @ThesisSerialNo 



--4h Add a grade for a thesis.

go 
create proc AddGrade @ThesisSerialNo int
AS 
UPDATE Thesis 
SET 
Grade=1
where serialNumber=@ThesisSerialNo

--5a Add grade for a defense.
go 
create proc AddDefenseGrade @ThesisSerialNo int,@DefenseDate Datetime,@grade decimal
as
update Defense
set 
Grade=@grade
where ThesisSerialNo=@ThesisSerialNo AND DefenseDate=@DefenseDate

--5b Add comments for a defense.
go
create proc AddCommentsGrade @ThesisSerialNo int,@DefenseDate Datetime,@comments varchar(300)
AS
UPDATE Defense
SET comments=@comments
where ThesisSerialNo=@ThesisSerialNo AND DefenseDate=@DefenseDate







--6
--a) View my profile that contains all my information.
GO
create proc  viewMyProfile
@studentId int
as
    begin
            if exists (select * from GucianStudent where id=@studentId)
                BEGIN
                    select * from GucianStudent where id=@studentId;
                end
            else 
                if exists (select * from NonGucianStudent where id=@studentId)
                    BEGIN
                        select * from NonGucianStudent where id=@studentId;
                    end
                else
                    print' Student not found ';
                
    end
go;


--b) Edit my profile (change any of my personal information).

GO

CREATE PROC editMyProfile @studentID int, 
@firstName varchar(10), 
@lastName varchar(10), 
@password varchar(10), 
@email varchar(10), 
@address varchar(10), 
@type varchar(10)
AS 
if(Exists( SELECT * FROM GucianStudent S where S.id=@studentId))
BEGIN
UPDATE GucianStudent
SET
firstName=@firstName, lastName=@lastName ,address=@address,type=@type
WHere id = @studentId

UPDATE PostGradUser
SET 
email=@email,password=@password
where PostGradUser.id=@studentId
END
ELSE if (Exists(SELECT * FROM NonGucianStudent S where S.id=@studentId))
BEGIN
UPDATE NonGucianStudent 
SET
firstName=@firstName, lastName=@lastName ,address=@address,type=@type
WHere id = @studentId
UPDATE PostGradUser
SET 
email=@email,password=@password
where PostGradUser.id=@studentId
END
ELSE
print 'error not found'

--c) As a Gucian graduate, add my undergarduate ID.

GO
CREATE Proc addUndergradID @studentID int ,@underGradeID varchar(10)
AS 
UPDATE GUCIANStudent 
SET 
undergradID = @underGradeID
WHERE id = @studentID

--d) As a nonGucian student, view my courses’ grades


GO
CREATE PROC ViewCoursesGrades @studentID int
AS
SELECT  NC.sid AS StudentID,NC.cid AS CourseID, C.courseCode , NC.grade
From NonGucianStudent S, NonGucianStudentTakeCourse NC ,Course C
Where S.id=NC.sid AND NC.cid=c.courseID AND S.id= @studentID 


--e 1) View all my payments and installments.

GO
CREATE PROC ViewCoursePaymentsInstall @studentID int
AS 
SELECT X.sid AS studentID,X.cid AS CourseID,P.id AS PaymentID , P.amount AS PaymentAmount,P.no_Installments,P.fundPercentage,
S.date,S.amount AS installmentsAmount ,S.status
FROM   NonGucianStudentPayForCourse X ,Payment P, installments S
WHERE X.cid = P.id AND P.id = S.paymentID AND X.sid=@studentID


--e 2)

GO
CREATE PROC ViewThesisPaymentsInstall @studentID int
AS 
if(EXISTS (SELECT * FROM GucianStudentRegisterThesis F where F.sid=@studentID))
SELECT F.sid As StudentID ,F.supid As SupervisorID , F.serial_no AS ThesisSerialNo,
T.field,T.type,T.title,T.startDate,T.endDate,T.defenseDate,T.grade,T.years,T.paymentID,
T.noExtension,P.amount AS PaymentAmount,P.no_Installments,P.fundPercentage,
I.date,I.amount AS installmentsAmount ,I.status

FROM GucianStudentRegisterThesis F, Thesis T, Payment P ,installments I
WHERE F.serial_no=T.serialNumber AND T.paymentID = P.id AND P.id=I.paymentID AND F.sid= @studentID 
Else if(EXISTS (SELECT * FROM NonGucianStudentRegisterThesis F where F.sid=@studentID))
SELECT F.sid As StudentID ,F.supid As SupervisorID , F.serial_no AS ThesisSerialNo,
T.field,T.type,T.title,T.startDate,T.endDate,T.defenseDate,T.grade,T.years,T.paymentID,
T.noExtension,P.amount AS PaymentAmount,P.no_Installments,P.fundPercentage,
I.date,I.amount AS installmentsAmount ,I.status

FROM NonGucianStudentRegisterThesis F, Thesis T, Payment P ,installments I
WHERE F.serial_no=T.serialNumber AND T.paymentID = P.id AND P.id=I.paymentID AND F.sid= @studentID 

--e 3)

Go
CREATE PROC ViewUpcomingInstallments @studentID int
AS
if(EXISTS (SELect * From GucianStudent WHERE id=@studentId))
BEGIN
SELECT F.sid AS StudentID,I.paymentID,I.date ,I.amount,I.status
FROM GucianStudentRegisterThesis F, Thesis T, Payment P ,installments I
WHERE F.serial_no=T.serialNumber AND T.paymentID = P.id AND P.id=I.paymentID AND F.sid= @studentID AND I.[date] > CURRENT_TIMESTAMP 
END
Else if(EXISTS (SELect * From NonGucianStudent WHERE id=@studentId))
BEGIN
(SELECT F.sid AS StudentID,I.paymentID,I.date ,I.amount,I.status
FROM NonGucianStudentRegisterThesis F, Thesis T, Payment P ,installments I
WHERE F.serial_no=T.serialNumber AND T.paymentID = P.id AND P.id=I.paymentID AND F.sid= @studentID  AND I.[date] > CURRENT_TIMESTAMP )
Union
(
SELECT X.sid AS StudentID,I.paymentID,I.date ,I.amount,I.status
FROM   NonGucianStudentPayForCourse X ,Payment P, installments I
WHERE X.cid = P.id AND P.id = I.paymentID AND X.sid=@studentID AND I.[date] > CURRENT_TIMESTAMP
)
END

SELECT * FROm INSTALLMENTS
UPDATE INSTALLMENTS SET date ='12-12-2000' where paymentID = 2
INSERT INTO INSTALLMENTS VALUES('9-6-2022',2,3,0)


--e 4)
Go
CREATE PROC ViewMissedInstallments @studentID int
AS
if(EXISTS (SELect * From GucianStudent WHERE id=@studentId))
BEGIN
SELECT F.sid AS StudentID,I.paymentID,I.date ,I.amount,I.status
FROM GucianStudentRegisterThesis F, Thesis T, Payment P ,installments I
WHERE F.serial_no=T.serialNumber AND T.paymentID = P.id AND P.id=I.paymentID AND F.sid= @studentID AND I.[date] < CURRENT_TIMESTAMP AND I.status=0
END
Else if(EXISTS (SELect * From NonGucianStudent WHERE id=@studentId))
BEGIN
(SELECT F.sid AS StudentID,I.paymentID,I.date ,I.amount,I.status
FROM NonGucianStudentRegisterThesis F, Thesis T, Payment P ,installments I
WHERE F.serial_no=T.serialNumber AND T.paymentID = P.id AND P.id=I.paymentID AND F.sid= @studentID  AND I.[date] < CURRENT_TIMESTAMP AND I.status=0)
Union
(
SELECT X.sid AS StudentID,I.paymentID,I.date ,I.amount,I.status
FROM   NonGucianStudentPayForCourse X ,Payment P, installments I
WHERE X.cid = P.id AND P.id = I.paymentID AND X.sid=@studentID AND I.[date] < CURRENT_TIMESTAMP AND I.status=0
)
END

--f) Add and fill my progress report(s).
GO
CREATE PROC AddProgressReport @thesisSerialNo int, @progressReportDate date
AS
IF(EXISTS(SELECT * FROM GucianStudentRegisterThesis WHERE serial_no = @thesisSerialNo))
BEGIN
DEclare @variable int,@sub int
SELECT @variable = sid ,@sub =supid
FROM GucianStudentRegisterThesis WHERE serial_no = @thesisSerialNo
INSERT INTO GUCianProgressReport(sid,ThesisSerialNo,progressReportDate,supid) VALUES(@variable,@thesisSerialNo, @progressReportDate,@sub)
END
ELSE IF(EXISTS(SELECT * FROM NonGucianStudentRegisterThesis WHERE serial_no = @thesisSerialNo))
BEGIN
DEclare @variasble int,@cub int
SELECT @variasble = sid ,@cub =supid
FROM NonGucianStudentRegisterThesis WHERE serial_no = @thesisSerialNo
INSERT INTO NonGUCianProgressReport(sid,ThesisSerialNo,progressReportDate,supid) VALUES(@variable,@thesisSerialNo, @progressReportDate,@cub)
END
ELSE Print 'error not found'

--f) 2)

GO
CREATE PROC FillProgressReport @thesisSerialNo int, @progressReportNo int, @state int, @description varchar(200)
AS
IF(EXISTS(SELECT * FROM GUCianProgressReport WHERE ThesisSerialNo = @thesisSerialNo))
BEGIN
Update GUCianProgressReport
SET 
stateReport = @state,
descriptionReport = @description
WHERE ThesisSerialNo = @thesisSerialNo AND progressReportNo = @progressReportNo
END
ELSE IF(EXISTS(SELECT * FROM NonGUCianProgressReport WHERE ThesisSerialNo = @thesisSerialNo))
BEGIN
Update NonGUCianProgressReport
SET 
stateReport = @state,
descriptionReport = @description
WHERE ThesisSerialNo = @thesisSerialNo AND progressReportNo =@progressReportNo
END
ELSE print 'error not found'


--g) View my progress report(s) evaluations.

GO
CREATE PROCEDURE ViewEvalProgressReport @thesisSerialNo int, @progressReportNo int
AS 
IF(EXISTS(SELECT * FROM GUCianProgressReport WHERE ThesisSerialNo = @thesisSerialNo AND progressReportNo=@progressReportNo))
BEGIN
SELECT progressReportNo , evaluation
FROM GUCianProgressReport
WHERE ThesisSerialNo=@thesisSerialNo AND progressReportNo=@progressReportNo
END
ELSE IF(EXISTS(SELECT * FROM NonGUCianProgressReport WHERE ThesisSerialNo = @thesisSerialNo AND progressReportNo=@progressReportNo))
BEGIN
SELECT progressReportNo , evaluation
FROM NonGUCianProgressReport
WHERE ThesisSerialNo=@thesisSerialNo AND progressReportNo=@progressReportNo
END
ELSE print 'error not found'

--h) Add publication.
GO
CREATE PROC addPublication @title varchar(50), @pubDate datetime, @host varchar(50), @place varchar(50), @accepted bit
AS
INSERT INTO Publication VALUES (@title,@pubDate,@host,@place,@accepted)

--i) Link publication to my thesis.

GO
CREATE PROC linkPubThesis @PubID int,@thesisSerialNo int
AS
INSERT INTO ThesisHasPublication Values(@thesisSerialNo,@PubID)




