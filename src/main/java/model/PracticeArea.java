package model;

/**
 * PracticeArea class that represents a legal practice area
 */
public class PracticeArea {
    private int areaId;
    private String areaName;
    private String description;
    private String image;

    // Default constructor
    public PracticeArea() {
    }

    // Constructor with essential fields
    public PracticeArea(String areaName, String description) {
        this.areaName = areaName;
        this.description = description;
    }

    // Constructor with all fields
    public PracticeArea(String areaName, String description, String image) {
        this.areaName = areaName;
        this.description = description;
        this.image = image;
    }

    // Getters and Setters
    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public String getAreaName() {
        return areaName;
    }

    public void setAreaName(String areaName) {
        this.areaName = areaName;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    @Override
    public String toString() {
        return "PracticeArea{" +
                "areaId=" + areaId +
                ", areaName='" + areaName + '\'' +
                '}';
    }
}
