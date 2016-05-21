package ro.hacktm.pricediff.control;

import ro.hacktm.pricediff.mdl.ProductMdl;

import java.util.ArrayList;
import java.util.List;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
public class ProductsControl {

    public List<ProductMdl> findProduct(String searchQuery) {

        List<ProductMdl> allProducts = new ArrayList<ProductMdl>();
        ProductMdl productMdl = new ProductMdl();
        productMdl.setName("lapte danone");
        productMdl.setId("1");
        allProducts.add(productMdl);

        productMdl = new ProductMdl();
        productMdl.setName("lapte zuzu");
        productMdl.setId("2");
        allProducts.add(productMdl);

        return allProducts;
    }
}
