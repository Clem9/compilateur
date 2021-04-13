%{
#include <stdio.h>

int yylex();
void yyerror (char*);
%}

%union {
	int nb;
	char * str;
}

%token tNB
%token tADD
%token tSUB
%token tOB
%token tCB
%token tPV
%token tMAIN
%token tCONST
%token tOA
%token tCA
%token tINT
%token tMUL
%token tDIV
%token tEG
%token tDOUBLEEG
%token tV
%token tTAB
%token tRL
%token tPRINT
%token tIF
%token tELSE
%token tERROR
%token tMOT
%token tVOID
%token tWHILE
%token tDIFF
%token tSUP
%token tSUPEG
%token tINF
%token tINFEG
%token tAND
%token tOR
%token tNOT


%%

S : Main;

Main : tINT tMAIN tOB tCB Body {printf("On a reconnu le main \n");};

Body : tOA DeclaVars Instrs tCA {printf("on est dans le body \n");};

DeclaVars : Declavar DeclaVars 
		  | ;

Declavar : tINT NomsVars tPV {printf("déclaration int \n");}
		 | tCONST tINT NomsVars tPV {printf("déclaration const int \n");};

NomsVars : tMOT AffectationVar MultiVars 
		 | tMOT MultiVars;

AffectationVar : tEG Operation {printf("affectation \n");};

MultiVars : tV tMOT MultiVars {printf("déclaration \n");}
		  | tV tMOT AffectationVar MultiVars {printf("déclaration + affect \n");} 
		  | ;


Instrs : Instr Instrs
	   | ;

Instr : Print 
	  | If 
	  | While 
	  | Affectation ;

Print : tPRINT tOB tMOT tCB tPV {printf("print \n");};

If : tIF tOB Condition tCB Body {printf("dans if");} 
   |tELSE tIF tOB Condition tCB Body {printf("dans else if");}
   |tELSE Body {printf("dans else");} ;  

While : tWHILE tOB Condition tCB Body {printf("while \n");};

Affectation : tMOT tEG Operation tPV {printf("affectation \n");};

Operation : Operation Op Operation {printf("operation \n");}
			| tOB Operation tCB {printf("parenthèses \n");}
			| tMOT {printf("var \n");}
			| tNB {printf("nombre \n");}
			| Condition
			;

Op : tADD
   | tSUB
   | tMUL
   | tDIV
   ;


Condition : Operation
		  | Condition Cond Condition {printf("Cond\n");} 
		  | tNOT Condition {printf("not \n");}
		  ;
		  

Cond : tAND
     | tOR
     | tDOUBLEEG
     | tDIFF
     | tINF
     | tINFEG
     | tSUP
     | tSUPEG ;


%%

void yyerror(char *s){
  printf("Error : %s\n",s); 
}

int main(void) {
	return yyparse();
}
