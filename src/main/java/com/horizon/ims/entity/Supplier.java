package com.horizon.ims.entity;

import jakarta.persistence.*;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "suppliers")
@NamedQueries({
        @NamedQuery(name = "Supplier.findAll",
                query =
                        "SELECT s FROM Supplier s"),
        @NamedQuery(name = "Supplier.findByName",
                query =
                        "SELECT s FROM Supplier s WHERE s.name LIKE :name")
})
@Data
public class Supplier implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "supplier_id")
    private Long id;
    @Column(name = "name", length = 150, nullable = false, unique = true)
    private String name;
    @Column(name = "email", length = 100, nullable = false, unique = true)
    private String email;
    @Column(name = "phone", length = 20)
    private String phone;
    @Column(name = "address", length = 255)
    private String address;
    @Column(name = "city", length = 100)
    private String city;
    @Column(name = "country", length = 100)
    private String country;
    @Column(name = "rating")
    private Double rating = 5.0;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "created_at")
    private Date createdAt;
    // Constructors
    public Supplier() {
        this.createdAt = new Date();
    }
    public Supplier(String name, String email, String phone) {
        this();
        this.name = name;
        this.email = email;
        this.phone = phone;
    }
    @Override
    public String toString() {
        return "Supplier{id=" + id + ", name='" + name + "', rating=" + rating +
                "}";
    }

}
