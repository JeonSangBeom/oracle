-- 주석
--오라클에서 기본으로 제공되는 함수들(문자관련)
SELECT * FROM EMP
where ENAME = UPPER('smith'); 
--> 대문자로 써야만 뽑을 수 있다


--컬럼명 변경
SELECT ENAME AS 이름 FROM EMP;

SELECT * FROM EMP;

SELECT * FROM EMP
WHERE ENAME LIKE '%S%';

SELECT * FROM EMP
WHERE LOWER(ENAME) LIKE '%S%'; 
--> 소문자로 바꿀때 사용
SELECT LOWER(ENAME) FROM EMP;

SELECT INITCAP(ENAME) FROM EMP; 
-->첫글자만 대문자로 변경시 사용

SELECT ENAME, LENGTH(ENAME) AS NAME_TOTAL FROM EMP; 
-->이름을 뽑고 LENGTH(ENAME) -길이 구해 주는 것 

SELECT ENAME, LENGTH(ENAME) AS TOTAL FROM EMP
WHERE LENGTH(ENAME) >=5; 
--> 5자 이상인 사람만 뽑아낼때

--데이터 출력이 궁금할 시 (scott 테이블 안 컬럼이 없는 경우)
--SYS로 만들어둔 DUMY테이블을 이용하여 간단한 출력 같은 것을 테스트 할 수 있다
SELECT LENGTH('한글'),LENGTHB('한글') FROM DUAL;
-->LENGTHB('한글') - BYTE값을 찾을수 있게 제공해 준다

SELECT JOB, SUBSTR(JOB,1,2), SUBSTR(JOB,3,2), SUBSTR(JOB,5) FROM EMP;
--> SUBSTR(JOB,1,2) JOB에서 출력할 단어  처음 1 위치가 시작 2가 끝
--> 게시판 같은 곳에 글을 일부만 뽑아 올때

SELECT ENAME, SUBSTR(ENAME,3) AS 세번째부터 FROM EMP;
-->이름 중에 3번째부터 마지막까지 출력

--INSTR('문자','찾을 문자')
SELECT INSTR('HELLO ORACLE','L') FROM DUAL;
-->L의 위치가 3번째에 있다는 것을 알 수 있다(컬럼이 없으니 dual을 사용)

--INSTR('문자','찾을 문자',순서지정)
SELECT INSTR('HELLO ORACLE','L',5) FROM DUAL;
-->5번째 부터 시작해서 찾아라
--INSTR('문자','찾을 문자',순서지정,몇번째 나오는 문자인지)
SELECT INSTR('HELLO ORACLE','L',2,2) FROM DUAL;
-->2번째 부터 2번째 L을 찾아라

--검색 시 주로 사용
SELECT * FROM EMP
WHERE ENAME LIKE '%S%';
-->S들어가는 것을 전부 찾겠다

SELECT * FROM EMP
WHERE INSTR(ENAME,'S')>0;
-->정수이기 떄문에 S보다 크면 뭐라도 뽑겠다
-->INSTR(ENAME,'S')의 리턴타입 자체가 정수이다/위 이름 찾는 것

--REPLACE('문자열','찾는 문자','바꿀 문자') 바꿀문자에 입력 안할시 다 붙어서 나온다
--회원가입 받을때 주로 사용한다
SELECT '010-2582-2242' AS REPLACE_BEFORE,
    REPLACE('010-2582-2242','-',' ') AS REPLACE01,
    REPLACE('010-2582-2242','-') AS REPLACE02
FROM DUAL;
--> FILTERRING 사용(아이디 있나 없나 공백 많은 것 있나 없나 확인)

--LPAD / RPAD 공백메꾸기(보안)
SELECT RPAD('901212-',14,'*') AS JUMIN,
         RPAD('010-6528-',13,'*') AS PHONE FROM DUAL;
-->RPAD 오른쪽에서 부터 메꾸기 ( '-'이 들어가서 14자(총 갯수),*(나머지 메꿀부분))
SELECT 'ORACLE', LPAD('ORACLE',10,'#') AS LPAD01 FROM DUAL;

-- CONCAT () 문자열 연결하기 ||
SELECT CONCAT(EMPNO,ENAME) FROM EMP;
-->두개의 컬럼을 연결하여 사용할때 사용
SELECT EMPNO || ENAME FROM EMP;
-->타이프를 이용하여도 사용 가능
SELECT CONCAT(EMPNO, CONCAT(' : ',ENAME)) AS NOANDNAME FROM EMP;
-->CONCAT안에 또 CONCAT 가능

