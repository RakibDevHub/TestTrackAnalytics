package com.rakibdevhub.testtrack.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.rakibdevhub.testtrack.config.DatabaseConfig;

@WebServlet("/add-test")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5)
public class AddTestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Display add_test.jsp form
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("add_test.jsp").forward(request, response);
    }

    // Handle form submission
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form fields
        String softwareName = request.getParameter("software_name");
        int softwareId = Integer.parseInt(request.getParameter("software_id"));
        String date = request.getParameter("date");
        String testerName = request.getParameter("tester_name");
        String bugTitle = request.getParameter("test_title");
        String bugType = request.getParameter("test_type");
        String bugSeverity = request.getParameter("test_severity");
        String stepsPerformed = request.getParameter("steps_performed");
        String expectedResult = request.getParameter("expected_result");
        String actualResult = request.getParameter("actual_result");
        String errorMessage = request.getParameter("error_message");
        String testResult = request.getParameter("test_result");
        
        // Handle file upload
        Part filePart = request.getPart("attachment");
        String fileName = null;
        if (filePart != null && filePart.getSize() > 0) {
            fileName = saveUploadedFile(filePart);
        }

        // Insert into database
        try (Connection conn = DatabaseConfig.getConnection();
             PreparedStatement stmt = conn.prepareStatement(
                "INSERT INTO bugs (software_name, software_id, test_date, tester_name, test_title, test_type, test_severity, steps_performed, expected_result, actual_result, error_message, test_result, attachment) VALUES (?, ?, TO_DATE(?, 'YYYY-MM-DD'), ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)")) {

            stmt.setString(1, softwareName);
            stmt.setInt(2, softwareId);
            stmt.setString(3, date);
            stmt.setString(4, testerName);
            stmt.setString(5, bugTitle);
            stmt.setString(6, bugType);
            stmt.setString(7, bugSeverity);
            stmt.setString(8, stepsPerformed);
            stmt.setString(9, expectedResult);
            stmt.setString(10, actualResult);
            stmt.setString(11, errorMessage);
            stmt.setString(12, testResult);
            stmt.setString(13, fileName);

            stmt.executeUpdate();
            response.sendRedirect("/view-tests?success=true"); // Redirect to view page

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("/add-test?error=true"); // Redirect on error
        }
    }

    // Save file to 'uploads' folder
    private String saveUploadedFile(Part filePart) throws IOException {
        String uploadDir = getServletContext().getRealPath("") + File.separator + "uploads";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdir();
        }

        String fileName = System.currentTimeMillis() + "_" + filePart.getSubmittedFileName();
        File file = new File(uploadDir, fileName);

        try (InputStream input = filePart.getInputStream();
             FileOutputStream output = new FileOutputStream(file)) {
            byte[] buffer = new byte[1024];
            int bytesRead;
            while ((bytesRead = input.read(buffer)) != -1) {
                output.write(buffer, 0, bytesRead);
            }
        }
        return "uploads/" + fileName;
    }
}
