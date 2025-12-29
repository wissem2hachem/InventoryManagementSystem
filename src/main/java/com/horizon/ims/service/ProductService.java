package com.horizon.ims.service;

import com.horizon.ims.entity.Product;
import com.horizon.ims.repository.ProductRepository;
import jakarta.ejb.Stateless;
import jakarta.inject.Inject;
import jakarta.transaction.Transactional;
import java.util.List;

/**
 * Service for Product Business Logic
 */
@Stateless
public class ProductService {

    @Inject
    private ProductRepository repository;

    // ==================== CREATE ====================
    @Transactional
    public Product createProduct(Product product) {
        // Validation
        if (product.getSku() == null || product.getSku().trim().isEmpty()) {
            throw new IllegalArgumentException("SKU cannot be empty");
        }
        if (product.getName() == null || product.getName().trim().isEmpty()) {
            throw new IllegalArgumentException("Product name cannot be empty");
        }
        if (product.getPrice() == null || product.getPrice() <= 0) {
            throw new IllegalArgumentException("Price must be greater than 0");
        }
        if (repository.findBySku(product.getSku()) != null) {
            throw new IllegalArgumentException("SKU already exists");
        }

        return repository.create(product);
    }

    // ==================== READ ====================
    public Product getProduct(Long id) {
        if (id == null || id <= 0) {
            throw new IllegalArgumentException("Invalid product ID");
        }
        Product product = repository.findById(id);
        if (product == null) {
            throw new IllegalArgumentException("Product not found with ID: " + id);
        }
        return product;
    }

    public List<Product> getAllProducts() {
        return repository.findAll();
    }

    // ==================== UPDATE ====================
    @Transactional
    public Product updateProduct(Long id, Product productData) {
        Product product = repository.findById(id);
        if (product == null) {
            throw new IllegalArgumentException("Product not found");
        }

        if (productData.getName() != null && !productData.getName().trim().isEmpty()) {
            product.setName(productData.getName());
        }
        if (productData.getPrice() != null && productData.getPrice() > 0) {
            product.setPrice(productData.getPrice());
        }
        if (productData.getQuantity() != null && productData.getQuantity() >= 0) {
            product.setQuantity(productData.getQuantity());
        }
        if (productData.getCategory() != null && !productData.getCategory().trim().isEmpty()) {
            product.setCategory(productData.getCategory());
        }
        if (productData.getDescription() != null) {
            product.setDescription(productData.getDescription());
        }
        if (productData.getMinStockLevel() != null && productData.getMinStockLevel() >= 0) {
            product.setMinStockLevel(productData.getMinStockLevel());
        }

        return repository.update(product);
    }

    // ==================== DELETE ====================
    @Transactional
    public void deleteProduct(Long id) {
        Product product = repository.findById(id);
        if (product == null) {
            throw new IllegalArgumentException("Product not found");
        }
        repository.delete(id);
    }

    // ==================== BUSINESS LOGIC ====================
    public List<Product> getLowStockProducts() {
        return repository.findLowStock();
    }

    public List<Product> getProductsBySupplier(Long supplierId) {
        return repository.findBySupplier(supplierId);
    }

    public Double getTotalInventoryValue() {
        return repository.getTotalInventoryValue();
    }

    public long getTotalProducts() {
        return repository.getTotalProducts();
    }

    public long getLowStockCount() {
        return repository.getLowStockCount();
    }
}
