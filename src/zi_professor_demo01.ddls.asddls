@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZC_PROFESSOR_DEMO01'
define root view entity ZI_PROFESSOR_DEMO01
  as select from znar_rap_demo_02
{
  key id                 as Id,
      firstname          as Firstname,
      lastname           as Lastname,
      age                as Age,
      role               as Role,
      salary             as Salary,
      active             as Active,
      lastchangedat      as Lastchangedat,
      locallastchangedat as Locallastchangedat
      // Make association public
}
