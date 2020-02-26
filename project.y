%{
  #include <stdio.h>
  #include "def.c"
  #include <errno.h>

  int yyparse(void);
  int yylex(void);
  int yyerror(char *s);
  void warning(char *s);
  
  extern int yylineno;
  int word_counter=0;
  int count=0;
  int error_count = 0;
  char * name = "";
  int idx=-1;
  int atr_num = 0;
  int sum = 0;
  char buffer[50];
  int product_idx= -1;
  int weight_num=0;
%}

%union {
  int i;
  char *s;
}

%token <s> _PROPERTY
%token <s> _ID
%token <s> _TEXT
%token <s> _NUMBER
%token _LPAREN
%token _RPAREN
%token _COLON
%token _DOT
%token _ASSIGN
%token _SEMICOLON
%token <s> _SYMBOL
%token _ARROW
%token _COMMA

%type <s> atribute atribute_list product_type product_name word
%type <i> weight weights

%%

program
  : 
  | product_types _DOT
  | product_types _DOT products
  ;

product_types
  : product_type
  | product_types product_type
  ;

product_type
	:  _LPAREN atribute_list _RPAREN _ARROW _ID	
	{	
		for(int i=0;i<atr_num;i++) {
			set_name(idx,$5);
			idx--;
		}
		int product_index = check_product($5,PRODUCT);
		if(product_index == -1) {
			idx = insert_product($5,"NOT_PARAM","NO_VALUE",PRODUCT);
			set_atr_num(idx,atr_num);
		}else {
			perror("Product allready defined\n");
			yyerror($5);
			exit(EXIT_FAILURE);
		}
		atr_num=0;
	}
	;

atribute_list
	: atribute
	| atribute_list _COMMA atribute
	;

atribute
	: _PROPERTY _COLON _NUMBER
	{
		atr_num++;
		idx=insert_symbol_attr($1,$3,ATR);
		set_atr_num(idx,atr_num);
	}
	;

products
	: product
	| products product
	;

product
	: _ID 
	{
		name=$1;
	}
	_COLON weights _ASSIGN product_name _SEMICOLON
	{
		printf(" %s , %d\n",$6,$4);
		buffer[0]=0;
		sum=0;
		weight_num=0;
	}
	;

weights
	: weight
	{
		sum += $1;
		$$ = sum;
	}
	| weights _COMMA weight
	{
		sum += $3;
		$$ = sum;
	}
	;
	
product_name 
	: word
	{
		$$=$1;
		strcat(buffer,$1);
		strcat(buffer," ");
	}
	| product_name word
	{
		strcat(buffer,$2);
		strcat(buffer, " ");
		$$=buffer;
	}
	;
	
word
	: _ID
	{
		$$= $1;
	}
	;
	
weight
	: _SYMBOL _PROPERTY
	{
		weight_num++;
		int i = check_symbol_atr(name,$2,ATR,weight_num);
		if(i == -1){
			perror("Atribute not defined\n");
			yyerror($2);
			exit(EXIT_FAILURE);
		}else {
			int value = get_symbol_value(name,$2,ATR);
			$$=value*sym_lookup($1);
		}
	}
	;
	
	


%%

int yyerror(char *s) {
  fprintf(stderr, "\nline %d: ERROR: %s\n", yylineno, s);
  error_count++;
  return 0;
}

void warning(char *s) {
  fprintf(stderr, "\nline %d: WARNING: %s", yylineno, s);
}

int main() {
	init_table();
	print_symbols();
	printf("Postignut rezultat: \n");
	yyparse();
	printf(" \n");
  	return yyparse();
}