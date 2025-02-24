package com.rakibdevhub.testtrack.model;

import java.sql.Blob;
import java.util.Date;

public class TestReport {

    private int id;
    private int softwareId;
    private String softwareName;
    private java.sql.Date testDate;
    private String testerName;
    private String testTitle;
    private String issueType;
    private String bugSeverity;
    private String stepsPerformed;
    private String expectedResult;
    private String actualResult;
    private String errorMessage;
    private String testResult;
    private String attachment;
    private Blob attachmentBlob;
    private String attachmentBase64;

    // Constructor
    public TestReport(int id, int softwareId, String softwareName, Date testDate, String testerName,
            String testTitle, String issueType, String bugSeverity, String stepsPerformed,
            String expectedResult, String actualResult, String errorMessage, String testResult, String attachment) {
        this.id = id;
        this.softwareName = softwareName;
        this.softwareId = softwareId;
        this.testDate = (java.sql.Date) testDate;
        this.testerName = testerName;
        this.testTitle = testTitle;
        this.issueType = issueType;
        this.bugSeverity = bugSeverity;
        this.stepsPerformed = stepsPerformed;
        this.expectedResult = expectedResult;
        this.actualResult = actualResult;
        this.errorMessage = errorMessage;
        this.testResult = testResult;
        this.attachment = attachment;
    }

    public Blob getAttachmentBlob() {
        return attachmentBlob;
    }

    public void setAttachmentBlob(Blob attachmentBlob) {
        this.attachmentBlob = attachmentBlob;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getSoftwareName() {
        return softwareName;
    }

    public void setSoftwareName(String softwareName) {
        this.softwareName = softwareName;
    }

    public int getSoftwareId() {
        return softwareId;
    }

    public void setSoftwareId(int softwareId) {
        this.softwareId = softwareId;
    }

    public Date getTestDate() {
        return testDate;
    }

    public void setTestDate(Date testDate) {
        this.testDate = (java.sql.Date) testDate;
    }

    public String getTesterName() {
        return testerName;
    }

    public void setTesterName(String testerName) {
        this.testerName = testerName;
    }

    public String getTestTitle() {
        return testTitle;
    }

    public void setTestTitle(String testTitle) {
        this.testTitle = testTitle;
    }

    public String getIssueType() {
        return issueType;
    }

    public void setIssueType(String issueType) {
        this.issueType = issueType;
    }

    public String getBugSeverity() {
        return bugSeverity;
    }

    public void setBugSeverity(String bugSeverity) {
        this.bugSeverity = bugSeverity;
    }

    public String getStepsPerformed() {
        return stepsPerformed;
    }

    public void setStepsPerformed(String stepsPerformed) {
        this.stepsPerformed = stepsPerformed;
    }

    public String getExpectedResult() {
        return expectedResult;
    }

    public void setExpectedResult(String expectedResult) {
        this.expectedResult = expectedResult;
    }

    public String getActualResult() {
        return actualResult;
    }

    public void setActualResult(String actualResult) {
        this.actualResult = actualResult;
    }

    public String getErrorMessage() {
        return errorMessage;
    }

    public void setErrorMessage(String errorMessage) {
        this.errorMessage = errorMessage;
    }

    public String getTestResult() {
        return testResult;
    }

    public void setTestResult(String testResult) {
        this.testResult = testResult;
    }

    public String getAttachment() {
        return attachment;
    }

    public void setAttachment(String attachment) {
        this.attachment = attachment;
    }
    
     public String getAttachmentBase64() {
        return attachmentBase64;
    }

    public void setAttachmentBase64(String attachmentBase64) {
        this.attachmentBase64 = attachmentBase64;
    }
}
