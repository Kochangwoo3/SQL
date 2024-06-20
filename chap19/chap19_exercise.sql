-- 19��  ���� �������α׷�
-- 19-1
CREATE OR REPLACE PROCEDURE PRO_NOPARAM
IS
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO: ' || V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME: ' || V_ENAME);
END;
/
SET SERVEROUTPUT ON;

-- ����: EXECUTE / EXEC ��ɾ� ���
EXEC PRO_NOPARAM;

-- �͸� ��Ͽ��� ���ν��� �����ϱ�
BEGIN
    PRO_NOPARAM;
END;
/

SELECT *
  FROM USER_SOURCE
 WHERE NAME = 'PRO_NOPARAM';

DROP PROCEDURE PRO_NOPARAM;


-- 19-7
CREATE OR REPLACE PROCEDURE pro_param_in
(
    param1 IN NUMBER,
    param2 NUMBER,
    param3 NUMBER := 3,
    param4 NUMBER DEFAULT 4
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('param1 : ' || param1);
    DBMS_OUTPUT.PUT_LINE('param2 : ' || param2);
    DBMS_OUTPUT.PUT_LINE('param3 : ' || param3);
    DBMS_OUTPUT.PUT_LINE('param4 : ' || param4);
END;
/

EXECUTE PRO_PARAM_IN(1, 2, 9, 8);

EXECUTE PRO_PARAM_IN(1, 2);

EXECUTE PRO_PARAM_IN(1);

-- 19-11 �Ķ���� �̸��� Ȱ���Ͽ� ���ν����� �� �Է��ϱ�
EXECUTE PRO_PARAM_IN(param2 => 20, param1 => 10);

-- OUT ��� �Ķ���� �����ϱ�
CREATE OR REPLACE PROCEDURE pro_param_out
(
    in_empno IN EMP.EMPNO%TYPE,
    out_ename OUT EMP.ENAME%TYPE,
    out_sal OUT EMP.SAL%TYPE
)
IS
BEGIN
    SELECT ENAME, SAL 
      INTO out_ename, out_sal
      FROM EMP
     WHERE EMPNO = in_empno;
END pro_param_out;
/
select ename, sal from emp where empno = 7788;

DECLARE
    v_ename EMP.ENAME%TYPE;
    v_sal EMP.SAL%TYPE;
BEGIN
    PRO_PARAM_OUT(7654, v_ename, v_sal);
    DBMS_OUTPUT.PUT_LINE('ENAME : ' || v_ename);
    DBMS_OUTPUT.PUT_LINE('SAL : ' || v_sal);
END;
/

-- 19-14 IN - OUT ���
CREATE OR REPLACE PROCEDURE pro_param_inout
(
    inout_no IN OUT NUMBER
)
IS

BEGIN
    inout_no := inout_no * 2;
END;
/

DECLARE
    no NUMBER;
BEGIN
    no := 5;
    pro_param_inout(no);
    DBMS_OUTPUT.PUT_LINE('no :' || no);
END;
/

-- 19-16
CREATE OR REPLACE PROCEDURE pro_err
IS
    err_no NUMBER;
BEGIN
    err_no := 100;   -- :=
    DBMS_OUTPUT.PUT_LINE('err_no : ' || err_no);
END;
/

show errors;

SELECT *
  FROM USER_ERRORS
 WHERE NAME = 'PRO_ERR';

-- ���� ��� ��� ���ν���
CREATE OR REPLACE PROCEDURE emp_avg_salary
(   avg_salary OUT NUMBER
) AS
BEGIN
    SELECT AVG(SAL)
      INTO avg_salary
      FROM EMP;
END emp_avg_salary;
/

DECLARE
    avg_sal NUMBER;
BEGIN
    emp_avg_salary(avg_sal);
    DBMS_OUTPUT.PUT_LINE(TRUNC(avg_sal));
END;
/

-- IF   ELSE �� ��� ���ν���
CREATE OR REPLACE PROCEDURE if_salary (
    salary IN  NUMBER
) AS
    avg_salary NUMBER;
BEGIN
    SELECT AVG(SAL) -- 2073.--- 
      INTO avg_salary
      FROM EMP;
      
    IF salary >= avg_salary THEN
        DBMS_OUTPUT.PUT_LINE('��� �̻�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('��� �̸�');
    END IF;
END;
/

EXECUTE if_salary(2000);

SELECT HIRE_DATE , EMAIL
  FROM EMPLOYEES;

-- CASE �� ��� ���ν���
CREATE OR REPLACE PROCEDURE  case_hire_date (
    emp_email  IN EMPLOYEES.EMAIL%TYPE
) AS
    hire_year  NCHAR(2);
    text_msg   VARCHAR2(20);
BEGIN
    SELECT TO_CHAR(HIRE_DATE, 'YY') INTO hire_year
      FROM EMPLOYEES
     WHERE EMAIL = emp_email;
   
    CASE
        WHEN (hire_year = '01') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '02') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '03') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '04') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '05') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '06') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '07') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '08') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        WHEN (hire_year = '09') THEN  text_msg := hire_year || '�⵵�� �Ի�';
        ELSE text_msg := '01~09�⵵ �̿ܿ� �Ի�';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(text_msg);
