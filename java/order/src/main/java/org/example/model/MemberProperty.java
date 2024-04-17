package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.example.model.enums.MemberPropertyType;

import java.time.ZonedDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberProperty {
    private int id;
    private String name;
    private boolean isRequired;
    private boolean shouldEncrypt;
    private ZonedDateTime createdAt;
    private ZonedDateTime updatedAt;
    private boolean isDeleted;
    private String rule;
    private MemberPropertyType type;
}
