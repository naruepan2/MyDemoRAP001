@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_STUDENT_DEMO_01'
@Metadata.allowExtensions: true
define root view entity ZC_STUDENT_DEMO_01
  as projection on ZI_STUDENT_DEMO_01 as Student
{
      @EndUserText.label: 'Student ID'
  key Id,
      @EndUserText.label: 'First Name'
      Firstname,
      @EndUserText.label: 'Last Name'
      Lastname,
      @EndUserText.label: 'Age'
      Age,
      @EndUserText.label: 'Course'
      Course,
      @EndUserText.label: 'Course Description'
      Course_desc,
      @EndUserText.label: 'Course Duration'
      Duration,
      @EndUserText.label: 'Status'
      Status,
      @EndUserText.label: 'Gender'
      Gender,
      GenderDesc,
      @EndUserText.label: 'DOB'
      Dob,
      @UI.hidden: true
      Lastchangedat,
      @UI.hidden: true
      Locallastchangedat,

      /* Associations */
      //      _academicres,
      _academicres : redirected to composition child ZC_AR_STUDENT_DEMO01,
      _gender
}
