---------------------------------------------------------------------------------
-- 트랜잭션 개요  ***
-- 관계형 데이터베이스에서 실행되는 여러 개의 SQL명령문을 하나의 논리적 작업 단위로 처리하는 개념
-- COMMIT : 트랜잭션의 정상적인 종료
--               트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 디스크에 영구적으로 저장하고 
--               트랜잭션을 종료
--               해당 트랜잭션에 할당된 CPU, 메모리 같은 자원이 해제
--               서로 다른 트랜잭션을 구분하는 기준
--               COMMIT 명령문 실행하기 전에 하나의 트랜잭션 변경한 결과를
--               다른 트랜잭션에서 접근할 수 없도록 방지하여 일관성 유지
 
-- ROLLBACK : 트랜잭션의 전체 취소
--                   트랜잭션내의 모든 SQL 명령문에 의해 변경된 작업 내용을 전부 취소하고 트랜잭션을 종료
--                   CPU,메모리 같은 해당 트랜잭션에 할당된 자원을 해제, 트랜잭션을 강제 종료
---------------------------------------------------------------------------------------


----------------------------------
-- SEQUENCE ***
-- 유일한 식별자
-- 기본 키 값을 자동으로 생성하기 위하여 일련번호 생성 객체
-- 예를 들면, 웹 게시판에서 글이 등록되는 순서대로 번호를 하나씩 할당하여 기본키로 지정하고자 할때 
-- 시퀀스를 편리하게 이용
-- 여러 테이블에서 공유 가능  -- > 일반적으로는 개별적 사용 
----------------------------------
-- 1) SEQUENCE 형식
--CREATE SEQUENCE sequence
--[INCREMENT BY n]
--[START WITH n]
--[MAXVALUE n | NOMAXVALUE]
--[MINVALUE n | NOMINVALUE]
--[CYCLE | NOCYCLE]
--[CACHE n | NOCACHE];
--INCREMENT BY n : 시퀀스 번호의 증가치로 기본은 1,  일반적으로 ?1 사용
--START WITH n : 시퀀스 시작번호, 기본값은 1
--MAXVALUE n : 생성 가능한 시퀀스의 최대값
--MAXVALUE n : 시퀀스 번호를 순환적으로 사용하는 cycle로 지정한 경우, MAXVALUE에 도달한 후 새로 시작하는 시퀀스값
--CYCLE | NOCYCLE : MAXVALUE 또는 MINVALUE에 도달한 후 시퀀스의 순환적인 시퀀스 번호의 생성 여부 지정
--CACHE n | NOCACHE : 시퀀스 생성 속도 개선을 위해 메모리에 캐쉬하는 시퀀스 개수, 기본값은 20

-- 2) SEQUENCE sample 예시1

CREATE SEQUENCE sample_seq
INCREMENT BY 1
START with 10000;

-- 3) SEQUENCE sample 예시2
SELECT sample_seq.nextVal FROM dual; --LAST NUMBER부터 시작
SELECT sample_seq.CURRVAL FROM dual; --현재값을 가져온다.



CREATE SEQUENCE dept_dno_seq
INCREMENT BY 1
START WITH 10;


-- 4) SEQUENCE dept_dno_seq를 이용 dept_second 입력 --> 실 사용 예시
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL,'Accouning','NEW WORK');


SELECT dept_dno_seq.CURRVAL FROM DUAL;


INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL,'회계','이대');

SELECT dept_dno_seq.CURRVAL FROM DUAL;


INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL,'인사팀','당산');


--max 전환
insert into dept_second values((select max(deptno)+1 from dept_second)
    ,'경영팀'
    ,'대림'
    );
--max와 nextval의 차이점


/*
            max                   seq
수행        sql           그룹함수 객체
문제점     트랜잭션 극히     값이 유한
        적으나 실패가능성     
공통점은   pk잡을 대 많이 사용

*/

--max 전환
INSERT INTO dept_second
VALUES(dept_dno_seq.NEXTVAL,'인사3팀','당산3');
--오류  -> max와 seq.nextval을 섞어쓰지 말자



--5)  Data 사전에서 정보 조회
SELECT sequence_name,min_value,max_value,increment_by from user_sequences;
-- 시퀀스 삭제
DROP SEQUENCE sample_SEQ;

/*
------------------------------------------------------------------
     데이터 사전
 1. 사용자와 데이터베이스 자원을 효율적으로 관리하기 위한 다양한 정보를 저장하는 시스템 테이블의 집합
 2. 사전 내용의 수정은 오라클 서버만 가능
 3. 오라클 서버는 데이타베이스의 구조, 감사, 사용자 권한, 데이터 등의 변경 사항을 반영하기 위해
    지속적 수정 및 관리
 4. 데이타베이스 관리자나 일반 사용자는 읽기 전용 뷰에 의해 데이터 사전의 내용을 조회만 가능
 5. 실무에서는 테이블, 칼럼, 뷰 등과 같은 정보를 조회하기 위해 사용

------------------------------------------------------------------
------------------------------------------------------------------
-----     데이터 사전 관리 정보
 1.데이터베이스의 물리적 구조와 객체의 논리적 구조
 2. 오라클 사용자 이름과 스키마 객체 이름
 3. 사용자에게 부여된 접근 권한과 롤
 4. 무결성 제약조건에 대한 정보
 5. 칼럼별로 지정된 기본값
 6. 스키마 객체에 할당된 공간의 크기와 사용 중인 공간의 크기 정보
 7. 객체 접근 및 갱신에 대한 감사 정보
 8.데이터베이스 이름, 버전, 생성날짜, 시작모드, 인스턴스 이름 정보
------------------------------------------------------------------
-------     데이터 사전 종류
 1. USER_ : 객체의 소유자만 접근 가능한 데이터 사전 뷰
 user_tables는 사용자가 소유한 테이블에 대한 정보를 조회할 수 있는 데이터 사전 뷰.
*/


SELECT table_name,tablespace_name
FROM user_tables;

SELECT *
FROM user_catalog;

-- 2. ALL_    : 자기 소유 또는 권한을 부여 받은 객체만 접근 가능한 데이터 사전 뷰
SELECT owner , table_name
FROM all_tables;
-- 3. DBA_   : 데이터베이스 관리자만 접근 가능한 데이터 사전 뷰
SELECT owner, table_name
FROM dba_tables;

