-- 주석
SELECT * FROM EMP;--EMP파일 내부 불러오고 뽑아오는 방법
--DESC emp; -- DESC - 구조볼떄 방법 중 하나
--DESC BONUS; -- 보통 cmd명령어로 쓰인다 (developer 같은 경우는 그냥 검색이 더 용이)


--SELECT가 기본 그뒤 필요한 정보를 쓰면 된다 FROM - ~에서
--ENAME 이름만 가져올때
SELECT EMPNO,ENAME,JOB, MGR FROM EMP;


-- DISTINCT 중복 제거(같은 부서나 중복이 있을때 사용)
--DEPTNO-부서 번호 
SELECT DISTINCT DEPTNO FROM EMP;

--ALL은 굳이 안써도 된다(쓰지 않아도 전부 출력)
SELECT ALL DEPTNO FROM EMP;

--부서와 직함을 알고 싶을때
SELECT DISTINCT DEPTNO,JOB FROM EMP;


--급여 정보가 궁금할떄 SAL-월급 SAL*12+COMM-연봉+커미션 
--AS ANNUALINCOME - AS를 쓰고 내용을 쓰면 입력한 값으로 컬러명이 연산된걸로 보이게 해준다 
SELECT ENAME, SAL, SAL*12+COMM AS ANNUALINCOME  FROM EMP;


--돈 많이 받는 사람 짜르기
--ORDER BY-정렬 (양이 많아지면 느려지게 하는 요인중 하나)
--DESC- 뒤집어라  DEPTNO ASC - 같은 부서 같이 모아서 출력
SELECT * FROM EMP
ORDER BY DEPTNO ASC,SAL DESC
;

-- 부서 번호가 30번 애들 뽑아보기...
-- WHERE절 조건 - 행의 값을 찾을때 사용
SELECT * FROM EMP
WHERE EMPNO = 7369
;

-- 부서 번호가 30 이면서 직업이 CLERK 인 사람
SELECT * FROM EMP
WHERE DEPTNO = 30 AND 
JOB = 'CLERK';


-- 부서 번호가 20 이거나 직업이 SALESMAN 인 사람
SELECT * FROM EMP
WHERE DEPTNO = 20 OR
JOB = 'SALESMAN'; --오라클 문자는 무조건 작은 따움표만 쓴다

-- SAL 3000인 사람....
SELECT * FROM EMP
WHERE SAL >= 3000;

-- 이름 F 이상인 사람....(문자도 크기 비교를 해준다/두글자도 가능)
SELECT * FROM EMP
WHERE ENAME >= 'F';

-- 월급이 3000이 아닌 사람 뽑기...
SELECT * FROM EMP
WHERE SAL != 3000; -- !=나 <>를 주로 사용한다

--JOB MANAGER ㄸ는 SALESMAN 또는 CLERK
SELECT * FROM EMP
WHERE JOB = 'MANAGER'   OR
      JOB = 'SALESMAN'  OR
      JOB = 'CLERK'
ORDER BY JOB;

--다른 방법 - 특정 조건 안에서 쓰고 싶을때 in을 사용
SELECT * FROM EMP
WHERE JOB IN ('MANAGER','SALESMAN','CLERK')
ORDER BY JOB;
--아닌 것 을 쓸때는 NOT을 앞에 쓴다
SELECT * FROM EMP
WHERE JOB NOT IN ('MANAGER','SALESMAN','CLERK')
ORDER BY JOB;

-- 부서 번호가 10, 20 번 사람 뽑기...
SELECT * FROM EMP
WHERE DEPTNO = 20 OR
      DEPTNO = 30;

SELECT * FROM EMP
WHERE DEPTNO IN (20,30) 
ORDER BY DEPTNO
;

-- 월급이 2000~3000 사이에 있는 사람
SELECT * FROM EMP
WHERE SAL >= 2000 AND
      SAL <= 3000;
--다른 방법 - BETWEEN 2000 AND 3000;
SELECT * FROM EMP
WHERE SAL BETWEEN 2000 AND 3000;


-- 월급이 2000 보다 작고  ~ 3000 보다 큰 사람
SELECT * FROM EMP
WHERE SAL <= 2000 OR
      SAL >= 3000;
--다른 방법 NOT BETWEEN 조건 제외한 나머지(부정)
SELECT * FROM EMP
WHERE SAL NOT BETWEEN 2000 AND 3000;


-- 검색  %는 길이와 상관없는 모든 글자....
SELECT * FROM EMP
WHERE ENAME LIKE 'M%'; -- LIKE - 검색해 올때 (%는 그 나머지 글 위치(무관))


-- 두번째 글자가 L인 사람 뽑기 WHERE ENAME LIKE '_L%';
SELECT * FROM EMP
WHERE ENAME LIKE '%A%'; 
-- A로 시작하든 중간에 A가 있든 다 뽑아 준다(주로 이름 두개를 써서 사용)


--NULL 조회하기...
--NULL = 로 조회가안된다 -  IS NULL을 써야 가능하다.
--IS NOT NULL(제외)
SELECT * FROM EMP
WHERE COMM IS NOT NULL;  



-- 합집합  union - join이 되면 잘 쓰지 않게 될 것(join이란 테이블 끼리 연결)
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 20
UNION -- or로도 쓸 수 있다 / 컬러명이 같아야 한다
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 30;

-- 합집합  union
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10
UNION ALL --똑같은걸 두번 뽑는다 중복허용
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;

-- 차집한  MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;

-- 교집한  union
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO FROM EMP
WHERE DEPTNO = 10;



---------------------------------------------------- 실습문제 ---------------
SELECT * FROM EMP
WHERE ENAME LIKE '%S'; 
-->S로 끝나는 사람 찾기

SELECT EMPNO , ENAME , JOB , SAL , DEPTNO FROM EMP
WHERE JOB = 'SALESMAN' AND 
      DEPTNO = 30;
-->  JOB = 'SALESMAN'   DEPTNO= 30 인 조건 찾기

--집합 연산자 사용 안한 경우
SELECT EMPNO , ENAME , JOB , SAL , DEPTNO FROM EMP
WHERE DEPTNO IN (20,30) AND -->20,30(or로 가능) 조건이 두개일 경우 이렇게 IN을 쓴는게 좋다
      SAL > 2000;
-->월급이 2000초과 이고 사원번호가 20또는 30인 조건 찾기      
  
--집합연산자를 사용한 경우
SELECT EMPNO , ENAME , JOB , SAL , DEPTNO FROM EMP
WHERE DEPTNO = 20  AND SAL > 2000
UNION
SELECT EMPNO , ENAME , JOB , SAL , DEPTNO FROM EMP
WHERE DEPTNO = 30  AND SAL > 2000;


SELECT * FROM EMP
WHERE SAL < 2000 OR 
      SAL > 3000;
-->월급 2000보다 작거나 3000보다 큰 경우
      
SELECT * FROM EMP
WHERE DEPTNO = 30 AND
      ENAME LIKE '%E%' AND
      SAL NOT BETWEEN 1000 AND 2000;
-->사원번호 30에 이름에 E가 포함되어 있고 월급이 1000이하 2000이상인 사람 
      
      
SELECT * FROM EMP
WHERE COMM IS NULL AND 
      MGR IS NOT NULL AND
      JOB IN ('MANAGER', 'CLERK') AND
      ENAME NOT LIKE '_L%';
-->커미션이 없고 상급자가 있고(MGR) 직책이 MANAGER', 'CLERK 둘중 하나거나 이름이 두번쨰가 L로 시작하지 않는 사람       
       