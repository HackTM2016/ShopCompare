package ro.hacktm.pricediff;

import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import ro.hacktm.pricediff.control.ProductsControl;
import ro.hacktm.pricediff.mdl.ProductMdl;

import javax.enterprise.context.RequestScoped;
import javax.inject.Inject;
import javax.validation.constraints.NotNull;
import javax.ws.rs.GET;
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
@RequestScoped
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
    @ApiOperation(value = "Find product", response = List.class)
    public Response findProduct(
            @NotNull @ApiParam(required = true, value = "search query.") @QueryParam(value = "query") final String query
                                          ) {
        List<ProductMdl> products = productsControl.findProduct(query);
        GenericEntity<List<ProductMdl>> generic = new GenericEntity<List<ProductMdl>>(products) {};
        return Response.ok(generic).build();
    }
}
