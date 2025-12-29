<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Products Management - Inventory System</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --success-color: #27ae60;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            padding-bottom: 2rem;
        }

        .navbar {
            background: var(--primary-color);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: white !important;
        }

        .nav-link {
            color: #bdc3c7 !important;
            transition: all 0.3s ease;
        }

        .nav-link:hover, .nav-link.active {
            color: var(--secondary-color) !important;
        }

        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin: 2rem 0;
        }

        .page-header h1 {
            color: var(--primary-color);
            font-weight: 700;
            margin: 0;
        }

        .search-bar {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            margin-bottom: 2rem;
        }

        .products-table {
            background: white;
            border-radius: 10px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }

        .table {
            margin: 0;
        }

        .table thead {
            background: var(--primary-color);
            color: white;
        }

        .table tbody tr {
            transition: all 0.2s ease;
        }

        .table tbody tr:hover {
            background: #f8f9fa;
            transform: scale(1.01);
        }

        .btn-action {
            padding: 0.375rem 0.75rem;
            margin: 0 0.25rem;
            border-radius: 5px;
            transition: all 0.3s ease;
        }

        .btn-action:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.2);
        }

        .badge-stock {
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
        }

        .badge-low {
            background: #ffe5e5;
            color: var(--danger-color);
        }

        .badge-normal {
            background: #e8f8f5;
            color: var(--success-color);
        }

        .modal-header {
            background: var(--primary-color);
            color: white;
        }

        .loading {
            text-align: center;
            padding: 3rem;
            color: #7f8c8d;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #7f8c8d;
        }

        .empty-state i {
            font-size: 4rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }
    </style>
</head>
<body>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark">
    <div class="container">
        <a class="navbar-brand" href="index.jsp">
            <i class="fas fa-cube"></i> Inventory System
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav ms-auto">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Dashboard</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="products.jsp">Products</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="suppliers.jsp">Suppliers</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="warehouses.jsp">Warehouses</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <!-- Page Header -->
    <div class="page-header">
        <div class="d-flex justify-content-between align-items-center">
            <h1><i class="fas fa-box"></i> Products Management</h1>
            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#productModal" onclick="openAddModal()">
                <i class="fas fa-plus"></i> Add Product
            </button>
        </div>
    </div>

    <!-- Search Bar -->
    <div class="search-bar">
        <div class="row g-3">
            <div class="col-md-6">
                <input type="text" class="form-control" id="searchInput" placeholder="Search by SKU or name...">
            </div>
            <div class="col-md-3">
                <select class="form-select" id="filterStock">
                    <option value="">All Stock Levels</option>
                    <option value="low">Low Stock</option>
                    <option value="normal">Normal Stock</option>
                </select>
            </div>
            <div class="col-md-3">
                <button class="btn btn-secondary w-100" onclick="loadProducts()">
                    <i class="fas fa-search"></i> Search
                </button>
            </div>
        </div>
    </div>

    <!-- Products Table -->
    <div class="products-table">
        <div id="loadingState" class="loading">
            <i class="fas fa-spinner fa-spin fa-3x"></i>
            <p class="mt-3">Loading products...</p>
        </div>
        <div id="emptyState" class="empty-state" style="display: none;">
            <i class="fas fa-box-open"></i>
            <h3>No Products Found</h3>
            <p>Start by adding your first product</p>
        </div>
        <table class="table table-hover" id="productsTable" style="display: none;">
            <thead>
                <tr>
                    <th>SKU</th>
                    <th>Name</th>
                    <th>Category</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody id="productsTableBody">
            </tbody>
        </table>
    </div>
</div>

<!-- Product Modal -->
<div class="modal fade" id="productModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="modalTitle">Add Product</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="productForm">
                    <input type="hidden" id="productId">
                    <div class="row g-3">
                        <div class="col-md-6">
                            <label class="form-label">SKU *</label>
                            <input type="text" class="form-control" id="sku" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Name *</label>
                            <input type="text" class="form-control" id="name" required>
                        </div>
                        <div class="col-md-12">
                            <label class="form-label">Description</label>
                            <textarea class="form-control" id="description" rows="3"></textarea>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Category *</label>
                            <input type="text" class="form-control" id="category" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label">Unit Price *</label>
                            <input type="number" step="0.01" class="form-control" id="unitPrice" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Quantity *</label>
                            <input type="number" class="form-control" id="quantity" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Min Stock Level *</label>
                            <input type="number" class="form-control" id="minStockLevel" required>
                        </div>
                        <div class="col-md-4">
                            <label class="form-label">Supplier ID</label>
                            <input type="number" class="form-control" id="supplierId">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="button" class="btn btn-primary" onclick="saveProduct()">Save Product</button>
            </div>
        </div>
    </div>
</div>

