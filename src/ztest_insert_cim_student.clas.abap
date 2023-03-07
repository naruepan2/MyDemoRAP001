CLASS ztest_insert_cim_student DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZTEST_INSERT_CIM_STUDENT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DELETE FROM zcim_rap_ar_nar2.
    INSERT zcim_rap_ar_nar2 FROM @(
        VALUE #( client = sy-mandt
                 id     = 'A6CE48C494271EDD9FA0DAF77CB38753' ) ).

  ENDMETHOD.
ENDCLASS.
