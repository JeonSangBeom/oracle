SELECT * FROM EMP;
(hint) distinct
1. 사원들이 근무하고 있는 근무 부서의 번호를 중복없이 가져오시오.;
SELECT DISTINCT DEPTNO
FROM EMP
ORDER BY DEPTNO;

(hint) 연결연산자 || 또는 concat 함수 이용 
2.사원들의 이름과 직무를 다음 양식으로 가져온다. 000 사원의 담당 직무는 XXX 입니다;
SELECT CONCAT(CONCAT(ENAME,CONCAT(' 사원의 담당 직무는 ',JOB)), ' 입니다') AS NOANDNAME FROM EMP;



(hint) 산술연산자 이용
3. 각 사원들의 급여액과 급여액에서 1000을 더한 값, 200을 뺀 값, 2를 곱한 값, 2로 나눈 값을 가져오시오.;
SELECT SAL, SAL+1000, SAL-200, SAL*2, SAL/2
FROM EMP;



4. 각 사원의 급여액, 커미션, 급여 + 커미션 액수를 가져오시오. ;
SELECT SAL, COMM, SAL+COMM
FROM EMP;

(hint) Select 컬럼명1, 컬럼명2 from 테이블명
5. 사원의 이름과 사원 번호를 가져온다.  
6. 사원의 이름과 사원 번호, 직무, 급여를 가져온다.
7. 부서 번호와 부서 이름을 가져온다.;
SELECT ENAME, EMPNO
FROM EMP;

--6
SELECT ENAME, EMPNO, JOB, SAL
FROM EMP;

--7
SELECT DEPTNO, DNAME
FROM DEPT;

 (hint) *
 8. 부서의 모든 정보를 가져온다.
 9. 사원의 모든 정보를 가져온다.;
 SELECT *
 FROM EMP
 ORDER BY DEPTNO;
 
 SELECT * 
 FROM EMP
 ORDER BY EMPNO;

(hint) where 
10. 근무 부서가 10번인 사원들의 사원번호, 이름, 근무 부서를 가져온다. ;
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = 10;
11. 근무 부서 번호가 10번이 아닌 사원들의 사원번호, 이름, 근무 부서 번호를 가져온다.;
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO != 10;
12. 급여가 1500이상인 사원들의 사원번호, 이름, 급여를 가져온다.;
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>=1500;
13. 이름이 SMITH 사원의 사원번호, 이름, 직무, 급여를 가져온다. 
SELECT EMPNO, ENAME, JOB, SAL
FROM EMP
WHERE ENAME = 'SMITH';
14. 가 SALESMAN인 사원의 사원번호, 이름, 직무를 가져온다. 
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB = 'SALESMAN';
15. 직무가 CLERK이 아닌 사원의 사원번호, 이름, 직무를 가져온다. 
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB != 'CLERK';
16. 1982년 1월 1일 이후에 입사한 사원의 사원번호, 이름, 입사일을 가져온다.
SELECT EMPNO, ENAME, HIREDATE
FROM EMP
WHERE HIREDATE>'1982-01-01' ;

(hint) where  논리연산자 이용 (and , or, not in, between  a and b 등등);
17. 10번 부서에서 근무하고 있는 직무가 MANAGER인 사원의 사원번호, 이름, 근무부서, 직무를 가져온다. 
SELECT EMPNO, ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO = 10 AND
       JOB = 'MANAGER';
       
       
18. 입사년도가 1981년인 사원중에 급여가 1500 이상인 사원의 사원번호, 이름, 급여, 입사일을 가져온다.  
SELECT EMPNO, ENAME, SAL, HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYY')= 1981 AND
       SAL >= 1500;
19. 20번 부서에 근무하고 있는 사원 중에 급여가 1500 이상인 사원의 사원번호, 이름, 부서번호, 급여를 가져온다.
SELECT EMPNO, ENAME, DEPTNO, SAL
FROM EMP
WHERE DEPTNO = 20 AND
       SAL >= 1500;
