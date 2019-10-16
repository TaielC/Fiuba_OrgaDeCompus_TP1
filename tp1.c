#include <stdio.h>
#include <stddef.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>
#include "matrix.h"
#include "mymalloc.h"

int main(int argc, char const *argv[]){

	if (argc>1){
		if (strcmp(argv[1],"-h") == 0 || strcmp(argv[1],"--help") == 0){
			printf("Usage: \n  tp0 -h \n  tp0 -V \n  tp0 < in_file > out_file \nOptions: \n  -V, --version \n  Print version and quit.\n  -h, --help	Print this information and quit.\nExamples:\n  tp0 < in.txt > out.txt\n  cat in.txt | tp0 > out.txt\n");
			exit(EXIT_SUCCESS);
		}
		else { 
			if (strcmp(argv[1],"-V") == 0 || strcmp(argv[1],"--version") == 0){
			printf("Matrix Multiplier \nVersion 1.0 \n");
			exit(EXIT_SUCCESS);
			}
			else {
				fprintf(stderr, "Parametros invalidos. Terminando ejecución.\n");
				exit(EXIT_FAILURE);
			}
		}
	}
	
	size_t i = 0;
	size_t dim;
	matrix_t* matrix1;
	matrix_t* matrix2;
	matrix_t* matrix_result;
	char c;

	while(!feof(stdin)){
		dim = 0;
		fscanf(stdin, " %zu", &dim);

		if(feof(stdin)) 
			exit(EXIT_SUCCESS);
		else if(dim <= 0 && !feof(stdin)){
			fprintf(stderr, "La dimension leida no es valida.\n");
			exit(EXIT_FAILURE);
		}

		// Creación de matrices 1 y 2 a multiplicar
		matrix1 = create_matrix(dim, dim);
		if(!matrix1){
			fprintf(stderr, "Hubo un error al crear una matriz para operar. \n");
			exit(EXIT_FAILURE);
		}
		matrix2 = create_matrix(dim, dim);
		if(!matrix2){
			destroy_matrix(matrix1);
			fprintf(stderr, "Hubo un error al crear una matriz para operar. \n");
			exit(EXIT_FAILURE);
		}

		// Cargado de datos a matrices 
		for(i = 0; i < matrix1->cols*matrix1->rows; i++){
			if(fscanf(stdin, " %lg", &(matrix1->array[i])) != 1){
				destroy_matrix(matrix1);
				destroy_matrix(matrix2);
				fprintf(stderr, "Hubo un error al leer los valores para la primer matriz. \n");
				exit(EXIT_FAILURE);
			}
		}
		for(i = 0; i < matrix1->cols*matrix2->rows; i++){
			if(fscanf(stdin, " %lg", &(matrix2->array[i])) != 1){
				destroy_matrix(matrix1);
				destroy_matrix(matrix2);
				fprintf(stderr, "Hubo un error al leer los valores para la segunda matriz. \n");
				exit(EXIT_FAILURE);
			}
		}	
		
		// Procesamiento de fin de linea 
		// (busqueda de caracteres diferentes a ' ')
		c = (char)getc(stdin);
		while(!feof(stdin) && c == ' '){
			c = (char)getc(stdin);
		}
		if(c != '\n'){
			destroy_matrix(matrix1);
			destroy_matrix(matrix2);
			fprintf(stderr, "Se halló un caracter inválido al final de la linea: %c\n", c);
			exit(EXIT_FAILURE);
		}

		matrix_result = matrix_multiply(matrix1, matrix2);
		print_matrix(stdout, matrix_result);

		destroy_matrix(matrix1);
		destroy_matrix(matrix2);
		// Destruimos la matriz de resultado con la función que fue creada
		free(matrix_result); 	
	}

	return EXIT_SUCCESS;
}
