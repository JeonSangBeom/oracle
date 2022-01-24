--서브 쿼리안에 또 다른 쿼리 쓰기
--SELECT(메인 쿼리) 안에 SELECT(서브 쿼리) 쓰기

SELECT SAL 
FROM EMP
WHERE ENAME = 'JONES'; -->조건

--JONES 보다 월급이 높은 사람
SELECT * 
FROM EMP
WHERE SAL > 2975;

--서브쿼리 이용으로 바로 사용 가능
SELECT * 
FROM EMP
WHERE SAL > (
            SELECT SAL
            FROM EMP
            WHERE ENAME = 'JONES'
            ); -->단일행 리턴 하는 이것을 중첩 서브 쿼리라고 칭한다(다중행 가능)
            
--서브 쿼리 이용하여 EMP에서 이름이 ALLEN의 추가 수당보다 많은 추가 수당을 받는 애 뽑기
SELECT *
FROM EMP
WHERE COMM > (
            SELECT COMM
            FROM EMP
            WHERE ENAME = 'ALLEN'
            );
            
--BLAKE의 입사일 보다 늦게 입사한 사람
SELECT *
FROM EMP
WHERE HIREDATE > (
                SELECT HIREDATE
                FROM EMP
                WHERE ENAME = 'BLAKE'
                );
                
--20번 부서에 속한 사람 중 전체 사원의 평균 급여 보다 높은 급여를 받는 사람 정보 출력
SELECT E.EMPNO,E.ENAME,E.JOB,E.SAL,D.DEPTNO,D.DNAME,D.LOC
--같은 테이블이 아니기 때문에 조인해 주어야 한다 DEPT 풀네임을 앞에 쓰면 길기에 별명 사용
FROM EMP E, DEPT D-->D.DEPTNO,D.DNAME,D.LOC (D와 C로 별명 사용하여 편하게 사용)
WHERE E.DEPTNO = D.DEPTNO 
AND E.DEPTNO = 20 --20번 부서
AND E.SAL > (SELECT TRUNC(AVG(SAL)) FROM EMP);   -- 전체사원의 평균 급여


-- IN,ANY,SOME,ALL - 조건이 하나가 아닐때 사용
-- 실행결과가 여러개 나올 경우(다중행)
-- 조건 안 조건

--주로 IN을 많이 사용한다
SELECT *
FROM EMP 
WHERE DEPTNO IN(20,30);--20번 또는 30번인 부서(IN안에 다중행 함수 사용 가능)

-- 각 부서의 최고(max) 급여를 받는 사람 구하기
SELECT *
FROM EMP
WHERE SAL IN (SELECT MAX(SAL) --> IN : 안에 있는 것
              FROM EMP
              GROUP BY DEPTNO)
              ORDER BY DEPTNO;

--이퀄 = 등 을 앞에 써준다 / 값을 뽑아올때 주로 사용
--ANY, SOME 값이 하나라도 있으면 만족(TRUE) - 앞에 이퀄을 붙여 준다
--ALL 조건을 전부 만족해야만 TRUE를 리턴한다
SELECT *
FROM EMP
WHERE SAL = SOME (SELECT MAX(SAL)
                 FROM EMP
                 GROUP BY DEPTNO);
                 
SELECT *
FROM EMP
WHERE SAL = ANY(1000,2000,3000); 
--> SAL이 에 셋중 하나라도 있으면 값이 떨어진다
--> ALL일 경우는 없는 것으로 나온다(세가지 값을 전부 만족하여야 하기 때문)
--> = 대신 > 를 붙이면 1000이상 전부 출력(SOME도 같다)
         
-- EXISTS : 검색한 값이 있으면 전체를 출력한다 없으면 출력 하지 않는다
SELECT *
FROM EMP
WHERE EXISTS (SELECT DNAME 
              FROM DEPT
              WHERE DEPTNO = 10
              );
              
SELECT * FROM DEPT;              
    
