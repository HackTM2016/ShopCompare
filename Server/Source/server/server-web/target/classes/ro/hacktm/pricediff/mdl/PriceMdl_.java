package ro.hacktm.pricediff.mdl;

import java.util.Date;
import javax.annotation.Generated;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import ro.hacktm.pricediff.mdl.GpsPosition;
import ro.hacktm.pricediff.mdl.ProductMdl;
import ro.hacktm.pricediff.mdl.ProfileMdl;

@Generated(value="EclipseLink-2.6.0.v20150330-rNA", date="2016-05-22T12:44:27")
@StaticMetamodel(PriceMdl.class)
public class PriceMdl_ { 

    public static volatile SingularAttribute<PriceMdl, Date> createdAt;
    public static volatile SingularAttribute<PriceMdl, ProductMdl> product;
    public static volatile SingularAttribute<PriceMdl, Double> price;
    public static volatile SingularAttribute<PriceMdl, ProfileMdl> profile;
    public static volatile SingularAttribute<PriceMdl, GpsPosition> store;
    public static volatile SingularAttribute<PriceMdl, String> id;

}