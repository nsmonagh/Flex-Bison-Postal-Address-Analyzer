/*
 * Filename        scan.l
 * Date            03/28/2019
 * Author          Noah Monaghan
 * Email           noah.monaghan@utdallas.edu
 * Course          CS 3377.502 Spring 2019
 * Version         1.0
 * Copyright 2019, All Rights Reserved
 *
 * Description
 *
 *     Cotains the scanner commands with
 *     associated output.
 */

%{
  #include "glue.h"
%}

%option noyywrap
%option nounput
%option noinput

%%
[ \t\r]           { }
[A-Z]\.?          { yylval.sval = strdup(yytext); return NAME_INITIAL_TOKEN; }
IX|IV|V?I{0,3}    { yylval.sval = strdup(yytext); return ROMANTOKEN; }
[A-Za-z]+         { yylval.sval = strdup(yytext); return NAMETOKEN; }
[0-9]+            { yylval.ival.prev = yylval.ival.curr; yylval.ival.curr = atoi(yytext); return INTTOKEN; }
[A-Z0-9]+         { yylval.sval = strdup(yytext); return IDENTIFIERTOKEN;}
Sr.               { yylval.sval = strdup(yytext); return SRTOKEN; }
Jr.               { yylval.sval = strdup(yytext); return JRTOKEN; }
#                 { return HASHTOKEN; }
,                 { return COMMATOKEN; }
\n                { return EOLTOKEN; }
-                 { return DASHTOKEN; }
.                 { }
%%