END;
/

select * from employees where email = 'SKING';
EXECUTE case_hire_date('SKING');

select first_name, last_name from employees;

-- IN   OUT  �Ķ���� ���  EXCEPTION ó�� ���ν���
CREATE OR REPLACE PROCEDURE in_out_emp (
    emp_name IN OUT VARCHAR2
) AS
BEGIN
    SELECT first_name || ' ' || last_name  INTO emp_name
      FROM employees
     WHERE first_name = emp_name OR last_name = emp_name;
     emp_name := '����: ' || emp_name;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           emp_name := '����: ����';  
END; 
/
     


DECLARE
    emp_name VARCHAR2(20)  := 'Kang';
BEGIN
    in_out_emp(emp_name);
    
    DBMS_OUTPUT.PUT_LINE(emp_name);
END;

 CURSOR �� �̿��� EMPLOYEES ���̺�
JOB_ID �� IT_PROG �� ������ FIRST_NAME �� LAST_NAME 
�� ������ �ΰ� �����Ͽ� ����ϴ� ���ν��� ����

CREATE OR REPLACE PROCEDURE cursor_it_prog 
IS
    fname VARCHAR2(20);
    lname VARCHAR2(20);
    jobid VARCHAR2(20);
    CURSOR emp_cursor IS
        SELECT first_name, last_name, job_id
          FROM employees;
BEGIN
    OPEN emp_cursor;
    LOOP
        FETCH emp_cursor INTO fname, lname, jobid;
        EXIT WHEN emp_cursor%NOTFOUND;
        IF jobid = 'IT_PROG' THEN
            DBMS_OUTPUT.PUT_LINE(fname || ' ' || lname);
        END IF;
    END LOOP;
END;
/


select first_name, last_name, job_id
  from employees
 where job_id = 'IT_PROG';
 
 EXECUTE cursor_it_prog();
 

CREATE OR REPLACE PROCEDURE if_minmax_salary 
(   
    salary IN NUMBER
)
IS
    avg_min_salary NUMBER;
    avg_max_salary NUMBER;
BEGIN
    SELECT AVG(MIN_SALARY), AVG(MAX_SALARY)
      INTO avg_min_salary, avg_max_salary
      FROM JOBS;  -- 7131, 14231

    IF  salary <= avg_min_salary  THEN  
        DBMS_OUTPUT.PUT_LINE('���� ��� ����');
    ELSIF salary >= avg_max_salary THEN
        DBMS_OUTPUT.PUT_LINE('�ִ� ��� �̻�');
    ELSE
        DBMS_OUTPUT.PUT_LINE('��� ����');
    END IF;
END;
/

EXECUTE if_minmax_salary(5000);

EXECUTE if_minmax_salary(10000);

EXECUTE if_minmax_salary(15000);

select * from nls_database_parameters
where parameter = 'NLS_CHARACTERSET';
-- AL32UTF8: �ѱ� 3BYTE
-- KO16KSC5601 : �ϼ��� �ѱ� 2BYTE
-- KO16MSWIN949 : ������ �ѱ� 2BYTE


SELECT LENGTHB('�ȳ�') FROM DUAL;

--19-19
CREATE OR REPLACE FUNCTION func_aftertax(
    sal IN NUMBER
) 
RETURN NUMBER
IS
    tax NUMBER := 0.05;
