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

NOT
: 'not'
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
: '~' ~[\r\n]* CR
;

CR
:('\u000A' | '\u000D''\u000A')
//:('\r\n'|'\n'|'\r')
;

WS
   : [ \r\n\t] + -> skip
   ;

IDENTIFIER
: ('a'..'z' | 'A'..'Z' | '_')+
;