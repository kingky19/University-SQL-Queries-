--AUTHOR: Kyle King


SHOW search_path;
SET search_path TO university;


-- 1. Retrieve the records of all instructors who work for department 68.


SELECT * 
FROM instructor
WHERE dept_id = 68;


-- 2. Retrieve the record of the instructor with the highest salary in dept 68.



SELECT *
FROM instructor
WHERE salary = (SELECT MAX(salary) FROM instructor WHERE dept_id = 68);



-- 3. Retrieve the records of the highest paid instructors for each department. Order the results by salary in descending order.
SELECT *
FROM instructor
WHERE (dept_id,salary) IN (SELECT instructor.dept_id, MAX(salary) FROM instructor GROUP BY dept_id) 
ORDER BY salary DESC;


-- 4. Retrieve the department information of the highest paid instructor. 


SELECT d.dept_id, d.dept_name,d.building, d.budget
FROM instructor, department as d
WHERE (d.dept_id,salary) IN (SELECT instructor.dept_id, MAX(salary) FROM instructor GROUP BY dept_id) 
ORDER BY salary DESC LIMIT(1);




-- 5. Sum the budget of the departments who are in the science and tech building.  

SELECT SUM(budget)
FROM department
WHERE building = 'Science and Technology';


-- 6. Return the budget average for the departments in the sci tech building. 
SELECT AVG(budget)
FROM department
WHERE building = 'Science and Technology';


-- 7. Retrieve the records of all CSCI courses 

SELECT * 
FROM course
WHERE course_id ILIKE 'CSCI%';


-- 8. Retrieve the records of all classes that were offered in Spring 2020. 
SELECT * 
FROM class
WHERE semester ILIKE 'Spring' AND year = 2020;


-- 9. Retrieve the records of all classes that were offered in Spring 2020 that do not have a prereq. 
SELECT *
FROM class
WHERE semester ILIKE 'spring'
AND year = 2020
AND course_id NOT IN (SELECT course_id FROM prereq);



-- 10. Retrieve the records of the instructors who have taught the class that has been offered the most number of times. 


SELECT *
FROM instructor
WHERE instructor_id IN (SELECT instructor_id
FROM class
WHERE course_id IN (SELECT course_id
FROM class
GROUP BY course_id
ORDER BY COUNT(course_id) DESC
LIMIT 1));




