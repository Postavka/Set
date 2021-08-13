*&---------------------------------------------------------------------*
*& Report Z_SET
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_SET.
 include Z_SET_TYPES.
 include Z_SET_CALSS.

START-OF-SELECTION.

DATA set TYPE REF TO lcl_set.
CREATE OBJECT set.
set->add( 'Text1' ).
set->add( 'Text2' ).
set->add( 'Text3' ).
set->add( 'Text4' ).
write / 'Dlina:'.
write set->size( ).
if set->has( 'Text2' ) = abap_true.
  write / 'Est v spiske'.
else.
  write / 'net v spiske'.
endif.

set->delete( 'Text2' ).

if set->has( 'Text2' ) = abap_true.
  write / 'Est v spiske'.
else.
  write / 'net v spiske'.
endif.
write / 'Dlina:'.
write set->size( ).
set->clear( ).
write / 'Dlina:'.
write set->size( ).
