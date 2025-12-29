# Product Inventory Management System

A comprehensive web-based inventory management system built with Jakarta EE, featuring real-time tracking of products, suppliers, and warehouses.

## 📋 Table of Contents

- [Quick Start](#-quick-start-10-minutes)
- [Features](#features)
- [Screenshots](#screenshots)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [API Documentation](#api-documentation)
- [API Testing Examples](#-api-testing-examples)
- [Project Structure](#project-structure)
- [Usage Guide](#usage-guide)
- [Troubleshooting](#troubleshooting)

## ⚡ Quick Start (10 Minutes)

Get up and running fast! Follow these 5 steps:

### Prerequisites Checklist
- [ ] Java JDK 23 installed
- [ ] Maven 3.6+ installed
- [ ] MySQL 8.0+ installed and running
- [ ] GlassFish 7.x or compatible Jakarta EE server

### Step 1: Database Setup (2 minutes)
```bash
# Start MySQL
mysql -u root -p

# Create database
CREATE DATABASE inventory_db;
exit;
```

### Step 2: Configure Database (1 minute)
Use default settings:
- **Database**: `inventory_db`
- **Username**: `root`
- **Password**: (your MySQL password)
- **Host**: `localhost`
- **Port**: `3306`

### Step 3: Build Project (2 minutes)
```bash
cd Product-Inventory-Management-System-master
mvn clean install
```

### Step 4: Deploy to GlassFish (3 minutes)

**Option A: Auto-deploy**
```bash
cp target/IMS.war <glassfish-home>/glassfish/domains/domain1/autodeploy/
```

**Option B: Command Line**
```bash
cd <glassfish-home>/bin
./asadmin start-domain
./asadmin deploy <path-to-project>/target/IMS.war
```

### Step 5: Access Application (1 minute)
```
http://localhost:8080/IMS/
```

### First-Time Usage

**Add Your First Supplier:**
1. Click **Suppliers** → **Add Supplier**
2. Fill in: Company Name, Contact Person, Email, Phone, Address
3. Click **Save**

**Add Your First Product:**
1. Click **Products** → **Add Product**
2. Fill in: SKU (e.g., "LAPTOP-001"), Name, Category, Price, Quantity, Min Stock Level
3. Click **Save Product**

**View Dashboard:**
- Navigate to **Dashboard** to see your statistics update in real-time!

### Quick API Test
```bash
# Test the API
curl http://localhost:8080/IMS/api/products
curl http://localhost:8080/IMS/api/stats/total-products
```

> **Need detailed instructions?** See the [full installation guide](#-installation--setup) below.

## ✨ Features

- **Product Management**: Create, read, update, and delete products with SKU tracking
- **Supplier Management**: Manage supplier information and relationships
- **Warehouse Management**: Track multiple warehouse locations and inventory
- **Real-time Statistics**: Dashboard with live inventory metrics
- **Low Stock Alerts**: Automatic tracking of products below minimum stock levels
- **RESTful API**: Full REST API for all operations
- **Responsive Design**: Modern, mobile-friendly interface
- **Search & Filter**: Advanced search and filtering capabilities

## 📸 Screenshots

### Dashboard
![Dashboard](C:/Users/ASUS/.gemini/antigravity/brain/d4880124-dd42-4b29-8e5b-e3e0d4447edf/dashboard_screenshot_1767037746424.png)

### Products Management
![Products Page](C:/Users/ASUS/.gemini/antigravity/brain/d4880124-dd42-4b29-8e5b-e3e0d4447edf/products_page_screenshot_1767037786913.png)

### Add/Edit Product
![Add Product Modal](C:/Users/ASUS/.gemini/antigravity/brain/d4880124-dd42-4b29-8e5b-e3e0d4447edf/add_product_modal_1767037804539.png)

### Suppliers Management
![Suppliers Page](C:/Users/ASUS/.gemini/antigravity/brain/d4880124-dd42-4b29-8e5b-e3e0d4447edf/suppliers_page_screenshot_1767037826440.png)

### Warehouses Management
![Warehouses Page](C:/Users/ASUS/.gemini/antigravity/brain/d4880124-dd42-4b29-8e5b-e3e0d4447edf/warehouses_page_screenshot_1767037852087.png)

## 🛠 Technology Stack

### Backend
- **Jakarta EE 10** - Enterprise Java platform
- **JAX-RS** - RESTful web services
- **JPA/Hibernate 6.4.5** - Object-relational mapping
- **CDI** - Contexts and Dependency Injection
- **Bean Validation** - Data validation

### Frontend
- **JSP** - JavaServer Pages
- **Bootstrap 5.3** - Responsive UI framework
- **Font Awesome 6.4** - Icons
- **Vanilla JavaScript** - Client-side logic

### Database
- **MySQL 8.0** - Relational database

### Build Tools
- **Maven 3.x** - Dependency management and build automation
- **Java 23** - Programming language

## 📦 Prerequisites

Before you begin, ensure you have the following installed:

1. **Java Development Kit (JDK) 23**
   - Download from [Oracle](https://www.oracle.com/java/technologies/downloads/) or use OpenJDK
   - Verify installation: `java -version`

2. **Apache Maven 3.6+**
   - Download from [Maven](https://maven.apache.org/download.cgi)
   - Verify installation: `mvn -version`

3. **MySQL 8.0+**
   - Download from [MySQL](https://dev.mysql.com/downloads/mysql/)
   - Verify installation: `mysql --version`

4. **Jakarta EE Compatible Application Server**
   - **GlassFish 7.x** (Recommended) - [Download](https://glassfish.org/download)
   - **WildFly 27+** - [Download](https://www.wildfly.org/downloads/)
   - **Payara 6+** - [Download](https://www.payara.fish/downloads/)

5. **IDE (Optional but Recommended)**
   - IntelliJ IDEA Ultimate
   - Eclipse IDE for Enterprise Java Developers
   - NetBeans with Java EE support

## 🚀 Installation & Setup

### Step 1: Clone the Repository

```bash
git clone <repository-url>
cd Product-Inventory-Management-System-master
```

### Step 2: Set Up MySQL Database

1. **Start MySQL Server**
   ```bash
   # Windows
   net start MySQL80
   
   # Linux/Mac
   sudo systemctl start mysql
   ```

2. **Create Database**
   ```bash
   mysql -u root -p
   ```
   
   Then run:
   ```sql
   CREATE DATABASE IF NOT EXISTS inventory_db;
   USE inventory_db;
   ```
   
   Or use the provided SQL file:
   ```bash
   mysql -u root -p < create_db.sql
   ```

3. **Configure Database Credentials**
   
   Create or edit `src/main/resources/META-INF/persistence.xml`:
   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <persistence xmlns="https://jakarta.ee/xml/ns/persistence" version="3.0">
       <persistence-unit name="InventoryPU" transaction-type="JTA">
           <jta-data-source>java:app/jdbc/InventoryDS</jta-data-source>
           <properties>
               <property name="jakarta.persistence.schema-generation.database.action" value="create"/>
               <property name="hibernate.dialect" value="org.hibernate.dialect.MySQLDialect"/>
               <property name="hibernate.show_sql" value="true"/>
           </properties>
       </persistence-unit>
   </persistence>
   ```

### Step 3: Configure Application Server

#### For GlassFish:

1. **Start GlassFish**
   ```bash
   cd <glassfish-installation>/bin
   ./asadmin start-domain
   ```

2. **Create JDBC Connection Pool**
   ```bash
   ./asadmin create-jdbc-connection-pool \
       --datasourceclassname com.mysql.cj.jdbc.MysqlDataSource \
       --restype javax.sql.DataSource \
       --property user=root:password=yourpassword:serverName=localhost:portNumber=3306:databaseName=inventory_db \
       InventoryPool
   ```

3. **Create JDBC Resource**
   ```bash
   ./asadmin create-jdbc-resource \
       --connectionpoolid InventoryPool \
       java:app/jdbc/InventoryDS
   ```

4. **Deploy MySQL Connector**
   - Download MySQL Connector/J from [MySQL](https://dev.mysql.com/downloads/connector/j/)
   - Copy `mysql-connector-j-8.0.33.jar` to `<glassfish>/glassfish/domains/domain1/lib/`
   - Restart GlassFish

#### For WildFly:

1. **Add MySQL Driver Module**
   - Create directory: `<wildfly>/modules/com/mysql/main/`
   - Copy `mysql-connector-j-8.0.33.jar` to this directory
   - Create `module.xml` in the same directory

2. **Configure Datasource**
   - Edit `<wildfly>/standalone/configuration/standalone.xml`
   - Add datasource configuration in the `<datasources>` section

### Step 4: Build the Project

```bash
mvn clean install
```

This will:
- Download all dependencies
- Compile the source code
- Run tests (if any)
- Package the application as a WAR file

### Step 5: Deploy the Application

#### Option A: Using Maven (GlassFish)
```bash
mvn cargo:deploy
```

#### Option B: Manual Deployment

1. **Locate the WAR file**
   ```
   target/IMS.war
   ```

2. **Deploy to Application Server**
   
   **GlassFish:**
   ```bash
   ./asadmin deploy <path-to-project>/target/IMS.war
   ```
   
   **WildFly:**
   ```bash
   cp target/IMS.war <wildfly>/standalone/deployments/
   ```

3. **Access the Application**
   ```
   http://localhost:8080/IMS/
   ```

### Step 6: Verify Installation

1. Open your browser and navigate to `http://localhost:8080/IMS/`
2. You should see the dashboard with statistics
3. Test the API endpoints:
   ```bash
   curl http://localhost:8080/IMS/api/products
   curl http://localhost:8080/IMS/api/suppliers
   curl http://localhost:8080/IMS/api/warehouses
   ```

## 📚 API Documentation

### Base URL
```
http://localhost:8080/IMS/api
```

### Products API

#### Get All Products
```http
GET /api/products
```

**Response:**
```json
[
  {
    "id": 1,
    "sku": "LAPTOP-001",
    "name": "Dell XPS 15",
    "description": "High-performance laptop",
    "category": "Electronics",
    "unitPrice": 1299.99,
    "quantity": 15,
    "minStockLevel": 5,
    "supplierId": 1
  }
]
```

#### Get Product by ID
```http
GET /api/products/{id}
```

**Response:**
```json
{
  "id": 1,
  "sku": "LAPTOP-001",
  "name": "Dell XPS 15",
  "description": "High-performance laptop",
  "category": "Electronics",
  "unitPrice": 1299.99,
  "quantity": 15,
  "minStockLevel": 5,
  "supplierId": 1
}
```

#### Create Product
```http
POST /api/products
Content-Type: application/json
```

**Request Body:**
```json
{
  "sku": "MOUSE-042",
  "name": "Logitech MX Master",
  "description": "Wireless mouse",
  "category": "Accessories",
  "unitPrice": 99.99,
  "quantity": 25,
  "minStockLevel": 10,
  "supplierId": 2
}
```

**Response:** `201 Created`
```json
{
  "id": 2,
  "sku": "MOUSE-042",
  "name": "Logitech MX Master",
  "description": "Wireless mouse",
  "category": "Accessories",
  "unitPrice": 99.99,
  "quantity": 25,
  "minStockLevel": 10,
  "supplierId": 2
}
```

#### Update Product
```http
PUT /api/products/{id}
Content-Type: application/json
```

**Request Body:**
```json
{
  "sku": "MOUSE-042",
  "name": "Logitech MX Master 3",
  "description": "Advanced wireless mouse",
  "category": "Accessories",
  "unitPrice": 109.99,
  "quantity": 30,
  "minStockLevel": 10,
  "supplierId": 2
}
```

**Response:** `200 OK`

#### Delete Product
```http
DELETE /api/products/{id}
```

**Response:** `204 No Content`

#### Get Low Stock Products
```http
GET /api/products/low-stock
```

**Response:**
```json
[
  {
    "id": 3,
    "sku": "KEYBOARD-015",
    "name": "Mechanical Keyboard",
    "quantity": 3,
    "minStockLevel": 10
  }
]
```

#### Get Products by Supplier
```http
GET /api/products/by-supplier/{supplierId}
```

### Suppliers API

#### Get All Suppliers
```http
GET /api/suppliers
```

**Response:**
```json
[
  {
    "id": 1,
    "companyName": "Tech Distributors Inc.",
    "contactPerson": "John Smith",
    "email": "john@techdist.com",
    "phone": "+1-555-0123",
    "address": "123 Tech Street, Silicon Valley, CA 94025"
  }
]
```

#### Create Supplier
```http
POST /api/suppliers
Content-Type: application/json
```

**Request Body:**
```json
{
  "companyName": "Global Electronics Supply",
  "contactPerson": "Jane Doe",
  "email": "jane@globales.com",
  "phone": "+1-555-0456",
  "address": "456 Commerce Blvd, New York, NY 10001"
}
```

#### Update Supplier
```http
PUT /api/suppliers/{id}
```

#### Delete Supplier
```http
DELETE /api/suppliers/{id}
```

### Warehouses API

#### Get All Warehouses
```http
GET /api/warehouses
```

**Response:**
```json
[
  {
    "id": 1,
    "name": "Main Distribution Center",
    "location": "New York, NY",
    "capacity": 10000,
    "manager": "Robert Johnson",
    "contactNumber": "+1-555-0789"
  }
]
```

#### Create Warehouse
```http
POST /api/warehouses
Content-Type: application/json
```

**Request Body:**
```json
{
  "name": "West Coast Warehouse",
  "location": "Los Angeles, CA",
  "capacity": 8000,
  "manager": "Sarah Williams",
  "contactNumber": "+1-555-0321"
}
```

#### Update Warehouse
```http
PUT /api/warehouses/{id}
```

#### Delete Warehouse
```http
DELETE /api/warehouses/{id}
```

### Statistics API

#### Get Total Products
```http
GET /api/stats/total-products
```

**Response:**
```json
{
  "name": "Total Products",
  "value": 47
}
```

#### Get Total Inventory Value
```http
GET /api/stats/total-stock-value
```

**Response:**
```json
{
  "name": "Total Inventory Value",
  "value": 12450.00
}
```

#### Get Low Stock Count
```http
GET /api/stats/low-stock-count
```

**Response:**
```json
{
  "name": "Low Stock Items",
  "value": 5
}
```

#### Get Total Suppliers
```http
GET /api/stats/total-suppliers
```

#### Get Total Warehouses
```http
GET /api/stats/total-warehouses
```

## 🧪 API Testing Examples

### Using cURL

#### Products API Examples

**Get All Products:**
```bash
curl -X GET http://localhost:8080/IMS/api/products \
  -H "Accept: application/json"
```

**Create Product:**
```bash
curl -X POST http://localhost:8080/IMS/api/products \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "sku": "LAPTOP-001",
    "name": "Dell XPS 15",
    "description": "High-performance laptop for professionals",
    "category": "Electronics",
    "unitPrice": 1299.99,
    "quantity": 15,
    "minStockLevel": 5,
    "supplierId": 1
  }'
```

**Update Product:**
```bash
curl -X PUT http://localhost:8080/IMS/api/products/1 \
  -H "Content-Type: application/json" \
  -d '{
    "sku": "LAPTOP-001",
    "name": "Dell XPS 15 (Updated)",
    "description": "High-performance laptop - 2024 model",
    "category": "Electronics",
    "unitPrice": 1399.99,
    "quantity": 20,
    "minStockLevel": 5,
    "supplierId": 1
  }'
```

**Delete Product:**
```bash
curl -X DELETE http://localhost:8080/IMS/api/products/1
```

**Get Low Stock Products:**
```bash
curl -X GET http://localhost:8080/IMS/api/products/low-stock
```

#### Suppliers API Examples

**Create Supplier:**
```bash
curl -X POST http://localhost:8080/IMS/api/suppliers \
  -H "Content-Type: application/json" \
  -d '{
    "companyName": "Tech Distributors Inc.",
    "contactPerson": "John Smith",
    "email": "john@techdist.com",
    "phone": "+1-555-0123",
    "address": "123 Tech Street, Silicon Valley, CA 94025"
  }'
```

#### Warehouses API Examples

**Create Warehouse:**
```bash
curl -X POST http://localhost:8080/IMS/api/warehouses \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Main Distribution Center",
    "location": "New York, NY",
    "capacity": 10000,
    "manager": "Robert Johnson",
    "contactNumber": "+1-555-0789"
  }'
```

#### Statistics API Examples

```bash
# Get all statistics
curl http://localhost:8080/IMS/api/stats/total-products
curl http://localhost:8080/IMS/api/stats/total-stock-value
curl http://localhost:8080/IMS/api/stats/low-stock-count
curl http://localhost:8080/IMS/api/stats/total-suppliers
curl http://localhost:8080/IMS/api/stats/total-warehouses
```

### Using Postman

#### Setup Postman Collection

1. **Create New Collection**: "Inventory Management API"
2. **Add Environment Variable**:
   - Variable: `base_url`
   - Value: `http://localhost:8080/IMS/api`

#### Sample Postman Requests

**1. Get All Products**
- Method: `GET`
- URL: `{{base_url}}/products`
- Headers: `Accept: application/json`

**2. Create Product**
- Method: `POST`
- URL: `{{base_url}}/products`
- Headers: 
  - `Content-Type: application/json`
  - `Accept: application/json`
- Body (raw JSON):
```json
{
  "sku": "MOUSE-042",
  "name": "Logitech MX Master 3",
  "description": "Advanced wireless mouse",
  "category": "Accessories",
  "unitPrice": 99.99,
  "quantity": 25,
  "minStockLevel": 10,
  "supplierId": 1
}
```

**3. Update Product**
- Method: `PUT`
- URL: `{{base_url}}/products/1`
- Headers: `Content-Type: application/json`
- Body: (Same structure as create)

**4. Delete Product**
- Method: `DELETE`
- URL: `{{base_url}}/products/1`

### Using JavaScript (Fetch API)

#### Get All Products
```javascript
fetch('http://localhost:8080/IMS/api/products')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

#### Create Product
```javascript
const product = {
  sku: "LAPTOP-001",
  name: "Dell XPS 15",
  description: "High-performance laptop",
  category: "Electronics",
  unitPrice: 1299.99,
  quantity: 15,
  minStockLevel: 5,
  supplierId: 1
};

fetch('http://localhost:8080/IMS/api/products', {
  method: 'POST',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(product)
})
  .then(response => response.json())
  .then(data => console.log('Success:', data))
  .catch(error => console.error('Error:', error));
```

#### Update Product
```javascript
const updatedProduct = {
  sku: "LAPTOP-001",
  name: "Dell XPS 15 (Updated)",
  description: "High-performance laptop - 2024 model",
  category: "Electronics",
  unitPrice: 1399.99,
  quantity: 20,
  minStockLevel: 5,
  supplierId: 1
};

fetch('http://localhost:8080/IMS/api/products/1', {
  method: 'PUT',
  headers: { 'Content-Type': 'application/json' },
  body: JSON.stringify(updatedProduct)
})
  .then(response => response.json())
  .then(data => console.log('Updated:', data))
  .catch(error => console.error('Error:', error));
```

#### Delete Product
```javascript
fetch('http://localhost:8080/IMS/api/products/1', {
  method: 'DELETE'
})
  .then(response => {
    if (response.ok) {
      console.log('Product deleted successfully');
    }
  })
  .catch(error => console.error('Error:', error));
```

### Sample API Responses

#### Get All Products (200 OK)
```json
[
  {
    "id": 1,
    "sku": "LAPTOP-001",
    "name": "Dell XPS 15",
    "description": "High-performance laptop",
    "category": "Electronics",
    "unitPrice": 1299.99,
    "quantity": 15,
    "minStockLevel": 5,
    "supplierId": 1
  },
  {
    "id": 2,
    "sku": "MOUSE-042",
    "name": "Logitech MX Master 3",
    "description": "Advanced wireless mouse",
    "category": "Accessories",
    "unitPrice": 99.99,
    "quantity": 25,
    "minStockLevel": 10,
    "supplierId": 1
  },
  {
    "id": 3,
    "sku": "KEYBOARD-015",
    "name": "Mechanical Keyboard RGB",
    "description": "Gaming keyboard with RGB lighting",
    "category": "Accessories",
    "unitPrice": 149.99,
    "quantity": 8,
    "minStockLevel": 5,
    "supplierId": 2
  }
]
```

#### Low Stock Products (200 OK)
```json
[
  {
    "id": 3,
    "sku": "KEYBOARD-015",
    "name": "Mechanical Keyboard RGB",
    "description": "Gaming keyboard with RGB lighting",
    "category": "Accessories",
    "unitPrice": 149.99,
    "quantity": 3,
    "minStockLevel": 10,
    "supplierId": 2
  },
  {
    "id": 5,
    "sku": "MONITOR-028",
    "name": "4K Monitor 27 inch",
    "description": "Ultra HD display",
    "category": "Electronics",
    "unitPrice": 399.99,
    "quantity": 2,
    "minStockLevel": 5,
    "supplierId": 1
  }
]
```

#### Error Responses

**Product Not Found (404)**
```json
{
  "error": "Not Found",
  "message": "Product with ID 999 not found"
}
```

**Validation Error (400)**
```json
{
  "error": "Validation Error",
  "message": "SKU cannot be empty"
}
```

**Server Error (500)**
```json
{
  "error": "Internal Server Error",
  "message": "Database connection failed"
}
```

### Testing Workflow

#### 1. Initial Setup Test
```bash
# Test database connection
curl http://localhost:8080/IMS/api/stats/total-products
# Expected: {"name":"Total Products","value":0}
```

#### 2. Create Test Data
```bash
# Create a supplier
curl -X POST http://localhost:8080/IMS/api/suppliers \
  -H "Content-Type: application/json" \
  -d '{
    "companyName": "Test Supplier",
    "contactPerson": "Test Person",
    "email": "test@example.com",
    "phone": "+1-555-0000",
    "address": "123 Test St"
  }'

# Create a product
curl -X POST http://localhost:8080/IMS/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "sku": "TEST-001",
    "name": "Test Product",
    "category": "Test",
    "unitPrice": 10.00,
    "quantity": 5,
    "minStockLevel": 10,
    "supplierId": 1
  }'
```

#### 3. Verify Low Stock Alert
```bash
# Check low stock products (should include TEST-001)
curl http://localhost:8080/IMS/api/products/low-stock
```

#### 4. Update and Verify
```bash
# Update product quantity
curl -X PUT http://localhost:8080/IMS/api/products/1 \
  -H "Content-Type: application/json" \
  -d '{
    "sku": "TEST-001",
    "name": "Test Product",
    "category": "Test",
    "unitPrice": 10.00,
    "quantity": 20,
    "minStockLevel": 10,
    "supplierId": 1
  }'

# Verify it's no longer in low stock
curl http://localhost:8080/IMS/api/products/low-stock
```

#### 5. Clean Up
```bash
# Delete test product
curl -X DELETE http://localhost:8080/IMS/api/products/1

# Delete test supplier
curl -X DELETE http://localhost:8080/IMS/api/suppliers/1
```

### Performance Testing

#### Using Apache Bench
```bash
# Test GET endpoint performance
ab -n 1000 -c 10 http://localhost:8080/IMS/api/products

# Test POST endpoint
ab -n 100 -c 5 -p product.json -T application/json \
  http://localhost:8080/IMS/api/products
```

#### Using wrk
```bash
# Load test
wrk -t12 -c400 -d30s http://localhost:8080/IMS/api/products
```

## 📁 Project Structure

```
Product-Inventory-Management-System/
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── com/horizon/ims/
│   │   │       ├── api/                    # REST API Resources
│   │   │       │   ├── ApplicationConfig.java
│   │   │       │   ├── ProductResource.java
│   │   │       │   ├── SupplierResource.java
│   │   │       │   ├── WarehouseResource.java
│   │   │       │   └── StatisticsResource.java
│   │   │       ├── entity/                 # JPA Entities
│   │   │       │   ├── Product.java
│   │   │       │   ├── Supplier.java
│   │   │       │   ├── Warehouse.java
│   │   │       │   └── StockLevel.java
│   │   │       ├── repository/             # Data Access Layer
│   │   │       │   ├── ProductRepository.java
│   │   │       │   ├── SupplierRepository.java
│   │   │       │   ├── WarehouseRepository.java
│   │   │       │   └── StockLevelRepository.java
│   │   │       └── service/                # Business Logic Layer
│   │   │           ├── ProductService.java
│   │   │           ├── SupplierService.java
│   │   │           └── WarehouseService.java
│   │   ├── resources/
│   │   │   └── META-INF/
│   │   │       └── persistence.xml         # JPA Configuration
│   │   └── webapp/
│   │       ├── WEB-INF/
│   │       │   ├── beans.xml               # CDI Configuration
│   │       │   └── web.xml                 # Web Application Config
│   │       ├── index.jsp                   # Dashboard Page
│   │       ├── products.jsp                # Products Management
│   │       ├── suppliers.jsp               # Suppliers Management
│   │       └── warehouses.jsp              # Warehouses Management
│   └── test/
│       └── java/                           # Unit Tests
├── pom.xml                                 # Maven Configuration
└── create_db.sql                           # Database Setup Script
```

## 📖 Usage Guide

### Managing Products

1. **View Products**: Navigate to the Products page from the main menu
2. **Add Product**: Click "Add Product" button, fill in the form, and save
3. **Edit Product**: Click the edit icon next to any product
4. **Delete Product**: Click the delete icon and confirm
5. **Search Products**: Use the search bar to filter by SKU or name
6. **Filter by Stock**: Use the dropdown to filter low stock items

### Managing Suppliers

1. Navigate to Suppliers page
2. Add, edit, or delete suppliers using the respective buttons
3. View all supplier contact information in the table

### Managing Warehouses

1. Navigate to Warehouses page
2. Manage warehouse locations, capacity, and manager information
3. Track inventory across multiple locations

### Dashboard Statistics

The dashboard automatically refreshes every 30 seconds and displays:
- Total number of products
- Total inventory value
- Low stock items count
- System status

## 🔧 Troubleshooting

### Common Issues

#### 1. Database Connection Error

**Problem:** Application can't connect to MySQL

**Solution:**
- Verify MySQL is running: `systemctl status mysql` (Linux) or check Services (Windows)
- Check database credentials in persistence.xml
- Ensure JDBC datasource is properly configured in application server
- Verify MySQL Connector JAR is in the server's lib directory

#### 2. 404 Error on API Endpoints

**Problem:** REST API returns 404 Not Found

**Solution:**
- Check the application context path (should be `/IMS`)
- Verify JAX-RS configuration in `ApplicationConfig.java`
- Ensure application is properly deployed
- Check server logs for deployment errors

#### 3. Build Failures

**Problem:** Maven build fails

**Solution:**
```bash
# Clean and rebuild
mvn clean install -U

# Skip tests if needed
mvn clean install -DskipTests
```

#### 4. Port Already in Use

**Problem:** Application server won't start due to port conflict

**Solution:**
- Change GlassFish port: Edit `domain.xml` and modify HTTP listener port
- Or kill the process using port 8080:
  ```bash
  # Windows
  netstat -ano | findstr :8080
  taskkill /PID <process-id> /F
  
  # Linux/Mac
  lsof -i :8080
  kill -9 <process-id>
  ```

#### 5. Hibernate Schema Generation Issues

**Problem:** Tables not created automatically

**Solution:**
- Check `persistence.xml` property: `jakarta.persistence.schema-generation.database.action`
- Manually create tables using SQL scripts
- Verify database user has CREATE TABLE permissions

### Viewing Logs

**GlassFish:**
```
<glassfish>/glassfish/domains/domain1/logs/server.log
```

**WildFly:**
```
<wildfly>/standalone/log/server.log
```

### Getting Help

- Check server logs for detailed error messages
- Verify all prerequisites are correctly installed
- Ensure database is accessible and credentials are correct
- Review application server configuration

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 👥 Authors

- Your Name - Initial work

## 🙏 Acknowledgments

- Jakarta EE community
- Bootstrap team
- Font Awesome
- Hibernate ORM team

---

## 📚 Additional Documentation

This README contains all essential information. For reference, the following standalone documentation files are also available:

- **[QUICKSTART.md](QUICKSTART.md)** - Condensed 10-minute setup guide
- **[API_EXAMPLES.md](API_EXAMPLES.md)** - Extended API testing examples and workflows

> **Note**: All content from these files has been integrated into this comprehensive README.

---

**Version:** 1.0.0  
**Last Updated:** December 2025  
**Status:** Production Ready