<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
<script>
    const API_BASE = '<%= request.getContextPath() %>/api';
    let currentProducts = [];

    // Load products on page load
    document.addEventListener('DOMContentLoaded', function() {
        loadProducts();
    });

    async function loadProducts() {
        showLoading();
        try {
            const response = await fetch(`${API_BASE}/products`);
            if (!response.ok) throw new Error('Failed to load products');
            
            currentProducts = await response.json();
            displayProducts(currentProducts);
        } catch (error) {
            console.error('Error loading products:', error);
            alert('Failed to load products. Please try again.');
        }
    }

    function displayProducts(products) {
        const tbody = document.getElementById('productsTableBody');
        const table = document.getElementById('productsTable');
        const emptyState = document.getElementById('emptyState');
        const loadingState = document.getElementById('loadingState');

        loadingState.style.display = 'none';

        if (products.length === 0) {
            table.style.display = 'none';
            emptyState.style.display = 'block';
            return;
        }

        emptyState.style.display = 'none';
        table.style.display = 'table';

        tbody.innerHTML = products.map(product => {
            const isLowStock = product.quantity < product.minStockLevel;
            const stockBadge = isLowStock 
                ? `<span class="badge badge-low">Low Stock</span>`
                : `<span class="badge badge-normal">In Stock</span>`;

            return `
                <tr>
                    <td><strong>${product.sku}</strong></td>
                    <td>${product.name}</td>
                    <td>${product.category || 'N/A'}</td>
                    <td>$${product.unitPrice.toFixed(2)}</td>
                    <td>${product.quantity}</td>
                    <td>${stockBadge}</td>
                    <td>
                        <button class="btn btn-sm btn-info btn-action" onclick="editProduct(${product.id})">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger btn-action" onclick="deleteProduct(${product.id})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
        }).join('');
    }

    function showLoading() {
        document.getElementById('loadingState').style.display = 'block';
        document.getElementById('productsTable').style.display = 'none';
        document.getElementById('emptyState').style.display = 'none';
    }

    function openAddModal() {
        document.getElementById('modalTitle').textContent = 'Add Product';
        document.getElementById('productForm').reset();
        document.getElementById('productId').value = '';
    }

    async function editProduct(id) {
        try {
            const response = await fetch(`${API_BASE}/products/${id}`);
            if (!response.ok) throw new Error('Failed to load product');
            
            const product = await response.json();
            
            document.getElementById('modalTitle').textContent = 'Edit Product';
            document.getElementById('productId').value = product.id;
            document.getElementById('sku').value = product.sku;
            document.getElementById('name').value = product.name;
            document.getElementById('description').value = product.description || '';
            document.getElementById('category').value = product.category || '';
            document.getElementById('unitPrice').value = product.unitPrice;
            document.getElementById('quantity').value = product.quantity;
            document.getElementById('minStockLevel').value = product.minStockLevel;
            document.getElementById('supplierId').value = product.supplierId || '';

            new bootstrap.Modal(document.getElementById('productModal')).show();
        } catch (error) {
            console.error('Error loading product:', error);
            alert('Failed to load product details.');
        }
    }

    async function saveProduct() {
        const id = document.getElementById('productId').value;
        const product = {
            sku: document.getElementById('sku').value,
            name: document.getElementById('name').value,
            description: document.getElementById('description').value,
            category: document.getElementById('category').value,
            unitPrice: parseFloat(document.getElementById('unitPrice').value),
            quantity: parseInt(document.getElementById('quantity').value),
            minStockLevel: parseInt(document.getElementById('minStockLevel').value),
            supplierId: document.getElementById('supplierId').value ? parseInt(document.getElementById('supplierId').value) : null
        };

        try {
            const url = id ? `${API_BASE}/products/${id}` : `${API_BASE}/products`;
            const method = id ? 'PUT' : 'POST';

            const response = await fetch(url, {
                method: method,
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(product)
            });

            if (!response.ok) throw new Error('Failed to save product');

            bootstrap.Modal.getInstance(document.getElementById('productModal')).hide();
            loadProducts();
            alert(id ? 'Product updated successfully!' : 'Product added successfully!');
        } catch (error) {
            console.error('Error saving product:', error);
            alert('Failed to save product. Please try again.');
        }
    }

    async function deleteProduct(id) {
        if (!confirm('Are you sure you want to delete this product?')) return;

        try {
            const response = await fetch(`${API_BASE}/products/${id}`, {
                method: 'DELETE'
            });

            if (!response.ok) throw new Error('Failed to delete product');

            loadProducts();
            alert('Product deleted successfully!');
        } catch (error) {
            console.error('Error deleting product:', error);
            alert('Failed to delete product. Please try again.');
        }
    }

    // Search functionality
    document.getElementById('searchInput').addEventListener('input', filterProducts);
    document.getElementById('filterStock').addEventListener('change', filterProducts);

    function filterProducts() {
        const searchTerm = document.getElementById('searchInput').value.toLowerCase();
        const stockFilter = document.getElementById('filterStock').value;

        let filtered = currentProducts.filter(product => {
            const matchesSearch = product.sku.toLowerCase().includes(searchTerm) || 
                                product.name.toLowerCase().includes(searchTerm);
            
            let matchesStock = true;
            if (stockFilter === 'low') {
                matchesStock = product.quantity < product.minStockLevel;
            } else if (stockFilter === 'normal') {
                matchesStock = product.quantity >= product.minStockLevel;
            }

            return matchesSearch && matchesStock;
        });

        displayProducts(filtered);
    }
</script>
</body>
</html>
