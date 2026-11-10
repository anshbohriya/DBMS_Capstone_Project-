-- Query 1: Create Database
CREATE DATABASE online_learning_mysql;

-- Query 2: Select Database
USE online_learning_mysql;

-- Query 3: Create Students Table
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(120) NOT NULL UNIQUE,
    joined_on DATE DEFAULT (CURRENT_DATE)
);

-- Query 4: Create Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(150) NOT NULL,
    description TEXT,
    difficulty_level ENUM('Beginner', 'Intermediate', 'Advanced')
        NOT NULL DEFAULT 'Beginner',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT NOT NULL,
    module_title VARCHAR(150) NOT NULL,
    module_description TEXT,
    module_order INT NOT NULL,
    estimated_duration INT,
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id),
    UNIQUE (course_id, module_order)
);

CREATE TABLE module_prerequisites (
    module_id INT NOT NULL,
    prerequisite_module_id INT NOT NULL,

    PRIMARY KEY (module_id, prerequisite_module_id),

    FOREIGN KEY (module_id)
        REFERENCES modules(module_id),

    FOREIGN KEY (prerequisite_module_id)
        REFERENCES modules(module_id),

    CHECK (module_id <> prerequisite_module_id)
);

CREATE TABLE learning_paths (
    path_id INT AUTO_INCREMENT PRIMARY KEY,
    path_name VARCHAR(150) NOT NULL,
    description TEXT,
    target_level ENUM('Beginner', 'Intermediate', 'Advanced')
        NOT NULL DEFAULT 'Beginner',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE path_modules (
    path_id INT NOT NULL,
    module_id INT NOT NULL,
    sequence_order INT NOT NULL,

    PRIMARY KEY (path_id, module_id),

    FOREIGN KEY (path_id)
        REFERENCES learning_paths(path_id),

    FOREIGN KEY (module_id)
        REFERENCES modules(module_id),

    UNIQUE (path_id, sequence_order)
);

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE DEFAULT (CURRENT_DATE),
    status ENUM('active', 'completed', 'dropped')
        NOT NULL DEFAULT 'active',

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (course_id)
        REFERENCES courses(course_id),

    UNIQUE (student_id, course_id)
);

CREATE TABLE module_completions (
    completion_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    module_id INT NOT NULL,
    completion_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    completion_status ENUM('completed', 'in_progress')
        NOT NULL DEFAULT 'in_progress',

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (module_id)
        REFERENCES modules(module_id),

    UNIQUE (student_id, module_id)
);