--EMP에서 10번 부서에 속한 모든 사원들 보다 일찍 입사한 사람    
SELECT *
FROM EMP -- 행과 열만 있으면 TABLE이다
WHERE HIREDATE < ALL
                (
                SELECT HIREDATE 
                FROM EMP
                WHERE DEPTNO = 10
                );
-- WHERE 절에 쓰는 서브 쿼리 - 중첩 서브 쿼리
-- FROM 절에 쓰는 서브쿼리를 보통 인라인 뷰(전체 테이블에서 일부만 마스킹 해서 뷰로 만드는 것)

-- FROM(인라인 뷰) 절 사용 법
SELECT * 
FROM EMP
WHERE DEPTNO = 10;

SELECT * 
FROM DEPT;

--INLINE VIEW

--서브쿼리  / 조인 - 잘 판단하여 사용하여야 한단
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10, -->EMP E10(별명)과 같은 것
     (SELECT * FROM DEPT) D -->DEPT D
     --> TABLE을 들고 오는 것과 같은 뜻
WHERE E10.DEPTNO = D.DEPTNO;      


--SELECT절 - 스칼라 서브쿼리(컬럼명에 쓰는 쿼리/무조건 단일행)
--FROM - INLINE VIEW
--WHERE절 - 절에 쓴는 쿼리 중첩서브쿼리(따로 명칭은 없다) / 다중행 가능
-->세군데 전부 서브 쿼리 사용 가능
SELECT EMPNO, ENAME, JOB, SAL,
        (SELECT GRADE FROM SALGRADE WHERE E.SAL BETWEEN LOSAL AND HISAL) AS SALGRADE, 
        -->컬럼 설정
        DEPTNO,
        (SELECT DNAME FROM DEPT WHERE E.DEPTNO = DEPT.DEPTNO) AS DNAME
FROM EMP E;
--SELECT GRADE FROM SALGRADE;

--연습 문제 
--0901번
SELECT E.JOB, E.EMPNO, E.ENAME, E.SAL, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND JOB = (SELECT JOB FROM EMP WHERE ENAME = 'WARD');
--> (SELECT JOB FROM EMP WHERE ENAME = 'WARD')여기 해당되는 직업(중첩서브쿼리 사용법)
--> 바로 직업인 'SALESMAN'을 써도 된다


--0902번
SELECT E.EMPNO, E.ENAME, D.DNAME, E.HIREDATE, D.LOC, E.SAL, S.GRADE
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO 
AND E.SAL > (SELECT TRUNC(AVG(SAL)) FROM EMP)
AND E.SAL BETWEEN S.LOSAL AND S.HISAL
ORDER BY E.SAL DESC, E.EMPNO; -->DESC(뒤집어 표시 할때)


--0903번
SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
AND E.DEPTNO = 10
AND E.JOB NOT IN(SELECT JOB FROM EMP WHERE DEPTNO = 30); --> 다중행 함수여서 IN 사용
-->JOB NOT IN -> 부정 30번 부서에 없는 직업

--SELECT JOB FROM EMP WHERE DEPTNO = 30; 30번 부서의 JOB

--0904번-01
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND E.SAL > (SELECT MAX(SAL)FROM EMP WHERE JOB = 'SALESMAN')
ORDER BY E.EMPNO;

SELECT MAX(SAL)
FROM EMP
WHERE JOB = 'SALESMAN';

--0904번-02 다중행
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL
AND E.SAL > ALL(SELECT SAL FROM EMP WHERE JOB = 'SALESMAN') --ANY,ALL,IN(다중행)
ORDER BY E.EMPNO;

--부서 번호 20번에 있는 사원들의 급여에서 해당하는 JOB의 평균 급여의 차이를 구해보세요

SELECT E.EMPNO, E.ENAME, E.JOB,E.SAL,
E.SAL - (SELECT TRUNC(AVG(SAL)) AS AVG FROM EMP EE WHERE E.JOB = EE.JOB) AS AVG_SAL_DIFF
FROM EMP E
WHERE DEPTNO =20;