BEGIN
    RETURN   ROUND(sal - (sal * tax));
END func_aftertax;
/

select func_aftertax(3000) from dual;

select ename, sal beforesal, func_aftertax(sal) as aftersal
  from emp;

DROP FUNCTION func_aftertax;

-- ��Ű�� �����ϱ�

CREATE OR REPLACE PACKAGE pkg_example
IS
    spec_no NUMBER := 10;
    FUNCTION func_aftertax(sal NUMBER) RETURN  NUMBER;
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE);
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE);
END;
/

SELECT TEXT
  FROM USER_SOURCE
 WHERE TYPE = 'PACKAGE'
   AND NAME = 'PKG_EXAMPLE';

desc pkg_example;

-- ��Ű�� ���� �����ϱ�
-- 19-27
CREATE OR REPLACE PACKAGE BODY pkg_example
IS
    body_no NUMBER := 10;
    
    FUNCTION func_aftertax(sal NUMBER) 
    RETURN NUMBER
    IS
        tax NUMBER := 0.05;
    BEGIN
        RETURN ROUND(SAL - (SAL*tax));
    END func_aftertax;
    
    PROCEDURE pro_emp(in_empno IN EMP.EMPNO%TYPE)
    IS 
        out_ename EMP.ENAME%TYPE;
        out_sal EMP.SAL%TYPE;
    BEGIN
        select ename, sal
          into out_ename, out_sal
          from emp
         where empno = in_empno;
         
         DBMS_OUTPUT.PUT_LINE ('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE ('SAL : ' || out_sal);
    END pro_emp;
     
    PROCEDURE pro_dept(in_deptno IN DEPT.DEPTNO%TYPE)
    IS
        out_dname DEPT.DNAME%TYPE;
        out_loc DEPT.LOC%TYPE;
    BEGIN
        SELECT DNAME, LOC
          INTO out_dname,  out_loc
          FROM DEPT
         WHERE DEPTNO = in_deptno;
         
         DBMS_OUTPUT.PUT_LINE ('DNAME : ' || out_dname);
         DBMS_OUTPUT.PUT_LINE ('LOC : ' || out_loc);
    END pro_dept;
END;
/

-- ���ν��� �����ε��ϱ�
CREATE OR REPLACE PACKAGE pkg_overload
IS
    PROCEDURE pro_emp(in_empno IN  EMP.EMPNO%TYPE);
    PROCEDURE pro_emp(in_ename IN  EMP.ENAME%TYPE);
END;
/

CREATE OR REPLACE PACKAGE BODY pkg_overload
IS 
    PROCEDURE pro_emp(in_empno IN  EMP.EMPNO%TYPE)
    IS
        out_ename EMP.ENAME%TYPE;
        out_sal EMP.SAL%TYPE;
    BEGIN
        SELECT ENAME, SAL INTO out_ename, out_sal
          FROM EMP
         WHERE EMPNO = in_empno;
         
         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
         
    END pro_emp;
    
    PROCEDURE pro_emp(in_ename IN  EMP.ENAME%TYPE)
    IS
        out_ename EMP.ENAME%TYPE;
        out_sal EMP.SAL%TYPE;
    BEGIN
        SELECT ENAME, SAL INTO out_ename, out_sal
          FROM EMP
         WHERE ENAME = in_ename;
         
         DBMS_OUTPUT.PUT_LINE('ENAME : ' || out_ename);
         DBMS_OUTPUT.PUT_LINE('SAL : ' || out_sal);
    END pro_emp;
END;
/
  
-- �ǽ� 19-30 
BEGIN
    DBMS_OUTPUT.PUT_LINE('-- pkg_example.func_aftertax(3000) -- ');
    DBMS_OUTPUT.PUT_LINE('after-tax : ' || pkg_example.func_aftertax(3000));
    
    DBMS_OUTPUT.PUT_LINE('-- pkg_example.pro_emp(7788) -- ');
    pkg_example.pro_emp(7788);
    
    DBMS_OUTPUT.PUT_LINE('-- pkg_example.pro_dept(10) -- ');
    pkg_example.pro_dept(10);
   
    DBMS_OUTPUT.PUT_LINE('-- pkg_overload.pro_emp(7788) --');
    pkg_overload.pro_emp(7788);
   
    DBMS_OUTPUT.PUT_LINE('-- pkg_overload.pro_emp(''SCOTT'') --');
    pkg_overload.pro_emp('SCOTT');
END;
/
  
SELECT TO_CHAR(sysdate, 'DY') FROM DUAL;

-- �ǽ� 19-31
CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;
SELECT * FROM EMP_TRG;

CREATE OR REPLACE TRIGGER nodml_weekend
BEFORE 
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR(sysdate, 'DY') IN ('��', '��') THEN
        IF INSERTING THEN
            raise_application_error(-20000, '�ָ� ������� �߰� �Ұ�');
        ELSIF UPDATING THEN
            raise_application_error(-20001, '�ָ� ������� ���� �Ұ�');
        ELSIF DELETING THEN
            raise_application_error(-20002, '�ָ� ������� ���� �Ұ�');
        ELSE
            raise_application_error(-20003, '�ָ� ������� ���� �Ұ�');
        END IF;
    END IF;
END;
/

SELECT * FROM EMP_TRG WHERE EMPNO = 7788;
UPDATE EMP_TRG SET SAL = 3500 WHERE EMPNO = 7788;


CREATE TABLE EMP_TRG_LOG(
    TABLE_NAME varchar2(10), --  dml ����� ���̺� �̸�
    DML_TYPE  varchar2(10),  -- insert, update, delete
    EMPNO NUMBER(4),         -- DML ����� �� �����ȣ
    USER_NAME VARCHAR2(30),   -- DML ���� �� USER�̸�
    CHANGE_DATE DATE         -- DML ����� ��¥
);


CREATE OR REPLACE TRIGGER trg_emp_log
AFTER
INSERT OR UPDATE OR DELETE ON EMP_TRG
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'INSERT', :new.empno, 
                sys_context('USERENV', 'SESSION_USER'), SYSDATE);
    ELSIF UPDATING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'UPDATE', :old.empno, 
                sys_context('USERENV', 'SESSION_USER'), SYSDATE);
    ELSIF DELETING THEN
        INSERT INTO EMP_TRG_LOG
        VALUES ('EMP_TRG', 'DELETE', :old.empno, 
                sys_context('USERENV', 'SESSION_USER'), SYSDATE);
    END IF;
