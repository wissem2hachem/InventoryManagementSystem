package com.horizon.ims.repository;

import com.horizon.ims.entity.StockLevel;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.List;

/**
 * Repository for StockLevel Entity
 */
@Stateless
public class StockLevelRepository {

    @PersistenceContext
    private EntityManager em;

    public StockLevel create(StockLevel stockLevel) {
        em.persist(stockLevel);
        return stockLevel;
    }

    public StockLevel findById(Long id) {
        return em.find(StockLevel.class, id);
    }

    public List<StockLevel> findByProduct(Long productId) {
        return em.createNamedQuery("StockLevel.findByProduct", StockLevel.class)
                .setParameter("productId", productId)
                .getResultList();
    }

    public List<StockLevel> findByWarehouse(Long warehouseId) {
        return em.createNamedQuery("StockLevel.findByWarehouse", StockLevel.class)
                .setParameter("warehouseId", warehouseId)
                .getResultList();
    }

    public StockLevel update(StockLevel stockLevel) {
        return em.merge(stockLevel);
    }

    public void delete(Long id) {
        StockLevel stockLevel = em.find(StockLevel.class, id);
        if (stockLevel != null) {
            em.remove(stockLevel);
        }
    }
}
