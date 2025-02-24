<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>TestTrack Analytics</title>
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
                <div>
                    <a href="<%= request.getContextPath()%>/add-test" class="px-4 py-2 bg-white text-blue-600 rounded-lg shadow hover:bg-gray-200">Add Test</a>
                    <a href="<%= request.getContextPath()%>/view-test" class="ml-4 px-4 py-2 bg-white text-blue-600 rounded-lg shadow hover:bg-gray-200">View Tests</a>
                </div>
            </div>
        </nav>

        <!-- Main Content -->
        <main class="container mx-auto text-center mt-16 flex-grow">
            <h2 class="text-4xl font-bold text-gray-800">Test & Track Software Bugs</h2>
            <p class="text-lg text-gray-600 mt-2">A simple and effective way to report, monitor, and resolve software issues.</p>

            <div class="mt-6">
                <a href="<%= request.getContextPath()%>/add-test" class="px-6 py-3 bg-blue-600 text-white rounded-lg shadow-md text-lg font-semibold hover:bg-blue-700">
                    Add Test Reports
                </a>
                <a href="<%= request.getContextPath()%>/view-test" class="ml-4 px-6 py-3 bg-gray-700 text-white rounded-lg shadow-md text-lg font-semibold hover:bg-gray-800">
                    View Test Reports
                </a>
            </div>
        </main>

        <!-- Sticky Footer -->
        <footer class="text-center py-6 mt-auto text-gray-600 shadow-t">
            &copy; 2025 BugCheck Analytics | Built for efficient bug tracking
        </footer>

    </body>
</html>
