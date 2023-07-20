Create or replace Procedure Dept_Insert --부서 테이블을 인서트 
    (Pdeptno in dept.deptno%type,         -- orreplace
     Pdname in dept.dname% type,
     Ploc in dept.loc%Type)
     --(파라미터 )3개를 입력
IS
    --변수명
begin
    INSERT into dept values(Pdeptno,Pdname,Ploc);
    commit;
END;