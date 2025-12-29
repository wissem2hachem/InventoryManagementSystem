package com.horizon.ims.api;

import com.horizon.ims.entity.Supplier;
import com.horizon.ims.service.SupplierService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;
import java.net.URI;
import java.util.List;

/**
 * REST Controller for Supplier Management
 * Endpoints: /api/suppliers
 */
@Path("/suppliers")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class SupplierResource {

    @Inject
    private SupplierService supplierService;

    @Context
    private UriInfo uriInfo;

    @POST
    public Response createSupplier(Supplier supplier) {
        try {
            Supplier created = supplierService.createSupplier(supplier);
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
    public Response getAllSuppliers() {
        List<Supplier> suppliers = supplierService.getAllSuppliers();
        return Response.ok(suppliers).build();
    }

    @GET
    @Path("{id}")
    public Response getSupplier(@PathParam("id") Long id) {
        try {
            Supplier supplier = supplierService.getSupplier(id);
            return Response.ok(supplier).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    @PUT
    @Path("{id}")
    public Response updateSupplier(@PathParam("id") Long id, Supplier supplierData) {
        try {
            Supplier updated = supplierService.updateSupplier(id, supplierData);
            return Response.ok(updated).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    @DELETE
    @Path("{id}")
    public Response deleteSupplier(@PathParam("id") Long id) {
        try {
            supplierService.deleteSupplier(id);
            return Response.noContent().build();
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
}