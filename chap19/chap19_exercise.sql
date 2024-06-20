-- 19장  저장 서브프로그램
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

-- 실행: EXECUTE / EXEC 명령어 사용
EXEC PRO_NOPARAM;

-- 익명 블록에서 프로시저 실행하기
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

-- 19-11 파라미터 이름을 활용하여 프로시저에 값 입력하기
EXECUTE PRO_PARAM_IN(param2 => 20, param1 => 10);

-- OUT 모드 파라미터 정의하기
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

-- 19-14 IN - OUT 모드
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

-- 직원 평균 출력 프로시저
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

-- IF   ELSE 문 사용 프로시저
CREATE OR REPLACE PROCEDURE if_salary (
    salary IN  NUMBER
) AS
    avg_salary NUMBER;
BEGIN
    SELECT AVG(SAL) -- 2073.--- 
      INTO avg_salary
      FROM EMP;
      
    IF salary >= avg_salary THEN
        DBMS_OUTPUT.PUT_LINE('평균 이상');
    ELSE
        DBMS_OUTPUT.PUT_LINE('평균 미만');
    END IF;
END;
/

EXECUTE if_salary(2000);

SELECT HIRE_DATE , EMAIL
  FROM EMPLOYEES;

-- CASE 문 사용 프로시저
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
        WHEN (hire_year = '01') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '02') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '03') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '04') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '05') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '06') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '07') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '08') THEN  text_msg := hire_year || '년도에 입사';
        WHEN (hire_year = '09') THEN  text_msg := hire_year || '년도에 입사';
        ELSE text_msg := '01~09년도 이외에 입사';
    END CASE;
    DBMS_OUTPUT.PUT_LINE(text_msg);
END;
/

select * from employees where email = 'SKING';
EXECUTE case_hire_date('SKING');

select first_name, last_name from employees;

-- IN   OUT  파라미터 사용  EXCEPTION 처리 프로시저
CREATE OR REPLACE PROCEDURE in_out_emp (
    emp_name IN OUT VARCHAR2
) AS
BEGIN
    SELECT first_name || ' ' || last_name  INTO emp_name
      FROM employees
     WHERE first_name = emp_name OR last_name = emp_name;
     emp_name := '직원: ' || emp_name;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
           emp_name := '직원: 없음';  
END; 
/
     


DECLARE
    emp_name VARCHAR2(20)  := 'Kang';
BEGIN
    in_out_emp(emp_name);
    
    DBMS_OUTPUT.PUT_LINE(emp_name);
END;

 CURSOR 를 이용해 EMPLOYEES 테이블에
JOB_ID 가 IT_PROG 인 직원의 FIRST_NAME 과 LAST_NAME 
을 공백을 두고 결합하여 출력하는 프로시저 정의

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
        DBMS_OUTPUT.PUT_LINE('최저 평균 이하');
    ELSIF salary >= avg_max_salary THEN
        DBMS_OUTPUT.PUT_LINE('최대 평균 이상');
    ELSE
        DBMS_OUTPUT.PUT_LINE('평균 구간');
    END IF;
END;
/

EXECUTE if_minmax_salary(5000);

EXECUTE if_minmax_salary(10000);

EXECUTE if_minmax_salary(15000);

select * from nls_database_parameters
where parameter = 'NLS_CHARACTERSET';
-- AL32UTF8: 한글 3BYTE
-- KO16KSC5601 : 완성형 한글 2BYTE
-- KO16MSWIN949 : 조합형 한글 2BYTE


SELECT LENGTHB('안녕') FROM DUAL;

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

-- 패키지 생성하기

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

-- 패키지 본문 생성하기
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

-- 프로시저 오버로드하기
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
  
-- 실습 19-30 
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

-- 실습 19-31
CREATE TABLE EMP_TRG
    AS SELECT * FROM EMP;
SELECT * FROM EMP_TRG;

CREATE OR REPLACE TRIGGER nodml_weekend
BEFORE 
INSERT OR UPDATE OR DELETE ON EMP_TRG
BEGIN
    IF TO_CHAR(sysdate, 'DY') IN ('토', '일') THEN
        IF INSERTING THEN
            raise_application_error(-20000, '주말 사원정보 추가 불가');
        ELSIF UPDATING THEN
            raise_application_error(-20001, '주말 사원정보 수정 불가');
        ELSIF DELETING THEN
            raise_application_error(-20002, '주말 사원정보 삭제 불가');
        ELSE
            raise_application_error(-20003, '주말 사원정보 변경 불가');
        END IF;
    END IF;
END;
/

SELECT * FROM EMP_TRG WHERE EMPNO = 7788;
UPDATE EMP_TRG SET SAL = 3500 WHERE EMPNO = 7788;


CREATE TABLE EMP_TRG_LOG(
    TABLE_NAME varchar2(10), --  dml 수행된 테이블 이름
    DML_TYPE  varchar2(10),  -- insert, update, delete
    EMPNO NUMBER(4),         -- DML 대상이 된 사원번호
    USER_NAME VARCHAR2(30),   -- DML 수행 한 USER이름
    CHANGE_DATE DATE         -- DML 수행된 날짜
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
  
-- 중간 문제
-- 함수
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


