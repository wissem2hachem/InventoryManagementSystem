<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Inventory Management System - Dashboard</title>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            :root {
                --primary-color: #2c3e50;
                --secondary-color: #3498db;
                --success-color: #27ae60;
                --warning-color: #f39c12;
                --danger-color: #e74c3c;
                --light-bg: #ecf0f1;
                --white: #ffffff;
                --dark-text: #2c3e50;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
                min-height: 100vh;
                color: var(--dark-text);
            }

            .navbar {
                background: var(--primary-color);
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 1rem 0;
            }

            .navbar-brand {
                font-size: 1.5rem;
                font-weight: 700;
                color: var(--white) !important;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .navbar-brand i {
                color: var(--secondary-color);
            }

            .nav-link {
                color: #bdc3c7 !important;
                transition: all 0.3s ease;
                margin: 0 0.5rem;
            }

            .nav-link:hover {
                color: var(--secondary-color) !important;
                transform: translateY(-2px);
            }

            .container-main {
                padding: 2rem 0;
            }

            .page-header {
                background: var(--white);
                padding: 2rem;
                border-radius: 10px;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
                margin-bottom: 2rem;
            }

            .page-header h1 {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 0.5rem;
                display: flex;
                align-items: center;
                gap: 1rem;
            }

            .page-header p {
                color: #7f8c8d;
                margin: 0;
            }

            .stat-card {
                background: var(--white);
                border-radius: 10px;
                padding: 2rem;
                margin-bottom: 2rem;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                transition: all 0.3s ease;
                border-left: 5px solid var(--secondary-color);
            }

            .stat-card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 30px rgba(0, 0, 0, 0.15);
            }

            .stat-card.products {
                border-left-color: #3498db;
            }

            .stat-card.suppliers {
                border-left-color: #27ae60;
            }

            .stat-card.warehouses {
                border-left-color: #f39c12;
            }

            .stat-card.low-stock {
                border-left-color: #e74c3c;
            }

            .stat-icon {
                font-size: 2.5rem;
                margin-bottom: 1rem;
                display: inline-flex;
                align-items: center;
                justify-content: center;
                width: 60px;
                height: 60px;
                border-radius: 10px;
                background: rgba(52, 152, 219, 0.1);
            }

            .stat-card.suppliers .stat-icon {
                background: rgba(39, 174, 96, 0.1);
                color: var(--success-color);
            }

            .stat-card.products .stat-icon {
                background: rgba(52, 152, 219, 0.1);
                color: var(--secondary-color);
            }

            .stat-card.warehouses .stat-icon {
                background: rgba(243, 156, 18, 0.1);
                color: var(--warning-color);
            }

            .stat-card.low-stock .stat-icon {
                background: rgba(231, 76, 60, 0.1);
                color: var(--danger-color);
            }

            .stat-value {
                font-size: 2.5rem;
                font-weight: 700;
                color: var(--primary-color);
                margin-bottom: 0.5rem;
            }

            .stat-label {
                color: #7f8c8d;
                font-size: 0.95rem;
                text-transform: uppercase;
                letter-spacing: 0.5px;
            }

            .action-buttons {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                gap: 1rem;
                margin-top: 2rem;
            }

            .action-btn {
                padding: 1rem 1.5rem;
                border: none;
                border-radius: 8px;
                font-weight: 600;
                cursor: pointer;
                transition: all 0.3s ease;
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 0.5rem;
                text-decoration: none;
                color: var(--white);
            }

            .action-btn-primary {
                background: linear-gradient(135deg, #3498db 0%, #2980b9 100%);
            }

            .action-btn-primary:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(52, 152, 219, 0.3);
                color: var(--white);
            }

            .action-btn-success {
                background: linear-gradient(135deg, #27ae60 0%, #229954 100%);
            }

            .action-btn-success:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(39, 174, 96, 0.3);
                color: var(--white);
            }

            .action-btn-warning {
                background: linear-gradient(135deg, #f39c12 0%, #d68910 100%);
            }

            .action-btn-warning:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(243, 156, 18, 0.3);
                color: var(--white);
            }

            .action-btn-info {
                background: linear-gradient(135deg, #9b59b6 0%, #8e44ad 100%);
            }

            .action-btn-info:hover {
                transform: translateY(-3px);
                box-shadow: 0 10px 20px rgba(155, 89, 182, 0.3);
                color: var(--white);
            }

            .quick-access {
                background: var(--white);
                border-radius: 10px;
                padding: 2rem;
                box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
                margin-top: 2rem;
            }

            .quick-access h3 {
                color: var(--primary-color);
                font-weight: 700;
                margin-bottom: 1.5rem;
                display: flex;
                align-items: center;
                gap: 0.5rem;
            }

            .loading {
                text-align: center;
                padding: 2rem;
                color: #7f8c8d;
            }

            .loading i {
                font-size: 2rem;
                animation: spin 2s linear infinite;
            }

            @keyframes spin {
                from {
                    transform: rotate(0deg);
                }

                to {
                    transform: rotate(360deg);
                }
            }

            .footer {
                background: var(--primary-color);
                color: var(--white);
                text-align: center;
                padding: 2rem;
                margin-top: 4rem;
                font-size: 0.9rem;
            }

            .alert-info-custom {
                background: linear-gradient(135deg, rgba(52, 152, 219, 0.1), rgba(52, 152, 219, 0.05));
                border-left: 4px solid var(--secondary-color);
                border-radius: 8px;
                padding: 1rem;
                margin-bottom: 1.5rem;
            }

            .feature-grid {
                display: grid;
                grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
                gap: 1rem;
                margin-top: 1rem;
            }

            .feature-item {
                padding: 1rem;
                background: #f8f9fa;
                border-radius: 8px;
                text-align: center;
                font-size: 0.85rem;
                color: #7f8c8d;
            }

            .feature-item i {
                display: block;
                font-size: 1.5rem;
                color: var(--secondary-color);
                margin-bottom: 0.5rem;
            }

            @media (max-width: 768px) {
                .page-header {
                    padding: 1.5rem;
                }

                .page-header h1 {
                    font-size: 1.5rem;
                }

                .action-buttons {
                    grid-template-columns: 1fr;
                }

                .stat-value {
                    font-size: 2rem;
                }
            }
        </style>
    </head>

    <body>
        <!-- Navigation Bar -->
        <nav class="navbar navbar-expand-lg navbar-dark">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <i class="fas fa-cube"></i>
                    Inventory System
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link active" href="index.jsp">Dashboard</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="products.jsp">Products</a>
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

        <!-- Main Content -->
        <div class="container-main">
            <div class="container">
                <!-- Page Header -->
                <div class="page-header">
                    <h1>
                        <i class="fas fa-chart-line"></i>
                        Dashboard
                    </h1>
                    <p>Welcome to your Inventory Management System</p>
                    <div class="alert-info-custom">
                        <i class="fas fa-info-circle"></i>
                        Real-time inventory tracking and management across multiple warehouses and suppliers.
                    </div>
                </div>

                <!-- Statistics Row -->
                <div class="row">
                    <!-- Total Products -->
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card products">
                            <div class="stat-icon">
                                <i class="fas fa-box"></i>
                            </div>
                            <div class="stat-value" id="totalProducts">0</div>
                            <div class="stat-label">Total Products</div>
                        </div>
                    </div>

                    <!-- Total Inventory Value -->
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card suppliers">
                            <div class="stat-icon">
                                <i class="fas fa-dollar-sign"></i>
                            </div>
                            <div class="stat-value" id="totalValue">$0.00</div>
                            <div class="stat-label">Inventory Value</div>
                        </div>
                    </div>

                    <!-- Low Stock Items -->
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card low-stock">
                            <div class="stat-icon">
                                <i class="fas fa-exclamation-triangle"></i>
                            </div>
                            <div class="stat-value" id="lowStockCount">0</div>
                            <div class="stat-label">Low Stock Items</div>
                        </div>
                    </div>

                    <!-- System Status -->
                    <div class="col-md-6 col-lg-3">
                        <div class="stat-card warehouses">
                            <div class="stat-icon">
                                <i class="fas fa-check-circle"></i>
                            </div>
                            <div class="stat-value" style="color: var(--success-color); font-size: 1.2rem;">Online</div>
                            <div class="stat-label">System Status</div>
                        </div>
                    </div>
                </div>

                <!-- Quick Actions -->
                <div class="quick-access">
                    <h3>
                        <i class="fas fa-lightning-bolt"></i>
                        Quick Actions
                    </h3>
                    <div class="action-buttons">
                        <a href="pages/products.jsp" class="action-btn action-btn-primary">
                            <i class="fas fa-box"></i>
                            Manage Products
                        </a>
                        <a href="pages/suppliers.jsp" class="action-btn action-btn-success">
                            <i class="fas fa-handshake"></i>
                            Manage Suppliers
                        </a>
                        <a href="pages/warehouses.jsp" class="action-btn action-btn-warning">
                            <i class="fas fa-warehouse"></i>
                            Manage Warehouses
                        </a>
                        <a href="pages/reports.jsp" class="action-btn action-btn-info">
                            <i class="fas fa-file-alt"></i>
                            View Reports
                        </a>
                    </div>
                </div>

                <!-- Features Section -->
                <div class="quick-access" style="margin-top: 2rem;">
                    <h3>
                        <i class="fas fa-star"></i>
                        Key Features
                    </h3>
                    <div class="feature-grid">
                        <div class="feature-item">
                            <i class="fas fa-sync-alt"></i>
                            Real-time Sync
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-chart-pie"></i>
                            Analytics
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-bell"></i>
                            Alerts
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-search"></i>
                            Smart Search
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-download"></i>
                            Export Data
                        </div>
                        <div class="feature-item">
                            <i class="fas fa-mobile-alt"></i>
                            Mobile Ready
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Footer -->
        <div class="footer">
            <p>&copy; 2025 Inventory Management System. All rights reserved.</p>
            <p style="margin-top: 0.5rem; font-size: 0.85rem;">API Version: 1.0 | Build: Production</p>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
        <script>
            // API Base URL
            const API_BASE_URL = 'http://localhost:8080/inventory/api';

            // Load statistics on page load
            document.addEventListener('DOMContentLoaded', function () {
                loadStatistics();
            });

            // Function to load statistics
            function loadStatistics() {
                // Get Total Products
                fetch(API_BASE_URL + '/stats/total-products')
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('totalProducts').textContent = data.value || 0;
                    })
                    .catch(error => {
                        console.error('Error loading total products:', error);
                        document.getElementById('totalProducts').textContent = 'Error';
                    });

                // Get Total Inventory Value
                fetch(API_BASE_URL + '/stats/total-stock-value')
                    .then(response => response.json())
                    .then(data => {
                        const value = parseFloat(data.value || 0).toFixed(2);
                        document.getElementById('totalValue').textContent = '$' + value;
                    })
                    .catch(error => {
                        console.error('Error loading total value:', error);
                        document.getElementById('totalValue').textContent = 'Error';
                    });

                // Get Low Stock Count
                fetch(API_BASE_URL + '/stats/low-stock-count')
                    .then(response => response.json())
                    .then(data => {
                        document.getElementById('lowStockCount').textContent = data.value || 0;
                    })
                    .catch(error => {
                        console.error('Error loading low stock count:', error);
                        document.getElementById('lowStockCount').textContent = 'Error';
                    });
            }

            // Auto-refresh statistics every 30 seconds
            setInterval(loadStatistics, 30000);
        </script>
    </body>

    </html>