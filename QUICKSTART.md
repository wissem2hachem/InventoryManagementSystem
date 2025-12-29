# Quick Start Guide

Get the Inventory Management System up and running in 10 minutes!

## Prerequisites Checklist

- [ ] Java JDK 23 installed
- [ ] Maven 3.6+ installed
- [ ] MySQL 8.0+ installed and running
- [ ] GlassFish 7.x or compatible Jakarta EE server

## 5-Step Quick Setup

### Step 1: Database Setup (2 minutes)

```bash
# Start MySQL
mysql -u root -p

# Create database
CREATE DATABASE inventory_db;
exit;
```

### Step 2: Configure Database Connection (1 minute)

Edit your application server's datasource configuration or use the default settings:
- **Database**: `inventory_db`
- **Username**: `root`
- **Password**: (your MySQL password)
- **Host**: `localhost`
- **Port**: `3306`

### Step 3: Build the Project (2 minutes)

```bash
cd Product-Inventory-Management-System-master
mvn clean install
```

### Step 4: Deploy to GlassFish (3 minutes)

#### Option A: Auto-deploy
```bash
# Copy WAR to autodeploy directory
cp target/IMS.war <glassfish-home>/glassfish/domains/domain1/autodeploy/
```

#### Option B: Admin Console
1. Start GlassFish: `asadmin start-domain`
2. Open: http://localhost:4848
3. Navigate to: Applications → Deploy
4. Upload: `target/IMS.war`
5. Click Deploy

#### Option C: Command Line
```bash
cd <glassfish-home>/bin
./asadmin start-domain
./asadmin deploy <path-to-project>/target/IMS.war
```

### Step 5: Access the Application (1 minute)

Open your browser and navigate to:
```
http://localhost:8080/IMS/
```

## First-Time Usage

### 1. Add Your First Supplier
1. Click **Suppliers** in the navigation
2. Click **Add Supplier**
3. Fill in the form:
   - Company Name: "Tech Distributors Inc."
   - Contact Person: "John Smith"
   - Email: "john@techdist.com"
   - Phone: "+1-555-0123"
   - Address: "123 Tech Street, CA"
4. Click **Save**

### 2. Add Your First Product
1. Click **Products** in the navigation
2. Click **Add Product**
3. Fill in the form:
   - SKU: "LAPTOP-001"
   - Name: "Dell XPS 15"
   - Description: "High-performance laptop"
   - Category: "Electronics"
   - Unit Price: 1299.99
   - Quantity: 15
   - Min Stock Level: 5
   - Supplier ID: 1 (the supplier you just created)
4. Click **Save Product**

### 3. Add Your First Warehouse
1. Click **Warehouses** in the navigation
2. Click **Add Warehouse**
3. Fill in the form:
   - Name: "Main Distribution Center"
   - Location: "New York, NY"
   - Capacity: 10000
   - Manager: "Robert Johnson"
   - Contact: "+1-555-0789"
4. Click **Save**

### 4. View Dashboard Statistics
1. Click **Dashboard** in the navigation
2. You should see:
   - Total Products: 1
   - Inventory Value: $1,299.99
   - Low Stock Items: 0
   - System Status: Online

## Quick API Test

Test the API is working:

```bash
# Get all products
curl http://localhost:8080/IMS/api/products

# Get statistics
curl http://localhost:8080/IMS/api/stats/total-products
```

Expected response:
```json
{
  "name": "Total Products",
  "value": 1
}
```

## Common Quick Fixes

### Application Won't Start
```bash
# Check GlassFish logs
tail -f <glassfish-home>/glassfish/domains/domain1/logs/server.log
```

### Database Connection Failed
```bash
# Verify MySQL is running
systemctl status mysql  # Linux
net start MySQL80       # Windows

# Test connection
mysql -u root -p -e "SHOW DATABASES;"
```

### Port 8080 Already in Use
```bash
# Find and kill the process
# Windows
netstat -ano | findstr :8080
taskkill /PID <pid> /F

# Linux/Mac
lsof -i :8080
kill -9 <pid>
```

### Build Fails
```bash
# Clean and rebuild
mvn clean install -U -DskipTests
```

## Next Steps

- ✅ Read the full [README.md](README.md) for detailed documentation
- ✅ Check [API_EXAMPLES.md](API_EXAMPLES.md) for API testing examples
- ✅ Explore the web interface and add more data
- ✅ Set up automated backups for your database
- ✅ Configure production settings for deployment

## Need Help?

1. Check the [Troubleshooting](README.md#troubleshooting) section in README
2. Review server logs for error messages
3. Verify all prerequisites are correctly installed
4. Ensure database credentials are correct

---

**Congratulations!** 🎉 Your Inventory Management System is now running!