--TRIM(자르기 공백제거) - 리플레이와 비슷
SELECT '[' || '   --ORACLE---   ' || ']' AS NOTTRIM,
        '[' || TRIM( '   --ORACLE---   ') || ']' AS TRIM01
FROM DUAL;
SELECT '[' || TRIM('-' FROM '--ORACLE---') || ']' AS TRIM02 FROM DUAL;
-->'-'를 지울 수 있다
SELECT '[' || TRIM(LEADING'-' FROM '--ORACLE---') || ']' AS TRIM02 FROM DUAL;
-->'-'앞에만 제거
SELECT '[' || TRIM(TRAILING'-' FROM '--ORACLE---') || ']' AS TRIM02 FROM DUAL;
-->'-'앞에만 제거
SELECT '[' || TRIM(BOTH'-' FROM '--ORACLE---') || ']' AS TRIM02 FROM DUAL;
-->BOTH 굳이 사용하지 않아도 된다 처음것과 같기 때문


--LTRIM / RTRIM (글자제거)
SELECT LTRIM('ORACLE STUDY OOPS','ORCLE') AS LTRIM FROM DUAL;
-->왼쪽부터 지워준다(철자가 중간에 틀리면 맞는 것 까지만 지워준다)
SELECT RTRIM('ORACLE STUDY OOPS','OOPS') AS RTRIM FROM DUAL;
-->오른쪽 부터
SELECT TRIM('  ORACLE STUDY OOPS   ') AS TRIM FROM DUAL;
-->공백제거


---숫자
SELECT ROUND(1234.5678) AS ROUND01,
        ROUND(1234.5678,0) AS ROUND02,
        ROUND(1234.5678,1) AS ROUND03,
        -->소숫점 첫째를 남긴다
        ROUND(1234.5678,2) AS ROUND04,
        ROUND(1255.5678,-3) AS ROUND05
        FROM DUAL;
        -->소숫점 자리를 남기는 것(하나씩 반올림5이상만)
        -->마이너스는 쓸일이 거의 없다(앞에서부터 시작)
        
SELECT TRUNC(1234.5678) AS TRUNC01,
       TRUNC(1234.5678,1) AS TRUNC02,
       TRUNC(1234.5678,2) AS TRUNC03,
       TRUNC(1234.5678,-1) AS TRUNC04,
       TRUNC(1234.5678,-2) AS TRUNC05
FROM DUAL;
-->TRUNC 반올림 하지 않고 나머지를 버린다

SELECT CEIL(1234.5678) AS CEIL01 ,
    FLOOR(1234.5678) AS FLOOR01 ,
    CEIL(-3.14) AS CEIL02 ,
    FLOOR(-3.1) AS FLOOR02 
FROM DUAL;
-->CEIL 무조건 올림 / FLOOR 무조건 내림(버림)

SELECT MOD(15,4) AS MOD01
FROM DUAL;
-->나눗셈 15를 4로 나눈 나머지 답 : 3

---DATE----
SELECT SYSDATE AS NOW, -->오늘 날짜
        SYSDATE - 1 AS YESTERDAY, -->전날을 알고 싶을때
        SYSDATE + 1 AS TOMORROW --> 내일을 알고 싶을떄
FROM DUAL;

SELECT SYSDATE AS NOW,
        ADD_MONTHS(SYSDATE,3) --> (SYSDATE,3)- 오늘 날짜에서 3개월 뒤
FROM DUAL;

SELECT * FROM EMP;
SELECT ADD_MONTHS(HIREDATE,120) AS ANNYVERSARY FROM EMP;
-->ADD_MONTHS(HIREDATE,120)(입사일,120(10주년))

--40년 안된 사람 출력하기.
SELECT ENAME, EMPNO, HIREDATE, SYSDATE FROM EMP;

SELECT ENAME, EMPNO, HIREDATE, SYSDATE
FROM EMP
WHERE ADD_MONTHS(HIREDATE,40*12) > SYSDATE;

--MONTHS_BETWEEN(날짜,날짜)
SELECT EMPNO,ENAME,HIREDATE,SYSDATE,
    TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE) /12) AS 근속연수 
FROM EMP;    
-->MONTHS_BETWEEN(SYSDATE,HIREDATE) 현재 날에서 - 일한날 빼준 것 /12(연으로 계산)

