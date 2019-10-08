grammar simpleCalc;

/* A grammar for arithmetic expressions */

start   : a=assign e=expr EOF ;

expr	: '(' e=expr ')'      # Parenthesis
        | e1=expr op=OPMD e2=expr # MulDiv
	    | c=FLOAT     	      # Constant
	    | x=ID	    	      # Variable
        | e1=expr op=OPPM e2=expr # AddSub
	;

assign  : v=ID '=' e=expr ';' # Assignment
    | v1=assign v2=assign # SplitAssignment
    | '{' v=assign '}' # AssignSequence
    ;

OPPM  : [-+] ;
OPMD  : [*/] ;
ID    : ALPHA (ALPHA|NUM)* ;
FLOAT : NUM+ ('.' NUM+)? ;

ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;

WHITESPACE : [ \n\t\r]+ -> skip;
COMMENT    : '//'~[\n]*  -> skip;
COMMENT2   : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;
