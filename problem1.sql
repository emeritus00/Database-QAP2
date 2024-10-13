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