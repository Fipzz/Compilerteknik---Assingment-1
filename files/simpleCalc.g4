grammar simpleCalc;

/* A grammar for arithmetic expressions */

start   : (s+=statement)* e=expr EOF ;

expr	: '(' e=expr ')'      # Parenthesis
        | e1=expr op=BOP  e2=expr #Binary
        | '~' e=expr                #Ones
        | e1=expr op=OPMD e2=expr # MulDiv
	    | c=FLOAT     	      # Constant
	    | x=ID	    	      # Variable
        | e1=expr op=OPPM e2=expr # AddSub
    	;

assign  : v=ID '=' e=expr ';' # Assignment
        | '{' a=assign '}' # AssignSequence
        ;

bool    : e1=expr op=CMP e2=expr #Compare
        | '!' b=bool #Not
        | b1=bool '&&' b2=bool #And
        | b1=bool '||' b2=bool #Or
        ;

statement   : 'if' '(' b=bool ')' a=assign ('else' s=statement)? #If
            | 'while' '(' b=bool ')' a=assign #While
            | a=assign #ToAssign
            ;

BOP   : SFT | [&|^~] ;
SFT   : '<<' | '>>' ;
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