END;
/

SELECT * FROM EMP_TRG_LOG;


INSERT INTO EMP_TRG
VALUES(9999, 'TestEmp', 'CLERK', 7788,
    '2024-06-18', 1200, NULL, 20);

COMMIT;

SELECT *
  FROM EMP_TRG
 WHERE MGR = 7788;


UPDATE EMP_TRG
   SET SAL = 1300
  WHERE MGR = 7788;

COMMIT;

SELECT TRIGGER_NAME, TRIGGER_TYPE,
      TABLE_NAME, STATUS
  FROM USER_TRIGGERS;  
  
-- �߰� ����
-- �Լ�
CREATE OR REPLACE FUNCTION to_yyyymmdd(dt Date)
RETURN VARCHAR2
IS
    char_date VARCHAR2(20);
BEGIN
    char_date := TO_CHAR(dt, 'YYYYMMDD');
    RETURN char_date;
END;
/
SELECT TO_YYYYMMDD(SYSDATE) FROM DUAL;

CREATE OR REPLACE FUNCTION get_age(dt Date)
RETURN NUMBER
IS
    age NUMBER;
BEGIN
    age := TRUNC(months_between(    TRUNC(SYSDATE)  , 
                                    TO_YYYYMMDD(dt)   ) / 12   );
    RETURN age;                 
END;
/

select get_age('20010101') from dual;

SELECT TRUNC(months_between(    TRUNC(SYSDATE)  , 
                 TO_YYYYMMDD(TO_DATE('20010101', 'YYYYMMDD'))   ) / 12   ) as age
FROM DUAL;

SELECT TRUNC(SYSDATE) FROM DUAL;
SELECT TO_YYYYMMDD(TO_DATE('20010101', 'YYYYMMDD')) FROM DUAL;

CREATE OR REPLACE FUNCTION add_num( in_num1 INTEGER, in_num2 INTEGER)
RETURN INTEGER
IS
BEGIN
    RETURN in_num1 + in_num2;
END;
/
select add_num(23, 2) from dual;


