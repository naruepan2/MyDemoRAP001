CLASS lhc_Student DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Student RESULT result.
    METHODS setadmitted FOR MODIFY
      IMPORTING keys FOR ACTION student~setadmitted RESULT result.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR student RESULT result.
    METHODS validationage FOR VALIDATE ON SAVE
      IMPORTING keys FOR student~validationage.
    METHODS updatecourseduration FOR DETERMINE ON SAVE
      IMPORTING keys FOR student~updatecourseduration.
    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE student.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR student RESULT result.

    METHODS is_updat_allowed_global
      RETURNING VALUE(update_allowed) TYPE abap_boolean.
    METHODS is_updat_allowed_insta
      RETURNING VALUE(update_allowed) TYPE abap_boolean.

ENDCLASS.

CLASS lhc_Student IMPLEMENTATION.

  METHOD get_instance_authorizations.
    DATA: update_requested TYPE abap_boolean,
          update_granted   TYPE abap_boolean.


    READ ENTITIES OF zi_student_demo_01 IN LOCAL MODE
        ENTITY Student
            FIELDS ( Status )
            WITH CORRESPONDING #( keys )
        RESULT DATA(studentdata)
        FAILED failed
        REPORTED reported.

    CHECK studentdata IS NOT INITIAL.

    update_requested = COND #( WHEN requested_authorizations-%update = if_abap_behv=>mk-on OR
                                    requested_authorizations-%action-Edit = if_abap_behv=>mk-on
                                    THEN abap_true ELSE abap_false ).

    LOOP AT studentdata ASSIGNING FIELD-SYMBOL(<lfs_stu_data>).
      IF <lfs_stu_data>-Status = abap_false.
        IF update_requested = abap_true.
          update_granted = is_updat_allowed_insta(  ).

          IF update_granted = abap_false.
            APPEND VALUE #( %tky = <lfs_stu_data>-%tky ) TO failed-student.
            APPEND VALUE #( %tky = <lfs_stu_data>-%tky
                            %msg = new_message_with_text(
                                     severity = if_abap_behv_message=>severity-error
                                     text     = 'No Authorization to update this status!!!'
                                   ) ) TO reported-student.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD setAdmitted.
    MODIFY ENTITIES OF zi_student_demo_01 IN LOCAL MODE
        ENTITY Student
            UPDATE FIELDS ( Status )
            WITH VALUE #( FOR key IN keys
                          ( %tky   = key-%tky
                            Status = abap_true ) )
            FAILED failed
            REPORTED reported.

    "Get the response updated record
    READ ENTITIES OF zi_student_demo_01 IN LOCAL MODE
        ENTITY Student
            ALL FIELDS WITH CORRESPONDING #( keys )
        RESULT DATA(studentdata)
        FAILED failed
        REPORTED reported.

    result = VALUE #( FOR studentrec IN studentdata
                      ( %tky   = studentrec-%tky
                        %param = studentrec ) ).

  ENDMETHOD.

  METHOD get_instance_features.
    READ ENTITIES OF zi_student_demo_01 IN LOCAL MODE
        ENTITY Student
            FIELDS ( Status )
            WITH CORRESPONDING #( keys )
        RESULT DATA(studentdata)
        FAILED failed
        REPORTED reported.



    result = VALUE #( FOR studentrec IN studentdata
                      LET statusval = COND #( WHEN studentrec-status IS NOT INITIAL
                                                THEN if_abap_behv=>fc-o-disabled
                                                ELSE if_abap_behv=>fc-o-enabled )
                      IN
                      ( %tky                = studentrec-%tky
                        %action-setAdmitted = statusval ) ).
  ENDMETHOD.

  METHOD validationAge.
    "Get Age field
    READ ENTITIES OF zi_student_demo_01 IN LOCAL MODE
        ENTITY Student
            FIELDS ( Age ) WITH CORRESPONDING #( keys )
        RESULT DATA(studentsAge).

    LOOP AT studentsAge INTO DATA(studentAge).
      IF studentAge-Age LE 1
      OR studentAge-Age GE 70.
        APPEND VALUE #( %tky = studentAge-%tky ) TO failed-student.
        APPEND VALUE #( %tky = keys[ 1 ]-%tky
                        %msg = new_message_with_text(
                                 severity = if_abap_behv_message=>severity-error
                                 text     = 'Age canot be less than 0 or greater than 70'
                               ) ) TO reported-student.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD updateCourseDuration.
    "Get Course field
    READ ENTITIES OF zi_student_demo_01 IN LOCAL MODE
        ENTITY Student
            FIELDS ( Course ) WITH CORRESPONDING #( keys )
        RESULT DATA(studentsCourses).

    LOOP AT studentsCourses INTO DATA(studentsCourse).
      IF |{ studentsCourse-Course CASE = UPPER }| = 'C'. "computers
        MODIFY ENTITIES OF zi_student_demo_01 IN LOCAL MODE
            ENTITY Student
            UPDATE FIELDS ( Duration ) WITH VALUE #( ( %tky      = studentsCourse-%tky
                                                        Duration = 5 ) ).
      ELSEIF |{ studentsCourse-Course CASE = UPPER }| = 'E'. "Electronics'.
        MODIFY ENTITIES OF zi_student_demo_01 IN LOCAL MODE
            ENTITY Student
            UPDATE FIELDS ( Duration ) WITH VALUE #( ( %tky      = studentsCourse-%tky
                                                        Duration = 3 ) ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD precheck_update.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<lfs_entity>).

