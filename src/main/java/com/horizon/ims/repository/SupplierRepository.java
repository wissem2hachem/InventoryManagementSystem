package com.horizon.ims.repository;


import com.horizon.ims.entity.Supplier;
import jakarta.ejb.Stateless;
import jakarta.persistence.*;
import java.util.List;

/**
 * Repository for Supplier Entity
 */
@Stateless
public class SupplierRepository {

    @PersistenceContext
    private EntityManager em;

    public Supplier create(Supplier supplier) {
        em.persist(supplier);
        return supplier;
    }

    public Supplier findById(Long id) {
        return em.find(Supplier.class, id);
    }

    public List<Supplier> findAll() {
        return em.createNamedQuery("Supplier.findAll", Supplier.class)
                .getResultList();
    }

    public Supplier findByName(String name) {
        try {
            return em.createNamedQuery("Supplier.findByName", Supplier.class)
                    .setParameter("name", name)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public List<Supplier> findByNameLike(String name) {
        return em.createNamedQuery("Supplier.findByName", Supplier.class)
                .setParameter("name", "%" + name + "%")
                .getResultList();
    }

    public Supplier update(Supplier supplier) {
        return em.merge(supplier);
    }

    public void delete(Long id) {
        Supplier supplier = em.find(Supplier.class, id);
        if (supplier != null) {
            em.remove(supplier);
        }
    }

    public long getTotalSuppliers() {
        return em.createQuery("SELECT COUNT(s) FROM Supplier s", Long.class)
                .getSingleResult();
    }
}
