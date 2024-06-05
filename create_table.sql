
DROP TABLE IF EXISTS grades;
DROP TABLE IF EXISTS subjects;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS professors;
DROP TABLE IF EXISTS groups;


-- Table: Groups
CREATE TABLE groups (
id SERIAL PRIMARY KEY,
name_group CHAR(50) NOT NULL
);

-- Table: Students
CREATE TABLE students (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL,
    group_id INTEGER,
    FOREIGN KEY (group_id) REFERENCES groups (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Table: Professors
CREATE TABLE professors (
	id SERIAL PRIMARY KEY,
	name_prof CHAR(50) NOT NULL
);

--Table: Subjects
CREATE TABLE subjects (
    id SERIAL PRIMARY KEY,
    name_subject VARCHAR(50) UNIQUE NOT NULL,
    prof_id INTEGER,
    FOREIGN KEY (prof_id) REFERENCES professors (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE
);

-- Table: Grades
CREATE TABLE grades (
    id SERIAL PRIMARY KEY,
    student_id INTEGER,
    subject_id INTEGER,
    score SMALLINT NOT NULL,
    score_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects (id)
      ON DELETE CASCADE
      ON UPDATE CASCADE      
);