SELECT SYSDATE, 
       NEXT_DAY(SYSDATE,'월요일'), -->지금 시간 이후로 월요일인 날을 찾아준다
       LAST_DAY(SYSDATE) --> 마지막 날 (그 달에서)
FROM DUAL;

-----  형변환(문자를 숫자로 / 숫자를 문자로) -------
DESC EMP;

SELECT EMPNO,ENAME, EMPNO+'100'   -- 암묵적 형변환
FROM EMP;
--> EMPNO+'100' 숫자인데 문자로 들어가진다

SELECT '10'+EMPNO 
FROM EMP;
-->SELECT 'ABCD'+EMPNO - 이러면 오류 발생
-- 문자끼리 할 경우 || 타이프 사용

--TO_CHAR(), TO_NUMBER(), TO_DATE() -- 바뀌는 것들

SELECT TO_CHAR(SYSDATE,'YYYY/MM/DD HH:MI:SS') AS TODAY FROM DUAL;
-->출력시 문자 변경 방법

--TO_CHAR-날짜를 문자로 바꾸는 것
SELECT SYSDATE ,
       TO_CHAR(SYSDATE,'MM') AS MM,
       TO_CHAR(SYSDATE,'MON') AS MON,  -- JAN(한국식이라 값이 다른 것)
       TO_CHAR(SYSDATE,'MONTH') AS MONTH, -- JANUARY(우리나라라 상관 없다)
       TO_CHAR(SYSDATE,'DD') AS DD, -- 
       TO_CHAR(SYSDATE,'DY') AS DY, -- 
       TO_CHAR(SYSDATE,'DAY') AS DAY, -- 
       TO_CHAR(SYSDATE,'YYYY/MM/DD DAY HH24:MI:SS') AS DAY -- 
FROM DUAL;

--우리나라는 의미가 없고 그래서 언어를 변경할 수 있다
SELECT SYSDATE ,
       TO_CHAR(SYSDATE,'MM') AS MM ,
       TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE = KOREAN') AS MM_KOR ,
       TO_CHAR(SYSDATE,'MON','NLS_DATE_LANGUAGE = ENGLISH') AS MM_ENG ,
       INITCAP(TO_CHAR(SYSDATE,'MONTH','NLS_DATE_LANGUAGE = ENGLISH')) AS MM_ENG 
FROM DUAL;

SELECT SYSDATE ,
       TO_CHAR(SYSDATE,'MM') AS MM,
       TO_CHAR(SYSDATE,'DD') AS DD,
       TO_CHAR(SYSDATE,'DY') AS DY,
       TO_CHAR(SYSDATE,'DY', 'NLS_DATE_LANGUAGE = ENGLISH') AS ENG_DY,
       TO_CHAR(SYSDATE,'DAY', 'NLS_DATE_LANGUAGE = ENGLISH') AS ENG_DAY,
       TO_CHAR(SYSDATE,'DAY', 'NLS_DATE_LANGUAGE = JAPANESE') AS JPN_DAY
FROM DUAL;

-- JSP(프론트 에서도 가능)
--숫자를 바꿔주는 것
SELECT SAL ,
       TO_CHAR(SAL,'$9999,999') AS DOLLAR,
       TO_CHAR(SAL,'L9999,999') AS WON,
       TO_CHAR(SAL,'999,999.00') AS SAL02
FROM EMP;
--> 999,999.00로 원하는대로 모양 변경 가능

SELECT TO_NUMBER('1300') - TO_NUMBER('1200')
FROM DUAL;
-->TO_NUMBER 숫자끼리 값 계산 가능

SELECT TO_DATE('2001/06/01','YYYY/MM/DD') FROM DUAL;
--TO_DATE 문자를 날짜로 바꿔 주는 것
--('2001/06/01','YYYY/MM/DD')'2001/06/01'를 'YYYY/MM/DD'이것으로
--연도는 무조건 YYYY4개를 써야 한다
SELECT * FROM EMP
WHERE HIREDATE > TO_DATE('1981/06/01','YYYY/MM/DD');

--IS NULL - NVL(NULL처리를 해주는 함수)

SELECT EMPNO, ENAME,SAL, COMM, SAL+COMM ,
        -->SAL+COMM NULL이 하나라도 들어가 있으면 값이 제대로 안뜬다
       NVL(COMM,0),
        -->NULL이 나올경우 0처리를 해주는 방법
       SAL*12 + NVL(COMM,0) AS ANNSAL
        -->연봉 구하는 식
