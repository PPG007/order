package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.ZonedDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Product {
    private int id;
    private String name;
    private String number;
    private boolean isDeleted;
    private ZonedDateTime createdAt;
    private ZonedDateTime updatedAt;
    private int categoryId;
    private int price;
    private List<String> videos;
    private List<String> pictures;
    private List<ProductSku> skus;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class ProductSku {
        private String sku;
        private List<String> properties;
    }
}