20. 상관 사원 번호가 7698번인 사원중에 직무가 CLERK인 사원의 사원번호, 이름, 직속상관번호, 직무를 가져온다.
SELECT EMPNO, ENAME, MGR, JOB
FROM EMP
WHERE MGR = 7698 AND
      JOB = 'CLERK';
21. 가 2000보다 크거나 1000보다 작은 사원의 사원번호, 이름, 급여를 가져온다.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL NOT BETWEEN 1000 AND 2000;
      
22. 번호가 20이거나 30인 사원의 사원번호, 이름, 부서번호를 가져온다.
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = 20 OR
      DEPTNO = 30;
23. 직무가 CLERK, SALESMAN, ANALYST인 사원의 사원번호, 이름, 직무를 가져온다.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB IN ('CLERK','SALESMAN','ANALYST')
ORDER BY JOB;

24. 사원 번호가 7499, 7566, 7839가 아닌 사원들의 사원번호, 이름을 가져온다
SELECT EMPNO, ENAME
FROM EMP
WHERE EMPNO NOT IN(7499, 7566, 7839);


(hint) like            ==>   _ : 글자 하나를 의미한다.  % : 글자 0개 이상을 의미한다.;
25. 이름이 F로 시작하는 사원의 이름과 사원 번호를 가져온다.
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE 'F%'; 

26. 이 S로 끝나는 사원의 이름과 사원 번호를 가져온다.
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%S'; 
27. 이름에 A가 포함되어 있는 사원의 이름과 사원 번호를 가져온다.
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '%A%'; 
28. 이름의 두번째 글자가 A인 사원의 사원 이름, 사원 번호를 가져온다.
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '_A%'; 
29. 이름이 4글자인 사원의 사원 이름, 사원 번호를 가져온다.
SELECT EMPNO, ENAME
FROM EMP
WHERE ENAME LIKE '____'; 


(hint) is null  /  is not null;
30. 사원중에 커미션을 받지 않는 사원의 사원번호, 이름, 커미션을 가져온다.
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE COMM IS NOT NULL; 
31. 회사 대표(직속상관이 없는 사람)의 이름과 사원번호를 가져온다.
SELECT EMPNO, ENAME
FROM EMP
WHERE MGR IS NULL;


(hint) order by;
32. 사원의 사원번호, 이름, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY SAL ASC;
33. 사원의 사원번호, 이름, 급여를 가져온다. 사원번호를 기준으로 내림차순 정렬을 한다.
SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY EMPNO DESC;
34. 사원의 사원번호, 이름을 가져온다, 사원의 이름을 기준으로 오름차순 정렬을 한다.
SELECT EMPNO,ENAME,SAL
FROM EMP
ORDER BY ENAME ASC;
35. 사원의 사원번호, 이름, 입사일을 가져온다. 입사일을 기준으로 내림차순 정렬을 한다.
SELECT EMPNO,ENAME,HIREDATE
FROM EMP
ORDER BY HIREDATE DESC;
36. 직무가 SALESMAN인 사원의 사원이름, 사원번호, 급여를 가져온다. 급여를 기준으로 오름차순 정렬을 한다.
SELECT EMPNO,ENAME,SAL
FROM EMP
WHERE JOB = 'SALESMAN'
ORDER BY SAL ASC;
37. 1981년에 입사한 사원들의 사원번호, 사원 이름, 입사일을 가져온다. 사원 번호를 기준으로 내림차순 정렬을 한다.
SELECT EMPNO,ENAME,HIREDATE
FROM EMP
WHERE TO_CHAR(HIREDATE,'YYYY')= 1981
ORDER BY HIREDATE DESC;
38. 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 오름차순 정렬을 한다.
SELECT ENAME,SAL,COMM
FROM EMP
WHERE COMM IS NOT NULL
ORDER BY COMM ASC ;
39. 사원의 이름, 급여, 커미션을 가져온다. 커미션을 기준으로 내림차순 정렬을 한다.
SELECT ENAME,SAL,COMM
FROM EMP
WHERE COMM IS NOT NULL
ORDER BY COMM DESC ;