FROM EMP;

SELECT EMPNO, ENAME,
       NVL2(COMM,'O','X') IS_COMM
       -->COMM이 있으면 O 없으면 X로 표시
FROM EMP;

SELECT EMPNO, ENAME,
       NVL2(COMM,SAL*12+COMM,SAL*12) AS ANNSAL
       -->SAL*12+COMM(있으면),SAL*12(없으면)
FROM EMP;


--DECODE IF()와 비슷 ==  표준 SQL이 아니다(오라클에서만 사용 가능)
SELECT EMPNO,ENAME,JOB,SAL,
        DECODE(JOB,
               'MANAGER',SAL*1.1,
               'SALESMAN',SAL*1.05,
               'ANALYST', SAL,
               SAL*1.03 --> ELSE(나머지)
        ) AS UP_SAL -->월급 인상 할떄 사용
FROM EMP;

--직급을 한글로 바꿔보기 컬럼명 JOB_KR
SELECT EMPNO,ENAME,JOB,
        DECODE(JOB,
               'MANAGER', '관리자',
               'PRESIDENT', '사장',
               'ANALYST', '분석가',
               'CLERK', '사원',
               '영업사원' --> ELSE(나머지)
        ) AS JOB_KR
FROM EMP;

WITH TEMP AS ( -->WITH구문은 임시 테이블을 만들때 사용 된다
-->TEMP 테이블 이름이 된다
    SELECT 'MALE' GENDER FROM DUAL UNION ALL
    SELECT 'FEMALE' GENDER FROM DUAL UNION ALL
    SELECT 'BISEXUAL' GENDER FROM DUAL 
)
SELECT GENDER, 
       DECODE(GENDER,
              'MALE','남자',
              'FEMALE','여자',
              '기타'
              )AS GENDER_KR
       FROM TEMP;
--SELECT * FROM TEMP;    
--> 테이블 이름이 된다(WITH 뒤에쓴 TEMP가) 
--> 그 뒤  SELECT * FROM TEMP; 이렇게 사용하면 임의로 테이블을 만들어 사용할 수 있게 된다


--CASE 로 써보기 DECODE와의 차이(오라클이 아닌 SQL이 아닌 데이터베이스에서 사용 가능)
SELECT EMPNO,ENAME,JOB,SAL,
             CASE JOB
             WHEN 'MANAGER'  THEN SAL*1.1
             WHEN 'SALESMAN' THEN SAL*1.05
             WHEN 'ANALYST'  THEN SAL
             ELSE SAL*1.03 --> ELSE(나머지)
             END   AS UP_SAL -->월급 인상 할떄 사용
FROM EMP;
SELECT EMPNO,ENAME,JOB,SAL,
             CASE 
             WHEN JOB = 'MANAGER'  THEN SAL*1.1
             WHEN JOB = 'SALESMAN' THEN SAL*1.05
             WHEN JOB = 'ANALYST'  THEN SAL
             ELSE SAL*1.03 --> ELSE(나머지)
             END   AS UP_SAL -->월급 인상 할떄 사용
FROM EMP;


--COMM이 있으면 해당사항 없음 / COMM 0이면 수당 없음  / COMM이 있으면 수당 : 300 출력
SELECT EMPNO,ENAME,COMM, 
             CASE 
             WHEN COMM IS NULL  THEN '해당사항 없음' -->COMM 비교는 IS를 써야 한다
             WHEN COMM = 0      THEN '수당없음'
             WHEN COMM > 0      THEN '수당 : ' || COMM
             END   AS COMM_KR
FROM EMP;

--SAL 2900보다 크면 DIAMOND 2700보다 크면 GOLD 2000보다 크면 SILVER 나머지 BRONZE
SELECT ENAME,SAL, 
         CASE 
             WHEN SAL > 2900  THEN 'DIAMOND'
             WHEN SAL > 2700  THEN 'GOLD'
             WHEN SAL > 2000  THEN 'SILVER'
             ELSE 'BRONZE'
             END   AS GRADE
FROM EMP
ORDER BY SAL DESC; --> DESC 높은 값부터 정렬


