@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'projection View for Student'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZRAP_C_STUDENT_TEST1
  as projection on ZRAP_I_STUDENT_TEST1 as Student
{
  key Id,
      Firstname,
      Lastname,
      Age,
      Course,
      Courseduration,
      Status,
      Gender,
      Dob,
      Lastchangedat,
      Locallastchangedat
}
