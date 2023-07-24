/* INDEX 관리 */


/*  인덱스는 SQL 명령문의 처리 속도를 향상(*) 시키기 위해 칼럼에 대해 생성하는 객체
--  인덱스는 포인트를 이용하여 테이블에 저장된 데이터를 랜덤 액세스하기 위한 목적으로 사용
--  [1]인덱스의 종류
--   1)고유 인덱스 : 유일한 값을 가지는 칼럼에 대해 생성하는 인덱스로 모든 인덱스 키는
--    테이블의 하나의 행과 연결
*/

CREATE UNIQUE INDEX idx_dept_name
ON      department(dname);

--   2)비고유 인덱스
-- 문) 학생 테이블의 birthdate 칼럼을 비고유 인덱스로 생성하여라

CREATE INDEX idx_stud_birthdate
on student(birthdate);
--성능에만 영향을 미치고 제약조건에는 영향이 없다?

insert into student(studno,name,idnum,birthdate)
                VALUES(30102,'김유신','8012301036614','84/09/16');


--   3)단일 인덱스




--   4)결합 인덱스 :  두 개 이상의 칼럼을 결합하여 생성하는 인덱스
--     문) 학생 테이블의 deptno, grade 칼럼을 결합 인덱스로 생성
--          결합 인덱스의 이름은 idx_stud_dno_grade 로 정의

CREATE INDEX idx_stud_dno_grade
    ON student(deptno,grade);
    
    
SELECT *
FROM student
WHERE deptno = 101
AND grade=2;

--- Optimizer
--- 1) RBO (규칙대로) 2) 요즘은 CBO

--RBO변경
ALTER SESSION SET OPTIMIZER_MODE = RULE;

--SESSION 상에셔 변경될때
ALTER SESSION SET OPTIMIZER_MODE = rule
ALTER SESSION SET OPTIMIZER_MODE = CHOOSE

--CBO
ALTER SESSION SET OPTIMIZER_MODE = first_rows
ALTER SESSION SET OPTIMIZER_MODE = ALL_ROWS

SELECT *
FROM student
WHERE deptno = 101
AND grade=2;