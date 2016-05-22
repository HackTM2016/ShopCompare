package ro.hacktm.pricediff.mdl;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
public enum GpsPosition {
    KAUFLAND_SAGULUI(45739566, 21212817, "Strada Damaschin Bojinca 2-4, Timișoara 300216"),
    KAUFLAND_LAZAR(45760772, 21220205, "Strada Gheorghe Lazar 26, Timișoara 300343"),
    PROFI_COMPLEX(45748815, 21239407, "Aleea Studenților 2, Timișoara");

    private static final int THRESHOLD = 700;

    private long longitude;
    private long latitude;
    private String adresa;

    GpsPosition(long latitude, long longitude, String adresa) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.adresa = adresa;
    }

    public static GpsPosition determineGpsPosition(double latitude, double longitude) {
        int latitudeLong = (int) (latitude * 1000000);
        int longitudeLong = (int) (longitude * 1000000);
        for (GpsPosition gpsPosition : GpsPosition.values()) {
            if (isValid(gpsPosition.latitude, latitudeLong) && isValid(gpsPosition.longitude, longitudeLong)) {
                return gpsPosition;
            }
        }
        throw new IllegalStateException("Unknown store location: " + latitude + ":" + longitude);
    }

    private static boolean isValid(final double coord1, final double coord2) {
        if (Math.abs(coord1 - coord2) < THRESHOLD) {
            return true;
        }
        return false;
    }
}