(hint) 숫자함수 round, abs, trunc 등등;
40. 전직원의 급여를 2000 삭감하고 삭감한 급여액의 절대값을 구한다.
SELECT ABS(SAL-2000)
FROM EMP;
41. 급여가 1500 이상인 사원의 급여를 15% 삭감한다. 단 소수점 이하는 버린다.
SELECT TRUNC(SAL*0.85)
FROM EMP
WHERE SAL>=1500;
42. 급여가 2천 이하인 사원들의 급여를 20%씩 인상한다. 단 10의 자리를 기준으로 반올림한다.
SELECT ROUND(SAL*1.2, -2)
FROM EMP
WHERE SAL<=2000;
43. 전 직원의 급여를 10자리 이하를 삭감한다
SELECT TRUNC(SAL,-2)
FROM EMP;


( hint) decode / case ;
44. 각 사원의 부서 이름을 가져온다.
    ex) 10 : 인사과, 20 : 개발부, 30 : 경원지원팀,    40 : 생산부
    SELECT DEPTNO,
        DECODE(DEPTNO,
               10,'인사과',
               20,'개발부',
               30,'경원지원팀',
               '생산부'
            ) AS 부서이름
FROM EMP;
45. 직급에 따라 인상된 급여액을 가져온다.
   ex) CLERK : 10%
       SALESMAN : 15%
       PRESIDENT : 200%
       MANAGER : 5%
       ANAYST : 20%;
SELECT JOB,SAL,
DECODE(JOB,
       'CLERK',SAL*1.1,
       'SALESMAN',SAL*1.15,
       'PRESIDENT', SAL*2.0,
       'MANAGER', SAL*1.05,
       'ANAYST', SAL*1.2,
       SAL 
        ) AS UP_SAL
FROM EMP;

46. 급여액 별 등급을 가져온다.
   ex) 1000 미만 : C등급
       1000 이상 2000미만 : B등급
       2000 이상 : A등급
SELECT ENAME,SAL, 
         CASE 
             WHEN SAL < 1000  THEN 'C등급'
             WHEN SAL < 2000  THEN 'B등급'
             WHEN SAL > 2000  THEN 'A등급'
             ELSE 'D등급'
             END   AS 등급표
FROM EMP
ORDER BY SAL;       

47. 직원들의 급여를 다음과 같이 인상한다.
ex) 1000 이하 : 100%
    1000 초과 2000미만 : 50%
    2000 이상 : 200%
SELECT ENAME,SAL, 
         CASE 
             WHEN SAL < 1000  THEN SAL
             WHEN SAL < 2000  THEN SAL*1.5
             WHEN SAL > 2000  THEN SAL*2.0
             END   AS 인상
FROM EMP
ORDER BY SAL;        


( hint)그룹함수 이용  sum/avg/count/max/min 등등;



48. 사원들의 커미션 총합을 구한다.;
SELECT SUM(COMM)
FROM EMP;
49. 급여가 1500 이상인 사원들의 급여 총합을 구한다.
SELECT SUM(SAL)
FROM EMP
WHERE SAL>=1500;
50. 20번 부서에 근부하고 있는 사원들의 급여 총합을 구한다.
SELECT SUM(SAL)
FROM EMP
WHERE DEPTNO = 20;
51. 직무가 SALESMAN인 사원들의 급여 총합을 구한다.
SELECT SUM(SAL)
FROM EMP
WHERE JOB='SALESMAN';
52. 직무가 SALESMAN인 사원들의 이름과 급여총합을 가져온다.
SELECT ENAME, SUM(SAL)
FROM EMP
WHERE JOB='SALESMAN'
GROUP BY ENAME, SAL;

