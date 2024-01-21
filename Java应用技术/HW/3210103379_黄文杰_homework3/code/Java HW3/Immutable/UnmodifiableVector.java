package Immutable;
import java.util.Arrays;

public final class UnmodifiableVector {
    private final double[] elements;

    public UnmodifiableVector(int size) {
        this.elements = new double[size];
    }

    // Use Arrays.copyOf to copy the input array, ensuring the immutability of the UnmodifiableVector class
    public UnmodifiableVector(double[] elements) {
        this.elements = Arrays.copyOf(elements, elements.length); // Copy the array to ensure immutability
    }

    public int getSize() {
        return elements.length;
    }

    public double getElement(int index) {
        if (index < 0 || index >= elements.length) {
            throw new IndexOutOfBoundsException("Invalid index");
        }
        return elements[index];
    }

    // Generate a copy of the array
    public double[] getElements() {
        return Arrays.copyOf(elements, elements.length);
    }

    public UnmodifiableVector setElement(int index, double value) {
        if (index < 0 || index >= elements.length) {
            throw new IndexOutOfBoundsException("Invalid index");
        }
        double[] newElements = Arrays.copyOf(elements, elements.length);
        newElements[index] = value;
        return new UnmodifiableVector(newElements);
    }

    // Vector addition
    public UnmodifiableVector add(UnmodifiableVector other) {
        if (this.getSize() != other.getSize()) {
            throw new IllegalArgumentException("Vectors must have the same size for addition.");
        }
        double[] resultElements = new double[this.getSize()];
        for (int i = 0; i < this.getSize(); i++) {
            resultElements[i] = this.getElement(i) + other.getElement(i);
        }
        return new UnmodifiableVector(resultElements);
    }

    // Vector subtraction
    public UnmodifiableVector subtract(UnmodifiableVector other) {
        if (this.getSize() != other.getSize()) {
            throw new IllegalArgumentException("Vectors must have the same size for subtraction.");
        }
        double[] resultElements = new double[this.getSize()];
        for (int i = 0; i < this.getSize(); i++) {
            resultElements[i] = this.getElement(i) - other.getElement(i);
        }
        return new UnmodifiableVector(resultElements);
    }

    // Vector dot product
    public double dotProduct(UnmodifiableVector other) {
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
