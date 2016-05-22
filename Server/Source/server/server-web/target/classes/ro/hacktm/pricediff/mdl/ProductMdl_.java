package ro.hacktm.pricediff.mdl;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import ro.hacktm.pricediff.mdl.CategoryMdl;
import ro.hacktm.pricediff.mdl.PriceMdl;

@Generated(value="EclipseLink-2.6.0.v20150330-rNA", date="2016-05-22T02:29:17")
@StaticMetamodel(ProductMdl.class)
public class ProductMdl_ { 

    public static volatile SingularAttribute<ProductMdl, String> name;
    public static volatile SingularAttribute<ProductMdl, String> id;
    public static volatile SingularAttribute<ProductMdl, CategoryMdl> category;
    public static volatile ListAttribute<ProductMdl, PriceMdl> prices;
    public static volatile SingularAttribute<ProductMdl, String> barcode;

}