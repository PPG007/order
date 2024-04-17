package org.example.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MemberAddress {
    private int id;
    private int memberId;
    private String phone;
    private String country;
    private String province;
    private String city;
    private String district;
    private String detail;
    private double lat;
    private double lng;
}
