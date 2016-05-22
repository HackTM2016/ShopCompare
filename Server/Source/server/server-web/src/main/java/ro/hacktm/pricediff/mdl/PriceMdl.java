package ro.hacktm.pricediff.mdl;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import java.time.LocalDateTime;
import java.util.Comparator;
import java.util.Date;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@Entity
@Table(name = PriceMdl.TABLE)
public class PriceMdl implements Comparable<PriceMdl> {

    protected static final String SEQUENCE_SUFFIX = "_SEQ";
    protected static final int SEQUENCE_INITIAL_VALUE = 1;
    protected static final int SEQUENCE_ALLOCATION_SIZE = 10;
    protected static final String GENERATOR_SUFFIX = "_GEN";
    private static final String BASE = "PRICE";
    private static final String GENERATOR = BASE + GENERATOR_SUFFIX;
    private static final String SEQUENCE = BASE + SEQUENCE_SUFFIX;
    static final String TABLE = BASE;

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = GENERATOR)
    @SequenceGenerator(name = GENERATOR, sequenceName = SEQUENCE, allocationSize = SEQUENCE_ALLOCATION_SIZE, initialValue = SEQUENCE_INITIAL_VALUE)
    @Column(name = "ID")
    private String id;

    @Column(name = "PRICE")
    private double price;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "PRODUCT_ID")
    private ProductMdl product;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "USER_ID")
    private ProfileMdl profile;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "CREATED_AT", updatable = false)
    private Date createdAt;

    @Column(name = "STORE")
    @Enumerated(EnumType.STRING)
    private GpsPosition store;

    public double getPrice() {
        return price;
    }

    public void setPrice(final double price) {
        this.price = price;
    }

    public ProductMdl getProduct() {
        return product;
    }

    public void setProduct(final ProductMdl product) {
        this.product = product;
    }

    public Date getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(final Date createdAt) {
        this.createdAt = createdAt;
    }

    public GpsPosition getStore() {
        return store;
    }

    public void setStore(final GpsPosition store) {
        this.store = store;
    }

    public int compareTo(final PriceMdl o) {
        return (int) (this.getPrice() - o.getPrice());
    }

    public ProfileMdl getProfile() {
        return profile;
    }

    public void setProfile(final ProfileMdl profile) {
        this.profile = profile;
    }
}