SELECT JOB, TRUNC(AVG(SAL)) AS AVG
FROM EMP
WHERE DEPTNO = 20
GROUP BY JOB;






----TABLE 만들어서 데이터 넣어보기---------


------INSERT UPDATE DELETE -이것들을 DML이라고 한다 ----

--DROP - 테이블을 지울떄 사용
DROP TABLE DEPT_TEMP; --> TABLE을 만들고 네임 써주기
CREATE TABLE DEPT_TEMP
    AS SELECT * FROM DEPT ;--> 복사할때 AS 를 사용(TABLE 복제)
    --AS SELECT * FROM DEPT WHERE 1 = 0;
--> WHERE 1 = 0; 껍데기만 가져올때 이런 조건자를 써둔다


SELECT *FROM DEPT_TEMP;

--추가로 넣고 싶을때
INSERT INTO DEPT_TEMP (DEPTNO,DNAME,LOC) --> 테이블명(컬럼명)
VALUES (50, 'DATABASE', 'SEOUL');--> 값

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (60, 'JAVA', 'BUSAN'); 
--> 정해진 갯수 중요 / 생략은 가능(컬럼과 값을 동일하게 맞춰 써둔 상태에서(NULL))

INSERT INTO DEPT_TEMP --> 생략도 가능하다
VALUES (70,'NETWORK','DANGSAN'); --> 컬럼 생략시 정확히 갯수 입력

INSERT INTO DEPT_TEMP
VALUES (80,'WEB',NULL);-->공백('') 또는 NULL값을 넣어주면 된다


----EMP 복제해서 본인 데이터 넣어보기
DROP TABLE EMP_TEMP;
CREATE TABLE EMP_TEMP
    AS SELECT * FROM EMP;
    
SELECT * FROM EMP_TEMP;    

INSERT INTO EMP_TEMP --> 컬럼 입력 해도 되고 안해도 됨(똑같은 값을 쓴다면 문제가 없다)
VALUES ('1','전상범','학생',NULL,'2021-10-21',NULL,NULL,NULL);
--> 날짜가 18/01/2022라고 쓰면 오류가 뜨지만 쓰고 싶을 경우
 -- TO_DATE('18/01/2022','DD/MM/YYYY')이렇게 써주면 사용이 가능하다
 -- SYSDATE 는 오늘 날짜

INSERT INTO EMP_TEMP
VALUES ('1','전상범','학생',NULL,SYSDATE,NULL,NULL,NULL);

-- 기존 가지고 있는 SMITH JAMES 추가
INSERT INTO EMP_TEMP
SELECT E.*
FROM EMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 1;
-->서브 쿼리로(정의 해둔걸 그대로 넣으면 된다) 넣을 경우 VALUES를 쓰지 않는다
-->데이터 타입이 같아야 하고 갯수도 같아야 한다

SELECT * FROM EMP_TEMP;


--UPDATE - 무조건 조건을 달아서 사용해야 한다
CREATE TABLE DEPT_TEMP02
AS SELECT * FROM DEPT;

--DML

UPDATE DEPT_TEMP02
SET LOC = 'SEOUL',-->LOC의 데이터 변경 / 조건이 없을 경우 전부 바뀐다
    DNAME = 'DB' -- 변경할 것 SET안에
WHERE DEPTNO = 40;

COMMIT;--> 저장(되둘릴 수 없다)
ROLLBACK; --> COMMIT전에는 다시 원상복구 시킬 수 있다

SELECT * FROM DEPT_TEMP02;

SELECT * FROM EMP_TEMP;
--2500 이하인 사람은 COMM 50

UPDATE EMP_TEMP
SET COMM = 50
WHERE SAL <= 2500;

ROLLBACK;
COMMIT;

----DELETE
DELETE FROM EMP_TEMP
WHERE JOB = 'CLERK'; --> JOB이 CLERK인 사람 삭제

SELECT * FROM EMP_TEMP;

