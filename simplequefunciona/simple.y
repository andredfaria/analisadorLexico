%{
#include "analex.c"
#include <stdio.h>
%}

%start ROOT

%token EQ
%token NE
%token LT
%token LE
%token GT
%token GE
%token PLUS
%token MINUS
%token MULT
%token DIVIDE
%token RPAREN
%token LPAREN
%token ASSIGN
%token SEMICOLON
%token IF
%token THEN
%token ELSE
%token FI
%token WHILE
%token DO
%token OD
%token PRINT
%token INT
%token REAL
%token NAME
%token CODE
%token DECL
%token END
%token REPEAT
%token UNTIL
%token DOISPONTOS

%%

ROOT:
    DECL decls CODE stmtseq END  
  ;

decls:
  decls var { }
  | var { }
  ;

var:
  NAME DOISPONTOS tipo SEMICOLON 
  ;

tipo: 
  REAL 
  | INT 
  ;

statement:
    designator ASSIGN expression  {  }
  | PRINT expression {  }             
  | IF expression THEN stmtseq ELSE stmtseq FI {  }   
  | IF expression THEN stmtseq FI {  }   
  | WHILE expression DO stmtseq OD {  }
  | REPEAT stmtseq UNTIL expression  {  }
  ;

stmtseq:
    stmtseq SEMICOLON statement { }
  | statement { }
  ;

expression:
    expr2 { }
  | expr2 EQ expr2 { } 
  | expr2 NE expr2 { }
  | expr2 LT expr2 { }
  | expr2 LE expr2 { }
  | expr2 GT expr2 { }
  | expr2 GE expr2 { }
  ;

expr2:
    expr3 { }
  | expr2 PLUS expr3 { }
  | expr2 MINUS expr3 { }
  ;

expr3:
    expr4 { }
  | expr3 MULT expr4 { }
  | expr3 DIVIDE expr4 { }
  ;

expr4:
    PLUS expr4 { }
  | MINUS expr4 { }
  | LPAREN expression RPAREN { }
  | INT { }
  | REAL { }
  | designator { }
  ;

designator:
    NAME { }
  ;

%%


extern FILE *yyin;

main ()
{
  do { yyparse(); }
  while (!feof(yyin));
}
