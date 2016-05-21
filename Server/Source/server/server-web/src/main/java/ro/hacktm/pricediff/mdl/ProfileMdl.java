package ro.hacktm.pricediff.mdl;

import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import java.util.List;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
public class ProfileMdl {

    protected static final String SEQUENCE_SUFFIX = "_SEQ";
    protected static final int SEQUENCE_INITIAL_VALUE = 1;
    protected static final int SEQUENCE_ALLOCATION_SIZE = 10;
    protected static final String GENERATOR_SUFFIX = "_GEN";
    private static final String BASE = "PROFILES";
    private static final String GENERATOR = BASE + GENERATOR_SUFFIX;
    private static final String SEQUENCE = BASE + SEQUENCE_SUFFIX;
    static final String TABLE = BASE;

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
}
