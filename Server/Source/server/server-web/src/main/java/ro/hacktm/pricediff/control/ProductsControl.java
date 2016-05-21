package ro.hacktm.pricediff.control;

import ro.hacktm.pricediff.mdl.CategoryMdl;
import ro.hacktm.pricediff.mdl.GpsPosition;
import ro.hacktm.pricediff.mdl.PriceMdl;
import ro.hacktm.pricediff.mdl.ProductMdl;
import ro.hacktm.pricediff.mdl.ProductResponseMdl;

import javax.enterprise.context.RequestScoped;
import javax.persistence.EntityManager;
import javax.persistence.NoResultException;
import javax.persistence.PersistenceContext;
import javax.persistence.TypedQuery;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

/**
 * TODO document me.
 *
 * @author Gabriela Potanc
 * @since 21.05.2016
 */
@RequestScoped
public class ProductsControl {

    @PersistenceContext
    private EntityManager manager;


    public List<ProductMdl> findProduct(final String searchQuery, CategoryMdl category) {

        final TypedQuery<ProductMdl> findProducts = manager.createNamedQuery(ProductMdl.FIND_ALL, ProductMdl.class);
        final List<ProductMdl> resultList = findProducts.getResultList();

        List<ProductMdl> filteredList = new ArrayList<ProductMdl>();
        for (ProductMdl productMdl : resultList) {
            if (searchQuery == null || productMdl.getName().contains(searchQuery)) {
                filteredList.add(productMdl);
            }
        }
        List<ProductMdl> refilteredList = new ArrayList<ProductMdl>();
        if (category != null) {
            for (ProductMdl productMdl : filteredList) {
                if (productMdl.getCategory() == category) {
                    refilteredList.add(productMdl);
                }
            }
        }
        return refilteredList;
    }

    public ProductMdl findProductByBarcode(final String barcode) {

        final TypedQuery<ProductMdl> findProducts = manager.createNamedQuery(ProductMdl.FIND_BY_BARCODE, ProductMdl.class);
        findProducts.setParameter("barcode", barcode);
        ProductMdl singleResult;
        try {
            singleResult = findProducts.getSingleResult();
        } catch (NoResultException nre) {
            singleResult = null;
        }

        return singleResult;
    }

    public ProductMdl addProduct(String name, String barcode, final CategoryMdl category, final GpsPosition store) {

        ProductMdl productMdl = getProductMdl(name, barcode, category);

        PriceMdl priceMdl = new PriceMdl();
        priceMdl.setStore(store);
//        priceMdl.setCreatedAt(LocalDateTime.now());
        priceMdl.setPrice(123);
        priceMdl.setProduct(productMdl);

        manager.persist(priceMdl);

        return productMdl;
    }

    private ProductMdl getProductMdl(final String name, final String barcode, final CategoryMdl category) {
        ProductMdl productMdl = findProductByBarcode(barcode);
        if (productMdl == null) {
            productMdl = new ProductMdl();
            productMdl.setName(name);
            productMdl.setBarcode(barcode);
            productMdl.setCategory(category);
            manager.persist(productMdl);
        }
        return productMdl;
    }

    public List<ProductResponseMdl> findBestDeal(List<String> productIds) {
        double min = Double.MAX_VALUE;
        GpsPosition bestStore = null;
        for (GpsPosition store : GpsPosition.values()) {
            double sumProducts = 0;
            for (String product : productIds) {
                final ProductMdl productMdl = manager.find(ProductMdl.class, product);
                sumProducts += getPriceForStore(productMdl.getPrices(), store).getPrice();
            }
            if (sumProducts < min) {
                min = sumProducts;
                bestStore = store;
            }
        }
        List<ProductResponseMdl> responseMdls = new ArrayList<ProductResponseMdl>();
        for (String product : productIds) {
            ProductResponseMdl productResponseMdl = new ProductResponseMdl();
            final ProductMdl productMdl = manager.find(ProductMdl.class, product);
            productResponseMdl.setProductMdl(productMdl);
            productResponseMdl.setBestPrice(getPriceForStore(productMdl.getPrices(), bestStore));
            productResponseMdl.setOtherPrices(getOtherPricesExceptBest(productMdl.getPrices(), bestStore));
            responseMdls.add(productResponseMdl);

        }
        return responseMdls;
    }

    private List<PriceMdl> getOtherPricesExceptBest(final List<PriceMdl> prices, final GpsPosition bestStore) {
        List<PriceMdl> otherPrices = new ArrayList<PriceMdl>();
        for (PriceMdl priceMdl : prices) {
            if (priceMdl.getStore() != bestStore) {
                otherPrices.add(priceMdl);
            }
        }
        Collections.sort(otherPrices);
        return otherPrices;
    }

    private PriceMdl getPriceForStore(final List<PriceMdl> prices, final GpsPosition store) {
        for (PriceMdl priceMdl : prices) {
            if (priceMdl.getStore() == store) {
                return priceMdl;
            }
        }
        throw new IllegalStateException("Store does not have this product");
    }
}