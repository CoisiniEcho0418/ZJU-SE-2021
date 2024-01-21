package Immutable;

public class MathUtils {
    public static UnmodifiableVector getUnmodifiableVector(Vector v) {
        double[] elements = new double[v.getSize()];
        for (int i = 0; i < v.getSize(); i++) {
            elements[i] = v.getElement(i);
        }
        return new UnmodifiableVector(elements);
    }

    public static UnmodifiableMatrix getUnmodifiableMatrix(Matrix m) {
        int rows = m.getRows();
        int columns = m.getColumns();
        double[][] data = new double[rows][columns];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                data[i][j] = m.getElement(i, j);
            }
        }
        return new UnmodifiableMatrix(rows, columns, data);
    }
}

