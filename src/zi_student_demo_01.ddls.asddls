@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_STUDENT_DEMO_01'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
/*+[hideWarning] { "IDS" : [ "CARDINALITY_CHECK" ]  } */
define root view entity ZI_STUDENT_DEMO_01
  as select from znar_rap_demo_01
  association [0..1] to ZI_STUDENT_GENDER_DEMO01 as _gender on $projection.Gender = _gender.Value
  association [0..1] to ZI_COURSE_DEGAL          as _course on $projection.Course = _course.Value
  composition [0..*] of ZI_AR_STUDENT_DEMO01     as _academicres
{
  key id                  as Id,
      firstname           as Firstname,
      lastname            as Lastname,
      age                 as Age,
      course              as Course,
      _course.Description as Course_desc,
      duration            as Duration,
      status              as Status,
      gender              as Gender,
      dob                 as Dob,
      lastchangedat       as Lastchangedat,
      locallastchangedat  as Locallastchangedat,

      _gender,
      _gender.Description as GenderDesc,

      _academicres,
      _course
}
