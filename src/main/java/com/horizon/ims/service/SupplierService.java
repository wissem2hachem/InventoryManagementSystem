package com.horizon.ims.service;

import com.horizon.ims.entity.Supplier;
import com.horizon.ims.repository.SupplierRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 * Service for Supplier Business Logic
 */
@Stateless
public class SupplierService {

    @Inject
    private SupplierRepository repository;

    @Transactional
    public Supplier createSupplier(Supplier supplier) {
        if (supplier.getName() == null || supplier.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Supplier name cannot be empty");
        }

        Supplier existing = repository.findByName(supplier.getName());
        if (existing != null) {
            throw new IllegalArgumentException("Supplier with this name already exists");
        }

        return repository.create(supplier);
    }

    public Supplier getSupplier(Long id) {
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid supplier ID");
        }
        Supplier supplier = repository.findById(id);
        if (supplier == null) {
            throw new IllegalArgumentException("Supplier not found with ID: " + id);
        }
        return supplier;
    }

    public List<Supplier> getAllSuppliers() {
        return repository.findAll();
    }

    @Transactional
    public Supplier updateSupplier(Long id, Supplier supplierData) {
        Supplier supplier = repository.findById(id);
        if (supplier == null) {
            throw new IllegalArgumentException("Supplier not found");
        }

        if (supplierData.getName() != null && !supplierData.getName().trim().isEmpty()) {
            supplier.setName(supplierData.getName());
        }
        if (supplierData.getEmail() != null) {
            supplier.setEmail(supplierData.getEmail());
        }
        if (supplierData.getPhone() != null) {
            supplier.setPhone(supplierData.getPhone());
        }
        if (supplierData.getAddress() != null) {
            supplier.setAddress(supplierData.getAddress());
        }
        if (supplierData.getCity() != null) {
            supplier.setCity(supplierData.getCity());
        }
        if (supplierData.getCountry() != null) {
            supplier.setCountry(supplierData.getCountry());
        }
        if (supplierData.getRating() != null && supplierData.getRating() >= 0 && supplierData.getRating() <= 5) {
            supplier.setRating(supplierData.getRating());
        }

        return repository.update(supplier);
    }

    @Transactional
    public void deleteSupplier(Long id) {
        Supplier supplier = repository.findById(id);
        if (supplier == null) {
            throw new IllegalArgumentException("Supplier not found");
        }
        repository.delete(id);
    }

    public long getTotalSuppliers() {
        return repository.getTotalSuppliers();
    }
}
