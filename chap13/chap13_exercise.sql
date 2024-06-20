-- 13장 객체 종류
-- 데이터베이스를 위한 데이터를 저장한 데이터 사전
-- 테이블 : 1. 사용자 테이블 과   2. 데이터 사전
-- 13-1
SELECT * FROM DICT;

SELECT * FROM DICTIONARY;

-- USER_ 접두어를 가진 데이터 사전
SELECT TABLE_NAME
  FROM USER_TABLES 
 ORDER BY TABLE_NAME ;
 
SELECT OWNER, TABLE_NAME
  FROM ALL_TABLES;
  
SELECT * FROM DBA_USERS;  
  
--13-8 hr 계정이 소유한 인덱스 정보 조회
-- 인덱스 정보 조회
SELECT *
  FROM USER_INDEXES 
 WHERE TABLE_NAME = 'EMP';
-- 인덱스 컬럼 조회 
SELECT *
  FROM USER_IND_COLUMNS
 WHERE TABLE_NAME = 'EMP';
 
 -- 13-10
 CREATE INDEX IDX_EMP_SAL
     ON EMP(SAL);

SELECT * FROM EMP WHERE EMPNO = 7369;

SELECT * FROM EMP WHERE ENAME = 'SMITH';

DROP INDEX IDX_EMP_SAL;

-- 추가   DDL
CREATE TABLE customers
( customer_id   number       NOT NULL PRIMARY KEY,
  first_name    varchar2(10) NOT NULL,
  last_name     varchar2(10) NOT NULL,
  email         varchar2(10),
  phone_number  varchar2(20),
  regist_date   date
);

-- drop table CUSTORMERS;
-- DML 
INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (1, 'JIHEON', 'HA', 'JIHEON@', '010-134-1234', '2024/06/13');

SELECT * FROM CUSTOMERS;

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (2, 'DAHYUN', 'LEE', 'DAHYUN@', '010-111-1234', '20240613');

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (3, 'JUHO', 'JEONG', 'JEONG@', '010-2222-1234', '2024-06-13');

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (4, 'HANUL', 'LEE', 'HANUL@', '010-3333-1234', '2024-06-13');

INSERT INTO CUSTOMERS (CUSTOMER_ID, FIRST_NAME, LAST_NAME, EMAIL, PHONE_NUMBER, REGIST_DATE)
VALUES (5, 'KILDONG', 'HONG', 'HONG@', '010-444-1234', SYSDATE);


SELECT *
  FROM USER_INDEXES
 WHERE TABLE_NAME = 'CUSTOMERS';

SELECT *
  FROM USER_IND_COLUMNS
 WHERE TABLE_NAME = 'CUSTOMERS';
 
CREATE INDEX idx_customer_registdate
   ON CUSTOMERS ( regist_date );
   
select to_char(regist_date, 'yyyy/mm/dd hh24:mi:ss')
  from customers
 where TO_CHAR(regist_date, 'YYYYMMDD') = '20240613';

select to_char(regist_date, 'yyyy/mm/dd hh24:mi:ss')
  from customers
 where regist_date = '2024/06/13';

-- 고유 인덱스   
CREATE UNIQUE INDEX idx_customer_email
   ON customers ( email );


-- 중간문제
CREATE TABLE products
(
    product_id      number          NOT NULL PRIMARY KEY,
    product_name    varchar2(10)    NOT NULL,
    reg_date        date,
    weight          number,
    price           number
);

INSERT INTO products (product_id, product_name, reg_date, weight, price)
VALUES (1, 'Computer', '2024/01/01', 10, 1600000);

INSERT INTO products (product_id, product_name, reg_date, weight, price)
VALUES (2, 'Smartphone', '2024/02/01', 0.2, 1000000);

INSERT INTO products (product_id, product_name, reg_date, weight, price)
VALUES (3, 'Television', '2024/03/01', 20, 2000000);

delete from products;
commit;

select * from products;

-- 13 - 3
-- 뷰: 가상 테이블

select e.first_name || ' ' || e.last_name as 직원명
     , e.department_name
     , e.job_title
     , mgr.first_name || ' ' || mgr.last_name  as 관리자명
  from emp_details_view e, employees mgr
 where e.manager_id = mgr.employee_id;

-- 13-15
CREATE OR REPLACE VIEW VW_EMP20
    AS (SELECT EMPNO, ENAME, JOB, DEPTNO
          FROM EMP
         WHERE DEPTNO = 20);
         
SELECT * 
  FROM USER_VIEWS;
  
SELECT VIEW_NAME, TEXT_LENGTH, TEXT
  FROM USER_VIEWS;
-- 13-18  
SELECT * 
  FROM VW_EMP20;
  
-- 1분 복습
-- 부서 번호가 30인 사원 정보의 모든 열을 출력하는 VM_EMP30ALL 뷰
-- SQL을 작성해보세요
CREATE OR REPLACE VIEW VW_EMP30ALL
   AS (SELECT *
         FROM EMP
        WHERE DEPTNO = 30);
        
