#define DEF_H

// Element tabele simbola
typedef struct sym_entry {
	char * name;          // ime product_type
	char * param;          // parametar1
	char * value;          //value
	unsigned type;
	int atr_num;
} SYMBOL_ENTRY;

typedef struct sym_table {
	char * simbol;          //simbol
	char * znacenje;          // znacenje
	int vrednost;          // vrednost
} SYM_TABLE;

enum types { NO_TYPE, ATR, PRODUCT };

//inicijalizacija sym_table 
void init_table();
//ispis simbola
void print_symbols();

//Upisuje u tabelu simbola proizvoda
int insert_symbol_attr(char *,char *,unsigned);
int get_next_empty_element(void);

//Print symbol_table
void print_symbol_table();

void set_name(int, char *);

//proverava da li postoji vec simbol
int lookup_symbol(char *name);

