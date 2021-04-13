%{
#include <stdio.h>
#include "tableSymboles.h"
#include "tableInstructions.h"

int yylex();
void yyerror (char*);

enum Type type; // = TYPE_INT

%}

%union {
	int nb;
	char * str;
}

%token <nb> tNB
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
%token <str> tMOT
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

%type <nb> Operation
%type <nb> Condition


%%

S : Main;

Main : tINT tMAIN tOB tCB Body {printf("On a reconnu le main \n"); afficherTableSymboles(); afficherTableInstructions();};

Body : tOA DeclaVars Instrs tCA {printf("on est dans le body \n");};

DeclaVars : Declavar DeclaVars 
		  | ;

Declavar : Type NomsVars tPV {printf("déclaration int \n");};

Type : tINT {type = TYPE_INT;} | tCONST tINT {type = TYPE_CONST_INT;};

NomsVars : tMOT AffectationVar {ajouterSymboleTop($1,type,1);} MultiVars 
		 | tMOT {ajouterSymboleTop($1,type,0);} MultiVars;

AffectationVar : tEG Operation {printf("affectation \n");};


MultiVars : tV NomsVars
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

Affectation : tMOT {initialisationSymbole($1);} tEG Operation tPV {printf("affectation \n");};

Operation : Operation tADD Operation {ajouterInstruction(ADD,$1,$3);libererVarTemp(); $$=$1;}
			| Operation tMUL Operation {ajouterInstruction(MUL,$1,$3);libererVarTemp();$$=$1;}
			| Operation tSUB Operation {ajouterInstruction(SOU,$1,$3);libererVarTemp();$$=$1;}
			| Operation tDIV Operation {ajouterInstruction(DIV,$1,$3);libererVarTemp();$$=$1;}
			| tSUB Operation
			| tOB Operation tCB {printf("parenthèses \n");}
			| tMOT {printf("var \n");} {getSymbole($1);}
			| tNB {printf("nombre \n");} {ajouterSymboleBottom(type,1);}
			| Condition
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