53. 전 사원의 급여 평균을 구한다.
SELECT TRUNC(AVG(SAL))
FROM EMP;
54. 커미션을 받는 사원들의 커미션 평균을 구한다.
SELECT TRUNC(AVG(COMM))
FROM EMP
WHERE COMM IS NOT NULL;
55. 전 사원의 커미션의 평균을 구한다.
SELECT TRUNC(AVG(COMM))
FROM EMP;
56. 커미션을 받는 사원들의 급여 평균을 구한다.
SELECT TRUNC(AVG(SAL))
FROM EMP
WHERE COMM IS NOT NULL;
57. 30번 부서에 근무하고 있는 사원들의 급여 평균을 구한다.
SELECT TRUNC(AVG(SAL))
FROM EMP
WHERE DEPTNO = 30;
58. 직무가 SALESMAN인 사원들의 급여 + 커미션 평균을 구한다.
SELECT AVG(SAL), TRUNC(AVG(COMM))
FROM EMP
WHERE JOB = 'SALESMAN';
59. 사원들의 총 수를 가져온다.
SELECT COUNT(*) AS COUNT
FROM EMP;
60. 커미션을 받는 사원들의 총 수를 가져온다.
SELECT COUNT(COMM) AS COUNT
FROM EMP;
61. 사원들의 급여 최대, 최소값을 가져온다.
SELECT MAX(SAL), MIN(SAL)
FROM EMP;

SELECT *
FROM EMP;

( hint)그룹함수 이용  sum/avg/count/max/min  group by 이용;
62. 각 부서별 사원들의 급여 평균을 구한다.
SELECT DEPTNO, TRUNC(AVG(SAL))
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;
63. 각 직무별 사원들의 급여 총합을 구한다.
SELECT JOB, SUM(SAL) 
FROM EMP
GROUP BY JOB
ORDER BY SUM(SAL);
64. 1500 이상 급여를 받는 사원들의 부서별 급여 평균을 구한다.
SELECT DEPTNO, TRUNC(AVG(SAL))
FROM EMP
WHERE SAL >= 1500
GROUP BY DEPTNO
ORDER BY DEPTNO;


( hint) having  이용;
65. 부서별 평균 급여가 2000이상은 부서의 급여 평균을 가져온다.
SELECT DEPTNO, TRUNC(AVG(SAL)) 
FROM EMP 
GROUP BY DEPTNO
HAVING AVG(SAL) >= 2000
ORDER BY DEPTNO;
66. 부서별 최대 급여액이 3000이하인 부서의 급여 총합을 가져온다.
SELECT DEPTNO, MAX(SAL) 
FROM EMP 
GROUP BY DEPTNO
HAVING MAX(SAL) <= 3000
ORDER BY DEPTNO;
67. 부서별 최소 급여액이 1000 이하인 부서에서 직무가 CLERK인 사원들의 급여 총합을 구한다
SELECT DEPTNO, JOB, MIN(SAL),SUM(SAL)
FROM EMP 
GROUP BY DEPTNO,JOB
HAVING MIN(SAL) <= 1000 AND
       JOB = 'CLERK';
ORDER BY DEPTNO;
68. 각 부서의 급여 최소가 900이상 최대가 10000이하인 부서의 사원들 중1500이상의 급여를 받는 사원들의 평균 급여액을 가져온다.
SELECT DEPTNO, MIN(SAL), MAX(SAL), TRUNC(AVG(SAL))
FROM EMP 
WHERE SAL >= 1500
GROUP BY DEPTNO
HAVING MIN(SAL)>=900 AND
       MAX(SAL)<=10000 ;
       
ORDER BY DEPTNO;

