CREATE TABLE TEMP (
    COL01 VARCHAR2(20),
    COL02 VARCHAR2(20)
    );

SELECT * FROM TEMP;    
INSERT INTO SCOTT.TEMP VALUES ('003','SCOTT03 ������');    

SELECT * FROM SCOTT.TEMP;

--GRANT SELECT ON TEMP TO SCOTT;
--GRANT INSERT ON TEMP TO SCOTT;
GRANT INSERT, SELECT ON TEMP TO SCOTT;