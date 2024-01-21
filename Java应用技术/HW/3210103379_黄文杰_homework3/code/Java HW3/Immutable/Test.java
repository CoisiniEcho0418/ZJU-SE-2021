package Immutable;

public class Test {

    public static void main(String[] args) {
        testVectorOperations();
        testMatrixOperations();
        testUnmodifiableVector();
        testUnmodifiableMatrix();
    }

    public static void testVectorOperations() {
        Vector v1 = new Vector(new double[]{1.0, 2.0, 3.0});
        Vector v2 = new Vector(new double[]{4.0, 5.0, 6.0});

        // Test vector addition
        Vector resultAdd = v1.add(v2);
        System.out.println("Vector Addition Result:");
        printVector(resultAdd);

        // Test vector subtraction
        Vector resultSubtract = v1.subtract(v2);
        System.out.println("Vector Subtraction Result:");
        printVector(resultSubtract);

        // Test vector dot product
        double dotProduct = v1.dotProduct(v2);
        System.out.println("Vector Dot Product Result: " + dotProduct);
    }

    public static void testMatrixOperations() {
        Matrix m1 = new Matrix(2, 2);
        m1.setElement(0, 0, 1.0);
        m1.setElement(0, 1, 2.0);
        m1.setElement(1, 0, 3.0);
        m1.setElement(1, 1, 4.0);

        Matrix m2 = new Matrix(2, 2);
        m2.setElement(0, 0, 5.0);
        m2.setElement(0, 1, 6.0);
        m2.setElement(1, 0, 7.0);
        m2.setElement(1, 1, 8.0);

        // Test matrix addition
        Matrix resultAdd = m1.add(m2);
        System.out.println("Matrix Addition Result:");
        printMatrix(resultAdd);

        // Test matrix subtraction
        Matrix resultSubtract = m1.subtract(m2);
        System.out.println("Matrix Subtraction Result:");
        printMatrix(resultSubtract);

        // Test matrix multiplication
        Matrix resultMultiply = m1.multiply(m2);
        System.out.println("Matrix Multiplication Result:");
        printMatrix(resultMultiply);

        // Test matrix transpose
        Matrix resultTranspose = m1.transpose();
        System.out.println("Matrix Transpose Result:");
        printMatrix(resultTranspose);

        // Test matrix scalar multiplication
        Matrix resultScalarMultiply = m1.scalarMultiply(2.0);
        System.out.println("Matrix Scalar Multiplication Result:");
        printMatrix(resultScalarMultiply);
    }

    public static void testUnmodifiableVector() {
        double[] elements = { 1.0, 2.0, 3.0 };
        Vector vector = new Vector(elements);
        UnmodifiableVector unmodifiableVector = MathUtils.getUnmodifiableVector(vector);


        // Test getElement method
        double element = unmodifiableVector.getElement(1);
        System.out.println("Element at index 1: " + element);

        // Test setElement method
        UnmodifiableVector modifiedVector = unmodifiableVector.setElement(1, 5.0);
        System.out.println("Original vector: ");
        printVector(unmodifiableVector);
        System.out.println("Modified vector: ");
        printVector(modifiedVector);

        // Verify that the original vector remains unchanged
        System.out.println("Original vector after modification: ");
        printVector(unmodifiableVector);
    }

    public static void testUnmodifiableMatrix() {
        double[][] data = {{1.0, 2.0}, {3.0, 4.0}};
        Matrix matrix = new Matrix(2, 2, data);
        UnmodifiableMatrix unmodifiableMatrix = MathUtils.getUnmodifiableMatrix(matrix);

        // Test getElement method
        double element = unmodifiableMatrix.getElement(1, 1);
        System.out.println("Element at (1, 1): " + element);

        // Test setElement method
        UnmodifiableMatrix modifiedMatrix = unmodifiableMatrix.setElement(1, 1, 5.0);
        System.out.println("Original matrix:");
        printMatrix(unmodifiableMatrix);
        System.out.println("Modified matrix:");
        printMatrix(modifiedMatrix);

        // Verify that the original matrix remains unchanged
        System.out.println("Original matrix after modification:");
        printMatrix(unmodifiableMatrix);
    }

    // Printing function for the Vector class
    public static void printVector(Vector vector) {
        int size = vector.getSize();
        System.out.print("[");
        for (int i = 0; i < size; i++) {
            System.out.print(vector.getElement(i));
            if (i < size - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }

    // Printing function for the UnmodifiableVector class
    public static void printVector(UnmodifiableVector vector) {
        int size = vector.getSize();
        System.out.print("[");
        for (int i = 0; i < size; i++) {
            System.out.print(vector.getElement(i));
            if (i < size - 1) {
                System.out.print(", ");
            }
        }
        System.out.println("]");
    }

    // Printing function for the Matrix class
    public static void printMatrix(Matrix matrix) {
        int rows = matrix.getRows();
        int columns = matrix.getColumns();
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                System.out.print(matrix.getElement(i, j) + " ");
            }
            System.out.println();
        }
    }

    // Printing function for the UnmodifiableMatrix class
    public static void printMatrix(UnmodifiableMatrix matrix) {
        int rows = matrix.getRows();
        int columns = matrix.getColumns();
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                System.out.print(matrix.getElement(i, j) + " ");
            }
            System.out.println();
        }
    }
}

