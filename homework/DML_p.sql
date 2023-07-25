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
��1) address��Ű��/Data �����ϸ�     addr_second Table ���� 
��2) address��Ű�� �����ϸ�  Data ���� ���� �ʰ�   addr_seven Table ���� 
��3) address(�ּҷ�) ���̺��� id, name Į���� �����Ͽ� addr_third ���̺��� �����Ͽ���         
��4) addr_second ���̺� �� addr_tmp�� �̸��� ���� �Ͻÿ�
*/

create Table  addr_second 
AS select *from address;


create Table  addr_seven 
AS select * from address
where 1=0;

create table  addr_third
as 
    select id, name 
    from address;

RENAME addr_seven TO  addr_seven_new;