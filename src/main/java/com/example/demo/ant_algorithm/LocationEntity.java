package com.example.demo.ant_algorithm;

import java.io.Serializable;

/**
 * 位置信息
 *
 * @author Administrator
 */
public class LocationEntity implements Serializable {

    private static final long serialVersionUID = -319854542260591796L;

    private String address;

    private Integer sortNum;

    private String location;

    private Double distance;

    public LocationEntity() {

    }

    public LocationEntity(Integer sortNum, String location) {
        this.sortNum = sortNum;
        this.location = location;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getSortNum() {
        return sortNum;
    }

    public void setSortNum(Integer sortNum) {
        this.sortNum = sortNum;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public Double getDistance() {
        return distance;
    }

    public void setDistance(Double distance) {
        this.distance = distance;
    }

}
