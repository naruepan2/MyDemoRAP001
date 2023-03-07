@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_STU_ATT_TAB_CP1'
define view entity ZI_STU_ATT_TAB_CP1
  as select from zstu_att_tab_cp1
  association to parent ZI_STU_HDR_TAB_CP1 as _Student on $projection.Id = _Student.Id
{
  key attach_id  as AttachId,
      id         as Id,
      @EndUserText.label: 'Comments'
      comments   as Comments,
      @EndUserText.label: 'Attachments'
      @Semantics.largeObject: {
        mimeType: 'Mimetype',
        fileName: 'Filename',
        contentDispositionPreference: #INLINE
      }
      attachment as Attachment,
      @EndUserText.label: 'File Type'
      mimetype   as Mimetype,
      @EndUserText.label: 'File Name'
      filename   as Filename,
      
      _Student.Lastchangedat as Lastchangedat,
      _Student
}
