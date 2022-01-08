
EXEC StudentRegister 'ahmed','ali','12wfd','met','True','ahmedali@yahoo','obour'

EXEC SupervisorRegister 'ali','mohamed','1fw2','iet','alimohamed@gmail'

DEclare @succESS BIT
EXEC userLogin 1,'12wfd',@succESS OUTPUT 
Print @succESS

Exec addMobile 1,'01226448546'

EXEC AdminListSup

EXEC AdminViewSupervisorProfile 3

EXEC AdminViewAllTheses

DEclare @count INT
EXEC AdminViewOnGoingTheses @count OUTPUT
Print @count


EXEC AdminViewStudentThesisBySupervisor

EXEC AdminListNonGucianCourse 3

EXEC AdminUpdateExtension 1

Declare @s Bit
EXEC AdminIssueThesisPayment 1,1,3,20 ,@s output
print @s

EXEC AdminViewStudentProfile 2


EXEC AdminIssueInstallPayment 1,'10-10-2005'

EXEC AdminListAcceptPublication


EXEC AddCourse '226',6,2000

EXEC linkCourseStudent 7,11

EXEC addStudentCourseGrade 7,11,50

EXEC ViewExamSupDefense '3-4-2015'

EXEC EvaluateProgressReport 21,1,6,2

EXEC ViewSupStudentsYears 21

EXEC SupViewProfile 21

EXEC UpdateSupProfile 21,'ahmed','met'

EXEC ViewAStudentPublications 1

EXEC AddDefenseGucian 2 ,'3-4-2015','eltahrir'

EXEC AddDefenseNonGucian 11 ,'5-7-2015','elsalam'


EXEC AddExaminer 3, '5-7-2015','Ali','True','met' 

EXEC CancelThesis 7


EXEC AddGrade 1

EXEC AddDefenseGrade 11 ,'5-7-2015',50

EXEC AddCommentsGrade 11 ,'5-7-2015','very good'

EXEC viewMyProfile 1

EXEC editMyProfile 1,'ali','wael','hhhaa','sssss','sas','gucian'

EXEC addUndergradID 1,'13321'


EXEC ViewCoursesGrades 11


EXEC ViewCoursePaymentsInstall 11

EXEC ViewThesisPaymentsInstall 11

EXEC ViewUpcomingInstallments 11

EXEC ViewMissedInstallments 11 

EXEC AddProgressReport 1,'4-4-2000'

EXEC FillProgressReport 1,6,1,'very good'

EXEC ViewEvalProgressReport 1,6

EXEC addPublication 'electric','1-1-2020','Egypt','maadi','True'

EXEC linkPubThesis 1,5
