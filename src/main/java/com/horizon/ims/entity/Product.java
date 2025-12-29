package com.horizon.ims.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "products")
@NamedQueries({
        @NamedQuery(name = "Product.findAll",
                query = "SELECT p FROM Product p ORDER BY p.name"),
        @NamedQuery(name = "Product.findBySku",
                query = "SELECT p FROM Product p WHERE p.sku = :sku"),
        @NamedQuery(name = "Product.findBySupplier",
                query = "SELECT p FROM Product p WHERE p.supplierId = :supplierId"),
        @NamedQuery(name = "Product.findLowStock",
                query = "SELECT p FROM Product p WHERE p.quantity < p.minStockLevel ORDER BY p.quantity ASC")
})
@Data
public class Product implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "product_id")
    private Long id;
    @Column(name = "sku", length = 50, unique = true, nullable = false)
    private String sku;  // Stock Keeping Unit - unique identifier
    @Column(name = "name", length = 200, nullable = false)
    private String name;
    @Column(name = "description", columnDefinition = "TEXT")
    private String description;
    @Column(name = "price", nullable = false)
    private Double price;
    @Column(name = "quantity", nullable = false)
    private Integer quantity = 0;
    @Column(name = "min_stock_level")
    private Integer minStockLevel = 10;  // Alert if below this
    @Column(name = "supplier_id")
    private Long supplierId;  // Foreign key to Supplier
    @Column(name = "category", length = 100)
    private String category;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "updated_at")
    private Date updatedAt;
    // Constructors
    public Product() {
        this.createdAt = new Date();
        this.updatedAt = new Date();
    }
    public Product(String sku, String name, Double price, Long supplierId) {
        this();
        this.sku = sku;
        this.name = name;
        this.price = price;
        this.supplierId = supplierId;
    }

    // Business logic method
    public Boolean isLowStock() {
        return quantity < minStockLevel;
    }
    public Double getTotalValue() {
        return price * quantity;
    }
    @Override
    public String toString() {
        return "Product{sku='" + sku + "', name='" + name + "', qty=" + quantity + "}";
    }

}
