CLASS zcl_abap_codepage DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    CLASS-METHODS:
      from IMPORTING source TYPE xstring RETURNING VALUE(result) TYPE string RAISING cx_static_check,
      to   IMPORTING source TYPE string RETURNING VALUE(result) TYPE xstring RAISING cx_static_check.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_codepage IMPLEMENTATION.
  METHOD from.
    TRY.
        DATA codepage_new TYPE REF TO object.
        DATA(codepage_cls_new) = 'CL_ABAP_CONV_CODEPAGE'.

        " Try using the new class dynamically
        CALL METHOD (codepage_cls_new)=>create_in RECEIVING instance = codepage_new.
        CALL METHOD codepage_new->('IF_ABAP_CONV_IN~CONVERT')
          EXPORTING
            source = source
          RECEIVING
            result = result.

      CATCH cx_sy_dyn_call_illegal_class.
        " Fallback to the old class
        DATA(codepage_cls_old) = 'CL_ABAP_CODEPAGE'.
        CALL METHOD (codepage_cls_old)=>convert_from
          EXPORTING
            source = source
          RECEIVING
            result = result.
    ENDTRY.
  ENDMETHOD.

  METHOD to.
    TRY.
        DATA codepage_new TYPE REF TO object.
        DATA(codepage_cls_new) = 'CL_ABAP_CONV_CODEPAGE'.

        " Try using the new class dynamically
        CALL METHOD (codepage_cls_new)=>create_out RECEIVING instance = codepage_new.
        CALL METHOD codepage_new->('IF_ABAP_CONV_OUT~CONVERT')
          EXPORTING
            source = source
          RECEIVING
            result = result.

      CATCH cx_sy_dyn_call_illegal_class.
        " Fallback to the old class
        DATA(codepage_cls_old) = 'CL_ABAP_CODEPAGE'.
        CALL METHOD (codepage_cls_old)=>convert_to
          EXPORTING
            source = source
          RECEIVING
            result = result.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
