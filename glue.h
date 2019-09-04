/*
 * Filename        glue.h
 * Date            03/28/2019
 * Author          Noah Monaghan
 * Email           noah.monaghan@utdallas.edu
 * Course          CS 3377.502 Spring 2019
 * Version         1.0
 * Copyright 2019, All Rights Reserved
 *
 * Description
 *
 *     Puts all shared resources in one place.
 */

#ifndef GLUE_H
#define GLUE_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

void yyerror(const char* s);
int yylex(void);

extern int yylex();
extern int yyparse();
extern char* yytext;

#endif /* GLUE_H */