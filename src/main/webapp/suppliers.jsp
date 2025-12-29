<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Suppliers Management - Inventory System</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #27ae60;
                --success-color: #27ae60;
                --danger-color: #e74c3c;
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

            .nav-link:hover,
            .nav-link.active {
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

            .suppliers-table {
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

            .contact-info {
                font-size: 0.9rem;
                color: #7f8c8d;
            }

            .contact-info i {
                width: 20px;
                color: var(--secondary-color);
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
                            <a class="nav-link" href="products.jsp">Products</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="suppliers.jsp">Suppliers</a>
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
                    <h1><i class="fas fa-truck"></i> Suppliers Management</h1>
                    <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#supplierModal"
                        onclick="openAddModal()">
                        <i class="fas fa-plus"></i> Add Supplier
                    </button>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="search-bar">
                <div class="row g-3">
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="searchInput"
                            placeholder="Search by name, email, or phone...">
                    </div>
                    <div class="col-md-3">
                        <button class="btn btn-secondary w-100" onclick="loadSuppliers()">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </div>
            </div>

            <!-- Suppliers Table -->
            <div class="suppliers-table">
                <div id="loadingState" class="loading">
                    <i class="fas fa-spinner fa-spin fa-3x"></i>
                    <p class="mt-3">Loading suppliers...</p>
                </div>
                <div id="emptyState" class="empty-state" style="display: none;">
                    <i class="fas fa-truck-loading"></i>
                    <h3>No Suppliers Found</h3>
                    <p>Start by adding your first supplier</p>
                </div>
                <table class="table table-hover" id="suppliersTable" style="display: none;">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Contact Person</th>
                            <th>Contact Info</th>
                            <th>Address</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="suppliersTableBody">
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Supplier Modal -->
        <div class="modal fade" id="supplierModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">Add Supplier</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="supplierForm">
                            <input type="hidden" id="supplierId">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Company Name *</label>
                                    <input type="text" class="form-control" id="name" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Contact Person *</label>
                                    <input type="text" class="form-control" id="contactPerson" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Email *</label>
                                    <input type="email" class="form-control" id="email" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Phone *</label>
                                    <input type="tel" class="form-control" id="phone" required>
                                </div>
                                <div class="col-md-12">
                                    <label class="form-label">Address</label>
                                    <textarea class="form-control" id="address" rows="2"></textarea>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-success" onclick="saveSupplier()">Save Supplier</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            const API_BASE = '<%= request.getContextPath() %>/api';
            let currentSuppliers = [];

            document.addEventListener('DOMContentLoaded', function () {
                loadSuppliers();
            });

            async function loadSuppliers() {
                showLoading();
                try {
                    const response = await fetch(`${API_BASE}/suppliers`);
                    if (!response.ok) throw new Error('Failed to load suppliers');

                    currentSuppliers = await response.json();
                    displaySuppliers(currentSuppliers);
                } catch (error) {
                    console.error('Error loading suppliers:', error);
                    alert('Failed to load suppliers. Please try again.');
                }
            }

            function displaySuppliers(suppliers) {
                const tbody = document.getElementById('suppliersTableBody');
                const table = document.getElementById('suppliersTable');
                const emptyState = document.getElementById('emptyState');
                const loadingState = document.getElementById('loadingState');

                loadingState.style.display = 'none';

                if (suppliers.length === 0) {
                    table.style.display = 'none';
                    emptyState.style.display = 'block';
                    return;
                }

                emptyState.style.display = 'none';
                table.style.display = 'table';

                tbody.innerHTML = suppliers.map(supplier => `
            <tr>
                <td><strong>${supplier.name}</strong></td>
                <td>${supplier.contactPerson || 'N/A'}</td>
                <td>
                    <div class="contact-info">
                        <div><i class="fas fa-envelope"></i> ${supplier.email || 'N/A'}</div>
                        <div><i class="fas fa-phone"></i> ${supplier.phone || 'N/A'}</div>
                    </div>
                </td>
                <td>${supplier.address || 'N/A'}</td>
                <td>
                    <button class="btn btn-sm btn-info btn-action" onclick="editSupplier(${supplier.id})">
                        <i class="fas fa-edit"></i>
                    </button>
                    <button class="btn btn-sm btn-danger btn-action" onclick="deleteSupplier(${supplier.id})">
                        <i class="fas fa-trash"></i>
                    </button>
                </td>
            </tr>
        `).join('');
            }

            function showLoading() {
                document.getElementById('loadingState').style.display = 'block';
                document.getElementById('suppliersTable').style.display = 'none';
                document.getElementById('emptyState').style.display = 'none';
            }

            function openAddModal() {
                document.getElementById('modalTitle').textContent = 'Add Supplier';
                document.getElementById('supplierForm').reset();
                document.getElementById('supplierId').value = '';
            }

            async function editSupplier(id) {
                try {
                    const response = await fetch(`${API_BASE}/suppliers/${id}`);
                    if (!response.ok) throw new Error('Failed to load supplier');

                    const supplier = await response.json();

                    document.getElementById('modalTitle').textContent = 'Edit Supplier';
                    document.getElementById('supplierId').value = supplier.id;
                    document.getElementById('name').value = supplier.name;
                    document.getElementById('contactPerson').value = supplier.contactPerson || '';
                    document.getElementById('email').value = supplier.email || '';
                    document.getElementById('phone').value = supplier.phone || '';
                    document.getElementById('address').value = supplier.address || '';

                    new bootstrap.Modal(document.getElementById('supplierModal')).show();
                } catch (error) {
                    console.error('Error loading supplier:', error);
                    alert('Failed to load supplier details.');
                }
            }

            async function saveSupplier() {
                const id = document.getElementById('supplierId').value;
                const supplier = {
                    name: document.getElementById('name').value,
                    contactPerson: document.getElementById('contactPerson').value,
                    email: document.getElementById('email').value,
                    phone: document.getElementById('phone').value,
                    address: document.getElementById('address').value
                };

                try {
                    const url = id ? `${API_BASE}/suppliers/${id}` : `${API_BASE}/suppliers`;
                    const method = id ? 'PUT' : 'POST';

                    const response = await fetch(url, {
                        method: method,
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(supplier)
                    });

                    if (!response.ok) throw new Error('Failed to save supplier');

                    bootstrap.Modal.getInstance(document.getElementById('supplierModal')).hide();
                    loadSuppliers();
                    alert(id ? 'Supplier updated successfully!' : 'Supplier added successfully!');
                } catch (error) {
                    console.error('Error saving supplier:', error);
                    alert('Failed to save supplier. Please try again.');
                }
            }

            async function deleteSupplier(id) {
                if (!confirm('Are you sure you want to delete this supplier?')) return;

                try {
                    const response = await fetch(`${API_BASE}/suppliers/${id}`, {
                        method: 'DELETE'
                    });

                    if (!response.ok) throw new Error('Failed to delete supplier');

                    loadSuppliers();
                    alert('Supplier deleted successfully!');
                } catch (error) {
                    console.error('Error deleting supplier:', error);
                    alert('Failed to delete supplier. Please try again.');
                }
            }

            // Search functionality
            document.getElementById('searchInput').addEventListener('input', filterSuppliers);

            function filterSuppliers() {
                const searchTerm = document.getElementById('searchInput').value.toLowerCase();

                let filtered = currentSuppliers.filter(supplier => {
                    return supplier.name.toLowerCase().includes(searchTerm) ||
                        (supplier.email && supplier.email.toLowerCase().includes(searchTerm)) ||
                        (supplier.phone && supplier.phone.toLowerCase().includes(searchTerm)) ||
                        (supplier.contactPerson && supplier.contactPerson.toLowerCase().includes(searchTerm));
                });

                displaySuppliers(filtered);
            }
        </script>
    </body>

    </html>