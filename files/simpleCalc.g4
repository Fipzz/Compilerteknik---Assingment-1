grammar simpleCalc;

/* A grammar for arithmetic expressions */

start   : a=assign e=expr EOF ;

expr	: e1=expr '+' e2=expr # Addition
	| e1=expr '*' e2=expr # Multiplication
	| c=FLOAT     	      # Constant
	| x=ID		      # Variable
	| '(' e=expr ')'      # Parenthesis
    | e1=expr '-' e2=expr # Subtraction
    | e1=expr '/' e2=expr # Division
	;
	
assign  : v=VAR '=' e=expr ';' #assignment
    ;

ID    : ALPHA (ALPHA|NUM)* ;
FLOAT : NUM+ ('.' NUM+)? ;

VAR   : ALPHA (ALPHA | NUM)*;
ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;

WHITESPACE : [ \n\t\r]+ -> skip;
COMMENT    : '//'~[\n]*  -> skip;
COMMENT2   : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;
