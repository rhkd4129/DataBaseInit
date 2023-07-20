---------------------------------------------------------
----   HW  10
----------------------------------------------------------
--1. salgrade 데이터 전체 보기
SELECT * FROM SALGRADE;

--2. scott에서 사용가능한 테이블 보기


--3. emp Table에서 사번 , 이름, 급여, 업무, 입사일 조회
SELECT empno,ename,sal,job,hiredate from EMP;


--4. emp Table에서 급여가 2000미만인 사람 에 대한 사번, 이름, 급여 항목 조회
SELECT empno,ename,sal from EMP
where sal<2000;



--5. emp Table에서 80/02이후에 입사한 사람에 대한  사번,이름,업무,입사일 
SELECT empno, ename, job, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1980-02-01', 'YYYY-MM-DD');
--WHERE hiredate EBTWWEN '80/02/01' AND sysdate
--WHERE to_char(hiredate,'mm')='02'


--6. emp Table에서 급여가 1500이상이고 3000이하 사번, 이름, 급여  조회
--    ( AND   &    BETWEEN)
SELECT empno,ename,sal from EMP
where sal between 1500 and 3000;



--7. emp Table에서 사번, 이름, 업무, 급여 조회 [ 급여가 2500이상이고  업무가 MANAGER인 사람]
SELECT empno,ename,job,sal from EMP
where  (sal>2500) and (job = 'MANAGER');




--8. emp Table에서 이름, 급여, 연봉 조회 
   -- [단 조건은  연봉 = (급여+상여) * 12  , null을 0으로 변경]
SELECT empno,ename,sal,NVL((sal+comm)*12,0) from EMP;
 
 
 
   
--9. emp Table에서  81/02 이후에 입사자들중 xxx는 입사일이 xxX
--  [ 전체 Row 출력 ] --> 2가지 방법 다
--concar == ||
SELECT empno, ename ,concat(concat(ename,'는 입사일이'),hiredate ) aa FROM emp
WHERE hiredate > to_date('1981-02-01','YYYY-MM-DD');
--WHWERE HIREDATE >='81/02/01';
--


--10.emp Table에서 이름속에 T가 있는 사번,이름 출력
SELECT empno, ename
FROM emp
WHERE ename LIKE '%T%';
