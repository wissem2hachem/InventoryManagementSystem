package com.horizon.ims.repository;

import com.horizon.ims.entity.Warehouse;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.List;

/**
 * Repository for Warehouse Entity
 */
@Stateless
public class WarehouseRepository {

    @PersistenceContext
    private EntityManager em;

    public Warehouse create(Warehouse warehouse) {
        em.persist(warehouse);
        return warehouse;
    }

    public Warehouse findById(Long id) {
        return em.find(Warehouse.class, id);
    }

    public List<Warehouse> findAll() {
        return em.createNamedQuery("Warehouse.findAll", Warehouse.class)
                .getResultList();
    }

    public List<Warehouse> findByCity(String city) {
        return em.createNamedQuery("Warehouse.findByCity", Warehouse.class)
                .setParameter("city", city)
                .getResultList();
    }

    public Warehouse update(Warehouse warehouse) {
        return em.merge(warehouse);
    }

    public void delete(Long id) {
        Warehouse warehouse = em.find(Warehouse.class, id);
        if (warehouse != null) {
            em.remove(warehouse);
        }
    }

    public long getTotalWarehouses() {
        return em.createQuery("SELECT COUNT(w) FROM Warehouse w", Long.class)
                .getSingleResult();
    }

    public List<Warehouse> findHighOccupancyWarehouses(Double threshold) {
        return em.createQuery(
                        "SELECT w FROM Warehouse w WHERE (w.currentStock / w.capacity) > :threshold ORDER BY w.name",
                        Warehouse.class)
                .setParameter("threshold", threshold / 100.0)
                .getResultList();
    }
}
