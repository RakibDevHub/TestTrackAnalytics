package com.rakibdevhub.testtrack.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Blob;
import java.io.InputStream;
import java.util.Base64;

import com.rakibdevhub.testtrack.config.DatabaseConfig;
import com.rakibdevhub.testtrack.model.TestReport;

@WebServlet("/export-test-report")
public class ExportTestReportServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/csv");
        response.setHeader("Content-Disposition", "attachment; filename=\"test_reports.csv\"");

        PrintWriter writer = null; // Declare writer outside try

        try {
            writer = response.getWriter(); // Initialize writer inside try

            try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement("SELECT * FROM test_reports"); ResultSet rs = stmt.executeQuery()) {

                // CSV Header
                writer.println("Test No,Software Name,Test Date,Tester,Test Title,Issue Type,Bug Severity,Steps Performed,Expected Result,Actual Result,Error Message,Test Result,Attachment (Base64)");

                int testNumber = 1; // More descriptive variable name

                while (rs.next()) {
                    TestReport report = new TestReport(
                            rs.getInt("TEST_ID"),
                            rs.getInt("SOFTWARE_ID"),
                            rs.getString("SOFTWARE_NAME"),
                            rs.getDate("TEST_DATE"),
                            rs.getString("TESTER_NAME"),
                            rs.getString("TEST_TITLE"),
                            rs.getString("ISSUE_TYPE"),
                            rs.getString("BUG_SEVERITY"),
                            rs.getString("STEPS_PERFORMED"),
                            rs.getString("EXPECTED_RESULT"),
                            rs.getString("ACTUAL_RESULT"),
                            rs.getString("ERROR_MESSAGE"),
                            rs.getString("TEST_RESULT"),
                            null // Placeholder, we will handle the blob seperately.
                    );

//                    String attachmentBase64 = ""; // Initialize attachmentBase64.
//                    Blob attachmentBlob = rs.getBlob("attachment");
//                    if (attachmentBlob != null) {
//                        try (InputStream inputStream = attachmentBlob.getBinaryStream()) {
//                            byte[] bytes = inputStream.readAllBytes();
//                            attachmentBase64 = Base64.getEncoder().encodeToString(bytes);
//                        }
//                    }

                    // CSV Row
                    writer.println(
                            testNumber++ + ","
                            + csvEscape(report.getSoftwareName()) + ","
                            + report.getTestDate() + ","
                            + csvEscape(report.getTesterName()) + ","
                            + csvEscape(report.getTestTitle()) + ","
                            + csvEscape(report.getIssueType()) + ","
                            + csvEscape(report.getBugSeverity()) + ","
                            + csvEscape(report.getStepsPerformed()) + ","
                            + csvEscape(report.getExpectedResult()) + ","
                            + csvEscape(report.getActualResult()) + ","
                            + csvEscape(report.getErrorMessage()) + ","
                            + csvEscape(report.getTestResult()) + ","
//                            + csvEscape(attachmentBase64) // Include base64 encoded attachment.
                    );
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            if (writer != null) {
                writer.println("Error exporting data: " + e.getMessage());
            }
        }
    }

    private String csvEscape(String value) {
        if (value == null) {
            return "N/A";
        }
        String escaped = value.replace("\"", "\"\"");
        if (escaped.contains(",") || escaped.contains("\"") || escaped.contains("\n")) {
            return "\"" + escaped + "\"";
        }
        return escaped;
    }
}
