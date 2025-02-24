package com.rakibdevhub.testtrack.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Blob;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import java.util.Base64;

import com.rakibdevhub.testtrack.config.DatabaseConfig;
import com.rakibdevhub.testtrack.model.TestReport;

@WebServlet("/test-reports")
public class TestReportsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int softwareId = Integer.parseInt(request.getParameter("software_id"));
        List<TestReport> testReports = new ArrayList<>();

        String sql = "SELECT * FROM test_reports WHERE software_id = ?";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, softwareId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    TestReport report = new TestReport(
                            rs.getInt("test_id"),
                            rs.getInt("software_id"),
                            rs.getString("software_name"),
                            rs.getDate("test_date"),
                            rs.getString("tester_name"),
                            rs.getString("test_title"),
                            rs.getString("issue_type"),
                            rs.getString("bug_severity"),
                            rs.getString("steps_performed"),
                            rs.getString("expected_result"),
                            rs.getString("actual_result"),
                            rs.getString("error_message"),
                            rs.getString("test_result"),
                            null // We will handle the blob in the servlet
                    );

                    Blob attachmentBlob = rs.getBlob("attachment");
                    String base64Image = null;
                    if (attachmentBlob != null) {
                        try (InputStream inputStream = attachmentBlob.getBinaryStream()) {
                            byte[] bytes = inputStream.readAllBytes();
                            base64Image = Base64.getEncoder().encodeToString(bytes);
                        } catch (SQLException | IOException e) {
                            e.printStackTrace();
                        }
                    }
                    report.setAttachmentBase64(base64Image); // Set the Base64 string in the TestReport object.
                    testReports.add(report);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("testReports", testReports);
        request.getRequestDispatcher("test_reports.jsp").forward(request, response);
    }
}
