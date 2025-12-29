package com.horizon.ims.api;

import com.horizon.ims.entity.Warehouse;
import com.horizon.ims.service.WarehouseService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;
import java.net.URI;
import java.util.List;

/**
 * REST Controller for Warehouse Management
 * Endpoints: /api/warehouses
 */
@Path("/warehouses")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class WarehouseResource {

    @Inject
    private WarehouseService warehouseService;

    @Context
    private UriInfo uriInfo;

    @POST
    public Response createWarehouse(Warehouse warehouse) {
        try {
            Warehouse created = warehouseService.createWarehouse(warehouse);
            URI uri = uriInfo.getAbsolutePathBuilder()
                    .path(String.valueOf(created.getId()))
                    .build();
            return Response.created(uri).entity(created).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.BAD_REQUEST)
                    .entity(new ErrorResponse("Validation Error", e.getMessage()))
                    .build();
        }
    }

    @GET
    public Response getAllWarehouses() {
        List<Warehouse> warehouses = warehouseService.getAllWarehouses();
        return Response.ok(warehouses).build();
    }

    @GET
    @Path("{id}")
    public Response getWarehouse(@PathParam("id") Long id) {
        try {
            Warehouse warehouse = warehouseService.getWarehouse(id);
            return Response.ok(warehouse).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    @PUT
    @Path("{id}")
    public Response updateWarehouse(@PathParam("id") Long id, Warehouse warehouseData) {
        try {
            Warehouse updated = warehouseService.updateWarehouse(id, warehouseData);
            return Response.ok(updated).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    @DELETE
    @Path("{id}")
    public Response deleteWarehouse(@PathParam("id") Long id) {
        try {
            warehouseService.deleteWarehouse(id);
            return Response.noContent().build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    @GET
    @Path("{id}/occupancy")
    public Response getOccupancyPercentage(@PathParam("id") Long id) {
        try {
            Double occupancy = warehouseService.getOccupancyPercentage(id);
            return Response.ok(new OccupancyResponse(occupancy)).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    public static class ErrorResponse {
        public String error;
        public String message;

        public ErrorResponse(String error, String message) {
            this.error = error;
            this.message = message;
        }

        public String getError() { return error; }
        public void setError(String error) { this.error = error; }
        public String getMessage() { return message; }
        public void setMessage(String message) { this.message = message; }
    }

    public static class OccupancyResponse {
        public Double occupancyPercentage;

        public OccupancyResponse(Double occupancyPercentage) {
            this.occupancyPercentage = occupancyPercentage;
        }

        public Double getOccupancyPercentage() { return occupancyPercentage; }
        public void setOccupancyPercentage(Double occupancyPercentage) { this.occupancyPercentage = occupancyPercentage; }
    }
}