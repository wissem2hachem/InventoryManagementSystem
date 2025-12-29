package com.horizon.ims.repository;

import com.horizon.ims.entity.Product;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.List;

/**
 * Repository for Product Entity
 * Handles all database operations for Product
 * @Stateless = EJB component (TomEE manages it)
 */
@Stateless
public class ProductRepository {

    @PersistenceContext
    private EntityManager em;

    // ==================== CREATE ====================
    public Product create(Product product) {
        em.persist(product);
        return product;
    }

    // ==================== READ ====================
    public Product findById(Long id) {
        return em.find(Product.class, id);
    }

    public List<Product> findAll() {
        return em.createNamedQuery("Product.findAll", Product.class)
                .getResultList();
    }

    public Product findBySku(String sku) {
        try {
            return em.createNamedQuery("Product.findBySku", Product.class)
                    .setParameter("sku", sku)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    // ==================== UPDATE ====================
    public Product update(Product product) {
        product.setUpdatedAt(new java.util.Date());
        return em.merge(product);
    }

    // ==================== DELETE ====================
    public void delete(Long id) {
        Product product = em.find(Product.class, id);
        if (product != null) {
            em.remove(product);
        }
    }

    // ==================== BUSINESS QUERIES ====================

    public List<Product> findLowStock() {
        return em.createNamedQuery("Product.findLowStock", Product.class)
                .getResultList();
    }

    public List<Product> findBySupplier(Long supplierId) {
        return em.createNamedQuery("Product.findBySupplier", Product.class)
                .setParameter("supplierId", supplierId)
                .getResultList();
    }

    public Double getTotalInventoryValue() {
        Double result = em.createQuery(
                        "SELECT SUM(p.price * p.quantity) FROM Product p",
                        Double.class)
                .getSingleResult();
        return result != null ? result : 0.0;
    }

    public long getTotalProducts() {
        return em.createQuery("SELECT COUNT(p) FROM Product p", Long.class)
                .getSingleResult();
    }

    public long getLowStockCount() {
        return em.createQuery("SELECT COUNT(p) FROM Product p WHERE p.quantity < p.minStockLevel", Long.class)
                .getSingleResult();
    }
}