(hint)  join 이용;
69. 사원의 사원번호, 이름, 근무부서 이름을 가져온다.
SELECT E.EMPNO, E.ENAME, D.DNAME 
FROM  EMP E , DEPT D 
WHERE E.DEPTNO = D.DEPTNO;
70. 사원의 사원번호, 이름, 근무지역을 가져온다.
SELECT E.EMPNO, E.ENAME, D.LOC 
FROM  EMP E , DEPT D 
WHERE E.DEPTNO = D.DEPTNO;
71. DALLAS에 근무하고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
SELECT E.EMPNO, E.ENAME, E.JOB, D.LOC 
FROM  EMP E , DEPT D 
WHERE E.DEPTNO = D.DEPTNO AND
        D.LOC = 'DALLAS';
72. SALES 부서에 근무하고 있는 사원들의 급여 평균을 가져온다.
SELECT TRUNC(AVG(E.SAL)), D.DNAME
FROM  EMP E , DEPT D 
WHERE E.DEPTNO = D.DEPTNO AND
        D.DNAME = 'SALES'
GROUP BY DNAME;         
SELECT *
FROM EMP;
73. 1982년에 입사한 사원들의 사원번호, 이름, 입사일, 근무부서이름을 가져온다.
SELECT E.EMPNO, E.ENAME, E.HIREDATE, D.DNAME
FROM  EMP E , DEPT D 
WHERE E.DEPTNO = D.DEPTNO AND
        TO_CHAR(E.HIREDATE,'YYYY')= 1982;
74. 각 사원들의 사원번호, 이름, 급여, 급여등급을 가져온다.
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
FROM EMP E, SALGRADE S;
75. SALES 부서에 근무하고 있는 사원의 사원번호, 이름, 급여등급을 가져온다.
SELECT E.EMPNO, E.ENAME, E.SAL, D.DNAME, S.GRADE 
FROM EMP E, SALGRADE S, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND
      D.DNAME = 'SALES'
ORDER BY S.GRADE;
76. 각 급여 등급별 급여의 총합과 평균, 사원의수, 최대급여, 최소급여를 가져온다.

SELECT S.GRADE,SUM(E.SAL),TRUNC(AVG(E.SAL)),COUNT(*),MAX(E.SAL),MIN(E.SAL)
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO
GROUP BY S.GRADE
ORDER BY S.GRADE;
77. 급여 등급이 4등급인 사원들의 사원번호, 이름, 급여, 근무부서이름, 근무지역을 가져온다.
SELECT S.GRADE, E.EMPNO, E.ENAME, E.SAL, D.DNAME, D.LOC
FROM EMP E, DEPT D, SALGRADE S
WHERE E.DEPTNO = D.DEPTNO AND
        S.GRADE = 4
ORDER BY S.GRADE;


(hint) self join 이용;
78. SMITH 사원의 사원번호, 이름, 직속상관 이름을 가져온다.
SELECT E1.EMPNO,E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_NO,
       E2.ENAME AS MGR_NAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO AND
        E1.ENAME = 'SMITH';       
79. FORD 사원 밑에서 일하는 사원들의 사원번호, 이름, 직무를 가져온다.
SELECT E1.EMPNO,E1.ENAME, E1.MGR,
       E2.EMPNO AS MGR_NO,
       E2.ENAME AS MGR_NAME
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO AND
        E2.ENAME = 'FORD';
       
80. SMITH 사원의 직속상관과 동일한 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
SELECT E1.EMPNO,E1.ENAME, E1.MGR,E1.JOB,
       E2.EMPNO AS MGR_NO,
       E2.ENAME AS MGR_NAME,
       E3.EMPNO AS E3_NO,
       E3.ENAME AS E3_NAME,
       E3.JOB AS E3_JOB
FROM EMP E1, EMP E2, EMP E3
WHERE E1.MGR = E2.EMPNO AND
      E2.JOB = E3.JOB AND
      E1.ENAME = 'SMITH';


        


