-- 1. 이름, 관리자명(emp TBL)
SELECT e.empno, e.ename,m.ename,m.mgr
FROM emp e , emp m
where e.empno = m.mgr;

-- 2. 이름,급여,부서코드,부서명,근무지, 관리자 --> 전체직원(emp ,dept TBL)
SELECT e.ename,e.sal,d.DNAME ,d.loc ,e.mgr
from emp e , dept d;

-- 3. 이름,급여,등급,부서명,관리자명, 급여가 2000이상인 사람 --    (emp, dept,salgrade2 TBL)
select e.ename,e.sal, s.grade , d.dname,e.mgr   --등급 급여
from emp e, dept d, salgrade2 s
where  e.sal>=2000 and e.sal between s.losal and s.hisal;


-- 4. 보너스를 받는 사원에 대하여 이름,부서명,위치를 출력하는 SELECT 문장을 작성 (emp ,dept TBL)

SELECT e.ename,d.dname,d.loc,e.comm
FROM emp e ,dept d
where e.comm  != 0;


-- 5. 사번, 사원명, 부서코드, 부서명을 검색하라. 사원명기준으로 오름차순정열(emp ,dept TBL)

SELECT e.empno,e.ename,d.dname
FROM emp e ,dept d
order by e.ename


