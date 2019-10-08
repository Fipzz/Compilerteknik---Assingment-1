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
        | v1=assign v2=assign # SplitAssignment
        | '{' v=assign '}' # AssignSequence
        ;

bool    : e1=expr op=CMP e2=expr #Compare
        | '!' e=expr #Not
        | e1=expr '&&' e2=expr #And
        | e1=expr '||' e2=expr #Or
        ;

statement   : 'if' '(' b=bool ')' a=assign ('else' s=statement)? #If
            | 'while' '(' b=bool ')' a=assign #While
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
