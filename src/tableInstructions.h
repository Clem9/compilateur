#ifndef TABLE_INSTRUCTIONS_H
#define TABLE_INSTRUCTIONS_H

#define INSTR_TABLE_SIZE 50

typedef enum Instruction{
	ADD, 
	MUL, 
	SOU, 
	DIV,
	COP,
	AFC,
	JMP,
	JMF,
	INF,
	SUP,
	EQU,
	PRI
}Instruction;

/**
 * Affiche la table des instructions
 * @param None
 */
void afficherTableInstructions();

/**
 * Ajoute une instruction dans la table, à l'indice accessible
 * @param instr
 * @param arg1
 * @param arg2
 * @return -1 si erreur, 0 si ok
 */
void ajouterInstruction(Instruction instr, int arg1, int arg2);


/**
 * Recopie les instructions ASM dans un fichier
 * @param filename
 */
//void genererAsm(char* filename);








#endif