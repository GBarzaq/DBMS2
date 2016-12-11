--campus

--professor: object, varray 5

--units: varray 5 varchar2

--school

--department

--research-center

--faculty

--equipments: varray 3 varchar2 

--building

--office 

--classroom

--lab

--degree
CREATE OR REPLACE TYPE Degree_T AS OBJECT(
  deg_ID VARCHAR2(20),
  deg_name VARCHAR2(30),
  deg_length VARCHAR2(30),
  deg_prereq VARCHAR2(30),
  faculty REF Faculty_T,
  
  STATIC PROCEDURE insert_degree (
    dge_id IN VARCHAR,
    deg_name IN VARCHAR2,
    deg_length IN VARCHAR2,
    deg_prereq IN VARCHAR2,
    fact_id IN VARCHAR2
  ),
  MEMBER PROCEDURE delete_degree,
  MEMBER PROCEDURE show_deg_record
);


CREATE TABLE Degrees OF Degree_T(
  PRIMARY KEY(deg_ID)
);

CREATE TABLE Degree_Records (
  deg_id VARCHAR2(20) PRIMARY KEY,
  deg_name VARCHAR2(30),
  deg_length  VARCHAR2(30),
  deg_prereq  VARCHAR2(30),
  all_students INTEGER
  
);

CREATE TYPE BODY Degree_T AS 
    STATIC PROCEDURE insert_degree (
    dge_id IN VARCHAR,
    deg_name IN VARCHAR2,
    deg_length IN VARCHAR2,
    deg_prereq IN VARCHAR2,
    fact_id IN VARCHAR2
  ) IS
     faculty REF Faculty_T;
    Begin
      SELECT REF(f) INTO faculty FROM Faculty f
      WHERE f.fact_id = fact_id;
      
      INSERT INTO Degrees VALUES
      (dge_id , deg_name , deg_length , deg_prereq , faculty);
    END insert_degree;
    
    MEMBER PROCEDURE delete_degree IS
      BEGIN 
        DELETE FROM Enrolls_In WHERE Enrolls_In.degree 
        IN (SELECT REF(d) FROM Degrees d 
        WHERE d.deg_id = SELF.deg_id);
        
        DELETE FROM Degrees d 
        WHERE d.deg_id = SELF.deg_id;
      END delete_degree;
        
    MEMBER PROCEDURE show_deg_record IS
      all_degrees INTEGER;
       BEGIN 
        SELECT COUNT(*) AS All_Students INTO 
        all_degrees FROM Degrees d , Enrolls e
        WHERE e.degree = REF(d) GROUP BY d.deg_id;
   
        INSERT INTO Degree_Records VALUES 
        (SELF.deg_id , SELF.deg_name
         , SELF.deg_length , SELF.deg_prereq , all_degrees );
  
    END show_deg_record;
END;
  
  

--person

--staff

--student

--admin

--technician

--lecturer

--senior_lecturer

--associate_lecturer

--tutor

--enrolls_in

--BODY OF OFFICE -SONDOS

--subject

--takes



