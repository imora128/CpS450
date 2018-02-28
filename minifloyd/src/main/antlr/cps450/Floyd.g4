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

type returns [Type myType]
: INT	#TypeInt
| STRING	#TypeString
| BOOLEAN	#TypeBool
| IDENTIFIER #TypeID
| type '[' (expression)? ']' #TypeExpr
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

expression returns [Type myType]
:relational_exp
| or_exp
;

or_exp returns [Type myType]
: e1=or_exp OR e2=and_exp
| and_exp
;

and_exp returns [Type myType]
: e1=and_exp AND e2=concat_exp
| concat_exp
;

relational_exp returns [Type myType]
: e1=or_exp GE e2=or_exp
| e1=or_exp GT e2=or_exp
| e1=or_exp EQ e2=or_exp
| or_exp
;

concat_exp returns [Type myType]
: e1=concat_exp AMPERSAND e2=add_exp
| add_exp
;

add_exp returns [Type myType]
: e1=add_exp PLUS e2=multi_exp	#AddPlus_Exp
| e1=add_exp MINUS e2=multi_exp #AddMinus_Exp
| multi_exp	#AddMulti_Exp
;

multi_exp returns [Type myType]
: e1=multi_exp TIMES e2=unary_exp #MultiTimes_Exp
| e1=multi_exp DIV e2=unary_exp	#MultiDIV_Exp
| unary_exp	#MultiUnary_Exp
;

unary_exp returns [Type myType]
: PLUS unary_exp	#UnaryPlus_Exp
| MINUS unary_exp	#UnaryMinus_Exp
| NOT unary_exp		#UnaryNot_Exp
| method_exp		#UnaryMethod_Exp
;

method_exp returns [Type myType]
: e1=method_exp NEW e2=expr_cont	#MethodNew_Exp
| e1=method_exp PERIOD e2=expr_cont	#MethodDot_Exp
| expr_cont							#MethodExpr_Cont
;

expr_cont returns [Type myType]
: IDENTIFIER	#ExprCont_ID
| STRING_LITERAL	#ExprCont_Strlit
| INTEGER_LITERAL 	#ExprCont_Intlit
| TRUE	#ExprCont_True
| FALSE	#ExprCont_False	
| NULL #ExprCont_Null
| ME	#ExprCont_ME
| R_PAR expression L_PAR	#ExprCont_ParExp
| NEW type	#ExprCont_New
| IDENTIFIER '[' expression ']' ('[' expression ']')*
expression PERIOD IDENTIFIER R_PAR (expression_list)? L_PAR #ExprCont_Array
| IDENTIFIER R_PAR (expression_list)? L_PAR #ExprCont_IDExpr
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