package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.model.enums.OrderRefundStatus;

import java.time.ZonedDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class OrderRefund {
    private int id;
    private int orderId;
    private int memberId;
    private String number;
    private OrderRefundStatus status;
    private ZonedDateTime createdAt;
    private ZonedDateTime updatedAt;
    private List<Order.History> histories;
    private List<Order.Product> products;
}
