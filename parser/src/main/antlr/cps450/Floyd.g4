/*
Name: Italo Moraes (IMORA128)
Class: CpS 450
Filename: Floyd.g4
Description: Contains the rules used to generate the scanner
*/
grammar Floyd;

start 
: CR? class_ (CR class_)* CR?
;

cr 
: CR+
;
class_
: CLASS IDENTIFIER (INHERITS FROM IDENTIFIER)? IS CR var_decl* method_decl* END IDENTIFIER
;

var_decl
: IDENTIFIER (COLON type)? (ASSIGNMENT_OPERATOR expression)? CR
;

method_decl
: IDENTIFIER R_PAR ((argument_decl_list)?) L_PAR (COLON type)? IS CR var_decl* BEGIN CR statement_list END IDENTIFIER CR
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
| type '[' (expression)* ']'
;

//stub
statement_list
: (statement CR)*
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
: IF expression THEN CR statement_list (ELSE CR statement_list)? END IF
;

loop_stmt
: LOOP WHILE expression CR statement_list END LOOP
;

call_stmt
: (expression PERIOD)? IDENTIFIER R_PAR (expression_list)? L_PAR
;

expression_list
: (expression)* expression
;

expression
: INTEGER_LITERAL
;

// expression
// : (IDENTIFIER | STRING_LITERAL | INTEGER_LITERAL | TRUE | FALSE | NULL | ME)
// | NEW type
// | expression binary_op expression
// | unary_op expression
// | R_PAR expression L_PAR
// | (expression PERIOD)? IDENTIFIER R_PAR expression_list? L_PAR
// | IDENTIFIER '[' expression ']' ('[' expression ']')*
// ;
// unary_op
// :
// ;
// binary_op
// :
// ;
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