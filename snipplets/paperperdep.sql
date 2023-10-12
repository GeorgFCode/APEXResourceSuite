-- Creating a table for storing information about researchers
CREATE TABLE researchers (
    researcher_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(50),
    last_name VARCHAR2(50),
    department VARCHAR2(100),
    email VARCHAR2(100)
);

-- Creating a table for storing research papers information
CREATE TABLE research_papers (
    paper_id NUMBER PRIMARY KEY,
    researcher_id NUMBER,
    title VARCHAR2(255),
    publication_date DATE,
    journal VARCHAR2(255),
    FOREIGN KEY (researcher_id) REFERENCES researchers(researcher_id)
);

-- Inserting sample data into researchers table
BEGIN
    INSERT INTO researchers VALUES (1, 'Alice', 'Johnson', 'Computer Science', 'alice.johnson@university.edu');
    INSERT INTO researchers VALUES (2, 'Bob', 'Smith', 'Physics', 'bob.smith@university.edu');
    INSERT INTO researchers VALUES (3, 'Carol', 'Davis', 'Biology', 'carol.davis@university.edu');
    COMMIT;
END;
/

-- Inserting sample data into research papers table
BEGIN
    INSERT INTO research_papers VALUES (1, 1, 'Algorithm Optimization in Machine Learning', TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'Journal of Computer Science');
    INSERT INTO research_papers VALUES (2, 2, 'Quantum Mechanics and Material Science', TO_DATE('2023-01-10', 'YYYY-MM-DD'), 'Journal of Physics');
    INSERT INTO research_papers VALUES (3, 3, 'Genetic Diversity in Plant Species', TO_DATE('2022-11-25', 'YYYY-MM-DD'), 'Journal of Biology');
    COMMIT;
END;
/

-- Creating a VIEW to analyze the data: Count of papers per department
CREATE OR REPLACE VIEW papers_per_department AS 
SELECT r.department, COUNT(*) as paper_count
FROM researchers r
JOIN research_papers p ON r.researcher_id = p.researcher_id
GROUP BY r.department;

-- Query to get the count of papers per department
SELECT * FROM papers_per_department;

-- Creating a stored procedure to get all papers by a specific researcher
CREATE OR REPLACE PROCEDURE get_papers_by_researcher (p_researcher_id IN NUMBER) AS
BEGIN
    FOR r IN (SELECT * FROM research_papers WHERE researcher_id = p_researcher_id) LOOP
        DBMS_OUTPUT.PUT_LINE('Title: ' || r.title || ', Published on: ' || TO_CHAR(r.publication_date, 'YYYY-MM-DD') || ', Journal: ' || r.journal);
    END LOOP;
END get_papers_by_researcher;
/

-- Executing the stored procedure to get all papers by a specific researcher
EXEC get_papers_by_researcher(1);
