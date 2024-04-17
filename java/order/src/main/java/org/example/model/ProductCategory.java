package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.ZonedDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProductCategory {
    private int id;
    private String name;
    private int parentId;
    private ZonedDateTime createdAt;
    private ZonedDateTime updatedAt;
    private boolean isDeleted;
}
