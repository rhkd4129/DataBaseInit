-----------------------------------------------------------------------------------------
--   11. View 
------------------------------------------------------------------------------
-- View : 하나 이상의 기본 테이블이나 다른 뷰를 이용하여 생성되는 가상 테이블
--       뷰는 데이터딕셔너리 테이블에 뷰에 대한 정의만 저장
--       장점 :   보안 
--       단점 :   Performance(성능)은 더 저하

CREATE OR REPLACE view  VIEW_PROFESSOR  AS 
SELECT PROFNO,name,userid,position,hiredate,deptno
from professor;

--PK없이도?
CREATE OR REPLACE view  VIEW_PROFESSOR2  AS 
SELECT name,userid,position,hiredate,deptno
from professor;
--professor 원본에 제약조건같은 것을 바꾸면 view에도 오류가 난다. 재컴파일하면 오류가없어짐
-- 조회하는 순간 professor가 받아서 전체적으로 실행
SELECT * FROM VIEW_PROFESSOR;


-- date insert도 가능함 
insert into view_professor values(2000,'velw','userid','posittion',sysdate,101);

-- 중간에 name없이도 가능하다 

-- name을 not null로 설정후에다시 넣을려고 하면 안된다. --> 제약조건은 그대로 따른다
-- 제약조건에 걸리지 않는다면 뷰를 통한 입력 가능
-- 특성 1. 원래 table [professor]에 입력 가능, 하지만 제약조건은 그대로 따름!

-- 연습
CREATE OR REPLACE view  v_emp_sample  AS 
SELECT empno , ename , job, mgr,deptno
from emp;


--통합뷰
CREATE OR REPLACE VIEW v_emp_complex
as
SELECT *
from emp natural join dept; --중복칼럼을 자연스럽게 하나 지워준다

INSERT INTO v_emp_complex(empno, ename,deptno)
            VALUES(1500,'홍길',20);  --EMP기준
   
INSERT INTO v_emp_complex(deptno, dname,loc)
            VALUES(77,'공무팀','낙성대');  --DEPT기준
            
            
INSERT INTO v_emp_complex(empno, ename,deptno , dname,loc) --한꺼버넹
            VALUES(1500,'홍길동',77,'공무팀','낙성대');  
-- 3개다 안넣어짐 복합뷰는 insert가 안된다.


select view_name,text
from user_vies;
--- homework --
---문1)  학생 테이블에서 101번 학과 학생들의 학번, 이름, 학과 번호로 정의되는 단순 뷰를 생성
---뷰 명 :  v_stud_dept101
CREATE OR REPLACE VIEW v_stud_dept1010
AS
    SELECT studno,name,deptno
    from student
    where deptno = 101;
    

 --문2) 학생 테이블과 부서 테이블을 조인하여 102번 학과 학생들의 학번, 이름, 학년, 학과 이름으로 정의되는 복합 뷰를 생성
--  뷰 명 :   v_stud_dept10    
CREATE OR REPLACE VIEW v_stud_dept10    
AS
    SELECT s.studno, s.name, s.grade,d.dname
    from student s
    join dept d  on s.deptno = d.deptno 
    where s.deptno = 102;
    

--문3)  교수 테이블에서 학과별 평균 급여와     총계로 정의되는 뷰를 생성
--  뷰 명 :  v_prof_avg_sal       Column 명 :   avg_sal      sum_sal
            
create or replace view v_prof_avg_sal 
as
    select deptno,avg(sal)  avg_sal  , sum(sal) sum_sal
    from professor
    group by deptno;
            