SELECT * FROM USER_VIEWS;

-- 뷰삭제
DROP VIEW VW_EMP20;

-- 인라인 뷰를 사용한 TOP-N SQL문
--13-20  -- ROWNUM 을 추가로 조회하기
SELECT ROWNUM, E.*
  FROM EMP E;
  
--13-21 SAL 열 기준으로 정렬
SELECT ROWNUM, E.*
  FROM EMP E
 ORDER BY SAL DESC;
 
 -- 단순뷰: 하나의 테이블
 -- 복합뷰: 두개 이상 테이블 조인해서 만든 뷰
 -- 인라인뷰: SELECT FROM절에 기술된 SELECT문
 
 --13-22
 SELECT ROWNUM, E.*
   FROM (SELECT *
           FROM EMP 
          ORDER BY SAL DESC) E;

WITH E AS 
( SELECT *
    FROM EMP
   ORDER BY SAL DESC )
SELECT ROWNUM, E.*
  FROM E;
          
 SELECT ROWNUM, E.*
   FROM (SELECT *
           FROM EMP 
          ORDER BY SAL DESC) E
  WHERE ROWNUM <= 3;
  
WITH E AS 
( SELECT *
    FROM EMP
   ORDER BY SAL DESC )
SELECT ROWNUM, E.*
  FROM E
 WHERE ROWNUM <= 3;

 SELECT EE.RN, EE.EMPNO, EE.ENAME, EE.SAL
  FROM (  SELECT ROWNUM AS RN, E.*
            FROM (SELECT *
                    FROM EMP 
                   ORDER BY SAL DESC) E ) EE
 WHERE EE.RN BETWEEN 11 AND 14;

 -- 13-4 시퀀스
 SELECT MAX(EMPNO) + 1
   FROM EMP;
   
 SELECT MAX(EMPNO)
   FROM EMP;   
   
CREATE TABLE DEPT_SEQUENCE
    AS SELECT *
         FROM DEPT
        WHERE 1 <> 1;
-- 13-27
CREATE SEQUENCE SEQ_DEPT_SEQUENCE
    INCREMENT BY 10
    START WITH 10
    MAXVALUE 90
    MINVALUE 0
    NOCYCLE
    CACHE 2;
    
SELECT *
  FROM USER_SEQUENCES;
        
-- 시퀀스 사용 PAGE 350
INSERT INTO DEPT_SEQUENCE (DEPTNO, DNAME, LOC)
VALUES(SEQ_DEPT_SEQUENCE.NEXTVAL, 'DATABASE', 'SEOUL');
    
SELECT * FROM DEPT_SEQUENCE ORDER BY DEPTNO DESC;    


SELECT SEQ_DEPT_SEQUENCE.NEXTVAL
  FROM DUAL;

SELECT SEQ_DEPT_SEQUENCE.CURRVAL
  FROM DUAL;
   
--13-32
ALTER SEQUENCE SEQ_DEPT_SEQUENCE
INCREMENT BY 3
MAXVALUE 99
CYCLE;

 SELECT * FROM USER_SEQUENCES;
-- page 356
 -- 13-5 동의어  synonym
 
create synonym E
   for emp;
   
select * from e;   

drop synonym e;

-- 잊기전에 한번더
--1-1
create table EMPIDX
 AS SELECT * FROM EMP;
 
 SELECT * FROM EMPIDX;
 
 CREATE INDEX IDX_EMPIDX_EMPNO
     ON EMPIDX (EMPNO);
     
SELECT *  FROM USER_INDEXES
WHERE TABLE_NAME = 'EMPIDX';

SELECT *  FROM USER_IND_COLUMNS
WHERE TABLE_NAME = 'EMPIDX';

CREATE OR REPLACE VIEW EMPIDX_OVER15K
AS (SELECT EMPNO, ENAME, JOB, DEPTNO, SAL
         , NVL2(COMM, 'O', 'X') AS COMM
      FROM EMPIDX
     WHERE SAL > 1500);

SELECT * FROM USER_VIEWS;

-- Q3 - 1   
CREATE TABLE DEPTSEQ
    AS SELECT * FROM DEPT;
-- Q3 - 2
CREATE SEQUENCE SEQ_DEPTSEQ
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 99
    MINVALUE 1
    NOCYCLE
    NOCACHE;
   
-- Q3 - 3
INSERT INTO DEPTSEQ (DEPTNO, DNAME, LOC) 
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'DATABASE', 'SELOUL');

INSERT INTO DEPTSEQ (DEPTNO, DNAME, LOC) 
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'WEB', 'BUSAN');

INSERT INTO DEPTSEQ (DEPTNO, DNAME, LOC) 
VALUES (SEQ_DEPTSEQ.NEXTVAL, 'MOBILE', 'ILSAN');


SELECT * FROM DEPTSEQ;

COMMIT;