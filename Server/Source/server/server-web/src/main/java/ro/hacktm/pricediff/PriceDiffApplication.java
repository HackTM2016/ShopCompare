package ro.hacktm.pricediff;

import org.glassfish.jersey.filter.LoggingFilter;

import javax.ws.rs.core.Application;
import java.util.HashSet;
import java.util.Set;
import java.util.logging.Logger;

/**
 * PriceDiff application.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@javax.ws.rs.ApplicationPath("app")
public class PriceDiffApplication extends Application  {
    @Override
    public Set<Class<?>> getClasses() {
        Set<Class<?>> classes = new HashSet<Class<?>>();

        classes.add(ProductsEndpointRS.class);
        return classes;
    }

    @Override
    public Set<Object> getSingletons() {
        Set<Object> classes = new HashSet<Object>();
        classes.add(new LoggingFilter(Logger.getLogger("rest"), true));
        return classes;
    }
}