--30번 부서에 GRADE =3인 사람 전부 날리기
DELETE FROM EMP_TEMP --> 전부 삭제(조건 필요)
WHERE EMPNO IN(
SELECT EMPNO 
FROM EMP_TEMP E, SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL 
AND S.GRADE = 3
AND E.DEPTNO = 30);

SELECT * FROM SALGRADE;

ROLLBACK;

SELECT * FROM EMP_TEMP;

--INSERT INTO TABLE명 () VALUES ();
--DELETE FROM TABLE명 WHERE 조건;
--UPDATE TABLE명 SET 컬러명 WHERE 조건;


---- 문제-----

CREATE TABLE CHAP10HW_EMP
AS SELECT * FROM EMP;

CREATE TABLE CHAP10HW_DEPT
AS SELECT * FROM DEPT;

CREATE TABLE CHAP10HW_SALGRADE
AS SELECT * FROM SALGRADE;

INSERT INTO CHAP10HW_DEPT(DEPTNO,DNAME,LOC) VALUES(50,'ORACLE','BUSAN');
INSERT INTO CHAP10HW_DEPT(DEPTNO,DNAME,LOC) VALUES(60,'SQL','ILSAN');
INSERT INTO CHAP10HW_DEPT(DEPTNO,DNAME,LOC) VALUES(70,'SELECT','INCHEON');
INSERT INTO CHAP10HW_DEPT(DEPTNO,DNAME,LOC) VALUES(80,'DML','BUNDANG');

ROLLBACK;

SELECT * FROM CHAP10HW_DEPT;

COMMIT;

INSERT INTO CHAP10HW_EMP
--VALUES(7201, 'TEST_USER','MANAGER',7788,TO_DATE('2016-01-02','YYYY-MM-DD-'),4500,NULL,50);
--values (7201,'TEST_USER1','MANAGER',7788,'2016/01/02',4500,NULL,50);
--values (7202,'TEST_USER2','CLERK',7201,'2016/02/21',1800,NULL,50);
--values (7203,'TEST_USER3','ANALYST',7201,'2016/04/11',3400,NULL,60);
--values (7204,'TEST_USER4','SALESMAN',7201,'2016/05/31',2700,300,60);
--values (7205,'TEST_USER5','CLERK',7201,'2016/07/20',2600,NULL,70);
--values (7206,'TEST_USER6','CLERK',7201,'2016/09/08',2600,NULL,70);
--values (7207,'TEST_USER7','LECTURER',7201,'2016/10/28',2300,NULL,80);
values (7208,'TEST_USER8','STUDENT',7201,'2018/03/09',1200,NULL,80);

SELECT * FROM CHAP10HW_EMP;
COMMIT;


UPDATE CHAP10HW_EMP
SET DEPTNO = 70 --> 70번으로 바꾸고
WHERE SAL >(SELECT AVG(SAL) FROM CHAP10HW_EMP
WHERE DEPTNO = 50); --> 50번의 부서에 있는 사람보다 월급 평균 보다 큰 사람

UPDATE CHAP10HW_EMP
SET SAL = SAL*1.1,
    DEPTNO = 80
WHERE HIREDATE > (SELECT MIN(HIREDATE) FROM CHAP10HW_EMP WHERE DEPTNO = 60);
ROLLBACK;
COMMIT;

--급여 등급이 5등급인 사람 삭제
DELETE FROM CHAP10HW_EMP
WHERE EMPBO = (SELECT E.EMPNO
                FROM CHAP10HW_EMP E, CHAP10HW_SALGRADE S
                WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL AND S.GRADE = 5);
                
SELECT * FROM CHAP10HW_EMP;


-------------TRANSACTION-----------------
-- 데이터 베이스 접속시 관계도

--다른 SCOTT 생성해서 테스트 실행
 -->동시에 두군데에서 접속을 할 경우 오류 발생(LOCK걸림) / 각 위치에서 COMMIT을 꼭 해야 함
    --한쪽을 COMMIT을 해야지만 가능 다음 서버에서 접속 가능하게 됨

