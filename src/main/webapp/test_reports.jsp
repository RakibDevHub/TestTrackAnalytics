<%@page import="java.util.Base64"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.util.List"%>
<%@page import="com.rakibdevhub.testtrack.model.TestReport"%>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Test Reports | TestTrack Analytics</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <style>
            #scrollTopBtn {
                position: fixed;
                bottom: 20px;
                right: 20px;
                display: none;
                z-index: 99;
                border: none;
                outline: none;
                background-color: #3b82f6;
                color: white;
                cursor: pointer;
                padding: 15px;
                border-radius: 10px;
                transition: background-color 0.3s ease;
            }

            #scrollTopBtn:hover {
                background-color: #2563eb;
            }

            html {
                scroll-behavior: smooth;
            }

            .attachment-image {
                max-width: 200px; /* Adjust as needed */
                max-height: 200px;
                margin-top: 10px;
                border-radius: 8px;
                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            }
        </style>
    </head>
    <body class="bg-gray-100 flex flex-col min-h-screen">

        <nav class="bg-gradient-to-r from-blue-600 to-indigo-600 text-white p-4 shadow-lg">
            <div class="container mx-auto flex justify-between items-center">
                <h1 class="text-2xl font-bold flex items-center">
                    <a href="<%= request.getContextPath()%>/home">
                        <i class="fas fa-bug mr-2"></i> TestTrack Analytics
                    </a>
                </h1>
                <a href="<%= request.getContextPath()%>/home" class="px-4 py-2 bg-white text-blue-600 rounded-lg shadow hover:bg-gray-200 transition duration-300">Home</a>
            </div>
        </nav>

        <div class="container mx-auto p-8">
            <div class="flex justify-between items-center mb-8">
                <h1 class="text-4xl font-extrabold text-gray-800">Test Reports</h1>
                <a href="<%= request.getContextPath()%>/export-test-report" class="px-4 py-2 bg-green-600 text-white rounded-lg shadow hover:bg-green-700 transition duration-300">
                    <i class="fas fa-file-export mr-2"></i> Export
                </a>
            </div>

            <%
                List<TestReport> testReports = (List<TestReport>) request.getAttribute("testReports");
                if (testReports != null && !testReports.isEmpty()) {
                    int serial = 1; // Initialize serial number
                    for (TestReport report : testReports) {
            %>
            <div class="bg-white rounded-2xl shadow-xl p-8 mb-6 border border-gray-200 transition duration-300 hover:shadow-2xl">
                <div class="flex justify-between items-start mb-6">
                    <div>
                        <h2 class="text-2xl font-semibold text-blue-700 mb-2">Test Report #<%= serial++%></h2>
                        <span class="text-sm text-gray-500">Reported on: <%= report.getTestDate()%></span>
                    </div>
                    <%
                        String resultColor = "bg-green-100 text-green-800"; // Default to green
                        if ("Fail".equals(report.getTestResult())) {
                            resultColor = "bg-red-100 text-red-800";
                        }
                    %>
                    <span class="inline-flex items-center px-3 py-1 rounded-full text-sm font-semibold <%= resultColor%>">
                        <%= report.getTestResult()%>
                    </span>
                </div>

                <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
                    <div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Software Name:</strong>
                            <span class="text-gray-800"><%= report.getSoftwareName() != null ? report.getSoftwareName() : "N/A"%></span>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Tester:</strong>
                            <span class="text-gray-800"><%= report.getTesterName() != null ? report.getTesterName() : "N/A"%></span>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Test Title:</strong>
                            <span class="text-gray-800"><%= report.getTestTitle() != null ? report.getTestTitle() : "N/A"%></span>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Issue Type:</strong>
                            <span class="text-gray-800"><%= report.getIssueType() != null ? report.getIssueType() : "N/A"%></span>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Bug Severity:</strong>
                            <span class="text-gray-800"><%= report.getBugSeverity() != null ? report.getBugSeverity() : "N/A"%></span>
                        </div>
                    </div>
                    <div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Steps Performed:</strong>
                            <pre class="whitespace-pre-wrap bg-gray-50 p-3 rounded-lg border border-gray-200 text-sm"><%= report.getStepsPerformed() != null ? report.getStepsPerformed() : "N/A"%></pre>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Expected Result:</strong>
                            <pre class="whitespace-pre-wrap bg-gray-50 p-3 rounded-lg border border-gray-200 text-sm"><%= report.getExpectedResult() != null ? report.getExpectedResult() : "N/A"%></pre>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Actual Result:</strong>
                            <pre class="whitespace-pre-wrap bg-gray-50 p-3 rounded-lg border border-gray-200 text-sm"><%= report.getActualResult() != null ? report.getActualResult() : "N/A"%></pre>
                        </div>
                        <div class="mb-4">
                            <strong class="block font-medium text-gray-700 mb-1">Error Message:</strong>
                            <pre class="whitespace-pre-wrap bg-gray-50 p-3 rounded-lg border border-gray-200 text-sm"><%= report.getErrorMessage() != null ? report.getErrorMessage() : "N/A"%></pre>
                        </div>                        
                        <% if (report.getAttachmentBase64() != null) {%>
                        <div class="mb-4">
                            <img src="data:image/jpeg;base64,<%= report.getAttachmentBase64()%>" alt="Attachment" class="attachment-image" />
                        </div>
                        <% } %>

                    </div>
                </div>
            </div>
            <%
                }
            } else {
            %>
            <p class="text-center text-gray-600">No test reports found.</p>
            <%
                }
            %>
        </div>

        <footer class="text-center py-6 mt-auto text-gray-600 shadow-t">
            &copy; 2025 TestTrack Analytics | Built for efficient bug tracking
        </footer>

        <button id="scrollTopBtn" title="Go to top"><i class="fas fa-arrow-up"></i></button>

        <script>
            let scrollTopBtn = document.getElementById("scrollTopBtn");

            window.onscroll = function () {
                scrollFunction()
            };

            function scrollFunction() {
                if (document.body.scrollTop > 20 || document.documentElement.scrollTop > 20) {
                    scrollTopBtn.style.display = "block";
                } else {
                    scrollTopBtn.style.display = "none";
                }
            }

            scrollTopBtn.onclick = function () {
                window.scrollTo({
                    top: 0,
                    behavior: 'smooth'
                });
            };
        </script>
    </body>
</html>