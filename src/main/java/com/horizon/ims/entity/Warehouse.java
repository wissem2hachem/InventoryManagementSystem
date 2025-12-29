package com.horizon.ims.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "warehouses")
@NamedQueries({
        @NamedQuery(name = "Warehouse.findAll",
                query = "SELECT w FROM Warehouse w ORDER BY w.name"),
        @NamedQuery(name = "Warehouse.findByCity",
                query = "SELECT w FROM Warehouse w WHERE w.city = :city")
})
@Data
public class Warehouse implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "warehouse_id")
    private Long id;

    @Column(name = "name", length = 150, nullable = false, unique = true)
    private String name;

    @Column(name = "address", length = 255)
    private String address;

    @Column(name = "city", length = 100)
    private String city;

    @Column(name = "country", length = 100)
    private String country;

    @Column(name = "capacity")
    private Integer capacity;  // Max number of products

    @Column(name = "current_stock")
    private Integer currentStock = 0;  // Current number of products

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;
    public Warehouse() {
        this.createdAt = new Date();
    }
    public Warehouse(String name, String city, Integer capacity) {
        this.name = name;
        this.city = city;
        this.capacity = capacity;
    }

    public Double getOccupancyPercentage() {
        if (capacity == 0) return 0.0;
        return (double) currentStock / capacity * 100;
    }

    @Override
    public String toString() {
        return "Warehouse{id=" + id + ", name='" + name + "', occupancy=" + getOccupancyPercentage() + "%}";
    }
}
