package ro.hacktm.pricediff.mdl;

import java.util.List;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
public class ProductResponseMdl {
    private ProductMdl productMdl;
    private PriceMdl bestPrice;
    private List<PriceMdl> otherPrices;
    private double totalSum;

    public ProductMdl getProductMdl() {
        return productMdl;
    }

    public void setProductMdl(final ProductMdl productMdl) {
        this.productMdl = productMdl;
    }

    public PriceMdl getBestPrice() {
        return bestPrice;
    }

    public void setBestPrice(final PriceMdl bestPrice) {
        this.bestPrice = bestPrice;
    }

    public List<PriceMdl> getOtherPrices() {
        return otherPrices;
    }

    public void setOtherPrices(final List<PriceMdl> otherPrices) {
        this.otherPrices = otherPrices;
    }

    public double getTotalSum() {
        return totalSum;
    }

    public void setTotalSum(final double totalSum) {
        this.totalSum = totalSum;
    }
}
