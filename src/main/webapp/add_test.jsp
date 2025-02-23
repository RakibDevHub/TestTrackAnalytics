<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Report a Bug | BugCheck Analytics</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col min-h-screen">

    <!-- Navbar -->
    <nav class="bg-blue-600 text-white p-4 shadow-lg">
        <div class="container mx-auto flex justify-between items-center">
            <h1 class="text-2xl font-bold">BugCheck Analytics</h1>
            <a href="<%= request.getContextPath()%>/home" class="px-4 py-2 bg-white text-blue-600 rounded-lg shadow hover:bg-gray-200">Home</a>
        </div>
    </nav>

    <!-- Form Container -->
    <main class="container mx-auto p-6 bg-white shadow-lg rounded-lg mt-10 w-full max-w-3xl">
        <h2 class="text-3xl font-bold text-center text-gray-800">Report a Bug</h2>
        <p class="text-center text-gray-600 mb-6">Fill out the form to report a new bug.</p>

        <form action="<%= request.getContextPath()%>/add_bug" method="post" enctype="multipart/form-data" class="space-y-4">
            
            <!-- Software Name -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Software Name:</label>
                <input type="text" name="software_name" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Software ID -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Software ID:</label>
                <input type="number" name="software_id" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Date -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Date:</label>
                <input type="date" name="date" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Tester Name -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Tester Name:</label>
                <input type="text" name="tester_name" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Bug Title -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Bug Title:</label>
                <input type="text" name="bug_title" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Bug Type (Dropdown) -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Bug Type:</label>
                <select name="bug_type" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                    <option value="UI Issue">UI Issue</option>
                    <option value="Functionality Issue">Functionality Issue</option>
                    <option value="Performance Issue">Performance Issue</option>
                    <option value="Security Issue">Security Issue</option>
                    <option value="Other">Other</option>
                </select>
            </div>

            <!-- Bug Severity (Radio Buttons) -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Bug Severity:</label>
                <div class="flex gap-4">
                    <label class="flex items-center">
                        <input type="radio" name="bug_severity" value="Low" required class="mr-2">
                        Low
                    </label>
                    <label class="flex items-center">
                        <input type="radio" name="bug_severity" value="Medium" required class="mr-2">
                        Medium
                    </label>
                    <label class="flex items-center">
                        <input type="radio" name="bug_severity" value="High" required class="mr-2">
                        High
                    </label>
                    <label class="flex items-center">
                        <input type="radio" name="bug_severity" value="Critical" required class="mr-2">
                        Critical
                    </label>
                </div>
            </div>

            <!-- Steps Performed -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Steps Performed:</label>
                <textarea name="steps_performed" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400"></textarea>
            </div>

            <!-- Expected Result -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Expected Result:</label>
                <textarea name="expected_result" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400"></textarea>
            </div>

            <!-- Actual Result -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Actual Result:</label>
                <textarea name="actual_result" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400"></textarea>
            </div>

            <!-- Error Message -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Error Message:</label>
                <input type="text" name="error_message" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Pass/Fail (Dropdown) -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Test Result:</label>
                <select name="test_result" required class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
                    <option value="Pass">Pass</option>
                    <option value="Fail">Fail</option>
                </select>
            </div>

            <!-- Attachments (JPG/PNG) -->
            <div>
                <label class="block text-gray-700 font-semibold mb-2">Attachments (JPG/PNG):</label>
                <input type="file" name="attachment" accept=".jpg, .png" class="w-full px-4 py-2 border rounded-lg focus:ring-2 focus:ring-blue-400">
            </div>

            <!-- Submit Button -->
            <div class="text-center">
                <button type="submit" class="px-6 py-3 bg-blue-600 text-white rounded-lg shadow-md text-lg font-semibold hover:bg-blue-700">
                    Submit Bug Report
                </button>
            </div>

        </form>
    </main>

    <!-- Sticky Footer -->
    <footer class="text-center py-6 mt-auto text-gray-600 shadow-t">
        &copy; 2025 BugCheck Analytics | Report, Track, and Fix Bugs Efficiently
    </footer>

</body>
</html>
