#!/bin/bash

BASE_URL="http://localhost:8080/inventory/api"

echo "========== INVENTORY MANAGEMENT API TEST =========="
echo ""

# 1. Create Suppliers
echo "1. Creating Supplier 1..."
SUPPLIER1=$(curl -s -X POST $BASE_URL/suppliers \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Samsung Electronics",
    "email": "sales@samsung.com",
    "phone": "+82 2 2000 0000",
    "country": "South Korea",
    "rating": 4.8
  }')
echo $SUPPLIER1 | jq .
SUPPLIER1_ID=$(echo $SUPPLIER1 | jq '.id')

echo ""
echo "2. Creating Supplier 2..."
SUPPLIER2=$(curl -s -X POST $BASE_URL/suppliers \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Sony Corporation",
    "email": "sales@sony.com",
    "phone": "+81 3 1234 5678",
    "country": "Japan",
    "rating": 4.7
  }')
echo $SUPPLIER2 | jq .
SUPPLIER2_ID=$(echo $SUPPLIER2 | jq '.id')

# 2. Create Warehouses
echo ""
echo "3. Creating Warehouse 1..."
WAREHOUSE1=$(curl -s -X POST $BASE_URL/warehouses \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Dubai Warehouse",
    "city": "Dubai",
    "country": "UAE",
    "capacity": 1000
  }')
echo $WAREHOUSE1 | jq .
WAREHOUSE1_ID=$(echo $WAREHOUSE1 | jq '.id')

echo ""
echo "4. Creating Warehouse 2..."
WAREHOUSE2=$(curl -s -X POST $BASE_URL/warehouses \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Tunis Hub",
    "city": "Tunis",
    "country": "Tunisia",
    "capacity": 500
  }')
echo $WAREHOUSE2 | jq .
WAREHOUSE2_ID=$(echo $WAREHOUSE2 | jq '.id')

# 3. Create Products
echo ""
echo "5. Creating Product 1 (HIGH STOCK)..."
PRODUCT1=$(curl -s -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -d "{
    "sku": "SAMSUNG-TV-55",
    "name": "Samsung TV 55 inch",
    "description": "Ultra HD 4K Television",
    "price": 799.99,
    "quantity": 50,
    "minStockLevel": 10,
    "supplierId": $SUPPLIER1_ID,
    "category": "Electronics"
  }")
echo $PRODUCT1 | jq .
PRODUCT1_ID=$(echo $PRODUCT1 | jq '.id')

echo ""
echo "6. Creating Product 2 (LOW STOCK)..."
PRODUCT2=$(curl -s -X POST $BASE_URL/products \
  -H "Content-Type: application/json" \
  -d "{
    "sku": "SONY-PS5",
    "name": "PlayStation 5",
    "description": "Next-gen Gaming Console",
    "price": 499.99,
    "quantity": 3,
    "minStockLevel": 20,
    "supplierId": $SUPPLIER2_ID,
    "category": "Gaming"
  }")
echo $PRODUCT2 | jq .
PRODUCT2_ID=$(echo $PRODUCT2 | jq '.id')

# 4. GET All Products
echo ""
echo "7. Getting all products..."
curl -s $BASE_URL/products | jq .

# 5. GET Low Stock Products
echo ""
echo "8. Getting low stock products (should show PS5)..."
curl -s $BASE_URL/products/low-stock | jq .

# 6. GET Products by Supplier
echo ""
echo "9. Getting products from Supplier 1..."
curl -s $BASE_URL/products/by-supplier/$SUPPLIER1_ID | jq .

# 7. Update Product Price
echo ""
echo "10. Updating product price..."
curl -s -X PUT $BASE_URL/products/$PRODUCT1_ID \
  -H "Content-Type: application/json" \
  -d '{"price": 699.99}' | jq .

# 8. Get Warehouse Occupancy
echo ""
echo "11. Getting warehouse occupancy..."
curl -s $BASE_URL/warehouses/$WAREHOUSE1_ID/occupancy | jq .

# 9. Statistics
echo ""
echo "12. Total Products..."
curl -s $BASE_URL/stats/total-products | jq .

echo ""
echo "13. Total Inventory Value..."
curl -s $BASE_URL/stats/total-stock-value | jq .

echo ""
echo "14. Low Stock Count..."
curl -s $BASE_URL/stats/low-stock-count | jq .

echo ""
echo "========== TEST COMPLETE =========="
