CLASS lhc_Professor DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Professor RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR professor RESULT result.

    METHODS setactive FOR MODIFY
      IMPORTING keys FOR ACTION professor~setactive RESULT result.
    METHODS changeSalary FOR DETERMINE ON MODIFY
      IMPORTING keys FOR professor~changeSalary.

ENDCLASS.

CLASS lhc_Professor IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_professor_demo01 IN LOCAL MODE
        ENTITY Professor
            FIELDS ( Active )
            WITH CORRESPONDING #( keys )
        RESULT DATA(professorData)
        FAILED failed
        REPORTED reported.



    result = VALUE #( FOR professorrec IN professorData
                      LET active_val = COND #( WHEN professorrec-active IS NOT INITIAL
                                                THEN if_abap_behv=>fc-o-disabled
                                                ELSE if_abap_behv=>fc-o-enabled )
                      IN
                      ( %tky              = professorrec-%tky
                        %action-setactive = active_val ) ).
  ENDMETHOD.

  METHOD setActive.
    MODIFY ENTITIES OF zi_professor_demo01 IN LOCAL MODE
        ENTITY Professor
            UPDATE FIELDS ( Active )
            WITH VALUE #( FOR key IN keys
                          ( %tky   = key-%tky
                            active = abap_true ) )
            FAILED failed
            REPORTED reported.

    "Get the response updated record
    READ ENTITIES OF zi_professor_demo01 IN LOCAL MODE
        ENTITY Professor
            ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(professorData)
        FAILED failed
        REPORTED reported.

    result = VALUE #( FOR professorrec IN professorData
                      ( %tky   = professorrec-%tky
                        %param = professorrec ) ).
  ENDMETHOD.

  METHOD changeSalary.
    READ ENTITIES OF zi_professor_demo01 IN LOCAL MODE
        ENTITY Professor
            FIELDS ( Role
                     Salary )
            WITH CORRESPONDING #( keys )
        RESULT DATA(professorData).

    LOOP AT professorData ASSIGNING FIELD-SYMBOL(<lfs_professorData>).
      IF |{ <lfs_professorData>-Role CASE = LOWER }| EQ 'professor'.
        MODIFY ENTITIES OF zi_professor_demo01 IN LOCAL MODE
            ENTITY Professor
                UPDATE FIELDS ( Salary )
                WITH VALUE #( ( %tky   = <lfs_professorData>-%tky
                                Salary = <lfs_professorData>-Salary + 10000 ) ).
      ELSEIF |{ <lfs_professorData>-Role CASE = LOWER }| EQ 'teacher'.
        MODIFY ENTITIES OF zi_professor_demo01 IN LOCAL MODE
            ENTITY Professor
                UPDATE FIELDS ( Salary )
                WITH VALUE #( ( %tky   = <lfs_professorData>-%tky
                                Salary = <lfs_professorData>-Salary + 5000 ) ).
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
