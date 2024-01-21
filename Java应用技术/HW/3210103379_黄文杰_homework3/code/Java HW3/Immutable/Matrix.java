package Immutable;

public class Matrix {
    private int rows;
    private int columns;
    private double[][] data;

    public Matrix(int rows, int columns) {
        this.rows = rows;
        this.columns = columns;
        data = new double[rows][columns];
    }

    public Matrix(int rows, int columns, double[][] data) {
        this.rows = rows;
        this.columns = columns;
        this.data = new double[rows][columns];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                this.data[i][j] = data[i][j];
            }
        }
    }

    public int getRows() {
        return rows;
    }

    public int getColumns() {
        return columns;
    }

    public double getElement(int row, int column) {
        if (row < 0 || row >= rows || column < 0 || column >= columns) {
            throw new IndexOutOfBoundsException("Invalid row or column index");
        }
        return data[row][column];
    }

    public void setElement(int row, int column, double value) {
        if (row < 0 || row >= rows || column < 0 || column >= columns) {
            throw new IndexOutOfBoundsException("Invalid row or column index");
        }
        data[row][column] = value;
    }

    // 矩阵加法
    public Matrix add(Matrix other) {
        if (this.getRows() != other.getRows() || this.getColumns() != other.getColumns()) {
            throw new IllegalArgumentException("Matrices must have the same dimensions for addition.");
        }
        Matrix result = new Matrix(this.getRows(), this.getColumns());
        for (int i = 0; i < this.getRows(); i++) {
            for (int j = 0; j < this.getColumns(); j++) {
                result.setElement(i, j, this.getElement(i, j) + other.getElement(i, j));
            }
        }
        return result;
    }

    // 矩阵减法
    public Matrix subtract(Matrix other) {
        if (this.getRows() != other.getRows() || this.getColumns() != other.getColumns()) {
            throw new IllegalArgumentException("Matrices must have the same dimensions for addition.");
        }
        Matrix result = new Matrix(this.getRows(), this.getColumns());
        for (int i = 0; i < this.getRows(); i++) {
            for (int j = 0; j < this.getColumns(); j++) {
                result.setElement(i, j, this.getElement(i, j) - other.getElement(i, j));
            }
        }
        return result;
    }

    // 矩阵乘法
    public Matrix multiply(Matrix other) {
        if (this.getColumns() != other.getRows()) {
            throw new IllegalArgumentException("Number of columns in the first matrix must match the number of rows in the second matrix.");
        }
        int resultRows = this.getRows();
        int resultColumns = other.getColumns();
        Matrix result = new Matrix(resultRows, resultColumns);
        for (int i = 0; i < resultRows; i++) {
            for (int j = 0; j < resultColumns; j++) {
                double sum = 0.0;
                for (int k = 0; k < this.getColumns(); k++) {
                    sum += this.getElement(i, k) * other.getElement(k, j);
                }
                result.setElement(i, j, sum);
            }
        }
        return result;
    }

    // 矩阵转置（matrix transpose）
    public Matrix transpose() {
        int resultRows = this.getColumns();
        int resultColumns = this.getRows();
        Matrix result = new Matrix(resultRows, resultColumns);
        for (int i = 0; i < resultRows; i++) {
            for (int j = 0; j < resultColumns; j++) {
                result.setElement(i, j, this.getElement(j, i));
            }
        }
        return result;
    }

    // 矩阵数乘
    public Matrix scalarMultiply(double scalar) {
        Matrix result = new Matrix(this.getRows(), this.getColumns());
        for (int i = 0; i < this.getRows(); i++) {
            for (int j = 0; j < this.getColumns(); j++) {
                result.setElement(i, j, this.getElement(i, j) * scalar);
            }
        }
        return result;
    }
}
