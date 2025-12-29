package com.horizon.ims.api;

import com.horizon.ims.service.ProductService;
import com.horizon.ims.service.SupplierService;
import com.horizon.ims.service.WarehouseService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;

/**
 * REST Controller for Statistics
 * Endpoints: /api/stats
 */
@Path("/stats")
@Produces(MediaType.APPLICATION_JSON)
public class StatisticsResource {

    @Inject
    private ProductService productService;

    @Inject
    private SupplierService supplierService;

    @Inject
    private WarehouseService warehouseService;

    @GET
    @Path("total-products")
    public Response getTotalProducts() {
        long total = productService.getTotalProducts();
        return Response.ok(new StatsResponse("Total Products", total)).build();
    }

    @GET
    @Path("total-stock-value")
    public Response getTotalStockValue() {
        Double value = productService.getTotalInventoryValue();
        return Response.ok(new StatsResponse("Total Inventory Value", value)).build();
    }

    @GET
    @Path("low-stock-count")
    public Response getLowStockCount() {
        long count = productService.getLowStockCount();
        return Response.ok(new StatsResponse("Low Stock Items", count)).build();
    }

    @GET
    @Path("total-suppliers")
    public Response getTotalSuppliers() {
        long total = supplierService.getTotalSuppliers();
        return Response.ok(new StatsResponse("Total Suppliers", total)).build();
    }

    @GET
    @Path("total-warehouses")
    public Response getTotalWarehouses() {
        long total = warehouseService.getTotalWarehouses();
        return Response.ok(new StatsResponse("Total Warehouses", total)).build();
    }

    public static class StatsResponse {
        public String name;
        public Object value;

        public StatsResponse(String name, Object value) {
            this.name = name;
            this.value = value;
        }

        public String getName() { return name; }
        public void setName(String name) { this.name = name; }
        public Object getValue() { return value; }
        public void setValue(Object value) { this.value = value; }
    }
}