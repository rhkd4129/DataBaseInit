select ename, UPPER(ename),LOWER(ename), INITCAP(ename) 
from EMP;

select ename,SAL,DEPTNO
FROM EMP
WHERE LOWER(ename)= 'scott'; --대문자인지 소문자인지 입력될지 모르지만 상관하지않겟다 
--WHERE UPPER(ename)= 'SCOTT';
-- 학생 테이블에서 학번이 ‘20101’인 학생의 사용자 아이디를 
-- 소문자와 대문자로 변환하여 출력

SELECT UPPER(USERID), LOWER(USERID) 
FROM STUDENT 
WHERE studno = 20101
;


--UTF-8 3자  
--예시 인사 1팀 --> 한글 3(3bytes씩) +1(1bytes)
SELECT dname, LENGTH(DNAME),LENGTHB(DNAME)
FROM DEPT;

--한글 문자열 길이  Test   --> Insert 안 된 표본 utf-8
INSERT INTO DEPT  VALUES(59,'경영지원팀','충정로');

--*
SELECT concat(concat(name,'의 직책은'),position) name
from professor;


--- 학생 테이블에서 1학년 학생의 주민등록 번호에서 생년월일과 태어난 달을 추출하여 
---  이름, 주민번호, 생년월일, 태어난 달을 출력하여라


SELECT name,idnum , SUBSTR(idnum,1,6) birth_date, SUBSTR(idNum,3,2) birth_mon
from student
WHERE grade = 1;

-- INSTR 함수
-- 문자열중에서 사용자가 지정한 특정 문자가 포함된 위치를 반환하는 함수
-- 학과  테이블의 부서 이름 칼럼에서 ‘과’ 글자의 위치를 출력하

SELECT dname,INSTR(dname,'과')
from department;

--LPAD, RPAD 함수
--LPAD와 RPAD 함수는 문자열이 일정한 크기가 되도록 왼쪽 또는 오른쪽에 지정한 문자를 삽입하는 함수
-- 교수테이블에서 직급 칼럼의 왼쪽에 ‘*’ 문자를 삽입하여 10바이트로 출력하고 
-- 교수 아이디 칼럼은 오른쪽에 ‘+’문자를 삽입하여 12바이트로 출력

SELECT position, LPAD(position,10,'*') lapd_position,
        userid,RPAD(userid,12,'+')  rapd_position
FROM professor;


--LTRIM, RTRIM 함수
--LTRIM와 RTRIM 함수는 문자열에서 특정 문자를 삭제하기 위해 사용
--함수의 인수에서 삭제할 문자를 지정하지 않으면 문자열의 앞뒤 부분에 있는 공백 문자를 삭제

SELECT LTRIM('   abcdefg  ',' ')FROM dual;
SELECT RTRIM('   abcdefg  ',' ')FROM dual;
SELECT LTRIM('***abcdefg  ','*')FROM dual;


--  학과 테이블에서 부서 이름의 마지막 글자인 ‘과’를 삭제하여 출력하여라\

SELECT RTRIM( DNAME,'과') 
from department;
---------------------------------------------------------
-------- 숫자 함수 *** ------------------------------------
---------------------------------------------------------
--1) ROUND 함수
--   지정한 자리 이하에서 반올림한 결과 값을 반환하는 함수
-- 교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여 소수점 첫째 자리와 
-- 셋째 자리에서 반올림 한 값과 소숫점 왼쪽 첫째 자리에서 반올림한 값을 출력하여라
select name,sal,sal/22,round(sal/22),round(sal/22,2), round(sal/22,-1)
from professor
where deptno = 101;

-- 2)TRUNC 함수
-- 지정한 소수점 자리수 이하를 절삭한 결과 값을 반환하는 함수

-- 교수 테이블에서 101학과 교수의 일급을 계산(월 근무일은 22일)하여
-- 소수점 첫째 자리와 셋째 자리에서 절삭 한 값과 
-- 소숫점 왼쪽 첫째 자리에서 절삭한 값을 출력
select trunc(sal/22,-1), trunc(sal/22,2)
from professor
where deptno = 101;

-- 3) MOD 함수 
--     MOD 함수는 나누기 연산후에 나머지를 출력하는 함수 
-- 교수 테이블에서 101번 학과 교수의 급여를 보직수당으로 나눈 나머지를 계산하여 출력하여

SELECT name,sal,comm ,  MOD(sal,comm)
from professor
where deptno = 101;
-- 4) CEIL, FLOOR 함수
-- CEIL 함수는 지정한 숫자보다 크거나 같은 정수 중에서 최소 값을 출력하는 함수
-- FLOOR함수는 지정한 숫자보다 작거나 같은 정수 중에서 최대 값을 출력하는 함수
-- 19.7보다 큰 정수 중에서 가장 작은 정수와 12.345보다 작은 정수 중에서 가장 큰 정수를 출력하여라

SELECT CEIL(19.7),FLOOR(12.345)
FROM dual;

---------------------------------------------------------
-------- 날자 함수 *** ------------------------------------
---------------------------------------------------------
-- 1) 날짜 + 숫자 = 날짜 (날짜에 일수를 가산)
-- 3) 날짜 - 날짜=  일수 (날짜에 날짜를 감산)
-- 교수 번호가 9908인 교수의 입사일을 기준으로 입사 30일 후와 60일 후의 날짜를 출력

select name,hiredate,hiredate+30,hiredate+60 from professor
where PROFNO =9908;
-- 4) SYSDATE 함수
--     SYSDATE 함수는 시스템에 저장된 현재 날짜를 반환하는 함수로서, 초 단위까지 반환

SELECT sysdate
from dual;
--     입사한지 120개월 미만인 교수의 교수번호, 입사일, 입사일로 부터 현재일까지의 개월 수,
--     입사일에서 6개월 후의 날짜를 출력하여라

select name,PROFNO,HIREDATE,
        MONTHS_BETWEEN(SYSDATE,HIREDATE) workin_day,
        ADD_MONTHS(hiredate,6) HIRE_6after
from professor
where MONTHS_BETWEEN(SYSDATE,HIREDATE)<120


-- 학생 테이블에서 전인하 학생의 학번과 생년월일 중에서 년월만 출력하여라

select 
