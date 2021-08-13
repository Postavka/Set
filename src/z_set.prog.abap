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

DATA set2 TYPE REF TO lcl_set.
CREATE OBJECT set2.

set2->add( 'Text5' ).
set2->add( 'Text6' ).
set2->add( 'Text7' ).
set2->add( 'Text8' ).

set->merge_with( set2 ).
if set->has( 'text8' ).
  write / 'aliluia'.
endif.
