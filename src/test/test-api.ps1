# ========== INVENTORY MANAGEMENT API TEST ==========

$BASE_URL = "http://localhost:8080/IMS_war_exploded/api"
$ErrorActionPreference = "Continue"

Write-Host "========== INVENTORY MANAGEMENT API TEST ==========" -ForegroundColor Cyan
Write-Host ""

# Helper function to pretty-print JSON
function Format-Json {
    param([string]$Json)
    try {
        $obj = $Json | ConvertFrom-Json
        $obj | ConvertTo-Json -Depth 10
    } catch {
        Write-Host "Invalid JSON response: $Json" -ForegroundColor Red
    }
}

# Helper function for API calls
function Invoke-ApiRequest {
    param(
        [string]$Method,
        [string]$Uri,
        [object]$Body,
        [string]$Description
    )

    Write-Host $Description -ForegroundColor Yellow
    try {
        if ($Body) {
            $response = Invoke-RestMethod -Method $Method -Uri $Uri `
                -Headers @{"Content-Type" = "application/json"} `
                -Body ($Body | ConvertTo-Json -Depth 10)
        } else {
            $response = Invoke-RestMethod -Method $Method -Uri $Uri
        }

        Write-Host ($response | ConvertTo-Json -Depth 10) -ForegroundColor Green
        return $response
    } catch {
        Write-Host "ERROR: $($_.Exception.Message)" -ForegroundColor Red
        return $null
    }
}

# ========== 1. CREATE SUPPLIERS ==========
Write-Host "`n--- SUPPLIERS ---" -ForegroundColor Magenta

$supplier1Data = @{
    name    = "Samsung Electronics"
    email   = "sales@samsung.com"
    phone   = "+82 2 2000 0000"
    country = "South Korea"
    rating  = 4.8
}
$supplier1 = Invoke-ApiRequest -Method POST -Uri "$BASE_URL/suppliers" `
    -Body $supplier1Data -Description "1. Creating Supplier 1..."
$supplier1Id = $supplier1.id

Write-Host ""

$supplier2Data = @{
    name    = "Sony Corporation"
    email   = "sales@sony.com"
    phone   = "+81 3 1234 5678"
    country = "Japan"
    rating  = 4.7
}
$supplier2 = Invoke-ApiRequest -Method POST -Uri "$BASE_URL/suppliers" `
    -Body $supplier2Data -Description "2. Creating Supplier 2..."
$supplier2Id = $supplier2.id

# ========== 2. CREATE WAREHOUSES ==========
Write-Host "`n--- WAREHOUSES ---" -ForegroundColor Magenta

$warehouse1Data = @{
    name     = "Dubai Warehouse"
    city     = "Dubai"
    country  = "UAE"
    capacity = 1000
}
$warehouse1 = Invoke-ApiRequest -Method POST -Uri "$BASE_URL/warehouses" `
    -Body $warehouse1Data -Description "3. Creating Warehouse 1..."
$warehouse1Id = $warehouse1.id

Write-Host ""

$warehouse2Data = @{
    name     = "Tunis Hub"
    city     = "Tunis"
    country  = "Tunisia"
    capacity = 500
}
$warehouse2 = Invoke-ApiRequest -Method POST -Uri "$BASE_URL/warehouses" `
    -Body $warehouse2Data -Description "4. Creating Warehouse 2..."
$warehouse2Id = $warehouse2.id

# ========== 3. CREATE PRODUCTS ==========
Write-Host "`n--- PRODUCTS ---" -ForegroundColor Magenta

$product1Data = @{
    sku             = "SAMSUNG-TV-55"
    name            = "Samsung TV 55 inch"
    description     = "Ultra HD 4K Television"
    price           = 799.99
    quantity        = 50
    minStockLevel   = 10
    supplierId      = $supplier1Id
    category        = "Electronics"
}
$product1 = Invoke-ApiRequest -Method POST -Uri "$BASE_URL/products" `
    -Body $product1Data -Description "5. Creating Product 1 (HIGH STOCK)..."
$product1Id = $product1.id

Write-Host ""

$product2Data = @{
    sku             = "SONY-PS5"
    name            = "PlayStation 5"
    description     = "Next-gen Gaming Console"
    price           = 499.99
    quantity        = 3
    minStockLevel   = 20
    supplierId      = $supplier2Id
    category        = "Gaming"
}
$product2 = Invoke-ApiRequest -Method POST -Uri "$BASE_URL/products" `
    -Body $product2Data -Description "6. Creating Product 2 (LOW STOCK)..."
$product2Id = $product2.id

# ========== 4. GET OPERATIONS ==========
Write-Host "`n--- GET OPERATIONS ---" -ForegroundColor Magenta

Invoke-ApiRequest -Method GET -Uri "$BASE_URL/products" `
    -Description "7. Getting all products..."

Write-Host ""

Invoke-ApiRequest -Method GET -Uri "$BASE_URL/products/low-stock" `
    -Description "8. Getting low stock products (should show PS5)..."

Write-Host ""

Invoke-ApiRequest -Method GET -Uri "$BASE_URL/products/by-supplier/$supplier1Id" `
    -Description "9. Getting products from Supplier 1..."

# ========== 5. UPDATE OPERATION ==========
Write-Host "`n--- UPDATE OPERATIONS ---" -ForegroundColor Magenta

$updateData = @{
    price = 699.99
}
Invoke-ApiRequest -Method PUT -Uri "$BASE_URL/products/$product1Id" `
    -Body $updateData -Description "10. Updating product price..."

# ========== 6. WAREHOUSE OPERATIONS ==========
Write-Host "`n--- WAREHOUSE OPERATIONS ---" -ForegroundColor Magenta

Invoke-ApiRequest -Method GET `
    -Uri "$BASE_URL/warehouses/$warehouse1Id/occupancy" `
    -Description "11. Getting warehouse occupancy..."

# ========== 7. STATISTICS ==========
Write-Host "`n--- STATISTICS ---" -ForegroundColor Magenta

Invoke-ApiRequest -Method GET -Uri "$BASE_URL/stats/total-products" `
    -Description "12. Total Products..."

Write-Host ""

Invoke-ApiRequest -Method GET -Uri "$BASE_URL/stats/total-stock-value" `
    -Description "13. Total Inventory Value..."

Write-Host ""

Invoke-ApiRequest -Method GET -Uri "$BASE_URL/stats/low-stock-count" `
    -Description "14. Low Stock Count..."

Write-Host "`n========== TEST COMPLETE ==========" -ForegroundColor Cyan
