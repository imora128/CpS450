/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Floyd.g4
Description: Contains the rules used to generate the scanner
*/
grammar Floyd;

start 
: cr? class_ (CR class_)* cr?
;

cr 
: CR+
;
class_
: CLASS IDENTIFIER (INHERITS FROM IDENTIFIER)? IS cr var_decl* method_decl* END IDENTIFIER
;

var_decl
: IDENTIFIER (COLON type)? (ASSIGNMENT_OPERATOR expression)? cr
;


method_decl
: IDENTIFIER R_PAR ((argument_decl_list)?) L_PAR (COLON type)? IS cr var_decl* BEGIN cr statement_list END IDENTIFIER cr
;

argument_decl_list
: (argument_decl SEMICOLON)* argument_decl
;

argument_decl
: IDENTIFIER COLON type
;

type
: (INT | STRING | BOOLEAN)
| IDENTIFIER
| type '[' (expression)? ']'
;


statement_list
: (statement cr)*
;

statement
: assignment_stmt
| if_stmt
| loop_stmt
| call_stmt
;

assignment_stmt
: IDENTIFIER ('[' expression ']')* ASSIGNMENT_OPERATOR expression
;

if_stmt
: IF expression THEN cr statement_list (ELSE cr statement_list)? END IF
;

loop_stmt
: LOOP WHILE expression cr statement_list END LOOP
;

call_stmt
: (expression PERIOD)? IDENTIFIER R_PAR (expression_list)? L_PAR
;

expression_list
: (expression COMMA)* expression
;

expression
:relational_exp
| or_exp
;

or_exp
: or_exp OR and_exp
| and_exp
;

and_exp
: and_exp AND concat_exp
| concat_exp
;

relational_exp
: or_exp GE or_exp
| or_exp GT or_exp
| or_exp EQ or_exp
| or_exp
;

concat_exp
: concat_exp AMPERSAND add_exp
| add_exp
;

add_exp
: add_exp PLUS multi_exp
| add_exp MINUS multi_exp
| multi_exp
;

multi_exp
: multi_exp TIMES unary_exp
| multi_exp DIV unary_exp
| unary_exp
;

unary_exp
: PLUS unary_exp
| MINUS unary_exp
| NOT unary_exp
| method_exp
;

method_exp
: method_exp NEW expr_cont
| method_exp PERIOD expr_cont
| expr_cont
;

expr_cont
: IDENTIFIER 
| STRING_LITERAL 
| INTEGER_LITERAL 
| TRUE 
| FALSE 
| NULL 
| ME
| R_PAR expression L_PAR
| NEW type
| IDENTIFIER '[' expression ']' ('[' expression ']')*
expression PERIOD IDENTIFIER R_PAR (expression_list)? L_PAR
| IDENTIFIER R_PAR (expression_list)? L_PAR
;

BOOLEAN
: 'boolean'
;

AND
: 'and'
;

NOT
: 'not'
;

OR
: 'or'
;

BEGIN
: 'begin'
;

CLASS
: 'class'
;

ELSE
: 'else'
;

END
: 'end'
;

FALSE
: 'false'
;

FROM
: 'from'
;

IF
: 'if'
;

INHERITS
: 'inherits'
;

INT
: 'int'
;

IS
: 'is'
;

LOOP
: 'loop'
;

ME
: 'me'
;

NEW
: 'new'
;

NULL
: 'null'
;

STRING
: 'string'
;

THEN
: 'then'
;

TRUE
: 'true'
;

WHILE
: 'while'
;

COMMENT
: '~' ~[\r\n]* -> skip
;

CR
:('\r\n'|'\n'|'\r')
;

LINE_EXTENSION
: '_' CR -> skip
;

WS
   : [ \t] + -> skip
   ;

IDENTIFIER
//: ('a'..'z' | 'A'..'Z' |  '_')+ ('0'..'9' | 'a'..'z' | 'A'..'Z' |  '_')*
: ('a'..'z' | 'A'..'Z' |  '_') ('0'..'9' | 'a'..'z' | 'A'..'Z' |  '_')*
;

INTEGER_LITERAL
: '-'? ('0'..'9')+
;

STRING_LITERAL
:'"' ( '\\' ([tnfr"\\] | ('0'.. '7')('0'.. '7')('0'.. '7'))  | ~[\r\n\\"] )* '"'

;

UNTERMINATED_STRING_ERROR
:'"' ('\\' ["\\] | ~["\\\r\n])*
;

ILLEGAL_STRING_ERROR
:'"' ('\\' [tnfr"\\01234567] | ~[\r\n"])* '"'
;

AMPERSAND
: '&'
;

PLUS
: '+'
;

MINUS
: '-'
;

TIMES
: '*'
;

DIV
: '/'
;

GT
: '>'
;

GE
: '>='
;

EQ
: '='
;

ASSIGNMENT_OPERATOR
: ':='
;

R_PAR
: '('
;

L_PAR
: ')'
;

R_BRACKET
: '['
;

L_BRACKET
: ']'
;

COMMA
: ','
;

SEMICOLON
: ';'
;

COLON
: ':'
;

PERIOD
: '.'
;
UNKNOWN_CHAR
: .
;