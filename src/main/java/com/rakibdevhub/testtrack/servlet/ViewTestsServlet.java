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
import java.util.ArrayList;
import java.util.List;

import com.rakibdevhub.testtrack.config.DatabaseConfig;
import com.rakibdevhub.testtrack.model.SoftwareTestStats;

@WebServlet("/view-test")
public class ViewTestsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<SoftwareTestStats> testStatsList = new ArrayList<>();

        String sql = "SELECT software_id, software_name, COUNT(*) AS total_tests, "
                + "SUM(CASE WHEN test_result = 'Pass' THEN 1 ELSE 0 END) AS passed_tests, "
                + "SUM(CASE WHEN test_result = 'Fail' THEN 1 ELSE 0 END) AS failed_tests "
                + "FROM test_reports GROUP BY software_id, software_name";

        try (Connection conn = DatabaseConfig.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                int softwareId = rs.getInt("software_id");
                String softwareName = rs.getString("software_name");
                int totalTests = rs.getInt("total_tests");
                int passedTests = rs.getInt("passed_tests");
                int failedTests = rs.getInt("failed_tests");
                double accuracy = totalTests > 0 ? ((double) passedTests / totalTests) * 100 : 0;

                testStatsList.add(new SoftwareTestStats(softwareId, softwareName, totalTests, passedTests, failedTests, accuracy));
            }
        } catch (SQLException e) {
            log("Database error while fetching test reports: " + e.getMessage(), e);
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error fetching test data.");
        }

        request.setAttribute("testStatsList", testStatsList);
        request.getRequestDispatcher("view_test.jsp").forward(request, response);
    }
}
