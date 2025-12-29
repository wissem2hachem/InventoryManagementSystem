package com.horizon.ims.service;

import com.horizon.ims.entity.Warehouse;
import com.horizon.ims.repository.WarehouseRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 * Service for Warehouse Business Logic
 */
@Stateless
public class WarehouseService {

    @Inject
    private WarehouseRepository repository;

    @Transactional
    public Warehouse createWarehouse(Warehouse warehouse) {
        if (warehouse.getName() == null || warehouse.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Warehouse name cannot be empty");
        }
        if (warehouse.getCapacity() == null || warehouse.getCapacity() <= 0) {
            throw new IllegalArgumentException("Capacity must be greater than 0");
        }

        return repository.create(warehouse);
    }

    public Warehouse getWarehouse(Long id) {
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid warehouse ID");
        }
        Warehouse warehouse = repository.findById(id);
        if (warehouse == null) {
            throw new IllegalArgumentException("Warehouse not found with ID: " + id);
        }
        return warehouse;
    }

    public List<Warehouse> getAllWarehouses() {
        return repository.findAll();
    }

    @Transactional
    public Warehouse updateWarehouse(Long id, Warehouse warehouseData) {
        Warehouse warehouse = repository.findById(id);
        if (warehouse == null) {
            throw new IllegalArgumentException("Warehouse not found");
        }

        if (warehouseData.getName() != null && !warehouseData.getName().trim().isEmpty()) {
            warehouse.setName(warehouseData.getName());
        }
        if (warehouseData.getCapacity() != null && warehouseData.getCapacity() > 0) {
            warehouse.setCapacity(warehouseData.getCapacity());
        }
        if (warehouseData.getAddress() != null) {
            warehouse.setAddress(warehouseData.getAddress());
        }
        if (warehouseData.getCity() != null) {
            warehouse.setCity(warehouseData.getCity());
        }
        if (warehouseData.getCountry() != null) {
            warehouse.setCountry(warehouseData.getCountry());
        }

        return repository.update(warehouse);
    }

    @Transactional
    public void deleteWarehouse(Long id) {
        Warehouse warehouse = repository.findById(id);
        if (warehouse == null) {
            throw new IllegalArgumentException("Warehouse not found");
        }
        repository.delete(id);
    }

    public Double getOccupancyPercentage(Long id) {
        Warehouse warehouse = repository.findById(id);
        if (warehouse == null) {
            throw new IllegalArgumentException("Warehouse not found");
        }
        return warehouse.getOccupancyPercentage();
    }

    public long getTotalWarehouses() {
        return repository.getTotalWarehouses();
    }
}