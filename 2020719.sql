-- 오늘이 속한 달의 마지막 날짜와 다가오는 일요일의 날짜를 출력하여라
-- TO_CHAR 함수는 날짜나 숫자를 문자로 변환하기 위해 사용--

SELECT sysdate,Last_DAY(sysdate),Next_DAY(sysdate,'일')
FROM dual;


-- to char함수  -- 문자형으로 현변환시 
SELECT TO_CHAR(sysdate,'YY/MM/DD HH24:MI:SS') YYMMDD,
    TO_CHAR(sysdate,'YY/MM/DD HH24') YYMMDDHH,
    TO_CHAR(sysdate,'MM') MM, 
    TO_CHAR(sysdate,'YY') YY,
    TO_CHAR(sysdate,'MM') DD 
FROM dual;



SELECT TO_CHAR(hiredate,'YY/MM/DD HH24:MI/SS') hiredate,
    TO_CHAR(ROUND(hiredate,'dd'),'YY/MM/DD') round_dd,
    TO_CHAR(ROUND(hiredate,'mm'),'YY/MM/DD') round_mm,
    TO_CHAR(ROUND(hiredate,'yy'),'YY/MM/DD') round_yy
FROM professor;


-- 학생 테이블에서 전인하 학생의 학번과 생년월일 중에서 년월만 출력하여라
SELECT STUDNO, TO_CHAR(BIRTHDATE,'yy/mm') birthdate 
FROM STUDENT
WHERE name = '전인하';


-- 1.숫자를 문자 형식으로 변환
-- 2.보직수당을 받는 교수들의 이름, 급여, 보직수당, 
-- 3.그리고 급여와 보직수당을 더한 값에 12를 곱한 결과를 anual_sal(연봉)으로 출력
-- 4. 단 출력형식은 '9,999'


SELECT name, sal,comm,TO_CHAR((sal+comm)*12,'9,999') anual_sal 
FROM professor
WHERE comm IS NOT NULL;

select TO_NUMBER('123')
FROM dual;


--  student Table에서 주민등록번호에서 생년월일을 추출하여 ‘YY/MM/DD’ 형태로 출력하여라
SELECT TO_CHAR(TO_DATE(SUBSTR(IDNUM,1,6),'YYMMDD'),'YY/MM/DD') AA FROM STUDENT;

SELECT TO_CHAR(SUBSTR(IDNUM,1,6),'YY/MM/DD') AA FROM STUDENT;

-- NVL 함수는 NULL을 0 또는 다른 값으로 변환하기 위한 함수
-- 101번 학과 교수의 이름, 직급, 급여, 보직수당, 급여와 보직수당의 합계를 출력하여라. 
-- 단, 보직수당이 NULL인 경우에는 보직수당을 0으로 계산한다

SELECT name,POSITION ,sal,nvl(comm,0),(nvl(comm,0)+sal) a FROM professor
WHERE DEPTNO = 101;


-- NVL2 함수
-- NVL2 함수는 첫 번째 인수 값이 NULL이 아니면 두 번째 인수 값을 출력하고,
--                  첫 번째 인수 값이 NULL이면 세 번째 인수 값을 출력하는 함수
-- 102번 학과 교수중에서 보직수당을 받는 사람은 급여와 보직수당을 더한 값을 급여 총액으로 
--출력하여라. 단, 보직수당을 받지 않는 교수는 급여만 급여 총액으로 출력하여
--                          

-- comm이 null이면 sal 아니면 sal+comm
SELECT name,POSITION ,sal,nvl(comm,0),nvl2(comm,sal+comm,sal) total FROM professor
WHERE DEPTNO = 102;


-- NULLIF 함수
-- NULLIF 함수는 두 개의 표현식을 비교하여 값이 동일하면 NULL을 반환하고,
-- 일치하지 않으면 첫 번째 표현식의 값을 반환
-- 믄) 교수 테이블에서 이름의 바이트 수와 사용자 아이디의 바이트 수를 비교해서
--      같으면 NULL을 반환하고 
--      같지 않으면 이름의 바이트 수를 반환


SELECT name,userid ,LENGTHB(name),LENGTHB(userid),
    NULLIF(LENGTHB(name),LENGTHB(userid)) nullif_result
FROM professor

