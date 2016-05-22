package ro.hacktm.pricediff.mdl;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
public enum GpsPosition {
    KAUFLAND_SAGULUI(457395660000000l, 212128170000000l, "Strada Damaschin Bojinca 2-4, Timișoara 300216", "https://goodlogo.com/images/logos/small/kaufland_logo_3885.gif"),
    KAUFLAND_LAZAR(457607720000000l, 212202050000000l, "Strada Gheorghe Lazar 26, Timișoara 300343", "https://goodlogo.com/images/logos/small/kaufland_logo_3885.gif"),
    PROFI_COMPLEX(457488150000000l, 212394070000000l, "Aleea Studenților 2, Timișoara", "http://startsales.ro/wp-content/uploads/2014/12/Profi.png"),
    HACKTM(457481033015984l, 212394941090622l, "HackTM Demo", "http://s4.evcdn.com/images/edpborder500/I0-001/026/557/983-0.png_/hacktm-2016-83.png");

    private static final long THRESHOLD = 5000000000l;

    private long longitude;
    private long latitude;
    private String adresa;
    private String imageUrl;

    GpsPosition(long latitude, long longitude, String adresa, String imageUrl) {
        this.latitude = latitude;
        this.longitude = longitude;
        this.adresa = adresa;
        this.imageUrl = imageUrl;
    }

    public static GpsPosition determineGpsPosition(double latitude, double longitude) {
        long latitudeLong = (long) (latitude * 10000000000000l);
        long longitudeLong = (long) (longitude * 10000000000000l);
        for (GpsPosition gpsPosition : GpsPosition.values()) {
            if (isValid(gpsPosition.latitude, latitudeLong) && isValid(gpsPosition.longitude, longitudeLong)) {
                return gpsPosition;
            }
        }
        throw new IllegalStateException("Unknown store location: " + latitude + ":" + longitude);
    }

    private static boolean isValid(final long coord1, final long coord2) {
        if (Math.abs(coord1 - coord2) < THRESHOLD) {
            return true;
        }
        return false;
    }

    public String getImageUrl() {
        return imageUrl;
    }
}
