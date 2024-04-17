package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.ZonedDateTime;
import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
    private int id;
    private String nickname;
    private int score;
    private int growth;
    private boolean isActivated;
    private String avatar;
    private String phone;
    private ZonedDateTime createdAt;
    private ZonedDateTime updatedAt;
    private List<String> tags;
    private List<Property> properties;

    @Data
    @AllArgsConstructor
    @NoArgsConstructor
    public static class Property {
        private int propertyId;
        private String propertyName;
        private Object propertyValue;
    }
}
