-- Create the database for managing university enrollment
CREATE DATABASE University_Enrollment;

-- Create the students table to store student information
CREATE TABLE students {
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL;
    last_name VARCHAR(50) NOT NULL;
    email VARCHAR(100) UNIQUE NOT NULL;
    school_enrollment_date DATE NOT NULL
};

-- Create the professors table to store professor information
CREATE TABLE professors {
    id SERIAL PRIMARY KEY;
    first_name VARCHAR(50) NOT NULL;
    last_name VARCHAR(50) NOT NULL;
    department VARCHAR(100) NOT NULL
};

-- Create the courses table to store course information and link to professors
CREATE TABLE courses {
    id SERIAL PRIMARY KEY;
    course_name VARCHAR(100) NOT NULL,
    course_description TEXT,
    professor_id INT REFERENCES professor(id) ON DELETE SET NULL
};

-- Create the enrollments table to manage student enrollments in courses
CREATE TABLE enrollments {
    student_id INT REFERENCES students(id) ON DELETE CASCADE,
    course_id INT REFERENCES courses(id) ON DELETE CASCADE,
    enrollment_date DATE NOT NULL,
    PRIMARY KEY (student_id, course_id)
};

-- Insert data into the students table
INSERT INTO students (first_name, last_name, email, school_enrollment_date)
VALUES
('Mark', 'Stone', 'mstone@gmail.com', '2022-09-01'),
('Wally', 'Smith', 'wally.smith@gmail.com', '2021-09-01'),
('Emily', 'Gee', 'emily.gee@gmail.com', '2023-01-15'),
('Michael', 'Brown', 'michaelbrown@yahoo.com', '2020-09-01'),
('Faith', 'Adegunna', 'faithadegunna@yahoo.com', '2022-05-01');

-- Insert data into the professors table
INSERT INTO professor (first_name, last_name, department)
VALUES
('Ahmed', 'Surkur', 'Computer Science'),
('Marie', 'Curie', 'Physics'),
('Emma', 'Isaac', 'Mathematics'),
('David', 'Osho', 'Biology');

-- Insert data into the courses table
INSERT INTO courses (course_name, course_description, professor_id)
VALUES
('Physics 101', 'Introduction to Physics', 2),
('Computer Science 101', 'Introduction to Computer Science', 1),
('Mathematics 101', 'Introduction to Mathematics', 3);

-- Insert data into the enrollments table
INSERT INTO enrollments (student_id, course_id, enrollment_date)
VALUES
(1, 1, '2023-09-01'),
(2, 1, '2023-09-02'),
(3, 2, '2023-09-03'),
(4, 3, '2023-09-04'),
(5, 1, '2023-09-05');

-- Query to retrieve the full names of students enrolled in 'Physics 101'
SELECT first_name || ", " || last_name AS full_name
FROM students
JOIN enrollments ON students.id = enrollments.student_id
JOIN courses ON enrollments.course_id = courses.id
WHERE courses.course_name = 'Physics 101';

-- Query to retrieve all courses along with the professor's name who teaches each course
SELECT courses.course_name, professors.first_name || ' ' || professors.last_name AS professor_name
FROM courses
JOIN professors ON courses.professor_id = professors.id;

-- Query to retrieve all courses that have students enrolled in them
SELECT DISTINCT courses.course_name
FROM courses
JOIN enrollments ON courses.id = enrollments.course_id;

--Query to update student's email
UPDATE students
SET email = 'mark.stone@outlook.com'
WHERE id = 1;

--Query to remove a student from one of the courses
DELETE FROM enrollments
WHERE student_id = 1 AND course_id = 1;



