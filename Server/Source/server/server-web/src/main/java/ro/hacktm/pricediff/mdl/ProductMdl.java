package ro.hacktm.pricediff.mdl;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import java.util.ArrayList;
import java.util.List;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@Entity
@Table(name = ProductMdl.TABLE)
@NamedQueries({
        @NamedQuery(name = ProductMdl.FIND_ALL, query = "select p from ProductMdl p"),
        @NamedQuery(name = ProductMdl.FIND_BY_BARCODE, query = "select p from ProductMdl p where p.barcode = :barcode")})
public class ProductMdl {

    protected static final String SEQUENCE_SUFFIX = "_SEQ";
    protected static final int SEQUENCE_INITIAL_VALUE = 1;
    protected static final int SEQUENCE_ALLOCATION_SIZE = 10;
    protected static final String GENERATOR_SUFFIX = "_GEN";
    private static final String BASE = "PRODUCT";
    private static final String GENERATOR = BASE + GENERATOR_SUFFIX;
    private static final String SEQUENCE = BASE + SEQUENCE_SUFFIX;
    static final String TABLE = BASE;
    public static final String FIND_ALL = "ProductMdl.FIND_ALL";
    public static final String FIND_BY_BARCODE = "ProductMdl.FIND_BY_BARCODE";

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = GENERATOR)
    @SequenceGenerator(name = GENERATOR, sequenceName = SEQUENCE, allocationSize = SEQUENCE_ALLOCATION_SIZE, initialValue = SEQUENCE_INITIAL_VALUE)
    @Column(name = "ID")
    private String id;

    @Column(name = "NAME")
    private String name;

    @Column(name = "BARCODE")
    private String barcode;

    @Column(name = "CATEGORY")
    @Enumerated(EnumType.STRING)
    private CategoryMdl category;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "product")
    private List<PriceMdl> prices;

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

    public CategoryMdl getCategory() {
        return category;
    }

    public void setCategory(final CategoryMdl category) {
        this.category = category;
    }

    public List<PriceMdl> getPrices() {
//        if (prices == null) {
//            prices = new ArrayList<PriceMdl>();
//        }
        return prices;
    }
}
