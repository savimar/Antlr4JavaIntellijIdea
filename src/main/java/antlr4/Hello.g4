grammar Hello;
r   : 'hello' ID;
ID  : [a-z]+;
WS  : [ \t\r\n]+ -> skip ;
//WS  :   ('\r' | '\n'| '\t'|/*'\u000C'*/) -> channel(HIDDEN);