#include "matrix.h"
#include <stdlib.h>
#include <math.h>


// Constructor de matrix_t
matrix_t* create_matrix(size_t rows, size_t cols){
	size_t i;

	if(rows <= 0 && cols <= 0) 
		return NULL;

	matrix_t* matrix = malloc(sizeof(matrix_t));
	if(! matrix)
		return NULL;

	matrix->array = malloc(sizeof(double) * rows * cols);
	if(!matrix->array){ 
		free(matrix);
		return NULL;
	}
	for(i = 0; i < rows * cols; i++) matrix->array[i] = 0;

	matrix -> rows = rows;
	matrix -> cols = cols;

	return matrix;
}

// Destructor de matrix_t
void destroy_matrix(matrix_t* m){
	if(m->array)
		free(m->array);
	if(m)
		free(m);
}

// Imprime matrix_t sobre el file pointer fp en el formato solicitado
// por el enunciado
int print_matrix(FILE* fp, matrix_t* m){
	size_t i;

	fprintf(fp, "%zu ", m->cols);
	for(i = 0; i < m->rows*m->cols; i++)
		fprintf(fp, "%lg ", m->array[i]);
	fprintf(fp, "\n");
	return 0;
}

// // Multiplica las matrices en m1 y m2
// matrix_t* matrix_multiply(matrix_t* m1, matrix_t* m2){

// 	if(!m1 || !m2) 
// 		return NULL;
// 	if(m1->cols != m2->rows) 
// 		return NULL;

// 	matrix_t* m_result = create_matrix(m1->rows, m2->cols);
// 	if(!m_result) 
// 		return NULL;

// 	for(size_t i = 0; i < m1->rows; i++){
// 		for(size_t j = 0; j < m2->cols; j++){
// 			double suma = 0;
// 			for(size_t k = 0; k < m1->cols; k++){
// 				suma += m1->array[i*m1->cols+k] * m2->array[k*m2->cols+j];
// 			}
// 			m_result->array[i*m1->rows+j] = suma;
// 		}
// 	}
// 	return m_result;
// }
