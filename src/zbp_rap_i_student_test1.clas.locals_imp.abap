CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Student RESULT result.

    METHODS statusUpdate FOR MODIFY
      IMPORTING keys FOR ACTION Student~statusUpdate.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD statusUpdate.
    READ ENTITIES OF zrap_i_student_test1 IN LOCAL MODE
      ENTITY Student
       ALL FIELDS WITH CORRESPONDING #( keys )
       RESULT DATA(lt_students)
       FAILED failed.

    CHECK lt_students[] IS NOT INITIAL.

    SORT lt_students BY Status DESCENDING.

    LOOP AT lt_students ASSIGNING FIELD-SYMBOL(<lfs_students>).
*        <lfs_students>-Status = abap_true.

      IF <lfs_students>-Age < 25.

        APPEND VALUE #(  %tky = <lfs_students>-%tky ) TO failed-student.
        APPEND VALUE #( %tky =  <lfs_students>-%tky
                        %msg = new_message_with_text(
                        severity = if_abap_behv_message=>severity-error
                        text = <lfs_students>-Firstname && ' has Age less then 25, status not updated '
                        ) ) TO reported-student.
      ELSE.

        <lfs_students>-Status = abap_true.

      ENDIF.

    ENDLOOP.

    MODIFY ENTITIES OF zrap_i_student_test1 IN LOCAL MODE
        ENTITY Student
            UPDATE FIELDS ( Status ) WITH CORRESPONDING #( lt_students ).

  ENDMETHOD.

ENDCLASS.
