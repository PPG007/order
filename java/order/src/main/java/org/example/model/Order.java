package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.model.enums.OrderRefundStatus;
import org.example.model.enums.OrderStatus;

import java.time.ZonedDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Order {
    private int id;
    private String number;
    private int memberId;
    private int payAmount;
    private int payScore;
    private String remarks;
    private ZonedDateTime createDate;
    private ZonedDateTime updateDate;
    private boolean isDeleted;
    private boolean memberDeleted;
    private OrderStatus status;
    private OrderRefundStatus refundStatus;
    private List<History> histories;
    private List<Product> products;
    private MemberAddress contact;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class History {
        private OrderStatus status;
        private ZonedDateTime createdAt;
    }

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Product {
        private int productId;
        private String sku;
        private OrderRefundStatus refundStatus;
        private int payAmount;
        private int totalAmount;
        private int total;
    }
}