DROP TABLE DEPT_TCL;
CREATE TABLE DEPT_TCL
AS SELECT * FROM DEPT;

INSERT INTO DEPT_TCL VALUES (50,'DATABASE','INCHEON');
UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 40;
DELETE FROM DEPT_TCL WHERE DEPTNO = 50;
SELECT * FROM DEPT_TCL;

ROLLBACK;

COMMIT;

--TEST
UPDATE DEPT_TCL SET DNAME = 'JAVA'
WHERE DEPTNO = 10;

SELECT * FROM DEPT_TCL;


--DML ---> INSERT UPDATE DELETE (COMMIT/ROLLBACK을 가지고 같이 움직임)
        --> 데이터를 다루는 것
--DDL ---> DEFINATION(정보) TABLE 만들기...
        --> 정보를 다룬다

DROP TABLE EMP_DDL;

--DDL TABLE/INDEX/VIEW 만드는 DB명령어 (COMMIT/ROLLBACK는 없다)
CREATE TABLE EMP_DDL(-->'_'이것만 쓸 수 있다
  ENPNO VARCHAR2(4) NOT NULL, -->NULL 값을 입력하면 안된다는 뜻
  ENAME VARCHAR2(10),
  JOB   VARCHAR2(9),
  MGR   NUMBER(4),
  HIREDATE  DATE,
  SAL   NUMBER(7,2), --> 7개 정수 두번째는 소숫점 올린단 뜻
  COMM  NUMBER(7,2),
  DEPTNO    NUMBER(2)
);
SELECT * FROM EMP_DDL;
INSERT INTO EMP_DDL VALUES(7877,'KING','PRESIDENT',NULL,TO_DATE('2022-01-18','YYYY-MM-DD'),5000,NULL, 10);
INSERT INTO EMP_DDL VALUES(7878,'BLAKE','MANAGER',7877,TO_DATE('2020-01-10','YYYY-MM-DD'),3000,NULL, 20);
INSERT INTO EMP_DDL VALUES(1001,'SCOTT','FREE',7877,SYSDATE,5000,NULL, NULL);
INSERT INTO EMP_DDL VALUES(1002,'JANG','FREE',7877,SYSDATE,55555.55,NULL, 10);

CREATE TABLE EMP_DEPT_DDL
AS SELECT E.EMPNO,E.ENAME,E.JOB,E.MGR,E.HIREDATE,E.SAL,E.COMM,D.DEPTNO, D.DNAME,D.LOC
FROM EMP E, DEPT D
WHERE 1 = 0;

SELECT * FROM EMP_DEPT_DDL;

DROP TABLE EMP_DEPT_DDL;

DROP TABLE EMP_ALTER;

CREATE TABLE EMP_ALTER 
AS SELECT * FROM EMP;

SELECT * FROM EMP_ALTER;

-- ALTER
-- TABLE 변경

--컬럼 추가 ADD
ALTER TABLE EMP_ALTER
ADD HP VARCHAR2(20);

-- 컬럼 이름 바꾸기 RENAME
ALTER TABLE EMP_ALTER
RENAME COLUMN HP TO TEL;

-- 컬럼 타입 바꾸기 MODIFY
ALTER TABLE EMP_ALTER
MODIFY EMPNO NUMBER(5);

DESC EMP_ALTER;

-- 삭제....
ALTER TABLE EMP_ALTER
DROP COLUMN HP;


-- TABLE 만들때 CREATE  수정할때 ALTER 
    
     
--- TABLE의 이름 바꾸기
RENAME EMP_ALTER TO EMP_RENAME;

-- 테이블 생성
CREATE TABLE EMP_ALTER 
AS SELECT * FROM EMP;

--- TABLE의 삭제.....
DROP TABLE EMP_RENAME;

DESC EMP_RENAME;

SELECT * FROM EMP_ALTER;

-- 데이터 삭제...
TRUNCATE TABLE EMP_ALTER;

