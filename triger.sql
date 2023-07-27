----------------------------------------------------------------------------------------
-------                     Trigger 
--  1. 정의 : 어떤 사건이 발생했을 때 내부적으로 실행되도록 데이터베 이스에 저장된 프로시저
--              트리거가 실행되어야 할 이벤트 발생시 자동으로 실행되는 프로시저 
--              트리거링 사건(Triggering Event), 즉 오라클 DML 문인 INSERT, DELETE, UPDATE이 
--              실행되면 자동으로 실행
--  2. 오라클 트리거 사용 범위
--    1) 데이터베이스 테이블 생성하는 과정에서 참조 무결성과 데이터 무결성 등의 복잡한 제약 조건 생성하는 경우 
--    2) 데이터베이스 테이블의 데이터에 생기는 작업의 감시, 보완 
--    3) 데이터베이스 테이블에 생기는 변화에 따라 필요한 다른 프로그램을 실행하는 경우 
--    4) 불필요한 트랜잭션을 금지하기 위해 
--    5) 컬럼의 값을 자동으로 생성되도록 하는 경우 
-------------------------------------------------------------------------------------------

CREATE OR REPLACE TRIGGER tirger_test
BEFORE            --DEPT테이블 수정하기전에 
UPDATE ON dept 
FOR EACH ROW --old, new 사용하기 위해  각각의 로우에 대해서 
BEGIN 
    DBMS_OUTPUT.ENABLE;
    DBMS_OUTPUT.PUT_LINE('변경전 칼럼값:'||:old.dname);--수정 전 부서이름
    DBMS_OUTPUT.PUT_LINE('변경후 칼럼값:'||:new.dname);--수정 후 부서이름;
END;

--누군가가 DEPT를 수정하게되면 수정하게 전에 이 로직(17~23줄)을 수행시켜줄게

--DBMS출력 
UPDATE dept
set dname = '회계3팀'
WHERE deptno = 55;


UPDATE dept
set dname = '인사 1팀'
WHERE deptno = 55;


----------------------------------------------------------
-- emp Table의 급여가 변화시
--       화면에 출력하는 Trigger 작성( emp_sal_change)
--       emp Table 수정전
--      조건 : 입력시는 empno가 0보다 커야함

--출력결과 예시
--     이전급여  : 10000
--     신  급여  : 15000
 --    급여 차액 :  5000
----------------------------------------------------------

CREATE OR REPLACE TRIGGER emp_sal_change
BEFORE DELETE OR INSERT OR UPDATE ON emp --여러가지 가능
FOR EACH ROW  --각각의 로우에 대해서 조건에 만족
    WHEN (new.empno>0)
    DECLARE
        sal_diff number; --차액에 대한 변수 명 선언
BEGIN 
    sal_diff := :new.sal - :old.sal;
    DBMS_OUTPUT.PUT_LINE('변경전 칼럼값:'||:old.sal);
    DBMS_OUTPUT.PUT_LINE('변경후 칼럼값:'||:new.sal);
    DBMS_OUTPUT.PUT_LINE('급여차액:'||sal_diff);
END;



--DBMS출력
update emp set sal=8000
where empno = 7369


--사용하는 예시
-----------------------------------------------------------
--  EMP 테이블에 INSERT,UPDATE,DELETE문장이 하루에 몇 건의 ROW가 발생되는지 조사
--  조사 내용은 EMP_ROW_AUDIT에 
--  ID ,사용자 이름, 작업 구분,작업 일자시간을 저장하는 트리거를 작성
-----------------------------------------------------------
--1.sequence

CREATE sequence emp_row_seq;--기본값생성<- 이게 젤 좋다 
--2. audit table
create table emp_row_audit(
    e_id NUMBER(6)      CONSTRAINT emp_row_pk PRIMARY KEY,
    e_name VARCHAR2(30),
    e_gubun VARCHAR2(10),
    e_date DATE

);

CREATE OR REPLACE TRIGGER emp_row_aud
    AFTER INSERT OR UPDATE OR DELETE ON emp
    FOR EACH ROW

