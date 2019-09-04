/*
 * Filename        main.c
 * Date            03/28/2019
 * Author          Noah Monaghan
 * Email           noah.monaghan@utdallas.edu
 * Course          CS 3377.502 Spring 2019
 * Version         1.0
 * Copyright 2019, All Rights Reserved
 *
 * Description
 *
 *     Contains the execution code to properly
 *     utilize the abilities of the scanner and
 *     the parser for postal address tokenizing.
 */

#include "glue.h"

int main(int argc, char* argv[]) {
  char* command = argv[0];
  
  if (strcmp(command, "scanner") == 0 || strcmp(command, "./scanner") == 0) {
    printf("\nOperating in scan mode\n\n");

    int token = yylex();
    while (token != 0) {
      printf("yylex returned ");
      
      switch (token) {
        case NAME_INITIAL_TOKEN: printf("NAME_INITIAL_TOKEN token (%s)\n", yytext); break;
        case ROMANTOKEN: printf("ROMANTOKEN token (%d)\n", token); break;
        case NAMETOKEN: printf("NAMETOKEN token (%s)\n", yytext); break;
        case INTTOKEN: printf("INTTOKEN token (%s)\n", yytext); break;
        case IDENTIFIERTOKEN: printf("IDENTIFIERTOKEN token (%s)\n", yytext); break;
        case SRTOKEN: printf("SRTOKEN token (%d)\n", token); break;
        case JRTOKEN: printf("JRTOKEN token (%d)\n", token); break;
        case HASHTOKEN: printf("HASHTOKEN token (%d)\n", token); break;
        case COMMATOKEN: printf("COMMATOKEN token (%d)\n", token); break;
        case EOLTOKEN: printf("EOLTOKEN token (%d)\n", token); break;
        case DASHTOKEN: printf("DASHTOKEN token (%d)\n", token); break;
      }

      token = yylex();
    }
  }
  else if (strcmp(command, "parser") == 0 || strcmp(command, "./parser") == 0) {
    printf("\nOperating in parse mode\n\n");

    int value = yyparse();
    if (value == 0)
      printf("\nParse Successful!\n");
    else
      printf("\nParse Failed!\n");
  }
  else {
    printf("%s is not the proper way to call this program\n", command);
  }
  
  return 0;
}

void yyerror(const char* s) {}
