# DBMS_Capstone_Project
🎓 Online Learning Platform with Adaptive Learning
A Database Management System (DBMS) Project Using MySQL
Developed by Sameer Mishra

📌 Project Overview
The Online Learning Platform with Adaptive Learning is a MySQL-based database project designed to manage students, courses, assessments, enrollments, learning paths, and academic progress.

The project demonstrates how relational database concepts and advanced SQL techniques can be used to support personalized learning experiences.

Unlike traditional learning systems that follow a fixed learning sequence, this database supports adaptive learning through prerequisite-based module recommendations and student performance analysis.

🎯 Project Objectives
Design a structured relational database for an online learning platform.
Manage students, courses, modules, and assessments.
Implement primary keys, foreign keys, and integrity constraints.
Track student progress and assessment performance.
Generate personalized learning recommendations.
Optimize database queries using indexing.
Analyze student performance using SQL window functions.
Examine query execution plans using EXPLAIN.
✨ Key Features
Feature	Description
Student Management	Stores student information and registration details
Course Management	Organizes courses according to difficulty levels
Learning Modules	Divides courses into structured modules
Prerequisite Management	Defines dependencies between learning modules
Learning Paths	Organizes modules into structured learning sequences
Enrollment Management	Tracks student course enrollments
Progress Tracking	Calculates module completion percentages
Assessment Management	Stores quizzes, tests, and student attempts
Adaptive Learning	Recommends eligible modules based on prerequisites
Performance Analysis	Uses SQL window functions to analyze student scores
Query Optimization	Uses indexes and EXPLAIN to analyze query execution
🛠️ Technologies Used
Technology	Purpose
MySQL 8.0+	Relational database management
MySQL Workbench	Database development and SQL execution
SQL	Database creation, manipulation, and analysis
Draw.io	Entity Relationship Diagram design
🗄️ Database Architecture
The database consists of 10 interconnected relational tables.

Table	Description
students	Stores student details
courses	Stores available courses
modules	Stores learning modules
module_prerequisites	Defines module dependencies
learning_paths	Stores structured learning paths
path_modules	Connects modules to learning paths
enrollments	Manages student enrollments
module_completions	Tracks module completion status
assessments	Stores assessments and passing criteria
assessment_attempts	Stores student assessment attempts and marks
Database Relationships
One student can enroll in multiple courses.
One course can contain multiple modules.
One module can have multiple prerequisites.
One learning path can contain multiple modules.
One student can have multiple assessment attempts.
Each assessment belongs to a learning module.
🧠 SQL Concepts Implemented
1. Database Design and Constraints
Primary Keys
Foreign Keys
UNIQUE Constraints
NOT NULL Constraints
CHECK Constraints
AUTO_INCREMENT
Referential Integrity
2. Indexing and Query Optimization
The project implements composite and unique indexes to improve database operations.

Indexes include:

idx_enrollments_student_course
idx_attempts_student_assessment_date
idx_unique_active_enrollment
Query execution plans are examined using:

EXPLAIN
FORCE INDEX
IGNORE INDEX
The project also discusses the disadvantages of over-indexing, including additional storage requirements and write-operation overhead.

3. SQL Views
Student Progress View

The student_progress_view provides:

Completed modules
Total modules
Completion percentage
Average assessment scores
Personalized Recommendation View

The recommendation_view identifies learning modules that students are eligible to study based on completed modules and prerequisite requirements.

4. Window Functions
Function	Application
RANK()	Overall and course-wise student ranking
LAG()	Previous assessment score comparison
NTILE(3)	Classification into three performance groups
AVG() OVER()	Running average score calculation
PARTITION BY	Student-wise and course-wise analysis
⚙️ Installation and Setup
Prerequisites
MySQL Server 8.0+
MySQL Workbench
Git (optional)
Step 1: Clone the Repository
git clone https://github.com/YOUR-USERNAME/YOUR-REPOSITORY.git
Step 2: Create the Database
Open MySQL Workbench and execute:

CREATE DATABASE online_learning_mysql;

USE online_learning_mysql;
Step 3: Create the Tables
Execute the table-creation statements in the following order:

students
courses
modules
module_prerequisites
learning_paths
path_modules
enrollments
module_completions
assessments
assessment_attempts
Step 4: Insert Sample Data
Execute the sample-data insertion statements after creating all tables.

Step 5: Create Indexes and Views
Execute the indexing and view-creation statements.

Step 6: Verify the Database
SHOW TABLES;
Step 7: Test Student Progress
SELECT *
FROM student_progress_view;
Step 8: Test Personalized Recommendations
SELECT *
FROM recommendation_view;
Note: If a complete SQL script is included in the repository, execute it in the documented order. Avoid rerunning non-idempotent CREATE TABLE and INSERT statements on an already populated database.

📊 Sample Dataset
The project uses the following sample records:

Entity	Records
Students	5
Courses	5
Modules	11
Module Prerequisites	6
Learning Paths	3
Path Modules	7
Enrollments	10
Module Completions	11
Assessments	11
Assessment Attempts	15
🔍 Adaptive Learning Logic
The personalized recommendation system follows prerequisite-based rules.

For example, consider the following learning sequence:

Python Basics → Control Flow → Functions and Modules

A student who has completed Python Basics but not Control Flow becomes eligible for the Control Flow module.

The recommendation query checks whether:

The student is enrolled in the relevant course.
The module has not already been completed.
All prerequisite modules have been completed.
Eligible modules are then returned as learning recommendations.

This implementation uses SQL-based prerequisite checking rather than a machine learning recommendation model.

📈 Student Performance Analysis
The database supports several analytical operations.

Student Ranking: Students are ranked according to average assessment scores.

Performance Trends: Previous and current assessment attempts are compared to identify improvement or decline.

Performance Classification: Students are divided into three approximately equal-sized performance groups.

Running Average: Average scores are recalculated across successive assessment attempts.

Course-wise Ranking: Students are ranked separately within individual courses.

🚀 Future Enhancements
Potential improvements include:

React-based frontend interface.
FastAPI backend integration.
Student authentication and role-based access control.
Real-time student progress dashboards.
Machine learning-based recommendation systems.
Automated knowledge-gap identification.
AI-powered personalized learning assistance.
Larger datasets for realistic performance benchmarking.
📚 Learning Outcomes
This project demonstrates practical knowledge of:

Relational Database Design
Entity Relationship Modeling
SQL Constraints and Referential Integrity
Data Insertion and Retrieval
Aggregate Functions
SQL Views
Window Functions
Composite and Unique Indexing
Query Execution Plans
Database Performance Optimization
👨‍💻 Developer
Sameer Mishra

B.Tech – Computer Science and Engineering (Data Science)

K.R. Mangalam University

Project: Online Learning Platform with Adaptive Learning

Domain: Database Management Systems (DBMS)

Project Type: Academic Database Project

📖 References
MySQL Official Documentation
MySQL Workbench Documentation
W3Schools SQL Tutorial
Draw.io
⭐ Support
If you find this project useful for learning SQL or Database Management Systems, consider giving the repository a star.


