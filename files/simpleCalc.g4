grammar simpleCalc;

/* A grammar for arithmetic expressions */

start   : a=assign e=expr EOF ;

expr	: '(' e=expr ')'      # Parenthesis
        | e1=expr op=BOP  e2=expr #Binary
        | '~' e=expr                #Ones
        | e1=expr op=OPMD e2=expr # MulDiv
	    | c=FLOAT     	      # Constant
	    | x=ID	    	      # Variable
        | e1=expr op=OPPM e2=expr # AddSub
    	;

assign  : v=ID '=' e=expr ';' # Assignment
        | a1=assign a2=assign # SplitAssignment
        | '{' a=assign '}' # AssignSequence
        ;

bool    : e1=expr op=CMP e2=expr #Compare
        | '!' b=bool #Not
        | b1=bool '&&' b2=bool #And
        | b1=bool '||' b2=bool #Or
        ;

statement   : 'if' '(' b=bool ')' a=assign ('else' s=statement)? #If
            | 'while' '(' b=bool ')' a=assign #While
            | s1=statement s2=statement # SplitStatement
            | a=assign #ToAssign
            ;

SFT   : '<<' | '>>' ;
BOP   : SFT | [&|^~] ;
OPPM  : [-+] ;
OPMD  : [*/] ;
CMP   : [<>!] | '==' ;
ID    : ALPHA (ALPHA|NUM)* ;
FLOAT : NUM+ ('.' NUM+)? ;

ALPHA : [a-zA-Z_ÆØÅæøå] ;
NUM   : [0-9] ;

WHITESPACE : [ \n\t\r]+ -> skip;
COMMENT    : '//'~[\n]*  -> skip;
COMMENT2   : '/*' (~[*] | '*'~[/]  )*   '*/'  -> skip;
