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

class_
: CLASS IDENTIFIER (INHERITS FROM IDENTIFIER)? IS
| var_decl*
//| method_decl*
| END IDENTIFIER
;

var_decl
: IDENTIFIER (COLON type)* (ASSIGNMENT_OPERATOR expression)* CR
;

type
: (INT | STRING | BOOLEAN)
| IDENTIFIER
| type '[' (expression)* ']'
;

expression
: INTEGER_LITERAL
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
: ('a'..'z' | 'A'..'Z' |  '_'). ('0'..'9' | 'a'..'z' | 'A'..'Z' |  '_')*
;

INTEGER_LITERAL
: '-'? ('0'..'9')+
;

STRING_LITERAL
//:'"' ( '\\' [tnfr"\\] | ~[\r\n\\"] )* '"'
:'"' ( '\\' ([tnfr"\\] | ('0'.. '7')('0'.. '7')('0'.. '7'))  | ~[\r\n\\"] )* '"'
//:'"' ( '\\' ([tnfr"\\] | ('0'..'7')('0'..'7')('0'..'7')) | ~[\r\n\\"] )* '"') | ~[\r\n\\"] )* '"'

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