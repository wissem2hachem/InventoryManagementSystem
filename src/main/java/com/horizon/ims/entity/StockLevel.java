package com.horizon.ims.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * StockLevel Entity
 * Tracks how many units of each product are in each warehouse
 * Many-to-many relationship between Product and Warehouse
 * Maps to 'stock_levels' table
 */
@Entity
@Table(name = "stock_levels")
@NamedQueries({
        @NamedQuery(name = "StockLevel.findByProduct",
                query = "SELECT s FROM StockLevel s WHERE s.productId = :productId"),
        @NamedQuery(name = "StockLevel.findByWarehouse",
                query = "SELECT s FROM StockLevel s WHERE s.warehouseId = :warehouseId")
})
@Data
public class StockLevel implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "stock_id")
    private Long id;

    @Column(name = "product_id", nullable = false)
    private Long productId;

    @Column(name = "warehouse_id", nullable = false)
    private Long warehouseId;

    @Column(name = "quantity", nullable = false)
    private Integer quantity = 0;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "last_updated")
    private Date lastUpdated;

    // Constructors
    public StockLevel() {
        this.lastUpdated = new Date();
    }

    public StockLevel(Long productId, Long warehouseId, Integer quantity) {
        this();
        this.productId = productId;
        this.warehouseId = warehouseId;
        this.quantity = quantity;
    }

    @Override
    public String toString() {
        return "StockLevel{" +
                "id=" + id +
                ", productId=" + productId +
                ", warehouseId=" + warehouseId +
                ", quantity=" + quantity +
                '}';
    }

}
