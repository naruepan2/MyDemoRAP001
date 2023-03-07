@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_AR_STUDENT_DEMO01'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define view entity ZI_AR_STUDENT_DEMO01
  as select from zcim_rap_ar_nar2
  association        to parent ZI_STUDENT_DEMO_01 as _student   on $projection.Id = _student.Id
  association [0..1] to ZI_COURSE_DEGAL           as _course    on $projection.Course = _course.Value
  association [0..1] to ZI_SEMESTER_VIEW          as _semester  on $projection.Semester = _semester.Value
  association [0..1] to zi_semres_5000            as _semresult on $projection.Semresult = _semresult.Value
{
  key id                     as Id,
      course                 as Course,
      semester               as Semester,
      _course.Description     as Course_desc,
      _semester.Description  as Semester_desc,
      _semresult.Description as Semresult_desc,
      semresult              as Semresult,
      lastchangedat          as Lastchangedat,
      locallastchangedat     as Locallastchangedat,

      _student,
      _course,
      _semester,
      _semresult
}
