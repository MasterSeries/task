<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Task Management System</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.5/main.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/fullcalendar/5.11.5/main.min.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/3.7.0/chart.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
    <style>
        /* CSS styles remain the same as provided */
        :root {
            --primary-color: #4f46e5;
            --secondary-color: #818cf8;
            --background-color: #f3f4f6;
            --text-color: #1f2937;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Helvetica Neue", Arial, sans-serif;
        }

        body {
            background-color: var(--background-color);
            color: var(--text-color);
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }

        .auth-container {
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }

        .auth-box {
            background: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 100%;
            max-width: 400px;
        }

        .auth-title {
            text-align: center;
            font-size: 24px;
            margin-bottom: 30px;
            color: var(--primary-color);
        }

        .input-group {
            margin-bottom: 20px;
        }

        .input-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
        }

        .input-group input, .input-group select, .input-group textarea {
            width: 100%;
            padding: 12px;
            border: 1px solid #e5e7eb;
            border-radius: 6px;
            font-size: 16px;
        }

        .btn {
            background-color: var(--primary-color);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
            font-weight: 500;
            width: 100%;
            transition: background-color 0.2s;
        }

        .btn:hover {
            background-color: var(--secondary-color);
        }

        .btn-secondary {
            background-color: #9ca3af;
        }

        .btn-secondary:hover {
            background-color: #6b7280;
        }

        .auth-switch {
            text-align: center;
            margin-top: 20px;
        }

        .auth-switch a {
            color: var(--primary-color);
            text-decoration: none;
        }

        .app-container {
            display: none;
            min-height: 100vh;
        }

        .sidebar {
            width: 250px;
            background: white;
            padding: 20px;
            position: fixed;
            height: 100vh;
            box-shadow: 2px 0 4px rgba(0, 0, 0, 0.1);
        }

        .main-content {
            margin-left: 250px;
            padding: 20px;
        }

        .task-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }

 .task-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            cursor: pointer;
            transition: transform 0.2s;
        }

        .task-card:hover {
            transform: translateY(-2px);
        }

        .calendar-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            margin-top: 20px;
            height: 600px; /* Adjust as necessary */
            overflow: auto; /* Allows scrolling if content overflows */

        }

        .task-form {
            display: none;
            position: fixed;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            width: 90%;
            max-width: 500px;
            z-index: 1000;
        }

        .overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
            z-index: 999;
        }

        .task-details {
            background: white;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .admin-dashboard {
            display: none;
        }

        .admin-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
            
        }
        

        .stat-card {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .stat-number {
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-color);
        }

        .notification {
            position: fixed;
            top: 20px;
            right: 20px;
            padding: 15px 25px;
            border-radius: 6px;
            color: white;
            z-index: 1000;
            display: none;
        }

        .notification.success {
            background-color: #10b981;
        }

        .notification.error {
            background-color: #ef4444;
        }
        .glass-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.3);
        }

        .performance-chart {
            width: 100%;
            height: 300px;
            margin: 20px 0;
        }

        .employee-stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin: 20px 0;
        }

        .stat-card {
            padding: 20px;
            text-align: center;
            transition: transform 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
        }

        /* Enhanced calendar styling */
        .fc {
            background: white;
            padding: 20px;
            border-radius: 16px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        .fc-header-toolbar {
            padding: 20px;
            margin-bottom: 20px !important;
        }

        .fc-button-primary {
            background-color: var(--primary-color) !important;
            border-color: var(--primary-color) !important;
        }

        /* Responsive design improvements */
        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
 margin-left: 0;
                padding: 20px;
            }
        }

        /* Animation effects */
        .fade-in {
            animation: fadeIn 0.5s ease-in;
        }

        @keyframes fadeIn {
            from { opacity: 0; }
            to { opacity: 1; }
        }
        .report-modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            z-index: 1000;
        }

        .report-content {
            background-color: white;
            width: 90%;
            max-width: 800px;
            margin: 50px auto;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }

        .report-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 1px solid #e5e7eb;
        }

        .report-options {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-bottom: 20px;
        }

        .report-type {
            background: #f3f4f6;
            padding: 15px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .report-type:hover {
            background: #e5e7eb;
            transform: translateY(-2px);
        }

        .report-type.selected {
            background: var(--primary-color);
            color: white;
        }

        .date-filters {
            display: flex;
            gap: 20px;
            margin-bottom: 20px;
        }

        .report-preview {
            background: #f9fafb;
            padding: 20px;
            border-radius: 6px;
            margin-bottom: 20px;
            max-height: 400px;
            overflow-y: auto;
        }

        .report-actions {
            display: flex;
            justify-content: flex-end;
            gap: 10px;
        }

        .download-options {
            display: flex;
            gap: 10px;
        }

        .report-btn {
            padding: 8px 16px;
            border-radius: 4px;
            cursor: pointer;
            transition: background-color 0.2s;
        }

        .report-btn.primary {
            background-color: var(--primary-color);
            color: white;
            border: none;
        }

        .report-btn.secondary {
            background-color: #e5e7eb;
            border: none;
        }

        .report-metrics {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 15px;
            margin-bottom: 20px;
        }

        .metric-card {
            background: white;
            padding: 15px;
            border-radius: 6px;
            box-shadow: 0 1px 3px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        .metric-value {
            font-size: 24px;
            font-weight: bold;
            color: var(--primary-color);
            margin-bottom: 5px;
        }

        .metric-label {
            color: #6b7280;
            font-size: 14px;
        }

        .chart-container {
            margin: 20px 0;
            height: 300px;
        }

        @media (max-width: 768px) {
            .date-filters {
                flex-direction: column;
            }
            
            .download-options {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Notifications -->
    <div id="notification" class="notification"></div>

    <!-- Overlay -->
    <div id="overlay" class="overlay"></div>

    <!-- Login Page -->
    <div class="auth-container" id="loginPage">
        <div class="auth-box">
            <h2 class="auth-title">Login to Task Manager</h2>
            <form id="loginForm">
                <div class="input-group">
                    <label for="email">Email</label>
                    <input type="email" id="email" required>
                </div>
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" required>
 </div>
                <div class="input-group">
                    <label>Role</label>
                    <div style="display: flex; gap: 20px;">
                        <label>
                            <input type="radio" name="role" value="employee" checked> Employee
                        </label>
                        <label>
                            <input type="radio" name="role" value="admin"> Admin
                        </label>
                    </div>
                </div>
                <button type="submit" class="btn">Login</button>
            </form>
            <div class="auth-switch">
                <a href="#" onclick="showSignup()">Don't have an account? Sign up</a>
            </div>
        </div>
    </div>

    <!-- Signup Page -->
    <div class="auth-container" id="signupPage" style="display: none;">
        <div class="auth-box">
            <h2 class="auth-title">Create Account</h2>
            <form id="signupForm">
                <div class="input-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" required>
                </div >
                <div class="input-group">
                    <label for="signupEmail">Email</label>
                    <input type="email" id="signupEmail" required>
                </div>
                <div class="input-group">
                    <label for="signupPassword">Password</label>
                    <input type="password" id="signupPassword" required>
                </div>
                <div class="input-group">
                    <label>Role</label>
                    <div style="display: flex; gap: 20px;">
                        <label>
                            <input type="radio" name="signupRole" value="employee" checked> Employee
                        </label>
                        <label>
                            <input type="radio" name="signupRole" value="admin"> Admin
                        </label>
                    </div>
                </div>
                <button type="submit" class="btn">Sign Up</button>
            </form>
            <div class="auth-switch">
                <a href="#" onclick="showLogin()">Already have an account? Login</a>
            </div>
        </div>
    </div>

    <!-- Main App -->
    <div class="app-container" id="mainApp">
        <!-- Sidebar -->
        <div class="sidebar">
            <h2 style="margin-bottom: 20px;">Task Manager</h2>
            <button class="btn" style="margin-bottom: 10px;" onclick="showAddTaskForm()">Add New Task</button>
            <button class="btn" onclick="logout()">Logout</button>
        </div>

        <!-- Main Content -->
        <div class="main-content">
            <!-- Employee Dashboard -->
            <div id="employeeDashboard">
                <h2>My Tasks</h2>
                <div class="task-grid" id="taskGrid"></div>
            </div>

            <!-- Admin Dashboard -->
            <div class="admin-dashboard" id="adminDashboard">
                <h2>Admin Dashboard</h2>
                <button onclick="showReportModal()" class="btn">Generate Report</button>
                <div class="report-modal" id="reportModal">
                    <div class="report-content">
                        <div class="report-header">
                            <h2>Generate Report</h2>
                            <button onclick="closeReportModal()" class="report-btn secondary">&times;</button>
                        </div>
                        
                        <div class="report-options">
                            <div class="report-type selected" onclick="selectReportType(this, 'performance')">
                                <h3>Performance Report</h3>
                                <p>Task completion and efficiency metrics</p>
                            </div>
                            <div class="report-type" onclick="selectReportType(this, 'workload')">
                                <h3>Workload Report</h3>
                                <p>Task distribution and capacity analysis</p>
                            </div>
                            <div class="report-type" onclick="selectReportType(this, 'timeline')">
                                <h3>Timeline Report</h3>
                                <p>Project timelines and milestones</p>
                            </div>
                        </div>
            
                        <div class="date-filters">
                            <div class="input-group">
                                <label for="startDate">Start Date</label>
                                <input type="date" id="reportStartDate" class="form-control">
                            </div>
                            <div class="input-group">
                                <label for="endDate">End Date</label>
                                <input type="date" id="reportEndDate" class="form-control">
                            </div>
                        </div>
            
                        <div class="report-preview" id="reportPreview">
                            <div class="report-metrics">
                                <div class="metric-card">
                                    <div class="metric-value ">85%</div>
                                    <div class="metric-label">Task Completion Rate</div>
                                </div>
                                <div class="metric-card">
                                    <div class="metric-value">12</div>
                                    <div class="metric-label">Active Projects</div>
                                </div>
                                <div class="metric-card">
                                    <div class="metric-value">3.5</div>
                                    <div class="metric-label">Avg. Task Duration (days)</div>
                                </div>
                            </div>
                            
                            <div class="chart-container">
                                <canvas id="reportChart"></canvas>
                            </div>
                        </div>
            
                        <div class="report-actions">
                            <div class="download-options">
                                <button onclick="downloadReport('pdf')" class="report-btn primary">Download PDF</button>
                                <button onclick="downloadReport('excel')" class="report-btn primary">Download Excel</button>
                                <button onclick="downloadReport('csv')" class="report-btn primary">Download CSV</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="admin-stats">
                    
                    <div class="stat-card">
                        <div class="stat-number" id="totalTasks">0</div>
                        <div>Total Tasks</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number" id="activeTasks">0</div>
                        <div>Active Tasks</div>
                    </div>
                    <div class="stat-card">
                        <div class="stat-number" id="totalEmployees">0</div>
                        <div>Employees</div>
                    </div>
                </div>
                <div class="task-grid" id="adminTaskGrid"></div>
                <div class="user-list" id="userList"></div>
                <button id="downloadReportButton">Download Report</button>
            </div>
        </div>
    </div>

    <!-- Calendar View -->
    <div class="app-container" id="calendarView">
        <div class="sidebar">
            <h2 style="margin-bottom: 20px;">Task Manager</h2>
            <button class="btn" style="margin-bottom: 10px;" onclick="showAddTaskForm()">Add New Task</button>
            <button class="btn" style="margin-bottom: 10px;" onclick="showMainApp()">Back to Dashboard</button>
            <button class="btn" onclick="logout()">Logout</button>
        </div>
        <div class="main-content">
            <div class="calendar-container" id="calendar"></div>
            <div id="taskDetails" class="task-details"></div>
        </div>
    </div>

    <!-- Add Task Form -->
    <div class="task-form" id="addTaskForm">
        <h3 style="margin-bottom: 20px;">Create New Task</h3>
        <form id="createTaskForm">
            <div class="input-group">
                <label for="taskTitle">Task Title</label>
                <input type="text" id="taskTitle" required>
            </div>
            <div class="input-group">
                <label for="taskDescription">Description</label>
                <textarea id="taskDescription" rows="4"></textarea>
            </div>
            <div class="input-group">
                <label for="startDate">Start Date</label>
                <input type="datetime-local" id="startDate" required>
            </div>
            <div class="input-group">
                <label for="endDate">End Date</label>
                <input type="datetime-local" id="endDate" required>
            </div>
            <div class="input-group" id="assigneeGroup">
                <label for="assignee">Assign To</label>
                <select id="assignee">
                    <option value="">Select Employee</option>
                </select>
            </div>
            <div style="display: flex; gap: 10px;">
                <button type="submit" class="btn">Create Task</button>
                <button type="button" class="btn btn-secondary" onclick="hideAddTaskForm()">Cancel</button>
            </div>
        </form>
    </div>
    <div id="performanceModal" class="fixed inset-0 bg-black bg-opacity-50 hidden">
        <div class="glass-card w-11/12 max-w-4xl mx-auto mt-20 p-6">
            <div class="flex justify-between items-center mb-4">
                <h2 class="text-2xl font-bold">Employee Performance Report</h2>
                <button onclick="closePerformanceModal()" class="text-gray-600 hover:text-gray-800">&times;</button>
            </div>
            <div class="performance-metrics">
                <canvas id=" performanceChart" class="performance-chart"></canvas>
                <div class="employee-stats">
                    <!-- Stats will be populated dynamically -->
                </div>
                <button onclick="generatePDF()" class="btn">Download PDF Report</button>
            </div>
        </div>
    </div>

    <script>
        let db;
        const DB_NAME = 'TaskManagementDB';
        const DB_VERSION = 1;

        // Initialize application
        document.addEventListener('DOMContentLoaded', function() {
            initDB();
            setupEventListeners();
        });

        function initDB() {
            const request = indexedDB.open(DB_NAME, DB_VERSION);

            request.onerror = (event) => {
                console.error("Database error:", event.target.error);
                showNotification("Database error occurred", "error");
            };

            request.onupgradeneeded = (event) => {
                const db = event.target.result;

                // Create object stores with indexes
                if (!db.objectStoreNames.contains('users')) {
                    const userStore = db.createObjectStore('users', { keyPath: 'id', autoIncrement: true });
                    userStore.createIndex('email', 'email', { unique: true });
                }
                if (!db.objectStoreNames.contains('tasks')) {
                    const taskStore = db.createObjectStore('tasks', { keyPath: 'id', autoIncrement: true });
                    taskStore.createIndex('assignedTo', 'assignedTo');
                    taskStore.createIndex('status', 'status');
                }
                if (!db.objectStoreNames.contains('performance')) {
                    const perfStore = db.createObjectStore('performance', { keyPath: 'id', autoIncrement: true });
                    perfStore.createIndex('userId', 'userId');
                }
            };

            request.onsuccess = (event) => {
                db = event.target.result;
                console.log("Database initialized successfully");
                initializeCalendar();
                loadInitialData();
            };
        }

        // Global variables
        let calendar;
        let tasks = [];
        let users = [];
        let currentUser = null;

        document.addEventListener('DOMContentLoaded', function() {
            initializeCalendar();
            setupEventListeners();
            loadMockData();
        });

        function initializeCalendar() {
    const calendarEl = document.getElementById('calendar');
    if (!calendarEl) return;

    calendar = new FullCalendar.Calendar(calendarEl, {
        initialView: 'dayGridMonth',
        headerToolbar: {
            left: 'prev,next today',
            center: 'title',
            right: 'dayGridMonth,timeGridWeek,timeGridDay,listWeek'
        },
        events: [], // Populate with your events
        eventClick: function(info) {
            showTaskDetails(info.event);
        },
        dayMaxEvents: true,
        nowIndicator: true,
        businessHours: true,
        height: 'auto' // Adjust if needed
    });
    calendar.render();
}
        // Authentication functions
        async function handleLogin(e) {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const role = document.querySelector('input[name="role"]:checked').value;

            try {
                const transaction = db.transaction(['users'], 'readonly');
                const store = transaction.objectStore('users');
                const emailIndex = store.index('email');
                const user = await emailIndex.get(email);

                if (user && user.password === password && user.role === role) {
                    currentUser = user;
                    showNotification('Login successful!', 'success');
                    showMainApp();
                    updateDashboard();
                } else {
                    showNotification('Invalid credentials!', 'error');
                }
            } catch (error) {
                console.error('Login error:', error);
                showNotification('An error occurred during login', 'error');
            }
        }

        // Task management functions
        async function handleCreateTask(e) {
            e.preventDefault();
            
            const title = document.getElementById('taskTitle').value.trim();
            const description = document.getElementById('taskDescription').value.trim();
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;

            if (!title || !startDate || !endDate) {
                showNotification('Please fill in all required fields', 'error');
                return;
            }

            if (new Date(endDate) < new Date(startDate)) {
                showNotification('End date cannot be before start date', 'error');
                return;
            }

            const assignedTo = currentUser.role === 'admin' ? 
                parseInt(document.getElementById('assignee').value) : 
                currentUser.id;

            if (currentUser.role === 'admin' && !assignedTo) {
                showNotification('Please select an employee to assign the task', 'error');
                return;
            }

            try {
                const transaction = db.transaction(['tasks'], 'readwrite');
                const store = transaction.objectStore('tasks');

                const newTask = {
                    title,
                    description,
                    startDate,
                    endDate,
                    assignedTo ,
                    createdBy: currentUser.id,
                    status: 'pending',
                    createdAt: new Date().toISOString()
                };

                await store.add(newTask);
                
                updateCalendarEvents();
                updateDashboard();
                hideAddTaskForm();
                showNotification('Task created successfully!', 'success');
            } catch (error) {
                console.error('Error creating task:', error);
                showNotification('Error creating task', 'error');
            }
        }

        // Performance tracking
        async function trackTaskCompletion(taskId) {
            const transaction = db.transaction(['tasks', 'performance'], 'readwrite');
            const taskStore = transaction.objectStore('tasks');
            const perfStore = transaction.objectStore('performance');

            try {
                const task = await taskStore.get(taskId);
                if (!task) throw new Error('Task not found');

                const completionTime = (new Date(task.endDate) - new Date(task.startDate)) / (1000 * 60 * 60); // hours
                
                await perfStore.add({
                    taskId,
                    userId: task.assignedTo,
                    completionTime,
                    completedAt: new Date().toISOString()
                });

                task.status = 'completed';
                await taskStore.put(task);

                updateDashboard();
                updateCalendarEvents();
                showNotification('Task marked as completed', 'success');
            } catch (error) {
                console.error('Error tracking completion:', error);
                showNotification('Error updating task status', 'error');
            }
        }

        // Utility functions
        function showNotification(message, type) {
            const notification = document.getElementById('notification');
            notification.textContent = message;
            notification.className = `notification ${type}`;
            notification.style.display = 'block';

            if (notification.timeout) {
                clearTimeout(notification.timeout);
            }

            notification.timeout = setTimeout(() => {
                notification.style.display = 'none';
            }, 3000);
        }

        function setupEventListeners() {
            document.getElementById('loginForm').addEventListener('submit', handleLogin);
            document.getElementById('signupForm').addEventListener('submit', handleSignup);
            document.getElementById('createTaskForm').addEventListener('submit', handleCreateTask);
            
            // Add input validation for dates
            document.getElementById('startDate').addEventListener('change', validateDates);
            document.getElementById('endDate').addEventListener('change', validateDates);
        }
        function validateDates() {
            const startDate = new Date(document.getElementById('startDate').value);
            const endDate = new Date(document.getElementById('endDate').value);
            
            if (endDate < startDate) {
                showNotification('End date cannot be before start date', 'error');
                document.getElementById('endDate').value = '';
            }
        }
        // Mock data loading
        function loadMockData() {
            users = [
                { id: 1, name: 'John Doe', email: 'john@example.com', password: 'password', role: 'employee' },
                { id: 2, name: 'Admin User', email: 'admin@example.com', password: 'admin', role: 'admin' }
            ];

            tasks = [
                {
                    id: 1,
                    title: 'Complete Project Proposal',
                    description: 'Draft and submit the project proposal for client review',
                    startDate: '2024-10-26T09:00',
                    endDate: '2024-10-26T17:00',
                    assignedTo: 1,
                    createdBy: 2,
                    status: 'pending'
                },
                {
                    id: 2,
                    title: 'Team Meeting',
                    description: 'Weekly team sync-up meeting',
                    startDate: '2024-10-27T10:00',
                    endDate: '2024-10-27T11:00',
                    assignedTo: 1,
                    createdBy: 2,
                    status: 'pending'
                }
            ];

            updateCalendarEvents();
            updateDashboard();
        }

        // Authentication functions
        function showLogin() {
            document.getElementById('loginPage').style.display = 'flex';
            document.getElementById('signupPage').style.display = 'none';
            document.getElementById('mainApp').style.display = 'none';
            document.getElementById('calendarView').style.display = 'none';
        }

        function showSignup() {
            document.getElementById('loginPage').style.display = 'none';
            document.getElementById('signupPage').style.display = 'flex';
            document.getElementById('mainApp').style.display = 'none';
            document.getElementById('calendarView').style.display = 'none';
        }

        function handleLogin(e) {
            e.preventDefault();
            const email = document.getElementById('email').value;
            const password = document.getElementById('password').value;
            const role = document.querySelector('input[name="role"]:checked').value;

            const user = users.find(u => u.email === email && u.password === password && u.role === role);
            if (user) {
                currentUser = user;
                showNotification('Login successful!', 'success');
                document.getElementById('loginPage').style.display = 'none';
                document.getElementById('mainApp').style.display = 'block';
                if (user.role === 'admin') {
                    document.getElementById('adminDashboard').style.display = 'block';
                    document.getElementById('employeeDashboard').style.display = 'none';
                    document.getElementById('assigneeGroup').style.display = 'block';
                } else {
                    document.getElementById('adminDashboard').style.display = 'none';
                    document.getElementById('employeeDashboard').style.display = 'block';
                    document.getElementById('assigneeGroup').style.display = 'none';
                }
                updateDashboard();
            } else {
                showNotification('Invalid credentials!', 'error');
            }
        }

        function handleSignup(e) {
            e.preventDefault();
            const name = document.getElementById('name').value;
            const email = document.getElementById('signupEmail').value;
            const password = document.getElementById('signupPassword').value;
            const role = document.querySelector('input[name="signupRole"]:checked').value;

            if (users.some(u => u.email === email)) {
                showNotification('Email already exists!', 'error');
                return ;
            }

            const newUser = {
                id: users.length + 1,
                name,
                email,
                password,
                role
            };

            users.push(newUser);
            showNotification('Account created successfully!', 'success');
            showLogin();
        }

        function logout() {
            currentUser = null;
            tasks = [];
            calendar.removeAllEvents();
            showLogin();
        }


        // Task management functions
        function showAddTaskForm() {
            document.getElementById('overlay').style.display = 'block';
            document.getElementById('addTaskForm').style.display = 'block';
            
            if (currentUser.role === 'admin') {
                const assigneeSelect = document.getElementById('assignee');
                assigneeSelect.innerHTML = '<option value="">Select Employee</option>';
                users.filter(u => u.role === 'employee').forEach(user => {
                    assigneeSelect.innerHTML += `<option value="${user.id}">${user.name}</option>`;
                });
            }
        }

        function hideAddTaskForm() {
            document.getElementById('overlay').style.display = 'none';
            document.getElementById('addTaskForm').style.display = 'none';
            document.getElementById('createTaskForm').reset();
        }

        function handleCreateTask(e) {
            e.preventDefault();
            const title = document.getElementById('taskTitle').value;
            const description = document.getElementById('taskDescription').value;
            const startDate = document.getElementById('startDate').value;
            const endDate = document.getElementById('endDate').value;
            
            // Added validation
            if (new Date(endDate) < new Date(startDate)) {
                showNotification('End date cannot be before start date', 'error');
                return;
            }

            const assignedTo = currentUser.role === 'admin' ? 
                parseInt(document.getElementById('assignee').value) : 
                currentUser.id;

            // Added validation for admin assigning tasks
            if (currentUser.role === 'admin' && !assignedTo) {
                showNotification('Please select an employee to assign the task', 'error');
                return;
            }

            const newTask = {
                id: tasks.length + 1,
                title,
                description,
                startDate,
                endDate,
                assignedTo,
                createdBy: currentUser.id,
                status: 'pending'
            };

            tasks.push(newTask);
            updateCalendarEvents();
            updateDashboard();
            hideAddTaskForm();
            showNotification('Task created successfully!', 'success');
        }


        function showTaskDetails(event) {
            const task = tasks.find(t => t.id === parseInt(event.id));
            if (!task) return;

            const assignedUser  = users.find(u => u.id === task.assignedTo);
            const createdUser  = users.find(u => u.id === task.createdBy);

            const detailsHTML = `
                <h3>${task.title}</h3>
                <p><strong>Description:</strong> ${task.description}</p>
                <p><strong>Start Date:</strong> ${new Date(task.startDate).toLocaleString()}</p>
                <p><strong>End Date:</strong> ${new Date(task.endDate).toLocaleString()}</p>
                <p><strong>Assigned To:</strong> ${assignedUser  ? assignedUser .name : 'Unassigned'}</p>
                <p><strong>Created By:</strong> ${createdUser  ? createdUser .name : 'Unknown'}</p>
                <p><strong>Status:</strong> ${task.status}</p>
            `;

            document.getElementById('taskDetails').innerHTML = detailsHTML;
        }
         // Add this to your existing JavaScript
         function showReportModal() {
            document.getElementById('reportModal').style.display = 'block';
            initializeReportChart();
        }

        function closeReportModal() {
            document.getElementById('reportModal').style.display = 'none';
        }

        function selectReportType(element, type) {
            // Remove selected class from all report types
            document .querySelectorAll('.report-type').forEach(el => {
                el.classList.remove('selected');
            });
            
            // Add selected class to clicked element
            element.classList.add('selected');
            
            // Update preview based on selected type
            updateReportPreview(type);
        }

        function initializeReportChart() {
            const ctx = document.getElementById('reportChart').getContext('2d');
            new Chart(ctx, {
                type: 'line',
                data: {
                    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Tasks Completed',
                        data: tasks.map(() => Math.floor(Math.random() * 20) + 10),
                        borderColor: '#4f46e5',
                        tension: 0.1
                    },
                    {
                        label: 'On-time Completion Rate (%)',
                        data: tasks.map(() => Math.floor(Math.random() * 30) + 70),
                        borderColor: '#10b981',
                        tension: 0.1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        }

        function updateReportPreview(type) {
            // Update metrics and chart based on report type
            const metrics = document.querySelector('.report-metrics');
            
            switch(type) {
                case 'performance':
                    metrics.innerHTML = `
                        <div class="metric-card">
                            <div class="metric-value">85%</div>
                            <div class="metric-label">Task Completion Rate</div>
                        </div>
                        <div class="metric-card">
                            <div class="metric-value">12</div>
                            <div class="metric-label">Active Projects</div>
                        </div>
                        <div class="metric-card">
                            <div class="metric-value">3.5</div>
                            <div class="metric-label">Avg. Task Duration (days)</div>
                        </div>
                    `;
                    break;
                case 'workload':
                    metrics.innerHTML = `
                        <div class="metric-card">
                            <div class="metric-value">8</div>
                            <div class="metric-label">Tasks per Employee</div>
                        </div>
                        <div class="metric-card">
                            <div class="metric-value">75%</div>
                            <div class="metric-label">Resource Utilization</div>
                        </div>
                        <div class="metric-card">
                            <div class="metric-value">15</div>
                            <div class="metric-label">Total Employees</div>
                        </div>
                    `;
                    break;
                case 'timeline':
                    metrics.innerHTML = `
                        <div class="metric-card">
                            <div class="metric-value">92%</div>
                            <div class="metric-label">On-time Completion</div>
                        </div>
                        <div class="metric-card">
                            <div class="metric-value">3</div>
                            <div class="metric-label">Delayed Projects</div>
                        </div>
                        <div class="metric-card">
                            <div class="metric-value">5.2</div>
                            <div class="metric-label">Avg. Project Duration</div>
                        </div>
                    `;
                    break;
            }
        }

        function downloadReport(format) {
            const startDate = document.getElementById('reportStartDate').value;
            const endDate = document.getElementById('reportEndDate').value;
            
            if (!startDate || !endDate) {
                showNotification('Please select date range', 'error');
                return;
            }

            // Get selected report type
            const selectedType = document.querySelector('.report-type.selected');
            if (!selectedType) {
                showNotification('Please select a report type', 'error');
                return;
            }

            // Generate report based on format
            switch(format) {
                case 'pdf':
                    generatePDFReport();
                    break;
                case 'excel':
                    generateExcelReport();
                    break;
                case 'csv':
                    generateCSVReport();
                    break;
            }
        }

        function generatePDFReport() {
            const { jsPDF } = window.jspdf;
            const doc = new jsPDF();
            const reportDate = new Date().toLocaleDateString();
            
            // Add title
            doc.setFontSize(20);
            doc.text('Task Management Report', 20, 20);
            
            // Add date range
            doc.setFontSize(12);
            doc.text(`Period: ${document.getElementById('reportStartDate').value} to ${document.getElementById('reportEndDate').value}`, 20, 30);
            
            // Add metrics
            doc.setFontSize(14);
            doc.text('Key Metrics:', 20, 50);
            
            // Get current metrics from the UI
            const metrics = document.querySelectorAll('.metric-card');
            let yPosition = 60;
            
            metrics.forEach((metric, index) => {
                const value = metric.querySelector('.metric-value'). textContent;
                const label = metric.querySelector('.metric-label').textContent;
                doc.text(`${label}: ${value}`, 30, yPosition + (index * 10));
            });
            
            // Save the PDF
            doc.save(`task-report-${reportDate}.pdf`);
            showNotification('PDF report downloaded successfully', 'success');
        }

        function generateExcelReport() {
            // Mock Excel report generation
            const data = [
                ['Task', 'Assignee', 'Status', 'Due Date'],
                ['Task 1', 'John Doe', 'Completed', '2024-10-28'],
                ['Task 2', 'Jane Smith', 'In Progress', '2024-10-29']
            ];

            let csvContent = "data:text/csv;charset=utf-8,";
            data.forEach(row => {
                csvContent += row.join(",") + "\r\n";
            });

            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "task-report.xlsx");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            showNotification('Excel report downloaded successfully', 'success');
        }

        function generateCSVReport() {
            // Generate CSV content
            const data = [
                ['Task', 'Assignee', 'Status', 'Due Date'],
                ['Task 1', 'John Doe', 'Completed', '2024-10-28'],
                ['Task 2', 'Jane Smith', 'In Progress', '2024-10-29']
            ];

            let csvContent = "data:text/csv;charset=utf-8,";
            data.forEach(row => {
                csvContent += row.join(",") + "\r\n";
            });

            const encodedUri = encodeURI(csvContent);
            const link = document.createElement("a");
            link.setAttribute("href", encodedUri);
            link.setAttribute("download", "task-report.csv");
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
            
            showNotification('CSV report downloaded successfully', 'success');
        }

        function updateCalendarEvents() {
            const events = tasks.map(task => ({
                id: task.id.toString(),
                title: task.title,
                start: task.startDate,
                end: task.endDate,
                backgroundColor: task.status === 'completed' ? '#10b981' : '#4f46e5'
            }));

            calendar.removeAllEvents();
            calendar.addEventSource(events);
        }

         // Fixed assignment issue in updateDashboard
         function updateDashboard() {
            if (!currentUser) return;

            if (currentUser.role === 'admin') {
                document.getElementById('totalTasks').textContent = tasks.length;
                document.getElementById('activeTasks').textContent = tasks.filter(t => t.status === 'pending').length;
                document.getElementById('totalEmployees').textContent = users.filter(u => u.role === 'employee').length;

                const adminTaskGrid = document.getElementById('adminTaskGrid');
                adminTaskGrid.innerHTML = '';
                tasks.forEach(task => {
                    const assignedUser = users.find(u => u.id === task.assignedTo);
                    adminTaskGrid.innerHTML += createTaskCard(task, assignedUser);
                });
                
                const userList = document.getElementById('userList');
                userList.innerHTML = '';
                users.forEach(user => {
                    const userItem = document.createElement('div');
                    userItem.className = 'user-item';
                    userItem.innerHTML = `User ID: ${user.id} - Name: ${user.name}`;
                    userList.appendChild(userItem);
                });
            } else {
                const taskGrid = document.getElementById('taskGrid');
                taskGrid.innerHTML = '';
                const userTasks = tasks.filter(t => t.assignedTo === currentUser.id);
                userTasks.forEach(task => {
                    taskGrid.innerHTML += createTaskCard(task);
                });
            }
        }

        function createTaskCard(task, assignedUser  = null) {
            return `
                <div class="task-card" onclick="showCalendarView(${task.id})">
                    <h3>${task.title}</h3>
                    <p>${task.description}</p>
                    <p><strong>Due:</strong> ${new Date(task.endDate).toLocaleDateString()}</p>
                    ${assignedUser  ? `<p><strong>Assigned to:</strong> ${assignedUser .name}</p>` : ''}
                    <p><strong>Status:</strong> ${task.status}</p>
                </div>
            `;
        }

        function showCalendarView(taskId) {
            document.getElementById('mainApp'). style.display = 'none';
            document.getElementById('calendarView').style.display = 'block';
            
            if (taskId) {
                const task = tasks.find(t => t.id === taskId);
                if (task) {
                    calendar.gotoDate(task.startDate);
                    showTaskDetails({ id: taskId.toString() });
                }
            }
        }

        function showMainApp() {
            document.getElementById('calendarView').style.display = 'none';
 document.getElementById('mainApp').style.display = 'block';
            document.getElementById('taskDetails').innerHTML = '';
        }

        function showNotification(message, type) {
            const notification = document.getElementById('notification');
            notification.textContent = message;
            notification.className = `notification ${type}`;
            notification.style.display = 'block';

            // Clear any existing timeout
            if (notification.timeout) {
                clearTimeout(notification.timeout);
            }

            // Set new timeout
            notification.timeout = setTimeout(() => {
                notification.style.display = 'none';
            }, 3000);
        }
        function showPerformanceReport() {
    const performanceModal = document.getElementById('performanceModal');
    performanceModal.style.display = 'block';
    
    // Initialize performance chart
    const ctx = document.getElementById('performanceChart').getContext('2d');
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
            datasets: [{
                label: 'Tasks Completed',
                data: tasks.map(() => Math.floor(Math.random() * 20) + 10),
                borderColor: '#4f46e5',
                tension: 0.1
            },
            {
                label: 'On-time Completion Rate (%)',
                data: tasks.map(() => Math.floor(Math.random() * 30) + 70),
                borderColor: '#10b981',
                tension: 0.1
            }]
        },
        options: {
            responsive: true,
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Populate employee stats
    const statsContainer = document.querySelector('.employee-stats');
    statsContainer.innerHTML = `
        <div class="stat-card">
            <div class="stat-number">3.2</div>
            <div>Avg Task Duration (days)</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">87%</div>
            <div>On-time Completion Rate</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${tasks.filter(t => t.status === 'pending').length}</div>
            <div>Tasks in Progress</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">${tasks.filter(t => new Date(t.endDate) < new Date() && t.status === 'pending').length}</div>
            <div>Overdue Tasks</div>
        </div>
    `;
}

function closePerformanceModal() {
    document.getElementById('performanceModal').style.display = 'none';
}

function generatePDF() {
    const { jsPDF } = window.jspdf;
    const doc = new jsPDF();
    const reportDate = new Date().toLocaleDateString();
    
    // Add title
    doc.setFontSize(20);
    doc.text('Employee Performance Report', 20, 20);
    
    // Add date
    doc.setFontSize(12);
    doc.text(`Generated on: ${reportDate}`, 20, 30);
    
    // Add performance metrics
    doc.setFontSize(14);
    doc.text('Performance Metrics:', 20, 50);
    
    doc.setFontSize(12);
    doc.text(`Total Tasks: ${tasks.length}`, 30, 60);
    doc.text(`Completed Tasks: ${tasks.filter(t => t.status === 'completed').length}`, 30, 70);
    doc.text(`Tasks in Progress: ${tasks.filter(t => t.status === 'pending').length}`, 30, 80);
    doc.text(`Overdue Tasks: ${tasks.filter(t => new Date(t.endDate) < new Date() && t.status === 'pending').length}`, 30, 90);
    
    // Save the PDF
    doc.save('performance-report.pdf');
}
    </script>
</body>
</html>