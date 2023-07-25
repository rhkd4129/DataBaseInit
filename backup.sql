--외래키-




-- FK  ***
-- 1. Restrict : 자식 존재 삭제 안됨  (연관 관계 때문)
--    1) 선언   Emp Table에서  REFERENCES DEPT (DEPTNO) 
--    2) 예시   integrity constraint (SCOTT.FK_DEPTNO) violated - child record found
delete dept where deptno =10; 


-- 2. Cascading Delete : 같이 죽자
--    1)종속삭제 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO) ON DELETE CASCADE

delete detp where deptno = 61;


-- 3.  SET NULL   
--    1) 종속 NULL 선언 : Emp Table에서 REFERENCES DEPT (DEPTNO)  ON DELETE SET NULL

---------------------------------------------------
--       Backup Dir 생성 ----------------
---------------------------------------------------

-- Oracle 부분 Backup후  부분 Restore  (scott)
-- exp scott/tiger@xe file = address.dmp tables=address 

--exp scoot/tiger@xe file=emp.dmp talbes = emp

--   2) Oracle 부분 Restore  (scott)
--   C:\oraclexe\mdbackup> >exp scott/tiger@xe file=address.dmp full=y
--   C:\oraclexe\mdbackup> >imp scott/tiger@xe file=address.dmp full=y 복구

-- 전채 백업/ 복구
--1)Admin권한
    --1 backp dir 생성후 
    -- 2 권한 부여 
    --create OR REPLACE DIRECTORY mdbackup as 'C:\backup';
    --GRANT read,write ON DIRECTORY mdbackup TO scoot;
    --디레토리 생성후  mdbackup의 권한을 scoot에게 주겟다.

--       3.scott전체 backup
-- EMPDP scott/tiger Directory = mdbackup DUMPFILE = scott.dmp 전체 백업?
        --4.복구
 --IMPDP scott/tiger Directory = mdbackup DUMPFILE = scott.dmp 전체 복구
 -- bat div_run.bat