CREATE TABLE assessments (
    assessment_id INT AUTO_INCREMENT PRIMARY KEY,
    module_id INT NOT NULL,
    assessment_title VARCHAR(150) NOT NULL,
    total_marks DECIMAL(6,2) NOT NULL,
    passing_marks DECIMAL(6,2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (module_id)
        REFERENCES modules(module_id),

    CHECK (total_marks > 0),
    CHECK (passing_marks >= 0),
    CHECK (passing_marks <= total_marks)
);

CREATE TABLE assessment_attempts (
    attempt_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    assessment_id INT NOT NULL,
    obtained_marks DECIMAL(6,2) NOT NULL,
    attempt_date DATETIME DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (student_id)
        REFERENCES students(student_id),

    FOREIGN KEY (assessment_id)
        REFERENCES assessments(assessment_id),

    CHECK (obtained_marks >= 0)
);

INSERT INTO students (full_name, email)
VALUES
('Aarav Sharma', 'aarav@gmail.com'),
('Priya Verma', 'priya@gmail.com'),
('Rahul Singh', 'rahul@gmail.com'),
('Ananya Gupta', 'ananya@gmail.com'),
('Rohan Mehta', 'rohan@gmail.com');

INSERT INTO courses
(course_name, description, difficulty_level)
VALUES
('Python Programming',
 'Learn Python programming from basics to advanced concepts.',
 'Beginner'),

('Data Structures and Algorithms',
 'Understand data structures and algorithmic problem solving.',
 'Intermediate'),

('Database Management Systems',
 'Learn database concepts, SQL, and database design.',
 'Intermediate'),

('Machine Learning',
 'Explore machine learning algorithms and applications.',
 'Advanced'),

('Web Development',
 'Learn frontend and backend web development.',
 'Beginner');

INSERT INTO modules
(course_id, module_title, module_description, module_order, estimated_duration)
VALUES
(1, 'Python Basics', 'Introduction to Python syntax and variables.', 1, 60),
(1, 'Control Flow', 'Conditional statements and loops in Python.', 2, 90),
(1, 'Functions and Modules', 'Functions, arguments and Python modules.', 3, 90),

(2, 'Introduction to Data Structures', 'Basics of arrays, stacks and queues.', 1, 90),
(2, 'Searching and Sorting', 'Common searching and sorting algorithms.', 2, 120),

(3, 'Database Fundamentals', 'Introduction to databases and DBMS.', 1, 60),
(3, 'SQL Fundamentals', 'Learn SQL queries and operations.', 2, 120),

(4, 'Introduction to Machine Learning', 'Basics of machine learning.', 1, 90),
(4, 'Supervised Learning', 'Introduction to supervised learning algorithms.', 2, 120),

(5, 'HTML and CSS', 'Build web pages using HTML and CSS.', 1, 120),
(5, 'JavaScript Basics', 'Introduction to JavaScript programming.', 2, 120);

INSERT INTO module_prerequisites
(module_id, prerequisite_module_id)
VALUES
(2, 1),
(3, 2),
(5, 4),
(7, 6),
(9, 8),
(11, 10);

INSERT INTO learning_paths
(path_name, description, target_level)
VALUES
('Python Developer Path',
 'A structured path to learn Python programming from fundamentals.',
 'Beginner'),

('Data Structures and Algorithms Path',
 'A learning path focused on problem solving and algorithms.',
 'Intermediate'),

('Machine Learning Path',
 'A structured path covering machine learning fundamentals.',
 'Advanced');

 INSERT INTO path_modules
(path_id, module_id, sequence_order)
VALUES
(1, 1, 1),
(1, 2, 2),
(1, 3, 3),

(2, 4, 1),
(2, 5, 2),

(3, 8, 1),
(3, 9, 2);

INSERT INTO enrollments
(student_id, course_id, status)
VALUES
(1, 1, 'active'),
(1, 2, 'active'),
(2, 1, 'active'),
(2, 3, 'active'),
(3, 2, 'active'),
(3, 4, 'active'),
(4, 3, 'active'),
(4, 5, 'active'),
(5, 4, 'active'),
(5, 5, 'active');

INSERT INTO module_completions
(student_id, module_id, completion_status)
VALUES
(1, 1, 'completed'),
(1, 2, 'completed'),
(1, 3, 'in_progress'),

(2, 1, 'completed'),
(2, 2, 'in_progress'),

(3, 4, 'completed'),
(3, 5, 'in_progress'),

(4, 6, 'completed'),
(4, 7, 'completed'),

(5, 8, 'completed'),
(5, 9, 'in_progress');

INSERT INTO assessments
(module_id, assessment_title, total_marks, passing_marks)
VALUES
(1, 'Python Basics Quiz', 100, 40),
(2, 'Control Flow Quiz', 100, 40),
(3, 'Functions Assessment', 100, 40),
(4, 'Data Structures Quiz', 100, 40),
(5, 'Searching and Sorting Test', 100, 40),
(6, 'Database Fundamentals Quiz', 100, 40),
(7, 'SQL Assessment', 100, 40),
(8, 'Machine Learning Basics Quiz', 100, 40),
(9, 'Supervised Learning Test', 100, 40),
(10, 'HTML and CSS Quiz', 100, 40),
(11, 'JavaScript Assessment', 100, 40);

INSERT INTO assessment_attempts
(student_id, assessment_id, obtained_marks)
VALUES
(1, 1, 85),
(1, 1, 92),
(1, 2, 78),
(1, 3, 88),

(2, 1, 65),
(2, 1, 75),
(2, 2, 82),

(3, 4, 55),
(3, 4, 72),
(3, 5, 68),

(4, 6, 90),
(4, 7, 95),

(5, 8, 60),
(5, 8, 80),
(5, 9, 75);

CREATE INDEX idx_enrollments_student_course
ON enrollments(student_id, course_id);

CREATE INDEX idx_attempts_student_assessment_date
ON assessment_attempts(student_id, assessment_id, attempt_date);

ALTER TABLE enrollments
ADD COLUMN active_course_id INT
GENERATED ALWAYS AS (
    CASE
        WHEN status = 'active' THEN course_id
        ELSE NULL
    END
) STORED;

CREATE UNIQUE INDEX idx_unique_active_enrollment
ON enrollments(student_id, active_course_id);

CREATE VIEW student_progress_view AS
SELECT
    s.student_id,
    s.full_name,
    c.course_id,
    c.course_name,

    COUNT(DISTINCT CASE
        WHEN mc.completion_status = 'completed'
        THEN mc.module_id
    END) AS completed_modules,

    COUNT(DISTINCT m.module_id) AS total_modules,

    ROUND(
        COUNT(DISTINCT CASE
            WHEN mc.completion_status = 'completed'
            THEN mc.module_id
        END) * 100.0 /
        NULLIF(COUNT(DISTINCT m.module_id), 0),
        2
    ) AS completion_percentage,

    ROUND(AVG(aa.obtained_marks), 2) AS average_score

FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id
LEFT JOIN modules m
    ON c.course_id = m.course_id
LEFT JOIN module_completions mc
    ON s.student_id = mc.student_id
    AND m.module_id = mc.module_id
LEFT JOIN assessments a
    ON m.module_id = a.module_id
LEFT JOIN assessment_attempts aa
    ON s.student_id = aa.student_id
    AND a.assessment_id = aa.assessment_id

GROUP BY
    s.student_id,
    s.full_name,
    c.course_id,
    c.course_name;

SELECT *
FROM student_progress_view
ORDER BY student_id, course_id;

CREATE VIEW recommendation_view AS
SELECT
    s.student_id,
    s.full_name,
    c.course_name,
    m.module_id,
    m.module_title AS recommended_module

FROM students s
JOIN enrollments e
    ON s.student_id = e.student_id
JOIN courses c
    ON e.course_id = c.course_id
JOIN modules m
    ON c.course_id = m.course_id

WHERE NOT EXISTS (
    SELECT 1
    FROM module_completions mc
    WHERE mc.student_id = s.student_id
      AND mc.module_id = m.module_id
      AND mc.completion_status = 'completed'
)

AND NOT EXISTS (
    SELECT 1
    FROM module_prerequisites mp
    WHERE mp.module_id = m.module_id
      AND NOT EXISTS (
          SELECT 1
          FROM module_completions mc2
          WHERE mc2.student_id = s.student_id
            AND mc2.module_id = mp.prerequisite_module_id
            AND mc2.completion_status = 'completed'
      )
);

SELECT *
FROM recommendation_view
ORDER BY student_id, module_id;

SELECT
    s.student_id,
    s.full_name,
    ROUND(AVG(aa.obtained_marks), 2) AS average_score,
    CASE
        WHEN AVG(aa.obtained_marks) < 70
            THEN 'Needs Improvement'
        ELSE 'Good Performance'
    END AS learning_status
FROM students s
JOIN assessment_attempts aa
    ON s.student_id = aa.student_id
GROUP BY
    s.student_id,
    s.full_name
HAVING AVG(aa.obtained_marks) < 70;

SELECT
    s.student_id,
    s.full_name,
    a.assessment_title,
    aa.obtained_marks,
    aa.attempt_date,

    LAG(aa.obtained_marks) OVER (
        PARTITION BY aa.student_id, aa.assessment_id
        ORDER BY aa.attempt_date, aa.attempt_id
    ) AS previous_score,

    aa.obtained_marks -
    LAG(aa.obtained_marks) OVER (
        PARTITION BY aa.student_id, aa.assessment_id
        ORDER BY aa.attempt_date, aa.attempt_id
    ) AS score_difference

FROM assessment_attempts aa
JOIN students s
    ON aa.student_id = s.student_id
JOIN assessments a
    ON aa.assessment_id = a.assessment_id

ORDER BY
    aa.student_id,
    aa.assessment_id,
    aa.attempt_date,
    aa.attempt_id;

SELECT
    s.student_id,
    s.full_name,
    COUNT(aa.attempt_id) AS total_attempts,
    ROUND(AVG(aa.obtained_marks), 2) AS average_score,
    MAX(aa.obtained_marks) AS highest_score,
    MIN(aa.obtained_marks) AS lowest_score
FROM students s
JOIN assessment_attempts aa
    ON s.student_id = aa.student_id
GROUP BY
    s.student_id,
    s.full_name
ORDER BY average_score DESC;

SELECT
    student_id,
    full_name,
    average_score,
    RANK() OVER (
        ORDER BY average_score DESC
    ) AS student_rank
FROM (
    SELECT
        s.student_id,
        s.full_name,
        ROUND(AVG(aa.obtained_marks), 2) AS average_score
    FROM students s
    JOIN assessment_attempts aa
        ON s.student_id = aa.student_id
    GROUP BY
        s.student_id,
        s.full_name
) AS student_scores;

SELECT
    student_id,
    full_name,
    average_score,
    NTILE(3) OVER (
        ORDER BY average_score DESC
    ) AS performance_group
FROM (
    SELECT
        s.student_id,
        s.full_name,
        ROUND(AVG(aa.obtained_marks), 2) AS average_score
    FROM students s
    JOIN assessment_attempts aa
        ON s.student_id = aa.student_id
    GROUP BY
        s.student_id,
        s.full_name
) AS student_scores;

SELECT
    s.student_id,
    s.full_name,
    aa.assessment_id,
    aa.obtained_marks,
    aa.attempt_date,

    ROUND(
        AVG(aa.obtained_marks) OVER (
            PARTITION BY aa.student_id
            ORDER BY aa.attempt_date, aa.attempt_id
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ), 2
    ) AS running_average

FROM assessment_attempts aa
JOIN students s
    ON aa.student_id = s.student_id

ORDER BY
    aa.student_id,
    aa.attempt_date,
    aa.attempt_id;

SELECT
    course_name,
    student_id,
    full_name,
    average_score,
    RANK() OVER (
        PARTITION BY course_id
        ORDER BY average_score DESC
    ) AS course_rank
FROM (
    SELECT
        c.course_id,
        c.course_name,
        s.student_id,
        s.full_name,
        ROUND(AVG(aa.obtained_marks), 2) AS average_score
    FROM students s
    JOIN assessment_attempts aa
        ON s.student_id = aa.student_id
    JOIN assessments a
        ON aa.assessment_id = a.assessment_id
    JOIN modules m
        ON a.module_id = m.module_id
    JOIN courses c
        ON m.course_id = c.course_id
    GROUP BY
        c.course_id,
        c.course_name,
        s.student_id,
        s.full_name
) AS course_scores;

EXPLAIN
SELECT
    enrollment_id,
    student_id,
    course_id,
    enrollment_date,
    status
FROM enrollments
WHERE student_id = 1
  AND course_id = 2;

EXPLAIN
SELECT
    attempt_id,
    student_id,
    assessment_id,
    obtained_marks,
    attempt_date
FROM assessment_attempts
WHERE student_id = 1
  AND assessment_id = 1
ORDER BY attempt_date;


EXPLAIN
SELECT
    attempt_id,
    student_id,
    assessment_id,
    obtained_marks,
    attempt_date
FROM assessment_attempts FORCE INDEX
(idx_attempts_student_assessment_date)
WHERE student_id = 1
  AND assessment_id = 1
ORDER BY attempt_date;


EXPLAIN
SELECT
    attempt_id,
    student_id,
    assessment_id,
    obtained_marks,
    attempt_date
FROM assessment_attempts IGNORE INDEX
(idx_attempts_student_assessment_date)
WHERE student_id = 1
  AND assessment_id = 1
ORDER BY attempt_date;

EXPLAIN
INSERT INTO assessment_attempts
(student_id, assessment_id, obtained_marks)
VALUES
(1, 1, 88);

SHOW INDEX FROM assessment_attempts;

SHOW TABLES;
