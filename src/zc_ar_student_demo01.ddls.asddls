@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_AR_STUDENT_DEMO01'
@Metadata.allowExtensions: true
define view entity ZC_AR_STUDENT_DEMO01
  as projection on ZI_AR_STUDENT_DEMO01 as Academic
{
      @EndUserText.label: 'Academic ID'
  key Id,
      @EndUserText.label: 'Course'
      Course,
      @EndUserText.label: 'Semester'
      Semester,
      @EndUserText.label: 'Course Description'
      Course_desc,
      @EndUserText.label: 'Semester Description'
      Semester_desc,
      @EndUserText.label: 'Semester Result Description'
      Semresult_desc,
      @EndUserText.label: 'Semester Result'
      Semresult,
      @UI.hidden: true
      Lastchangedat      as Lastchangedat,
      @UI.hidden: true
      Locallastchangedat as Locallastchangedat,

      /* Associations */
      //      _student
      _student : redirected to parent ZC_STUDENT_DEMO_01
}
