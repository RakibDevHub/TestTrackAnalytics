<%@page import="java.util.List"%>
<%@page import="com.rakibdevhub.testtrack.model.SoftwareTestStats"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>View Test Reports | TestTrack Analytics</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body class="bg-gray-100 flex flex-col min-h-screen">

        <!-- Navbar -->
        <nav class="bg-blue-600 text-white p-4 shadow-lg">
            <div class="container mx-auto flex justify-between items-center">
                <h1 class="text-2xl font-bold flex items-center">
                    <a href="<%= request.getContextPath()%>/home">
                        <i class="fas fa-bug mr-2"></i> TestTrack Analytics
                    </a>
                </h1>
                <a href="<%= request.getContextPath()%>/home" class="px-4 py-2 bg-white text-blue-600 rounded-lg shadow hover:bg-gray-200">Home</a>
            </div>
        </nav>

        <div class="container mx-auto p-6">
            <h1 class="text-3xl font-bold text-center mb-6">Software Test Reports</h1>
            <div class="overflow-x-auto">
                <table class="min-w-full bg-white border rounded-lg shadow-md">
                    <thead class="bg-blue-500 text-white">
                        <tr>
                            <th class="py-2 px-4">Software ID</th>
                            <th class="py-2 px-4">Software Name</th>
                            <th class="py-2 px-4">Number of Tests</th>
                            <th class="py-2 px-4">Passed Tests</th>
                            <th class="py-2 px-4">Failed Tests</th>
                            <th class="py-2 px-4">Accuracy (%)</th>
                            <th class="py-2 px-4">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% List<SoftwareTestStats> testStatsList = (List<SoftwareTestStats>) request.getAttribute("testStatsList");
                            for (SoftwareTestStats stats : testStatsList) {%>
                        <tr class="border-t hover:bg-gray-100">
                            <td class="py-2 px-4 text-center"><%= stats.getSoftwareId()%></td>
                            <td class="py-2 px-4 text-center"><%= stats.getSoftwareName()%></td>
                            <td class="py-2 px-4 text-center"><%= stats.getTotalTests()%></td>
                            <td class="py-2 px-4 text-center"><%= stats.getPassedTests()%></td>
                            <td class="py-2 px-4 text-center"><%= stats.getFailedTests()%></td>
                            <td class="py-2 px-4 text-center"><%= String.format("%.2f", stats.getAccuracy())%></td>
                            <td class="py-2 px-4 text-center">
                                <a href="<%= request.getContextPath()%>/test-reports?software_id=<%= stats.getSoftwareId()%>" 
                                   class="bg-blue-500 text-white px-3 py-1 rounded-md hover:bg-blue-600">View</a>
                            </td>
                        </tr>
                        <% }%>
                    </tbody>
                </table>
            </div>
        </div>
        <!-- Sticky Footer -->
        <footer class="text-center py-6 mt-auto text-gray-600 shadow-t">
            &copy; 2025 BugCheck Analytics | Built for efficient bug tracking
        </footer>
    </body>
</html>
