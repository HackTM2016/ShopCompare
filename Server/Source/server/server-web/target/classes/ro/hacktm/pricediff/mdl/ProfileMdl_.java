package ro.hacktm.pricediff.mdl;

import javax.annotation.Generated;
import javax.persistence.metamodel.ListAttribute;
import javax.persistence.metamodel.SingularAttribute;
import javax.persistence.metamodel.StaticMetamodel;
import ro.hacktm.pricediff.mdl.PriceMdl;

@Generated(value="EclipseLink-2.6.0.v20150330-rNA", date="2016-05-22T12:44:27")
@StaticMetamodel(ProfileMdl.class)
public class ProfileMdl_ { 

    public static volatile SingularAttribute<ProfileMdl, String> password;
    public static volatile SingularAttribute<ProfileMdl, String> id;
    public static volatile ListAttribute<ProfileMdl, PriceMdl> prices;
    public static volatile SingularAttribute<ProfileMdl, String> email;
    public static volatile SingularAttribute<ProfileMdl, String> username;

}