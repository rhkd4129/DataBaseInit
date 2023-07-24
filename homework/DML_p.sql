/*


*/

create table address
(

    id          NUMBER(3),
    Name        VARCHAR2(50),
    addr        VARCHAR2(100),
    phone       VARCHAR2(30),
    email       VARCHAR2(100)
);
insert into address
values(1,'HGDONG','SEOUL','123-4567','gbhong@naver.com')

/*
문1) address스키마/Data 유지하며     addr_second Table 생성 
문2) address스키마 유지하며  Data 복제 하지 않고   addr_seven Table 생성 
문3) address(주소록) 테이블에서 id, name 칼럼만 복사하여 addr_third 테이블을 생성하여라         
문4) addr_second 테이블 을 addr_tmp로 이름을 변경 하시요




