@EndUserText.label: 'ZC_PROFESSOR_DEMO01'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity ZC_PROFESSOR_DEMO01
  as projection on ZI_PROFESSOR_DEMO01
{
          @EndUserText.label: 'Id'
  key     Id,
          @EndUserText.label: 'Firstname'
          Firstname,
          @EndUserText.label: 'Lastname'
          Lastname,
          @EndUserText.label: 'Age'
          Age,
          @EndUserText.label: 'Role'
          Role,
          @EndUserText.label: 'Salary'
          Salary,
          @EndUserText.label: 'Active'
          Active,
          Lastchangedat,
          Locallastchangedat,

          @ObjectModel: { virtualElementCalculatedBy: 'ABAP:ZCL_CALCULATE' }
          @EndUserText.label: 'Total Pay'
  virtual BonusAmount : abap.int4
}
