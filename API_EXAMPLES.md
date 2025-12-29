# API Examples & Testing Guide

This document provides practical examples for testing the Inventory Management System API using various tools.

## Using cURL

### Products API

#### Get All Products
```bash
curl -X GET http://localhost:8080/IMS/api/products \
  -H "Accept: application/json"
```

#### Get Single Product
```bash
curl -X GET http://localhost:8080/IMS/api/products/1 \
  -H "Accept: application/json"
```

#### Create Product
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

#### Update Product
```bash
curl -X PUT http://localhost:8080/IMS/api/products/1 \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
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

#### Delete Product
```bash
curl -X DELETE http://localhost:8080/IMS/api/products/1 \
  -H "Accept: application/json"
```

#### Get Low Stock Products
```bash
curl -X GET http://localhost:8080/IMS/api/products/low-stock \
  -H "Accept: application/json"
```

### Suppliers API

#### Create Supplier
```bash
curl -X POST http://localhost:8080/IMS/api/suppliers \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "companyName": "Tech Distributors Inc.",
    "contactPerson": "John Smith",
    "email": "john@techdist.com",
    "phone": "+1-555-0123",
    "address": "123 Tech Street, Silicon Valley, CA 94025"
  }'
```

#### Get All Suppliers
```bash
curl -X GET http://localhost:8080/IMS/api/suppliers \
  -H "Accept: application/json"
```

### Warehouses API

#### Create Warehouse
```bash
curl -X POST http://localhost:8080/IMS/api/warehouses \
  -H "Content-Type: application/json" \
  -H "Accept: application/json" \
  -d '{
    "name": "Main Distribution Center",
    "location": "New York, NY",
    "capacity": 10000,
    "manager": "Robert Johnson",
    "contactNumber": "+1-555-0789"
  }'
```

#### Get All Warehouses
```bash
curl -X GET http://localhost:8080/IMS/api/warehouses \
  -H "Accept: application/json"
```

### Statistics API

#### Get Dashboard Statistics
```bash
# Total Products
curl -X GET http://localhost:8080/IMS/api/stats/total-products

# Total Inventory Value
curl -X GET http://localhost:8080/IMS/api/stats/total-stock-value

# Low Stock Count
curl -X GET http://localhost:8080/IMS/api/stats/low-stock-count

# Total Suppliers
curl -X GET http://localhost:8080/IMS/api/stats/total-suppliers

# Total Warehouses
curl -X GET http://localhost:8080/IMS/api/stats/total-warehouses
```

## Using Postman

### Import Collection

Create a new Postman collection with the following requests:

1. **Create Collection**: "Inventory Management API"
2. **Set Base URL Variable**: 
   - Variable: `base_url`
   - Value: `http://localhost:8080/IMS/api`

### Sample Requests

#### 1. Get All Products
- **Method**: GET
- **URL**: `{{base_url}}/products`
- **Headers**: 
  - `Accept: application/json`

#### 2. Create Product
- **Method**: POST
- **URL**: `{{base_url}}/products`
- **Headers**: 
  - `Content-Type: application/json`
  - `Accept: application/json`
- **Body** (raw JSON):
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

#### 3. Update Product
- **Method**: PUT
- **URL**: `{{base_url}}/products/1`
- **Headers**: 
  - `Content-Type: application/json`
- **Body**: (Same as create, with updated values)

#### 4. Delete Product
- **Method**: DELETE
- **URL**: `{{base_url}}/products/1`

## Sample API Responses

### Successful Product Creation (201 Created)
```json
{
  "id": 1,
  "sku": "LAPTOP-001",
  "name": "Dell XPS 15",
  "description": "High-performance laptop for professionals",
  "category": "Electronics",
  "unitPrice": 1299.99,
  "quantity": 15,
  "minStockLevel": 5,
  "supplierId": 1
}
```

### Get All Products (200 OK)
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

### Low Stock Products (200 OK)
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

### Statistics Response (200 OK)
```json
{
  "name": "Total Products",
  "value": 47
}
```

```json
{
  "name": "Total Inventory Value",
  "value": 12450.50
}
```

```json
{
  "name": "Low Stock Items",
  "value": 5
}
```

### Error Responses

#### Product Not Found (404 Not Found)
```json
{
  "error": "Not Found",
  "message": "Product with ID 999 not found"
}
```

#### Validation Error (400 Bad Request)
```json
{
  "error": "Validation Error",
  "message": "SKU cannot be empty"
}
```

#### Server Error (500 Internal Server Error)
```json
{
  "error": "Internal Server Error",
  "message": "Database connection failed"
}
```

## Using JavaScript (Fetch API)

### Get All Products
```javascript
fetch('http://localhost:8080/IMS/api/products')
  .then(response => response.json())
  .then(data => console.log(data))
  .catch(error => console.error('Error:', error));
```

### Create Product
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
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify(product)
})
  .then(response => response.json())
  .then(data => console.log('Success:', data))
  .catch(error => console.error('Error:', error));
```

### Update Product
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
  headers: {
    'Content-Type': 'application/json',
  },
  body: JSON.stringify(updatedProduct)
})
  .then(response => response.json())
  .then(data => console.log('Updated:', data))
  .catch(error => console.error('Error:', error));
```

### Delete Product
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

## Testing Workflow

### 1. Initial Setup Test
```bash
# Test database connection
curl http://localhost:8080/IMS/api/stats/total-products

# Should return: {"name":"Total Products","value":0}
```

### 2. Create Test Data
```bash
# Create a supplier first
curl -X POST http://localhost:8080/IMS/api/suppliers \
  -H "Content-Type: application/json" \
  -d '{
    "companyName": "Test Supplier",
    "contactPerson": "Test Person",
    "email": "test@example.com",
    "phone": "+1-555-0000",
    "address": "123 Test St"
  }'

# Create products
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

### 3. Verify Low Stock Alert
```bash
# Check low stock products (should include TEST-001)
curl http://localhost:8080/IMS/api/products/low-stock
```

### 4. Update and Verify
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

### 5. Clean Up
```bash
# Delete test product
curl -X DELETE http://localhost:8080/IMS/api/products/1

# Delete test supplier
curl -X DELETE http://localhost:8080/IMS/api/suppliers/1
```

## Performance Testing

### Using Apache Bench
```bash
# Test GET endpoint performance
ab -n 1000 -c 10 http://localhost:8080/IMS/api/products

# Test POST endpoint
ab -n 100 -c 5 -p product.json -T application/json \
  http://localhost:8080/IMS/api/products
```

### Using wrk
```bash
# Load test
wrk -t12 -c400 -d30s http://localhost:8080/IMS/api/products
```

## Troubleshooting API Issues

### CORS Issues
If testing from a different origin, you may need to configure CORS in the application server.

### Authentication
Currently, the API doesn't require authentication. For production, implement JWT or OAuth2.

### Rate Limiting
Consider implementing rate limiting for production deployments.

---

**Note**: Replace `localhost:8080` with your actual server address and port if different.