BEGIN
    IF INSERTING THEN
        INSERT INTO emp_row_audit
            VALUES(emp_row_seq.NEXTVAL,:old.ename,'inserting',SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO emp_row_audit
            VALUES(emp_row_seq.NEXTVAL,:old.ename,'updateing',SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO emp_row_audit
            VALUES(emp_row_seq.NEXTVAL,:old.ename,'deleting',SYSDATE);
    END IF;
END;


INSERT INTO EMP(empno,ename,sal,deptno) values(3000,'김용빈',3500,91);
-- 실행하면 emp_row_audit에 추가가 되는데 emp_row_audit에.ename속성에 null들어가있다
-- 왜냐하면 old.ename을 사용해서 그럼 원래 값이 없기 때무넹 insert할 시에는 new를써야함

--트리거는 우클릭으로 활성화 비활성화 할 수도 잇다

/*
db보안  <--- 이거 기사때 했던거인듯
    1) 접근제어
        1 DAC:사용권한 -> 직접권한부여
        2 MAC:군대
        3 RBAC:ROLE에 의한 권한부여
    2)암호화         RSA   DES_SEED   
        1.API암호화 :공개,  비공개,    HASH
        2 PLUG-IM 암호화 :DB자체 암호화 
        3.PROXY 암호화 
    3추출 제어 


*/
-----------------------------------------------
---   데이터베이스 보안
---  1. 다중 사용자 환경(multi-user environment)
---     1) 사용자는 자신이 생성한 객체에 대해 소유권을 가지고 데이터에 대한 조작이나 조회 가능
---     2) 다른 사용자가 소유한 객체는 소유자로부터 접근 권한을 부여받지 않는 접근 불가
---     3) 다중 사용자 환경에서는 데이터베이스 관리자의 암호를 철저하게 관리
---  2. 중앙 집중적인 데이터 관리
---  3. 시스템 보안
---     1) 데이터베이스 관리자는 사용자 계정, 암호 관리, 사용자별 허용 가능한 디스크공간 할당
---     2) 시스템 관리 차원에서 데이터베이스 자체에 대한 접근 권한을 관리
---  4. 데이터 보안
---     1) 사용자별로 객체를 조작하기 위한 동작 관리
---     2) 데이터베이스 객체에 대한 접근 권한을 관리
-----------------------------------------------
----------------------------------------------------------------------
---  권한(Privilege) 부여
---    1. 정의 : 사용자가 데이터베이스 시스템을 관리하거나 객체를 이용할 수 있는 권리
---    2. 유형 
---         1) 시스템 권한 : 시스템 차원의 자원 관리나 사용자 스키마 객체 관리 등과 같은 
---                               데이터베이스 관리 작업을 할 수 있는 권한
---             [1]  데이터베이스 관리자가 가지는 시스템 권한
---                   CREATE USER     :  사용자를 생성할 수 있는 권한
---                   DROP    USER     : 사용자를 삭제할 수 있는 권한
---                   DROP ANY TABLE : 임의의 테이블을 삭제할 수 있는 권한
---                   QUERY REWRITE  : 함수 기반 인덱스를 생성하기 위한 권한
        ---   [2]  일반사용자가 가지는 시스템 권한
---                   CREATE SESSION      : DB에 접속할 수 있는 권한
---                   CREATE TABLE          : 사용자 스키마에서 테이블을 생성할 수 있는 권한
---                   CREATE SEQUENCE   : 사용자 스키마에서 시퀀스를 생성할 수 있는 권한
---                   CREATE VIEW            : 사용자 스키마에서 뷰를 생성할 수 있는 권한
---                   CREATE PROCEDURE : 사용자 스키마에서 프로시저, 함수, 패키지를 생성할 수 있는 권한
---         2) 객체 권한    : 테이블, 뷰, 시퀀스, 함수 등과 같은 객체를 조작할 수 있는 권한

---------------------------------------------------------------------------------------------
---  롤(role)
---  1. 개념 : 다수 사용자와 다양한 권한을 효과적으로 관리하기 위하여 서로 관련된 권한을 그룹화한 개념
---              일반 사용자가 데이터베이스를 이용하기 위한 공통적인 권한(데이터베이스 접속권한, 테이블 생성, 수정, 삭제, 조회 권한, 뷰 생성 권한)을 그룹화
-- 사전에 정의된 롤
-- 1. CONNECT 롤
--     1) 사용자가 데이터베이스에 접속하여 세션을 생성할 수 있는 권한
--     2) 테이블 또는 뷰와 같은 객체를 생성할 수 있는 권한
-- 2. RESOURCE 롤
--     1) 사용자에게 자신의 테이블, 시퀀스, 프로시져, 트리거 객체 생성 할 수 있는 권한
--     2) 사용자 생성시 : CONNECT 롤과 RESOURCE 롤을 부여
-- 3.  DBA 롤
--     1) 시스템 자원의 무제한적인 사용이나 시스템 관리에 필요한 모든 권한
--     2) DBA 권한을 다른 사람에게 부여할 수 있음
--     3) 모든 사용자 소유의 CONNECT, RESOURCE, DBA 권한을 포함한 모든 권한을 부여 및 철회 가능

