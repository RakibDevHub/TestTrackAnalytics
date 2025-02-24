package com.rakibdevhub.testtrack.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.io.InputStream;

import com.rakibdevhub.testtrack.config.DatabaseConfig;

@WebServlet("/add-test")
@MultipartConfig(maxFileSize = 10 * 1024 * 1024) // 10MB limit
public class AddTestServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private static final Logger LOGGER = Logger.getLogger(AddTestServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("add_test.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Retrieve form data
        String softwareName = request.getParameter("software_name");
        String testDateStr = request.getParameter("test_date");
        String testerName = request.getParameter("tester_name");
        String testTitle = request.getParameter("test_title");
        String issueType = request.getParameter("issue_type");
        String bugSeverity = request.getParameter("bug_severity");
        String stepsPerformed = request.getParameter("steps_performed");
        String expectedResult = request.getParameter("expected_result");
        String actualResult = request.getParameter("actual_result");
        String errorMessage = request.getParameter("error_message");
        String testResult = request.getParameter("test_result");

        int softwareId = 0;
        try {
            softwareId = Integer.parseInt(request.getParameter("software_id"));
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid Software ID.");
            request.getRequestDispatcher("add_test.jsp").forward(request, response);
            return;
        }

        // Convert test_date to SQL Date
        Date testDate = null;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            java.util.Date parsedDate = sdf.parse(testDateStr);
            testDate = new Date(parsedDate.getTime());
        } catch (ParseException e) {
            request.setAttribute("error", "Invalid test date format.");
            request.getRequestDispatcher("add_test.jsp").forward(request, response);
            return;
        }

        // Handle bug severity display logic
        if ("N/A".equals(issueType)) {
            bugSeverity = null; // Set to null if N/A
        }

        // Convert empty error_message to NULL
        if (errorMessage != null && errorMessage.trim().isEmpty()) {
            errorMessage = null;
        }

        InputStream attachmentStream = null;
        Part filePart = request.getPart("attachment");
        if (filePart != null && filePart.getSize() > 0) {
            attachmentStream = filePart.getInputStream();
        }

        // SQL Query
        String sql = "INSERT INTO test_reports (software_name, software_id, test_date, tester_name, test_title, "
                + "issue_type, bug_severity, steps_performed, expected_result, actual_result, error_message, test_result, attachment) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, softwareName);
            stmt.setInt(2, softwareId);
            stmt.setDate(3, testDate);
            stmt.setString(4, testerName);
            stmt.setString(5, testTitle);
            stmt.setString(6, issueType);
            stmt.setString(7, bugSeverity);
            stmt.setString(8, stepsPerformed);
            stmt.setString(9, expectedResult);
            stmt.setString(10, actualResult);
            stmt.setString(11, errorMessage);
            stmt.setString(12, testResult);
            if (attachmentStream != null) {
                stmt.setBlob(13, attachmentStream);
            } else {
                stmt.setNull(13, java.sql.Types.BLOB);
            }

            int rowsInserted = stmt.executeUpdate();

            if (rowsInserted > 0) {
                request.setAttribute("message", "Test report added successfully!");
            } else {
                request.setAttribute("error", "Failed to add test report.");
            }

        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Database error", e);
            request.setAttribute("error", "Database error: " + e.getMessage());
        }

        // Forward to the response page
        request.getRequestDispatcher("/add_test.jsp").forward(request, response);
    }
}
