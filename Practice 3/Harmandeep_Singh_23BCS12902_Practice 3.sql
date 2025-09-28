-- Drop table if it exists
DROP TABLE IF EXISTS StudentEnrollments;

-- Create table
CREATE TABLE StudentEnrollments (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    course_id VARCHAR(10),
    enrollment_date DATE
);

-- Insert initial records
INSERT INTO StudentEnrollments (student_name, course_id, enrollment_date)
VALUES
('Ashish', 'CSE101', '2024-06-01'),
('Smaran', 'CSE102', '2024-06-01'),
('Vaibhav', 'CSE103', '2024-06-01');

-- Transaction 1: Update student 1
START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-01' WHERE student_id = 1;
COMMIT;

-- Transaction 2: Update student 2 twice in same transaction
START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-05' WHERE student_id = 2;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-15' WHERE student_id = 2;
COMMIT;

-- Transaction 3: Update student 1 again
START TRANSACTION;
UPDATE StudentEnrollments SET enrollment_date = '2024-07-20' WHERE student_id = 1;
COMMIT;

-- Clear table and insert one record
TRUNCATE TABLE StudentEnrollments;
INSERT INTO StudentEnrollments (student_name, course_id, enrollment_date)
VALUES ('Ashish', 'CSE101', '2024-06-01');

-- Transaction with REPEATABLE READ isolation level
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;
SELECT * FROM StudentEnrollments WHERE student_id = 1;

UPDATE StudentEnrollments SET enrollment_date = '2024-07-10' WHERE student_id = 1;
COMMIT;

SELECT * FROM StudentEnrollments WHERE student_id = 1;

-- Transaction using SELECT ... FOR UPDATE
TRUNCATE TABLE StudentEnrollments;
INSERT INTO StudentEnrollments (student_name, course_id, enrollment_date)
VALUES ('Ashish', 'CSE101', '2024-06-01');

START TRANSACTION;
SELECT * FROM StudentEnrollments WHERE student_id = 1 FOR UPDATE;

UPDATE StudentEnrollments SET enrollment_date = '2024-07-10' WHERE student_id = 1;
COMMIT;

SELECT * FROM StudentEnrollments WHERE student_id = 1;
