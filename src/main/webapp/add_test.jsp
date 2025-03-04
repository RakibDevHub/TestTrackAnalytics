<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Add Test Report | TestTrack Analytics</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <script>
            function toggleBugSeverity() {
                var issueType = document.getElementById("issueType").value;
                var bugSeverityDiv = document.getElementById("bugSeverityDiv");
                var errorMessageDiv = document.getElementById("errorMessageDiv");

                if (issueType === "N/A") {
                    bugSeverityDiv.style.display = "none";
                    errorMessageDiv.style.display = "none";

                } else {
                    bugSeverityDiv.style.display = "block";
                    errorMessageDiv.style.display = "block";
                }
            }
        </script>
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

        <!-- Form Container -->
        <main class="container mx-auto p-6 bg-white shadow-lg rounded-lg mt-10 w-full max-w-3xl">
            <h2 class="text-3xl font-bold text-center text-gray-800 mb-2">Add a Test</h2>
            <p class="text-center text-gray-600 mb-6">Fill out the form to report a new test.</p>

            <% if (request.getAttribute("message") != null) {%>
            <div class="bg-green-100 border border-green-400 text-green-700 px-4 py-3 rounded relative mb-4" role="alert">
                <strong class="font-bold">Success!</strong>
                <span class="block sm:inline"><%= request.getAttribute("message")%></span>
            </div>
            <% } %>

            <% if (request.getAttribute("error") != null) {%>
            <div class="bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative mb-4" role="alert">
                <strong class="font-bold">Error!</strong>
                <span class="block sm:inline"><%= request.getAttribute("error")%></span>
            </div>
            <% }%>

            <form action="<%= request.getContextPath()%>/add-test" method="post" enctype="multipart/form-data" class="space-y-4">

                <!-- Software Name -->
                <div>
                    <label for="softwareName" class="block text-gray-700 font-semibold mb-2">Software Name:</label>
                    <input type="text" id="softwareName" name="software_name" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Software ID -->
                <div>
                    <label for="softwareId" class="block text-gray-700 font-semibold mb-2">Software ID:</label>
                    <input type="number" id="softwareId" name="software_id" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Test Date -->
                <div>
                    <label for="testDate" class="block text-gray-700 font-semibold mb-2">Test Date:</label>
                    <input type="date" id="testDate" name="test_date" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Tester Name -->
                <div>
                    <label for="testerName" class="block text-gray-700 font-semibold mb-2">Tester Name:</label>
                    <input type="text" id="testerName" name="tester_name" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Test Title -->
                <div>
                    <label for="testTitle" class="block text-gray-700 font-semibold mb-2">Test Title:</label>
                    <input type="text" id="testTitle" name="test_title" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Issue Type (Dropdown) -->
                <div>
                    <label for="issueType" class="block text-gray-700 font-semibold mb-2">Issue Type:</label>
                    <select id="issueType" name="issue_type" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400" onchange="toggleBugSeverity()">
                        <option value="N/A">N/A</option>
                        <option value="UI/UX">UI/UX</option>
                        <option value="Functionality">Functionality Issue</option>
                        <option value="Performance">Performance Issue</option>
                        <option value="Security">Security Issue</option>
                    </select>
                </div>

                <!-- Bug Severity (Only displayed if Issue Type is selected) -->
                <div id="bugSeverityDiv" style="display: none;">
                    <label class="block text-gray-700 font-semibold mb-2">Bug Severity:</label>
                    <div class="flex gap-4">
                        <label class="flex items-center">
                            <input type="radio" name="bug_severity" value="Low" class="mr-2">
                            Low
                        </label>
                        <label class="flex items-center">
                            <input type="radio" name="bug_severity" value="Medium" class="mr-2">
                            Medium
                        </label>
                        <label class="flex items-center">
                            <input type="radio" name="bug_severity" value="High" class="mr-2">
                            High
                        </label>
                        <label class="flex items-center">
                            <input type="radio" name="bug_severity" value="Critical" class="mr-2">
                            Critical
                        </label>
                    </div>
                </div>

                <!-- Steps Performed -->
                <div>
                    <label for="stepsPerformed" class="block text-gray-700 font-semibold mb-2">Steps Performed:</label>
                    <textarea id="stepsPerformed" name="steps_performed" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400"></textarea>
                </div>

                <!-- Expected Result -->
                <div>
                    <label for="expectedResult" class="block text-gray-700 font-semibold mb-2">Expected Result:</label>
                    <textarea id="expectedResult" name="expected_result" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400"></textarea>
                </div>

                <!-- Actual Result -->
                <div>
                    <label for="actualResult" class="block text-gray-700 font-semibold mb-2">Actual Result:</label>
                    <textarea id="actualResult" name="actual_result" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400"></textarea>
                </div>

                <!-- Error Message -->
                <div id="errorMessageDiv" style="display: none;">
                    <label for="errorMessage" class="block text-gray-700 font-semibold mb-2">Error Message (Optional):</label>
                    <input type="text" id="errorMessage" name="error_message" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Test Result -->
                <div>
                    <label for="testResult" class="block text-gray-700 font-semibold mb-2">Test Result:</label>
                    <select id="testResult" name="test_result" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                        <option value="Pass">Pass</option>
                        <option value="Fail">Fail</option>
                    </select>
                </div>

                <!-- Attachments -->
                <div>
                    <label class="block text-gray-700 font-semibold mb-2">Attachments (JPG/PNG):</label>
                    <input type="file" name="attachment" accept=".jpg, .png" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                </div>

                <!-- Submit Button -->
                <div class="text-center">
                    <button type="submit" class="px-6 py-3 bg-blue-600 text-white rounded-lg shadow-md text-lg font-semibold hover:bg-blue-700">
                        Submit Test Report
                    </button>
                </div>

            </form>
        </main>
        <!-- Sticky Footer -->
        <footer class="text-center py-6 mt-auto text-gray-600 shadow-t">
            &copy; 2025 TestTrack Analytics | Built for efficient bug tracking
        </footer>
    </body>
</html>