(hint) outer join 이용;
81. 각 사원의 이름, 사원번호, 직장상사 이름을 가져온다. 단 직속상관이 없는 사원도 가져온다.
SELECT E1.EMPNO, E1.ENAME,
       E2.EMPNO AS MGR_NO,
       E2.ENAME AS MGR_NAME
FROM EMP E1,EMP E2
WHERE E1.MGR = E2.EMPNO(+) 
ORDER BY E1.EMPNO;   
82. 모든 부서의 소속 사원의 근무부서명, 사원번호, 사원이름, 급여를 가져온다
SELECT D.DNAME, E.EMPNO, E.ENAME, E.SAL
FROM EMP E,DEPT D
WHERE E.DEPTNO(+) = D.DEPTNO ;
       

(hint) subquery;
83. SMITH사원이 근무하고 있는 부서의 이름을 가져온다.
SELECT DNAME 
FROM DEPT
WHERE DEPTNO = (
            SELECT DEPTNO
            FROM EMP
            WHERE ENAME = 'SMITH'
            );
84. SMITH와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 급여액, 부서이름을 가져온다.
SELECT EMPNO, ENMAME, SAL, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND
      E.DEPTNO = (
            SELECT DEPTNO
            FROM EMP
            WHERE ENAME = 'SMITH'
            );
85. MARTIN과 같은 직무를 가지고 있는 사원들의 사원번호, 이름, 직무를 가져온다.
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE JOB = (SELECT JOB
             FROM EMP
             WHERE ENAME = 'MARTIN');
86. ALLEN과 같은 직속상관을 가진 사원들의 사원번호, 이름, 직속상관이름을 가져온다.
SELECT E1.EMPNO, E1.ENAME, E2.ENAME AS 상관
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO AND 
        E1.MGR = (SELECT MGR
                  FROM EMP
                  WHERE ENAME = 'ALLEN');
87. WARD와 같은 부서에 근무하고 있는 사원들의 사원번호, 이름, 부서번호를 가져온다.
SELECT EMPNO, ENAME, DEPTNO
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM EMP
                WHERE ENAME = 'WARD');
88. SALESMAN의 평균 급여보다 많이 받는 사원들의 사원번호, 이름, 급여를 가져온다.
SELECT EMPNO, ENAME, SAL 
FROM EMP
WHERE SAL > (SELECT TRUNC(AVG(SAL))
             FROM EMP
             WHERE JOB = 'SALESMAN');
89. DALLAS 지역에 근무하는 사원들의 평균 급여를 가져온다.
SELECT AVG(SAL)
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM DEPT
                WHERE LOC = 'DALLAS');
90. SALES 부서에 근무하는 사원들의 사원번호, 이름, 근무지역을 가져온다
SELECT E.EMPNO, E.ENAME, D.LOC
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO AND 
        E.DEPTNO = (SELECT DEPTNO
                    FROM DEPT
                    WHERE DNAME = 'SALES');

91. CHICAGO 지역에 근무하는 사원들 중 BLAKE이 직속상관인 사원들의 사원번호, 이름, 직무를 가져온다.	
SELECT EMPNO, ENAME, JOB
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
                FROM DEPT
                WHERE LOC = 'CHICAGO') AND
        MGR = (SELECT EMPNO
                FROM EMP
                WHERE ENAME = 'BLAKE');


(hint) 결과가 하나 이상인 subquery는 in,some,any , all  을 이용한다.;
92. 3000 이상의 급여를 받는 사원들과 같은 부서에 근무하고 있는 사원의 사원번호, 이름, 급여를 가져온다
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
                 FROM EMP
                 WHERE SAL >= 3000);
93. 직무가 CLERK인 사원과 동일한 부서에 근무하고 있는 사원들의 사원번호, 이름, 입사일 가져온다.
SELECT EMPNO, ENMAE, HIREDATE
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
                FROM EMP
                WHERE JOB = 'CLERK');


