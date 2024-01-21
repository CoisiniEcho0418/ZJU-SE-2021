package Immutable;

public final class UnmodifiableMatrix {
    private final int rows;
    private final int columns;
    private final double[][] data;

    public UnmodifiableMatrix(int rows, int columns, double[][] data) {
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

    public UnmodifiableMatrix setElement(int row, int column, double value) {
        if (row < 0 || row >= rows || column < 0 || column >= columns) {
            throw new IndexOutOfBoundsException("Invalid row or column index");
        }
        double[][] newData = new double[rows][columns];
        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < columns; j++) {
                newData[i][j] = this.data[i][j];
            }
        }
        newData[row][column] = value;
        return new UnmodifiableMatrix(rows, columns, newData);
    }

    // Matrix addition
    public UnmodifiableMatrix add(UnmodifiableMatrix other) {
        if (this.getRows() != other.getRows() || this.getColumns() != other.getColumns()) {
            throw new IllegalArgumentException("Matrices must have the same dimensions for addition.");
        }
        double[][] resultData = new double[this.getRows()][this.getColumns()];
        for (int i = 0; i < this.getRows(); i++) {
            for (int j = 0; j < this.getColumns(); j++) {
                resultData[i][j] = this.getElement(i, j) + other.getElement(i, j);
            }
        }
        return new UnmodifiableMatrix(this.getRows(), this.getColumns(), resultData);
    }

    // Matrix subtract
    public UnmodifiableMatrix subtract(UnmodifiableMatrix other) {
        if (this.getRows() != other.getRows() || this.getColumns() != other.getColumns()) {
            throw new IllegalArgumentException("Matrices must have the same dimensions for subtraction.");
        }
        double[][] resultData = new double[this.getRows()][this.getColumns()];
        for (int i = 0; i < this.getRows(); i++) {
            for (int j = 0; j < this.getColumns(); j++) {
                resultData[i][j] = this.getElement(i, j) - other.getElement(i, j);
            }
        }
        return new UnmodifiableMatrix(this.getRows(), this.getColumns(), resultData);
    }

    // Matrix multiply
    public UnmodifiableMatrix multiply(UnmodifiableMatrix other) {
        if (this.getColumns() != other.getRows()) {
            throw new IllegalArgumentException("Number of columns in the first matrix must match the number of rows in the second matrix.");
        }
        int resultRows = this.getRows();
        int resultColumns = other.getColumns();
        double[][] resultData = new double[resultRows][resultColumns];
        for (int i = 0; i < resultRows; i++) {
            for (int j = 0; j < resultColumns; j++) {
                double sum = 0.0;
                for (int k = 0; k < this.getColumns(); k++) {
                    sum += this.getElement(i, k) * other.getElement(k, j);
                }
                resultData[i][j] = sum;
            }
        }
        return new UnmodifiableMatrix(resultRows, resultColumns, resultData);
    }

    // Matrix transpose
    public UnmodifiableMatrix transpose() {
        int resultRows = this.getColumns();
        int resultColumns = this.getRows();
        double[][] resultData = new double[resultRows][resultColumns];
        for (int i = 0; i < resultRows; i++) {
            for (int j = 0; j < resultColumns; j++) {
                resultData[i][j] = this.getElement(j, i);
            }
        }
        return new UnmodifiableMatrix(resultRows, resultColumns, resultData);
    }

    // Matrix scalarMultiply
    public UnmodifiableMatrix scalarMultiply(double scalar) {
        double[][] resultData = new double[this.getRows()][this.getColumns()];
        for (int i = 0; i < this.getRows(); i++) {
            for (int j = 0; j < this.getColumns(); j++) {
                resultData[i][j] = this.getElement(i, j) * scalar;
            }
        }
        return new UnmodifiableMatrix(this.getRows(), this.getColumns(), resultData);
    }
}
