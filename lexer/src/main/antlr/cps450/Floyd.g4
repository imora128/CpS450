grammar Floyd;

start : ;

BOOLEAN
: 'boolean'
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
//: 'r'? 'n' 
:('\r\n'|'\n'|'\r')
;

WS
   : [ \t] + -> skip
   ;

IDENTIFIER
: ('a'..'z' | 'A'..'Z' | '_')+
;

INTEGER_LITERAL
: ('-')? ('0'..'9')
;
STRING_LITERAL
:'"' ( '\\' [tnfr"\\] | ~[\u000D\u000A\\"] )* '"'
;

PREDEFINED_OPERATOR
: ('&' | '+' | '-' | '*' | '/' | '>' | '>=' | '=')
;

ASSIGNMENT_OPERATOR
: ':='
;

L_PAR
: '('
;

R_PAR
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