*    01 = Value was updated/changed, 00 = Value hasn't been update/changed
      CHECK <lfs_entity>-%control-Course = '01' OR <lfs_entity>-%control-Duration = '01'.

      "Get Course field
      READ ENTITIES OF zi_student_demo_01 IN LOCAL MODE
          ENTITY Student
              FIELDS ( Course
                       Duration ) WITH VALUE #( ( %key = <lfs_entity>-%key ) )
          RESULT DATA(studentsCourses).

      CHECK sy-subrc IS INITIAL.

      READ TABLE studentsCourses ASSIGNING FIELD-SYMBOL(<lfs_db_studentsCourse>) INDEX 1.

      CHECK sy-subrc IS INITIAL.

      <lfs_db_studentsCourse>-Course = COND #( WHEN <lfs_entity>-%control-Course = '01' THEN <lfs_entity>-Course
                                               ELSE <lfs_db_studentsCourse>-Course ).
      <lfs_db_studentsCourse>-Duration = COND #( WHEN <lfs_entity>-%control-Duration = '01' THEN <lfs_entity>-Duration
                                                 ELSE <lfs_db_studentsCourse>-Duration ).

      IF <lfs_db_studentsCourse>-Duration < 5.
        IF |{ <lfs_db_studentsCourse>-Course CASE = UPPER }| = 'C'. "computers
          APPEND VALUE #( %tky = <lfs_entity>-%tky ) TO failed-student.
          APPEND VALUE #( %tky = <lfs_entity>-%tky
                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                        text     = 'Invalid Course duration...'
                        ) ) TO reported-student.
        ENDIF.
      ENDIF.

*      IF |{ <lfs_db_studentsCourse>-Course CASE = LOWER }| = 'computer'.
*        IF <lfs_db_studentsCourse>-Duration < 5.
*          APPEND VALUE #( %tky = <lfs_entity>-%tky ) TO failed-student.
*          APPEND VALUE #( %tky = <lfs_entity>-%tky
*                          %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
*                                                        text     = 'Invalid Course duration...'
*                        ) ) TO reported-student.
*        ENDIF.
*      ENDIF.
    ENDLOOP.

  ENDMETHOD.

  METHOD get_global_authorizations.

    IF requested_authorizations-%update = if_abap_behv=>mk-on OR
        requested_authorizations-%action-Edit = if_abap_behv=>mk-on.

      IF is_updat_allowed_global(  ).
        result-%update = if_abap_behv=>auth-allowed.
        result-%action-Edit = if_abap_behv=>auth-allowed.
      ELSE.
        result-%update = if_abap_behv=>auth-unauthorized.
        result-%action-Edit = if_abap_behv=>auth-unauthorized.
      ENDIF.

    ENDIF.

  ENDMETHOD.

  METHOD is_updat_allowed_global.

* Do not use in production env.
*    update_allowed = abap_true.
    update_allowed = space.
  ENDMETHOD.

  METHOD is_updat_allowed_insta.
* Do not use in production env.
    update_allowed = abap_true.
    update_allowed = space.
  ENDMETHOD.

ENDCLASS.
