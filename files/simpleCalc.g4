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

bool    : e1=expr op=CMP e2=expr #Compare
        ;

statement   : 'if' '(' b=bool ')' a=assign ('else' s=statement)? #If
            | 'while' '(' b=bool ')' a=assign #While
            | a=assign #ToAssign
            ;

OPPM  : [-+] ;
OPMD  : [*/] ;
CMP   : [<>] | '==' ;
ID    : ALPHA (ALPHA|NUM)* ;
FLOAT : NUM+ ('.' NUM+)? ;

ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;

WHITESPACE : [ \n\t\r]+ -> skip;
COMMENT    : '//'~[\n]*  -> skip;
COMMENT2   : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;
