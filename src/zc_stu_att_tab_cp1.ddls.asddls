@EndUserText.label: 'ZC_STU_ATT_TAB_CP1'
@AccessControl.authorizationCheck: #NOT_REQUIRED
define view entity ZC_STU_ATT_TAB_CP1
  as projection on ZI_STU_ATT_TAB_CP1
{

      @UI.facet: [{
                    id: 'StudentData',
                    purpose: #STANDARD,
                    label: 'Attachment Information',
                    type: #IDENTIFICATION_REFERENCE,
                    position: 10
                   }]

      @UI:{
        selectionField: [{ position: 10 }],
        lineItem: [{ position: 10 }],
        identification: [{ position: 10 }]
      }
  key AttachId,
      @UI:{
      identification: [{ position: 20 }]
      }
      Id,
      @UI:{
      lineItem: [{ position: 30 }],
      identification: [{ position: 30 }]
      }
      Comments,
      @UI:{
      lineItem: [{ position: 40 }],
      identification: [{ position: 40 }]
      }
      Attachment,
      @UI.hidden: true
      Mimetype,
      @UI.hidden: true
      Filename,
      @UI.hidden: true
      Lastchangedat,
      /* Associations */
      _Student : redirected to parent ZC_STU_HDR_TAB_CP1
}
