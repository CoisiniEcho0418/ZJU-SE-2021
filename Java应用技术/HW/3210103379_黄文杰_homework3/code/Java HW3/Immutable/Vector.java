package Immutable;

public class Vector {
    private double[] elements;

    public Vector(int size) {
        this.elements = new double[size];
    }

    public Vector(double[] elements) {
        this.elements = elements;
    }

    // getsize
    public int getSize() {
        return elements.length;
    }

    // get方法
    public double getElement(int index) {
        if (index < 0 || index >= elements.length) {
            throw new IndexOutOfBoundsException("Invalid index");
        }
        return elements[index];
    }


    // set方法
    public void setElement(int index, double value) {
        if (index < 0 || index >= elements.length) {
            throw new IndexOutOfBoundsException("Invalid index");
        }
        elements[index] = value;
    }

    // 向量和
    public Vector add(Vector other) {
        if (this.getSize() != other.getSize()) {
            throw new IllegalArgumentException("Vectors must have the same size for addition.");
        }
        Vector result = new Vector(this.getSize());
        for (int i = 0; i < this.getSize(); i++) {
            result.setElement(i, this.getElement(i) + other.getElement(i));
        }
        return result;
    }

    // 向量差
    public Vector subtract(Vector other) {
        if (this.getSize() != other.getSize()) {
            throw new IllegalArgumentException("Vectors must have the same size for subtraction.");
        }
        Vector result = new Vector(this.getSize());
        for (int i = 0; i < this.getSize(); i++) {
            result.setElement(i, this.getElement(i) - other.getElement(i));
        }
        return result;
    }

    // 向量点积
    public double dotProduct(Vector other) {
        if (this.getSize() != other.getSize()) {
            throw new IllegalArgumentException("Vectors must have the same size for dot product.");
        }
        double product = 0.0;
        for (int i = 0; i < this.getSize(); i++) {
            product += this.getElement(i) * other.getElement(i);
        }
        return product;
    }

}
