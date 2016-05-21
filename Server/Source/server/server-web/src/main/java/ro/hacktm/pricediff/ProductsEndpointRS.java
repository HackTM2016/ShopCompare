package ro.hacktm.pricediff;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import ro.hacktm.pricediff.control.ProductsControl;
import ro.hacktm.pricediff.mdl.CategoryMdl;
import ro.hacktm.pricediff.mdl.GpsPosition;
import ro.hacktm.pricediff.mdl.ProductMdl;

import javax.ejb.Stateless;
import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.validation.constraints.NotNull;
import javax.ws.rs.GET;
import javax.ws.rs.PUT;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.GenericEntity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

/**
 * Endpoint for retrieve products.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@Path("/rest")
@Produces(MediaType.APPLICATION_JSON)
@Api(value = "/rest", description = "Products resource")
@Stateless
public class ProductsEndpointRS {

    @Inject
    private ProductsControl productsControl;

    @GET
    public Response ping() {
        return Response.ok("Hello world").build();
    }

    @GET
    @Path("profiles")
    public Response profiles() {
        return Response.ok("hello").build();
    }

    @GET
    @Path("find")
    @ApiOperation(value = "Find product", response = ProductMdl[].class)
    public ProductMdl[] findProduct(
            @ApiParam(required = true, value = "search category.") @QueryParam(value = "category") final CategoryMdl category,
            @ApiParam(required = true, value = "search query.") @QueryParam(value = "query") final String query
                                          ) {
        List<ProductMdl> products = productsControl.findProduct(query, category);
        return products.toArray(new ProductMdl[]{});
    }

    @GET
    @Path("add")
    @ApiOperation(value = "Add product", response = ProductMdl.class)
    public Response addProduct(
            @NotNull @ApiParam(required = true, value = "gps position.") @QueryParam(value = "gpsPosition") final String gpsPosition,
            @ApiParam(required = true, value = "barcode.") @QueryParam(value = "barcode") final String barcode,
            @NotNull @ApiParam(required = true, value = "name.") @QueryParam(value = "name") final String name,
            @NotNull @ApiParam(required = true, allowableValues = "LACTATE, FRUCTE, CARNE, DULCIURI", value = "category.") @QueryParam(value = "category") final CategoryMdl category
                               ) {
        final String[] split = gpsPosition.split(",");
        final GpsPosition store = GpsPosition.determineGpsPosition(Double.valueOf(split[0]), Double.valueOf(split[1]));
        final ProductMdl productMdl = productsControl.addProduct(name, barcode, category, store);
        return Response.ok(productMdl).build();
    }

    @GET
    @Path("deal")
    @ApiOperation(value = "Find best deal", response = List.class)
    public Response findBestDeal(
            @NotNull @ApiParam(required = true, value = "gps position.") @QueryParam("list") final List<String> list
                              ) {
        return Response.ok(list).build();
    }
}
