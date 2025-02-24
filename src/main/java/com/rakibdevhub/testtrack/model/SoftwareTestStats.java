package com.rakibdevhub.testtrack.model;

public class SoftwareTestStats {

    private int softwareId;
    private String softwareName;
    private int totalTests;
    private int passedTests;
    private int failedTests;
    private double accuracy;

    // Constructor
    public SoftwareTestStats(int softwareId, String softwareName, int totalTests, int passedTests, int failedTests, double accuracy) {
        this.softwareId = softwareId;
        this.softwareName = softwareName;
        this.totalTests = totalTests;
        this.passedTests = passedTests;
        this.failedTests = failedTests;
        this.accuracy = accuracy;
    }

    // Getters and Setters
    public int getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(int softwareId) {
        this.softwareId = softwareId;
    }

    public String getSoftwareName() {
        return softwareName;
    }

    public void setSoftwareName(String softwareName) {
        this.softwareName = softwareName;
    }

    public int getTotalTests() {
        return totalTests;
    }

    public void setTotalTests(int totalTests) {
        this.totalTests = totalTests;
    }

    public int getPassedTests() {
        return passedTests;
    }

    public void setPassedTests(int passedTests) {
        this.passedTests = passedTests;
    }

    public int getFailedTests() {
        return failedTests;
    }

    public void setFailedTests(int failedTests) {
        this.failedTests = failedTests;
    }

    public double getAccuracy() {
        return accuracy;
    }

    public void updateAccuracy() {
        this.accuracy = (totalTests > 0) ? ((double) passedTests / totalTests) * 100 : 0.0;
    }
}
