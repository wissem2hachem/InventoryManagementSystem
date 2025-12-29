<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Warehouses Management - Inventory System</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            :root {
                --primary-color: #2c3e50;
                --secondary-color: #f39c12;
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

            .warehouses-table {
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

            .progress {
                height: 25px;
                border-radius: 10px;
            }

            .progress-bar {
                font-weight: 600;
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

            .location-info {
                font-size: 0.9rem;
                color: #7f8c8d;
            }

            .location-info i {
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
                            <a class="nav-link" href="suppliers.jsp">Suppliers</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="warehouses.jsp">Warehouses</a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>

        <div class="container">
            <!-- Page Header -->
            <div class="page-header">
                <div class="d-flex justify-content-between align-items-center">
                    <h1><i class="fas fa-warehouse"></i> Warehouses Management</h1>
                    <button class="btn btn-warning text-white" data-bs-toggle="modal" data-bs-target="#warehouseModal"
                        onclick="openAddModal()">
                        <i class="fas fa-plus"></i> Add Warehouse
                    </button>
                </div>
            </div>

            <!-- Search Bar -->
            <div class="search-bar">
                <div class="row g-3">
                    <div class="col-md-9">
                        <input type="text" class="form-control" id="searchInput"
                            placeholder="Search by name or location...">
                    </div>
                    <div class="col-md-3">
                        <button class="btn btn-secondary w-100" onclick="loadWarehouses()">
                            <i class="fas fa-search"></i> Search
                        </button>
                    </div>
                </div>
            </div>

            <!-- Warehouses Table -->
            <div class="warehouses-table">
                <div id="loadingState" class="loading">
                    <i class="fas fa-spinner fa-spin fa-3x"></i>
                    <p class="mt-3">Loading warehouses...</p>
                </div>
                <div id="emptyState" class="empty-state" style="display: none;">
                    <i class="fas fa-warehouse"></i>
                    <h3>No Warehouses Found</h3>
                    <p>Start by adding your first warehouse</p>
                </div>
                <table class="table table-hover" id="warehousesTable" style="display: none;">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Location</th>
                            <th>Capacity</th>
                            <th>Occupancy</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody id="warehousesTableBody">
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Warehouse Modal -->
        <div class="modal fade" id="warehouseModal" tabindex="-1">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalTitle">Add Warehouse</h5>
                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="warehouseForm">
                            <input type="hidden" id="warehouseId">
                            <div class="row g-3">
                                <div class="col-md-6">
                                    <label class="form-label">Warehouse Name *</label>
                                    <input type="text" class="form-control" id="name" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Location *</label>
                                    <input type="text" class="form-control" id="location" required>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Capacity *</label>
                                    <input type="number" class="form-control" id="capacity" required>
                                    <small class="text-muted">Maximum storage capacity in units</small>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label">Current Occupancy</label>
                                    <input type="number" class="form-control" id="currentOccupancy" value="0">
                                    <small class="text-muted">Current number of units stored</small>
                                </div>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                        <button type="button" class="btn btn-warning text-white" onclick="saveWarehouse()">Save
                            Warehouse</button>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            const API_BASE = '<%= request.getContextPath() %>/api';
            let currentWarehouses = [];

            document.addEventListener('DOMContentLoaded', function () {
                loadWarehouses();
            });

            async function loadWarehouses() {
                showLoading();
                try {
                    const response = await fetch(`${API_BASE}/warehouses`);
                    if (!response.ok) throw new Error('Failed to load warehouses');

                    currentWarehouses = await response.json();
                    displayWarehouses(currentWarehouses);
                } catch (error) {
                    console.error('Error loading warehouses:', error);
                    alert('Failed to load warehouses. Please try again.');
                }
            }

            function displayWarehouses(warehouses) {
                const tbody = document.getElementById('warehousesTableBody');
                const table = document.getElementById('warehousesTable');
                const emptyState = document.getElementById('emptyState');
                const loadingState = document.getElementById('loadingState');

                loadingState.style.display = 'none';

                if (warehouses.length === 0) {
                    table.style.display = 'none';
                    emptyState.style.display = 'block';
                    return;
                }

                emptyState.style.display = 'none';
                table.style.display = 'table';

                tbody.innerHTML = warehouses.map(warehouse => {
                    const occupancyPercent = (warehouse.currentOccupancy / warehouse.capacity * 100).toFixed(1);
                    const progressClass = occupancyPercent > 80 ? 'bg-danger' :
                        occupancyPercent > 50 ? 'bg-warning' : 'bg-success';

                    return `
                <tr>
                    <td><strong>${warehouse.name}</strong></td>
                    <td>
                        <div class="location-info">
                            <i class="fas fa-map-marker-alt"></i> ${warehouse.location}
                        </div>
                    </td>
                    <td>${warehouse.capacity.toLocaleString()} units</td>
                    <td>
                        <div class="mb-1">
                            <small>${warehouse.currentOccupancy.toLocaleString()} / ${warehouse.capacity.toLocaleString()} units</small>
                        </div>
                        <div class="progress">
                            <div class="progress-bar ${progressClass}" role="progressbar" 
                                 style="width: ${occupancyPercent}%" 
                                 aria-valuenow="${occupancyPercent}" 
                                 aria-valuemin="0" 
                                 aria-valuemax="100">
                                ${occupancyPercent}%
                            </div>
                        </div>
                    </td>
                    <td>
                        <button class="btn btn-sm btn-info btn-action" onclick="editWarehouse(${warehouse.id})">
                            <i class="fas fa-edit"></i>
                        </button>
                        <button class="btn btn-sm btn-danger btn-action" onclick="deleteWarehouse(${warehouse.id})">
                            <i class="fas fa-trash"></i>
                        </button>
                    </td>
                </tr>
            `;
                }).join('');
            }

            function showLoading() {
                document.getElementById('loadingState').style.display = 'block';
                document.getElementById('warehousesTable').style.display = 'none';
                document.getElementById('emptyState').style.display = 'none';
            }

            function openAddModal() {
                document.getElementById('modalTitle').textContent = 'Add Warehouse';
                document.getElementById('warehouseForm').reset();
                document.getElementById('warehouseId').value = '';
                document.getElementById('currentOccupancy').value = '0';
            }

            async function editWarehouse(id) {
                try {
                    const response = await fetch(`${API_BASE}/warehouses/${id}`);
                    if (!response.ok) throw new Error('Failed to load warehouse');

                    const warehouse = await response.json();

                    document.getElementById('modalTitle').textContent = 'Edit Warehouse';
                    document.getElementById('warehouseId').value = warehouse.id;
                    document.getElementById('name').value = warehouse.name;
                    document.getElementById('location').value = warehouse.location;
                    document.getElementById('capacity').value = warehouse.capacity;
                    document.getElementById('currentOccupancy').value = warehouse.currentOccupancy || 0;

                    new bootstrap.Modal(document.getElementById('warehouseModal')).show();
                } catch (error) {
                    console.error('Error loading warehouse:', error);
                    alert('Failed to load warehouse details.');
                }
            }

            async function saveWarehouse() {
                const id = document.getElementById('warehouseId').value;
                const warehouse = {
                    name: document.getElementById('name').value,
                    location: document.getElementById('location').value,
                    capacity: parseInt(document.getElementById('capacity').value),
                    currentOccupancy: parseInt(document.getElementById('currentOccupancy').value) || 0
                };

                try {
                    const url = id ? `${API_BASE}/warehouses/${id}` : `${API_BASE}/warehouses`;
                    const method = id ? 'PUT' : 'POST';

                    const response = await fetch(url, {
                        method: method,
                        headers: { 'Content-Type': 'application/json' },
                        body: JSON.stringify(warehouse)
                    });

                    if (!response.ok) throw new Error('Failed to save warehouse');

                    bootstrap.Modal.getInstance(document.getElementById('warehouseModal')).hide();
                    loadWarehouses();
                    alert(id ? 'Warehouse updated successfully!' : 'Warehouse added successfully!');
                } catch (error) {
                    console.error('Error saving warehouse:', error);
                    alert('Failed to save warehouse. Please try again.');
                }
            }

            async function deleteWarehouse(id) {
                if (!confirm('Are you sure you want to delete this warehouse?')) return;

                try {
                    const response = await fetch(`${API_BASE}/warehouses/${id}`, {
                        method: 'DELETE'
                    });

                    if (!response.ok) throw new Error('Failed to delete warehouse');

                    loadWarehouses();
                    alert('Warehouse deleted successfully!');
                } catch (error) {
                    console.error('Error deleting warehouse:', error);
                    alert('Failed to delete warehouse. Please try again.');
                }
            }

            // Search functionality
            document.getElementById('searchInput').addEventListener('input', filterWarehouses);

            function filterWarehouses() {
                const searchTerm = document.getElementById('searchInput').value.toLowerCase();

                let filtered = currentWarehouses.filter(warehouse => {
                    return warehouse.name.toLowerCase().includes(searchTerm) ||
                        warehouse.location.toLowerCase().includes(searchTerm);
                });

                displayWarehouses(filtered);
            }
        </script>
    </body>

    </html>