--몇분기 입사했는지 알아보기
SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE,'Q') FROM EMP; 
-->'Q'를 사용하면 분기로 나누어 준다
SELECT ENAME, TO_CHAR(HIREDATE, 'YYYY-MM') AS ENRTY_DATE ,
       CASE
           WHEN TO_CHAR(HIREDATE,'Q') = '1' THEN '1분기 입사'
           WHEN TO_CHAR(HIREDATE,'Q') = '2' THEN '2분기 입사'
           WHEN TO_CHAR(HIREDATE,'Q') = '3' THEN '3분기 입사'
           ELSE '4분기 입사'
           END AS QUATER
FROM EMP;       

--SELECT ENAME, HIREDATE, TO_CHAR(HIREDATE, 'Q') || '분기 입사' AS QUATER FROM EMP;

----------연습문제

SELECT EMPNO,
       RPAD(SUBSTR(EMPNO,1,2),4,'*') AS MASKING_EMPNO,
       -->SUBSTR 여기서 부터 여기까지 뽑아내고 RPAD 4개의 숫자만큼 오른쪽에서 부터 *(앞 제외)
       ENAME,
       RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*') AS MASKING_ENAME
       -->LENGTH(ENAME)글자수 만큼 *처리
FROM EMP    
WHERE LENGTH(ENAME) >=5 AND LENGTH(ENAME) <6;

--보통 아래로 더 많이 사용 할 것
SELECT EMPNO,
       RPAD(SUBSTR(EMPNO,1,2),4,'*') AS MASKING_EMPNO,
       ENAME,
       RPAD(SUBSTR(ENAME,1,1),LENGTH(ENAME),'*') AS MASKING_ENAME
FROM EMP;    


---2번 원화로 바꾸기
SELECT EMPNO, SAL,
        TRUNC(SAL/21.5,2) AS DAY_PAY,
        TRUNC(SAL/21.5/8,1) AS TIME_PAY
FROM EMP;

---2번 문제를 하루 일당과 시급을 원화 또는 달러로 바꾸기
SELECT EMPNO, SAL,
        TO_CHAR(TRUNC(SAL/21.5,2),'L999,99.00') AS DAY_PAY,
        -->(TRUNC(SAL/21.5,2) 소숫점 세번째에서 버리기
        -->21.5 근무 일수
        -->TO_CHAR(TRUNC(SAL/21.5,2),'L999,99.00') -원화로 바꾸기
        TO_CHAR(TRUNC(SAL/21.5/8,1),'$999,999.0') AS TIME_PAY
FROM EMP;

-- 3번
SELECT EMPNO,ENAME,
       TO_CHAR(HIREDATE,'YYYY/MM/DD') AS HIREDATE,
       -->HIREDATE를(기존은 시간 초도 떠서 길었음) 'YYYY/MM/DD'로 변경
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월'),'YYYY-MM-DD')  AS R_JOB,
       -->ADD_MONTHS - 입사한 날에서 3개월 뒤
       -->NEXT_DAY - 3개월 뒤에서 첫 월요일
       -->TO_CHAR 문자로 변경
       NVL(TO_CHAR(COMM),'N/A') AS COMM 
       -->NVL은 숫자만 쓸수 있다 그래서 TO_CHAR(COMM) 코밋을 문자로 바꿔주고
       -->NULL일 경우 N/A로 표시
FROM EMP;

--3번을 CASE 문으로 바꿔보기...  COMM 있는 그대로 출력, 0 0으로 출력
SELECT EMPNO,ENAME,
       TO_CHAR(HIREDATE,'YYYY/MM/DD') AS HIREDATE,
       TO_CHAR(NEXT_DAY(ADD_MONTHS(HIREDATE,3),'월'),'YYYY-MM-DD')  AS R_JOB,
       CASE
            WHEN COMM IS NULL THEN 'N/A'
            --ELSE TO_CHAR(COMM) / 위에'N/A'인 문자로 사용하였기 때문에 
            --ELSE ''||COMM
            ELSE CONCAT('',COMM) -- 위 타이프랑 같은 용도('' : 문자와 코밋을 함께 쓰기 위해)
       END AS COMM 
FROM EMP;

-- 4번 
SELECT EMPNO,ENAME,MGR,
       CASE
            WHEN MGR IS NULL THEN 0000 --> MGR이 존재하지 않을때 0000
            WHEN SUBSTR(MGR,1,2) = 75 THEN 5555
            WHEN SUBSTR(MGR,1,2) = 76 THEN 6666
            WHEN SUBSTR(MGR,1,2) = 77 THEN 7777
            WHEN SUBSTR(MGR,1,2) = 78 THEN 8888
            ELSE MGR
       END AS CHG_MGR
FROM EMP;




