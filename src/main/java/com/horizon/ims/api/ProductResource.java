package com.horizon.ims.api;

import com.horizon.ims.entity.Product;
import com.horizon.ims.service.ProductService;
import jakarta.inject.Inject;
import jakarta.ws.rs.*;
import jakarta.ws.rs.core.*;
import java.net.URI;
import java.util.List;

/**
 * REST Controller for Product Management
 * Endpoints: /api/products
 */
@Path("/products")
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class ProductResource {

    @Inject
    private ProductService productService;

    @Context
    private UriInfo uriInfo;

    // ==================== CREATE ====================
    @POST
    public Response createProduct(Product product) {
        try {
            Product created = productService.createProduct(product);
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

    // ==================== READ ====================
    @GET
    public Response getAllProducts() {
        List<Product> products = productService.getAllProducts();
        return Response.ok(products).build();
    }

    @GET
    @Path("{id}")
    public Response getProduct(@PathParam("id") Long id) {
        try {
            Product product = productService.getProduct(id);
            return Response.ok(product).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    // ==================== UPDATE ====================
    @PUT
    @Path("{id}")
    public Response updateProduct(@PathParam("id") Long id, Product productData) {
        try {
            Product updated = productService.updateProduct(id, productData);
            return Response.ok(updated).build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    // ==================== DELETE ====================
    @DELETE
    @Path("{id}")
    public Response deleteProduct(@PathParam("id") Long id) {
        try {
            productService.deleteProduct(id);
            return Response.noContent().build();
        } catch (IllegalArgumentException e) {
            return Response.status(Response.Status.NOT_FOUND)
                    .entity(new ErrorResponse("Not Found", e.getMessage()))
                    .build();
        }
    }

    // ==================== BUSINESS LOGIC ====================
    @GET
    @Path("low-stock")
    public Response getLowStockProducts() {
        List<Product> products = productService.getLowStockProducts();
        return Response.ok(products).build();
    }

    @GET
    @Path("by-supplier/{supplierId}")
    public Response getProductsBySupplier(@PathParam("supplierId") Long supplierId) {
        try {
            List<Product> products = productService.getProductsBySupplier(supplierId);
            if (products.isEmpty()) {
                return Response.status(Response.Status.NOT_FOUND)
                        .entity(new ErrorResponse("Not Found", "No products for this supplier"))
                        .build();
            }
            return Response.ok(products).build();
        } catch (Exception e) {
            return Response.status(Response.Status.INTERNAL_SERVER_ERROR)
                    .entity(new ErrorResponse("Error", e.getMessage()))
                    .build();
        }
    }

    // Helper class
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