--------------------------SYSTEM 워크시트---------------------------------------------
--SYSTEM계정 접속
--SYSTEM 워크시트에 작성
--CREATE USER usertest01 IDENTIFIED by tiger;
--CREATE USER usertest02 IDENTIFIED by tiger;
--CREATE USER usertest03 IDENTIFIED by tiger;
--CREATE USER usertest04 IDENTIFIED by tiger;


--GRANT CREATE SESSION to usertest01  <-- 권한주고 테이블만들려고 하는데 권한 문제때문에 안됨
-- 연결권한만 준거 
----------------------------

-- user2에서 더 넓은 권한 주기   user2에는 다줌
--GRANT CREATE SESSION , CREATE table, CREATE VIEW to usertest02;
--이것도 안됨


-- -> 그럼 우째?

-- 현장에서 dba가 개발자 권한 부여하는 방법
--GRANT CONNECT , RESOURCE  to  usertest03;
--GRANT CONNECT , RESOURCE  to  usertest04;
--> 이게   롤(role) 방법 RBAC!!!!!!! ***
-----------------------usertest03워크시트-------------------------------
-- 이제 usertest03에 테이블 생성(usertest03 워크시트에 작업)
--CREATE TABLE SALGRADE5
--        (GRADE NUMBER(2)  CONSTRAINT PK_GRADE  PRIMARY KEY,
--         LOSAL NUMBER(5),
--         HISAL NUMBER(5));

-------------------- system 워크시트 ----------------------------------------

--admin관점(system 워크시트)에서  볼수잇나?
--select * from emp;<-- 안됨
--select * from scott.emp; --<--됨


--create table systemTBL
--    (memo varchar2(50));
--INSERT INTO systemTBL values('오월푸름');
--INSERT INTO systemTBL values('결실을 맺으리라 ');

-- 나(system)는 (당연히) 스스로 조회 가능 
--SELECT * FROM systemTBL;
-------------usertest1,2,3,4 워크시트에서 순서대로 작업 --------------------------
--SELECT * FROM systemTBL;   <-- 다 안됨 -> admin TBL은 다른데서 다 조회안됨 


-----------------------system 워크시트에 작업-------------------------------------
--system에 있는 systemTBL에 Read 권한 usertest04 주는법
--->  GRANT SELECT ON systemTBL TO usertest04 WITH GRANT OPTION --
-->   접근 권한과 이 권한을 줄 수 있는 권한을 너에게도 줄게 ! 



--------------------------usertest4 에서 작업----------------------------
--  SELECT * from system.systemTBL; 원래 안됐는데 
-- system에서 userteset04에게 읽는 권한을 줘서 됨 
--GRANT SELECT ON system.systemTBL TO usertest03; -->userset04에서 03에게 권한을 준다 

--------------------------usertest3 에서 작업----------------------------
--SELECT * FROM system.systemTBL; 된다 -> 4가 3에게 권한을 줘서
-- usertest3에 잇는 systemtbl에 read권한을 usertest2에게 줄래
-- GRANT SELECT ON system.systemTBL to usertest02;->안됨



----------------------------------  결론   -----------------
-->GRANT SELECT ON systemTBL TO usertest04 WITH GRANT OPTION --
-- 끝에 grant option을 주면 권한을 줄수 있는 권한까지 준다
-->GRANT SELECT ON system.systemTBL TO usertest03; 
-- 읽은 건 가능하지만 권한을 주지는 못한다,

-->>>  우리 뒤에 계신 학생교수님이 revoke 권한회수질문 
-------------- user test 4에서 작업 -------------------------
--revoke select on system.systemTBL FROM usertest03;
-- 권환회수도 된다 




