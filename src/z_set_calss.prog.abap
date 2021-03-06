*&---------------------------------------------------------------------*
*& Include Z_SET_CALSS
*&---------------------------------------------------------------------*
class lcl_set definition final.
  public section.



    types: begin of ty_set ,
             element      type string,
             upperelement type string,
           end of ty_set.



    methods add
      importing value(iv_element) type string.

    methods delete
      importing value(iv_element) type string.

    methods size
      returning value(rv_size) type i.

    methods clear.

    methods merge_with
      importing value(iv_element) type ref to lcl_set.

    methods has
      importing value(iv_element) type string
      returning value(rv_element) type boolean.

    methods get_data
      importing value(iv_number) type i
      returning value(rv_element) type string.

  private section.
      types: tt_data type sorted table of ty_set with unique key upperelement.

      data: mt_data type tt_data .

endclass.

class lcl_set implementation.

  method get_data.
    data: mw_data type ty_set.
    read table mt_data index iv_number into mw_data.
    rv_element = mw_data-element.
  endmethod.


  method merge_with.
     data element type string.
     data size type i.
     data index type i value 1.
     data: mw_data type ty_set.
     data: lv_upper type string.
     size = iv_element->size( ).
     while index <= size.
       element = iv_element->get_data( index ).
       lv_upper = to_upper( element ).
       mw_data-upperelement = lv_upper.
       mw_data-element = element.
       append mw_data to mt_data.
       index = index + 1.
     endwhile.
  endmethod.

  method has.
    data: mw_data type ty_set.
    data: lv_upper type string.
    lv_upper = to_upper( iv_element ).
    read table mt_data with key upperelement = lv_upper into mw_data.
    if mw_data-upperelement = lv_upper.
      rv_element = abap_true.
    endif.
  endmethod.

  method clear.
    clear mt_data.
  endmethod.

  method add.
    data: mw_data type ty_set.
    data: lv_upper type string.
    lv_upper = to_upper( iv_element ).
    mw_data-upperelement = lv_upper.
    mw_data-element = iv_element.
    append mw_data to mt_data.
  endmethod.

  method delete.
    data: lv_upper type string.
    lv_upper = to_upper( iv_element ).
    delete mt_data where upperelement = lv_upper.
  endmethod.


  method size.
    rv_size = lines( mt_data ).
  endmethod.
endclass.

**********************************************************************
* unit tests
**********************************************************************

class ltcl_test_set definition
  for testing
  risk level harmless
  duration short.

  private section.

    methods do_add for testing.
    methods do_delete for testing.
    methods do_clear for testing.
    methods do_size for testing.
    methods do_has for testing.
    methods do_merge_with for testing.
    methods do_add_ununique_value for testing.

endclass.

class ltcl_test_set implementation.

  method do_merge_with.
    DATA lo_set TYPE REF TO lcl_set.
    CREATE OBJECT lo_set.
    lo_set->add( 'Text1' ).
    lo_set->add( 'Text2' ).
    lo_set->add( 'Text3' ).
    lo_set->add( 'Text4' ).

    DATA lo_set2 TYPE REF TO lcl_set.
    CREATE OBJECT lo_set2.

    lo_set2->add( 'Text5' ).
    lo_set2->add( 'Text6' ).
    lo_set2->add( 'Text7' ).
    lo_set2->add( 'Text8' ).

    lo_set->merge_with( lo_set2 ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_set->size( )
      exp = 8 ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_set->has( 'text8' )
      exp = abap_true ).

  endmethod.

  method do_add.

    data lo_set type ref to lcl_set.

    create object lo_set.



    cl_abap_unit_assert=>assert_equals(
     act = lo_set->size( )
     exp = 0 ).

    lo_set->add( 'First value' ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_set->size( )
      exp = 1 ).

  endmethod.

  method do_delete.

    data lo_set type ref to lcl_set.

    create object lo_set.

    lo_set->add( 'fIRST VALUE' ).

    cl_abap_unit_assert=>assert_equals(
     act = lo_set->size( )
     exp = 1 ).

    lo_set->delete( 'First value' ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_set->size( )
      exp = 0 ).


  endmethod.

  method do_clear.

    data lo_set type ref to lcl_set.

    create object lo_set.

    lo_set->add( 'fIRST VALUE' ).
    lo_set->add( 'second VALUE' ).

    cl_abap_unit_assert=>assert_equals(
     act = lo_set->size( )
     exp = 2 ).

    lo_set->clear( ).

    cl_abap_unit_assert=>assert_equals(
      act = lo_set->size( )
      exp = 0 ).

  endmethod.

  method do_has.
    data lo_set type ref to lcl_set.

    create object lo_set.
    lo_set->add( 'fIRST VALUE' ).
    lo_set->add( 'second VALUE' ).



    cl_abap_unit_assert=>assert_equals(
      act = lo_set->has( 'SECoND vAluE' )
      exp = abap_true ).

  endmethod.

  method do_size.
    data lo_set type ref to lcl_set.

    create object lo_set.

    lo_set->add( 'Text1' ).
    lo_set->add( 'Text2' ).
    lo_set->add( 'Text3' ).
    lo_set->add( 'Text4' ).

    cl_abap_unit_assert=>assert_equals(
     act = lo_set->size( )
     exp = 4 ).

  endmethod.

  method do_add_ununique_value.

    data lo_set type ref to lcl_set.

    create object lo_set.

    lo_set->add( 'Text' ).

    lo_set->add( 'tEXT' ).

  endmethod.
endclass.
