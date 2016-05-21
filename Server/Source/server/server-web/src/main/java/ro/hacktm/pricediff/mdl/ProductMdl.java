package ro.hacktm.pricediff.mdl;

import javax.xml.bind.annotation.XmlRootElement;
import java.io.Serializable;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@XmlRootElement
public class ProductMdl {

    private String name;

    private String id;

    private String barcode;

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public String getId() {
        return id;
    }

    public void setId(final String id) {
        this.id = id;
    }

    public String getBarcode() {
        return barcode;
    }

    public void setBarcode(final String barcode) {
        this.barcode = barcode;
    }
}
