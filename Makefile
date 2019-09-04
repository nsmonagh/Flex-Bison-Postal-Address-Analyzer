#!/usr/bin/make -f
#
# Filename:        Makefile
# Date:            03/28/2019
# Author:          Noah Monaghan
# Email:           noah.monaghan@utdallas.edu
# Version:         1.1
# Copyright 2019, All Rights Reserved
#
# Description
#
#     Originally derived from an example given
#     courtesy of Dr. Stephen Perkins, this
#     simplified version has been modified to
#     make program4 using implicit rules.

CC = gcc
CFLAGS = -Wall -Werror
LEX = flex
YACC = bison
YFLAGS = -d
PROJECTNAME = assignment_4
EXEC = flexbison
OBJS = parse.o scan.o main.o

.PHONY: all clean

all: $(EXEC)

clean:
	rm -f $(OBJS) *~ y.tab.h scanner parser $(EXEC)

$(EXEC): $(OBJS)
	$(CC) -o $(EXEC) $(OBJS)
	ln -fs ./$(EXEC) scanner
	ln -fs ./$(EXEC) parser

backup:	clean
	@mkdir -p ~/backups; chmod 700 ~/backups
	@$(eval CURDIRNAME := $(shell basename `pwd`))
	@$(eval MKBKUPNAME := ~/backups/$(PROJECTNAME)-$(shell date +'%Y.%m.%d-%H:%M:%S').tar.gz)
	@echo
	@echo Writing Backup file to: $(MKBKUPNAME)
	@echo
	@-tar zcfv $(MKBKUPNAME) ../$(CURDIRNAME)
	@chmod 600 $(MKBKUPNAME)
	@echo
	@echo Done!
