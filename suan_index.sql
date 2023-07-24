SELECT *
FROM user_indexes; --������ dbms���� �����ϴ� user_index

SELECT *
FROM user_indexes
where table_name = 'EMP';

SELECT *
from emp
where empno = 7369;

SELECT *
from emp
where ename = 'WARD';

CREATE TABLE customers
( customer_id number NOT NULL PRIMARY KEY,
first_name varchar2(10) NOT NULL,
last_name varchar2(10) NOT NULL,
email varchar2(10),
phone_number varchar2(20),
regist_date date
);

INSERT INTO customers
VALUES (1, 'Suan', 'Lee', 'suan', '010-1234-1234', '21/01/01');

INSERT INTO customers
VALUES (2, 'Elon', 'Musk', 'elon', '010-1111-2222', '21/05/01');

INSERT INTO customers
VALUES (3, 'Steve', 'Jobs', 'steve', '010-3333-4444', '21/10/01');

INSERT INTO customers
VALUES (4, 'Bill', 'Gates', 'bill', '010-5555-6666', '21/11/01');

INSERT INTO customers
VALUES (5, 'Mark', 'Zuckerberg', 'mark', '010-7777-8888','21/12/01');

--���̺��� �ε��� Ȯ��
select *
from user_indexes
where table_name = 'CUSTOMERS';


SELECT * FROM CUSTOMERS;


--Ǯ��ĵ���� ã�´� , ������ �ο��τb�� ��ȿ����
SELECT * FROM CUSTOMERS
WHERE regist_date = '21/01/01';
-- �ε����� �ϰ� �ٽ� �����ϸ� ��ȹ���� �ε����� ����

CREATE INDEX regist_date_idx
ON CUSTOMERS(regist_date); --�ε��� ����




CREATE INDEX name_idx
on CUSTOMERS(first_name,last_name);

SELECT * FROM CUSTOMERS
WHERE first_name = 'Suan';


--������ �ε��� ����
CREATE UNIQUE INDEX email_idx
ON customers (email);

SELECT *
FROM customers
WHERE email = 'suan';
