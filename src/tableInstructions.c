#include "tableInstructions.h"
#include <stdio.h>
#include<string.h>

char * print_instructions[12] = {
        "ADD",
        "MUL",
        "SOU",
        "DIV",
        "COP",
        "AFC",
        "JMP",
        "JMF",
        "INF",
        "SUP",
        "EQU",
        "PRI"
};

typedef struct LigneInstruction{
	Instruction instruction;
	int arg1;
	int arg2;
	int arg3;
}LigneInstruction;

struct LigneInstruction tableInstructions[INSTR_TABLE_SIZE];

/* Indice dans la table*/
int indexInstrs = 0; 


/**
 * Affiche la table des instructions
 * @param None
 */
void afficherTableInstructions() {

	printf("	+------------------------------------------------+\n");
	printf("	|                 Code assembleur                |\n");
	printf("	+------------------------------------------------+\n");
	for (int i=0; i < indexInstrs ; i++) {
		printf("	| %2d | %3s | %10d | %10d |%10d |\n",i, print_instructions[tableInstructions[i].instruction], tableInstructions[i].arg1, tableInstructions[i].arg2, tableInstructions[i].arg3);
			printf("	+------------------------------------------------+\n");
	}

}


/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 * @param arg2
 * @return -1 si erreur, 0 si ok
 */
void ajouterInstruction(Instruction instr, int arg1, int arg2){
	if (indexInstrs < 0 ||indexInstrs >= INSTR_TABLE_SIZE){
		printf("Erreur d'ajout au niveau de l'indice \n");
	}
	else{
		LigneInstruction instru;
		instru.instruction = instr;
		instru.arg1 = arg1;
		instru.arg2 = arg1;
		instru.arg3 = arg2;
		tableInstructions[indexInstrs] = instru;
		indexInstrs ++;
	}
}



