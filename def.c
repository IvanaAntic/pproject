#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include "def.h"
#define LENGTH   64
#define LENGTH_TABLE 4
SYMBOL_ENTRY symbol_table[LENGTH];
SYM_TABLE symbols[LENGTH_TABLE];
int first_empty=0;

int get_next_empty_element(void){
	if(first_empty<LENGTH){
		return first_empty++;
	}else{
		printf("Compiler error! variable_list overflow!");
		exit(EXIT_FAILURE);
	}
}

int insert_symbol_attr(char *param,char *value,unsigned type){
	int index=get_next_empty_element();
	symbol_table[index].param=param;
	symbol_table[index].value=value;
	symbol_table[index].type=type;
	return index;
}

int insert_product(char* name,char *param,char *value,unsigned type){
	int index=get_next_empty_element();
	symbol_table[index].name=name;
	symbol_table[index].type=type;
	symbol_table[index].param=param;
	symbol_table[index].value=value;
	return index;
	
}

int check_product(char* name,unsigned type){
	int i;
	for(i=0;i<first_empty;i++){
		if(strcmp(symbol_table[i].name,name)==0 && symbol_table[i].type==type ){
			return i; //ako postoji vrati broj
		}
	}
	return -1;		//ako ne postoji vrati minus 1
}

int check_symbol_atr(char* name,char* param,unsigned type,int weight_num){
	int i;
	for(i=0;i<first_empty;i++){
		if(strcmp(symbol_table[i].name,name)==0 && strcmp(symbol_table[i].param,param)==0 && symbol_table[i].type==type  && symbol_table[i].atr_num==weight_num){
			return i; //ako postoji vrati broj
		}
	}
	return -1;
}

int get_symbol_value(char* name,char* param,unsigned type){
	int i;
	for(i=0;i<first_empty;i++){
		if(strcmp(symbol_table[i].name,name)==0 && strcmp(symbol_table[i].param,param)==0 && symbol_table[i].type==type ){
			return atoi(symbol_table[i].value);
		}
	}
	return 0;
	
}

int sym_lookup(char* simbol){
	int i;
	for(i=0;i<LENGTH_TABLE;i++){
		if(strcmp(simbol,symbols[i].simbol)==0){
			return symbols[i].vrednost;
		}
	}
	
	return -1;
	
}

void set_atr_num(int index,int atr_num){
	if(index > -1 && index < LENGTH){
		symbol_table[index].atr_num = atr_num;
  }
}

void print_symbol_table(void){
	printf("TABELA SIMBOLA \n");
	for(int i=0; i<first_empty; i++){
		printf("%s",symbol_table[i].name);
		printf("\t%s",symbol_table[i].param);
		printf("\t%s",symbol_table[i].value);
		printf("\t type%u",symbol_table[i].type);
		printf("\t atrnum  %d",symbol_table[i].atr_num);
		printf("\n");
	}
}

void set_name(int index, char *name) {
  if(index > -1 && index < LENGTH){
   symbol_table[index].name = name;
  }
}

void print_symbols() {
	printf("------SYMBOLS-------\n");
	printf("SIMBOL VREDNOST ZNACENJE \n");
	for(int i=0; i<LENGTH_TABLE; i++){
		printf("%s",symbols[i].simbol);
		printf("\t%d",symbols[i].vrednost);
		printf("\t%s",symbols[i].znacenje);
		printf("\n");
	}
	printf("-----------------------\n");
}

void init_table(){
	
	symbols[0].simbol="*";
	symbols[0].znacenje="odlicno";
	symbols[0].vrednost=3;
	
	symbols[1].simbol="+";
	symbols[1].znacenje="dobro";
	symbols[1].vrednost=2;
	
	symbols[2].simbol="/";
	symbols[2].znacenje="dovoljno";
	symbols[2].vrednost=1;
	
	symbols[3].simbol="-";
	symbols[3].znacenje="nedovoljno";
	symbols[3].vrednost=0;
	
}

int lookup_symbol(char *name){
	int i;
	for(i=0;i<first_empty;i++){
		if(strcmp(symbol_table[i].name,name)==0){
			return i;
		}
	}
	return -1;
}