package ro.hacktm.pricediff.mdl;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import java.util.List;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@Entity
@Table(name = ProfileMdl.TABLE)
@NamedQueries({
        @NamedQuery(name = ProfileMdl.FIND_BY_USERNAME, query = "select p from ProfileMdl p where p.username = :username")})
public class ProfileMdl {

    protected static final String SEQUENCE_SUFFIX = "_SEQ";
    protected static final int SEQUENCE_INITIAL_VALUE = 1;
    protected static final int SEQUENCE_ALLOCATION_SIZE = 10;
    protected static final String GENERATOR_SUFFIX = "_GEN";
    private static final String BASE = "PROFILES";
    private static final String GENERATOR = BASE + GENERATOR_SUFFIX;
    private static final String SEQUENCE = BASE + SEQUENCE_SUFFIX;
    static final String TABLE = BASE;

    public static final String FIND_BY_USERNAME = "ProductMdl.FIND_BY_USERNAME";

    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = GENERATOR)
    @SequenceGenerator(name = GENERATOR, sequenceName = SEQUENCE, allocationSize = SEQUENCE_ALLOCATION_SIZE, initialValue = SEQUENCE_INITIAL_VALUE)
    @Column(name = "ID")
    private String id;

    @Column(name = "USERNAME")
    private String username;

    @Column(name = "PASSWORD")
    private String password;

    @Column(name = "EMAIL")
    private String email;

    @OneToMany(fetch = FetchType.EAGER, mappedBy = "profile")
    private List<PriceMdl> prices;

    public String getUsername() {
        return username;
    }

    public void setUsername(final String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(final String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(final String email) {
        this.email = email;
    }

    public List<PriceMdl> getPrices() {
        return prices;
    }

    public String getId() {
        return id;
    }

    public void setId(final String id) {
        this.id = id;
    }
}