-- 동의어(synonym)
-- 1. 정의 : 하나의 객체에 대해 다른 이름을 정의하는 방법
--      동의어와 별명(Alias) 차이점
--      동의어는 데이터베이스 전체에서 사용
--      별명은 해당 SQL 명령문에서만 사용
-- 2. 동의어의 종류
--   1) 전용 동의어(private synonym) 
--      객체에 대한 접근 권한을 부여 받은 사용자가 정의한 동의어로 해당 사용자만 사용
--
--   2) 공용 동의어(public sysnonym)
--      권한을 주는 사용자가 정의한 동의어로 누구나 사용
--      DBA 권한을 가진 사용자만 생성 (예 : 데이터 딕셔너리)
 


-----------------ㅍ----------system워크시트에서 --------------------------------------
-- 권한 부여 했지만 번거로움 -->  Simple 하게 하기 위해  공용 동의어(public sysnonym) 생성
--CREATE PUBLIC SYNONYM systemTBL FOR systemTBL;;-- 현장용
-- 공용동의어 들가보면 잇음 (ㅈㄴ 많음 다른거 쯕내려야함)
------------------- USERTEST4에서 --------------------------------------------------
--SELECT * FROM systemTBL; 이제 됨 원래는 SELECT * from system.systemTBL이렇게 해야됨


--현재 SCOTT과 아무런 연관이 없다, 
--SELECT* FROM scott.emp <-당연히 안된다  명령문하고 싶어요 어떻게 ?
-- 3. scott에 있는 student TBL에 Read 권한 usertest04 주세요 <--현장 웤ㅋ

----------scott서작업-----------------------------------------------
--GRANT SELECT ON scott.student TO usertest04;
-->teset4에게 scott.stduent를 조회할 수 잇는 권한을준다.
---------------- usertest4에서 작업----------------9-------------------------------
--select * from scott.student -- 됨  (준우야 ㅈㄴ 왔다갔다해서 정신이 없다 ㅅㅂ

--update scott.student
--set userid ='kkk'
--where studno = 30101;  ->이건 되냐? 안됨 왜? 읽기 권환만 줘서 


--------------------------------------------------------------------

        


--3시 5분 현장 웤 타입------------------------ㅋ.. ㅋ.z..z...zzz..
--  2-3.emp테이블의 SELECT 권한 부여 개발자 권한까지 usertest04에 부여해보기

---------------- 해답 ------------------- scott에서 하는거 -------------
GRANT SELECT ON scott.emp TO usertest04 WITH GRANT OPTION 

--이것도 해보라하심
GRANT SELECT ON scott.dept TO usertest04 WITH GRANT OPTION 



---  권한 회수---------------------------------------------------
-- 이제 한계야 ㅈㄴ졸려 계쏙 권한 줫다 뺏다 해 오늘도 내일도
-- 개미는 뚠둔

---------------------------------------------------
---  권한 회수
---------------------------------------------------
-- 1. 원래 권한 준 계정아니면 권한 회수 안 됨
-- 3시반 앞으로 50분어캐함  와 방금 본능적으로 눈피했다  질문 ㅅㅂ



-- 원래 권한 준 꼐정으로 부터 권한 회수 후  
--권한 권한(WITH GRANT OPTION)로 부여한 모든권한 모두 회수 됨 
-- 그래서 DAC방식으로 해도 어느정도 컨트롤이 되서  이걸 많이쓴다. ~~~
-- 뭐 RBAC도 앵간쓰기한다~ -> 갑자기 앞에줄 빵터짐 교수님: ?? 나만 왕따네.. 

--> 이거 뭔가 부장급되야 권한 줬다 뺏다할거같은뎅,,, 힝 너무 귀찮아 옹{~~~~

--> 전에 공용동의어 햇언슨데 이제 막 뭐 사용자 전용 동의어 설정하기 핸슨데 
--  이거 앞에 사람들 블로그가서 보셈 ^^^ 잠깐 딴생각햇는데 뭐 갑자기 A에서 Z로 가더라
-- 근데 교수님이 이거 할때정도가면 아마 너네 취업하고 팀장급에서 할꺼니가 몰라돋 될듯 ㄹㅇ ㅋㅋㅋ
-- 교수님도 정신없는거 인정하시고 지금 3시 50분인데 지금부터 자습한데 ㄹㅇ.. 너 오늘 안오는거 개꿀이엿노 


