CLASS zcl_calculate DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_CALCULATE IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.

    DATA: lt_professorData TYPE STANDARD TABLE OF zc_professor_demo01 WITH DEFAULT KEY.

    lt_professorData = CORRESPONDING #( it_original_data ).

    LOOP AT lt_professorData ASSIGNING FIELD-SYMBOL(<lfs_professorData>).
      IF |{ <lfs_professorData>-Role CASE = LOWER }| EQ 'professor'.
        <lfs_professorData>-BonusAmount = <lfs_professorData>-Salary + 500.
      ELSEIF |{ <lfs_professorData>-Role CASE = LOWER }| EQ 'teacher'.
        <lfs_professorData>-BonusAmount = <lfs_professorData>-Salary + 1000.
      ENDIF.

    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( lt_professorData ).

  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.


  ENDMETHOD.
ENDCLASS.
