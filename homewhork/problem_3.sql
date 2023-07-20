--SELECT NAME FROM EMP
---------------         Home Work           --------------------
--1. emp Table 의 이름을 대문자, 소문자, 첫글자만 대문자로 출력
SELECT ENAME, UPPER(ENAME), LOWER(ENAME),INITCAP(ENAME)
FROM EMP;

--2. emp Table 의  이름, 업무, 업무를 2-5사이 문자 출력
SELECT ename,SUBSTR(job,2,5) FROM EMP;

--3. emp Table 의 이름, 이름을 10자리로 하고 왼쪽에 #으로 채우기
SELECT ename, LPAD(ename,10,'#')FROM EMP ;
--4. emp Table 의  이름, 업무, 업무가 MANAGER면 관리자로 출력 replace
SELECT ENAME,REPLACE(JOB,'MANAGER','관리자') FROM EMP;



--5. emp Table 의  이름, 급여/7을 각각 정수, 소숫점 1자리. 10단위로   반올림하여 출력
SELECT ename ,ROUND((sal/7)) , ROUND((sal/7),1),  ROUND((sal/7),-1)
FROM EMP;
--6.  emp Table 의  이름, 급여/7을 각각 절사하여 출력
SELECT ENAME,TRUNC(SAL/7,1) FROM EMP;

--7. emp Table 의  이름, 급여/7한 결과를 반올림,절사,ceil,floor


--8. emp Table 의  이름, 급여, 급여/7한 나머지
SELECT ENAME,SAL,MOD(SAL,7)FROM EMP;

--9. emp Table 의 이름, 급여, 입사일, 입사기간(각각 날자,월)출력,  소숫점 이하는 반올림
--SELECT ename,sal,hiredate, TO_DATE(MONTHS_BETWEEN(SYSDATE,hiredate,'MM/YY/DD'))
--FROM emp;


--10.emp Table 의  job 이 'CLERK' 일때 10% ,'ANALYSY' 일때 20% 
--                                 'MANAGER' 일때 30% ,'PRESIDENT' 일때 40%
--                                 'SALESMAN' 일때 50% 
--                                 그외일때 60% 인상 하여 
--   empno, ename, job, sal, 및 각 급여인상를 출력하세요(CASE/Decode문 사용);
select empno,ename,job,sal,
        CASE When JOB='CLERK'   Then sal*10
             When JOB='CLERK'   Then sal*20
             When JOB='MANAGER'   Then sal*30
             When JOB='PRESIDENT'   Then sal*40
             When JOB='SALESMAN'   Then sal*50
            else                     sal*60    
        end aa
from emp;


-----------  Home Work   Group 함수   --------------------
-- 1. 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)


-- 2. 부서별 최근 입사 사원과 가장 오래된 사원의 입사일 출력 (emp)




-- 3. 부서별, 직업별 count & sum[급여] , 출력순서 --> 부서별, 직업별    (emp)

select deptno,COUNT(job), sum(sal)
from emp
group by deptno,job;

-- 4. 부서별 급여총액 3000이상 부서번호,부서별 최대급여   (emp)
select DEPTNO, SUM(sal) 
from emp
GROUP BY DEPTNO
having SUM(sal)>3000;

-- 5. 전체 학생을 소속 학과별로 나누고, 같은 학과 학생은 다시 학년별로 그룹핑하여, 
--   학과와 학년별 인원수, 평균 몸무게를 출력, 
--  (단, 평균 몸무게는 소수점 이하 첫번째 자리에서 반올림 )  STUDENT

select deptno,count(grade),round(avg(weight),0)
from student
group by deptno,grade

-----------  Home Work   Group 함수 END --------------------