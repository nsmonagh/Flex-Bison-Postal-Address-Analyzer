/*
 * Filename        parse.y
 * Date            03/28/2019
 * Author          Noah Monaghan
 * Email           noah.monaghan@utdallas.edu
 * Course          CS 3377.502 Spring 2019
 * Version         1.0
 * Copyright 2019, All Rights Reserved
 *
 * Description
 *
 *     Cotains the parser grammar with
 *     associated tokens for processing.
 */

%{
  #include "glue.h"
%}

%file-prefix "y"

%union {
  struct {
    int prev;
    int curr;
  } ival;
  char* sval;
}

%token <ival> INTTOKEN
%token <sval> NAMETOKEN IDENTIFIERTOKEN NAME_INITIAL_TOKEN ROMANTOKEN SRTOKEN JRTOKEN 
%token HASHTOKEN COMMATOKEN EOLTOKEN DASHTOKEN

%%
postal_addresses : address_block EOLTOKEN postal_addresses
 | address_block
 ;

address_block : name_part street_address location_part { fprintf(stderr, "\n"); }
 ;

name_part : personal_part last_name suffix_part EOLTOKEN
 | personal_part last_name EOLTOKEN
 | error EOLTOKEN { yyerrok; yyclearin; printf("Bad name-part ... skipping to newline\n"); }
 ;

personal_part : NAMETOKEN { fprintf(stderr, "<FirstName>%s</FirstName>\n", yytext); }
 | NAME_INITIAL_TOKEN { fprintf(stderr, "<FirstName>%s</FirstName>\n", yytext); }
 ;

last_name : NAMETOKEN { fprintf(stderr, "<LastName>%s</LastName>\n", yytext); }
 ;

suffix_part : SRTOKEN { fprintf(stderr, "<Suffix>%s</Suffix>\n", yytext); }
 | JRTOKEN { fprintf(stderr, "<Suffix>%s</Suffix>\n", yytext); }
 | ROMANTOKEN { fprintf(stderr, "<Suffix>%s</Suffix>\n", yytext); }
 ;

street_address : street_number street_name INTTOKEN EOLTOKEN  { fprintf(stderr, "<AptNum>%d</AptNum>\n", yylval.ival.curr); }
 | street_number street_name HASHTOKEN INTTOKEN EOLTOKEN { fprintf(stderr, "<AptNum>%d</AptNum>\n", yylval.ival.curr); }
 | street_number street_name EOLTOKEN
 | error EOLTOKEN { yyerrok; yyclearin; printf("Bad address_line ... skipping to newline\n"); }
 ;

street_number : INTTOKEN { fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", yytext); }
 | IDENTIFIERTOKEN { fprintf(stderr, "<HouseNumber>%s</HouseNumber>\n", yytext); }
 ;

street_name : NAMETOKEN { fprintf(stderr, "<StreetName>%s</StreetName>\n", yytext); }
 ;

location_part : town_name COMMATOKEN state_code zip_code EOLTOKEN
 | error EOLTOKEN { yyerrok; yyclearin; printf("Bad location_line ... skipping to newline\n"); }
 ;

town_name : NAMETOKEN { fprintf(stderr, "<City>%s</City>\n", yytext); }
 ;

state_code : NAMETOKEN { fprintf(stderr, "<State>%s</State>\n", yytext); }
 ;

zip_code : INTTOKEN DASHTOKEN INTTOKEN { fprintf(stderr, "<Zip5>%d</Zip5>\n", yylval.ival.prev); fprintf(stderr, "<Zip4>%d</Zip4>\n", yylval.ival.curr); }
 | INTTOKEN { fprintf(stderr, "<Zip5>%d</Zip5>\n", yylval.ival.curr); }
 ;
%%
