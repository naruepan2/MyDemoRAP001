@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_STU_HDR_TAB_CP1'
define root view entity ZI_STU_HDR_TAB_CP1 as select from ZSTU_HDR_TAB_CP1
composition [1..*] of ZI_STU_ATT_TAB_CP1 as _Attachments
{   
    @EndUserText.label: 'Student ID'
    key id as Id,
    @EndUserText.label: 'Firse Name'
    firstname as Firstname,
    @EndUserText.label: 'Last Name'
    lastname as Lastname,
    @EndUserText.label: 'Age'
    age as Age,
    @EndUserText.label: 'Course'
    course as Course,
    @EndUserText.label: 'Course Duration'
    courseduration as Courseduration,
    @EndUserText.label: 'Status'
    status as Status,
    @EndUserText.label: 'Gender'
    gender as Gender,
    @EndUserText.label: 'DOB'
    dob as Dob,
    
    lastchangedat as Lastchangedat,
    locallastchangedat as Locallastchangedat,
    
    _Attachments
}
