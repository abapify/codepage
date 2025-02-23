class tcl_codepage definition final for testing
  INHERITING FROM zcl_assertable_unit
  duration short
  risk level harmless.

  private section.
    methods:
      roundtrip for testing raising cx_static_check.
endclass.


class tcl_codepage implementation.

  method roundtrip.

    data(test) = |This is a sample string|.
    data(lv_binary) = zcl_abap_codepage=>to( test ).
    assert( zcl_abap_codepage=>from( lv_binary ) )->eq( test ).

  endmethod.


endclass.
