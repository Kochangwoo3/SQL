-- 6��
-- ���� �����͸� �����ϴ� �����Լ�  page 130
-- 6-1 UPPER, LOWER, INITCAP
SELECT ENAME, UPPER(ENAME), LOWER(ENAME), INITCAP(ENAME)
  FROM EMP;
  
-- 6-2  
SELECT *
  FROM EMP
 WHERE lower(ENAME) = lower('Scott');
 
 -- 6-3
SELECT *
  FROM EMP
 WHERE UPPER(ENAME) LIKE UPPER('%Scott%');
 
-- 6-4 ���ڿ����̸� ���ϴ� LENGTH �Լ�
SELECT ENAME, LENGTH(ENAME)
  FROM EMP;
  
-- 6-5 ��� �̸��� ���̰� 5�̻��� �� ���
SELECT ENAME, LENGTH(ENAME)
  FROM EMP
 WHERE LENGTH(ENAME) >= 5;
 
 -- 6-6 
 SELECT LENGTH('�ѱ�'), LENGTHB('�ѱ�')
   FROM DUAL;
   
SELECT SYSDATE FROM DUAL;

--1�� ����: ��å �̸��� 6���� �̻��� ������ ��� ���� �ۼ�
SELECT *
  FROM EMP
 WHERE LENGTH(JOB) >= 6;
 
-- �߿�: ���ڿ� �Ϻθ� �����ϴ� SUBSTR(�÷���, ������ġ, �������) �Լ� 
-- 6-7
SELECT JOB 
    --, SUBSTR(JOB, 1, 2)  -- �ε��� �ƴ� 1���� ����
    -- , SUBSTR(JOB, 3, 2)
    -- , SUBSTR(JOB, 5)
     , SUBSTR(JOB, -5) 
  FROM EMP;
 
SELECT JOB
     , SUBSTR(JOB, -LENGTH(JOB))  -- ó������ ������
     , SUBSTR(JOB, -LENGTH(JOB), 2)
     , SUBSTR(JOB, -3)
  FROM EMP;
 
-- INSTR
SELECT INSTR('HELLO, ORACLE!', 'L') AS INSTR_1
     , INSTR('HELLO, ORACLE!', 'L', 5) AS INSTR_1
     , INSTR('HELLO, ORACLE!', 'L', 2, 2) AS INSTR_1  -- 4
  FROM DUAL;

-- 6-10 INSTR �Լ��� ����̸��� S�� �ִ� �� ���ϱ�
SELECT *
  FROM EMP
 WHERE INSTR(ENAME, 'S') > 0;
 
--6-11
SELECT *
  FROM EMP
 WHERE ENAME LIKE '%S%';

-- 6-12 �߿�: REPLACE 
SELECT '010-1234-5678' AS REPLACE_BEFORE
     , REPLACE('010-1234-5678', '-', ' ') AS REPLACE_1
     , REPLACE('010-1234-5678', '-') AS REPLACE_2
  FROM DUAL;
  
-- LPAD, RPAD
SELECT 'Oracle'
     , LPAD('Oracle', 10, '#') AS LPAD_1
     , RPAD('Oracle', 10, '*') AS RPAD_1
     , LPAD('Oracle', 10) AS LPAD_2
     , RPAD('Oracle', 10) AS RPAD_2
  FROM DUAL;
  
-- 6-14 �������� ����ŷ ó�� 
--   SUBSTR(JUMIN, 1, 7)
SELECT RPAD('971225-', 14, '*') AS RPAD_JMNO
     , RPAD('010-1234-', 13, '*') AS RPAD_PHONE
  FROM DUAL;

-- 6-15 �� �� ���̿�  ������(|)
SELECT CONCAT(EMPNO, ENAME)
     , CONCAT(EMPNO, CONCAT('|', ENAME))
     , EMPNO || '|' || ENAME
  FROM EMP
 WHERE DEPTNO = 10;
 
-- 6-16 
SELECT TRIM('    __Oracle__   ') AS T
     , TRIM(LEADING FROM '    __Oracle__   ') AS LTRIM
     , TRIM(TRAILING FROM '    __Oracle__   ') AS RTRIM
     , TRIM(BOTH FROM '    __Oracle__   ') AS TRIM
  FROM DUAL;

-- 6-17
SELECT TRIM('_' FROM '__Oracle__') AS T
     , TRIM(LEADING '_' FROM '__Oracle__') AS LTRIM
     , TRIM(TRAILING '_' FROM '__Oracle__') AS RTRIM
     , TRIM(BOTH '_' FROM '__Oracle__') AS TRIM
  FROM DUAL;

-- 6-18
SELECT TRIM('   __Oracle__    ') AS T
     , LTRIM('    __Oracle__    ') AS LTRIM
     , RTRIM('   __Oracle__   ') AS RTRIM
     , LTRIM('__Oracle__', '_') AS LTRIM
     , RTRIM('__Oracle__', '_') AS RTRIM
  FROM DUAL;
  
-- �߰�����
SELECT job_title, LOWER(job_title), UPPER(job_title)
  FROM jobs;

SELECT SUBSTR(first_name,1,1), last_name
  FROM employees;
  
SELECT job_id, REPLACE(job_id, 'REP', 'REPRESENTATIVE') AS REPL
  FROM employees;
  
SELECT CONCAT(SUBSTR(first_name,1,1), CONCAT(' ', last_name))
     , SUBSTR(first_name,1,1) ||  ' ' || last_name
  FROM employees;


SELECT LENGTH(first_name) + LENGTH(last_name)
  FROM employees;
  
SELECT job_id, INSTR(job_id, 'A')
  FROM employees;
  
SELECT LPAD(city, 15, '.'), RPAD(city, 15, '.')
  FROM locations;
  
SELECT city, LTRIM(city, 'S'), RTRIM(city, 'e')
  FROM locations
 WHERE city like 'S%' or city like '%e' ;
 
 -- 06 - 3�� ���� �Լ�
SELECT ROUND(1234.5678) AS ROUND
     , ROUND(1234.5678, 0) AS ROUND0 -- �Ҽ��� ù° �ڸ����� �ݿø�
     , ROUND(1234.5678, 1) AS ROUND1 -- �Ҽ��� ��° �ڸ����� �ݿø� ���
     , ROUND(1234.5678, 2) AS ROUND2 -- ��° �ڸ����� �ݿø� 
     , ROUND(1234.5678, -1) AS ROUND_M1  -- �ڿ��� ù°�ڸ����� �ݿø�
     , ROUND(1234.5678, -2) AS ROUND_M2  -- �ڿ��� ��°�ڸ����� �ݿø�
  FROM DUAL;
  
-- 6-20  
SELECT TRUNC(1234.5678) AS TRUNC
     , TRUNC(1234.5678, 0) AS TRUNC0 -- �Ҽ��� ù° �ڸ����� ����
     , TRUNC(1234.5678, 1) AS TRUNC1 -- �Ҽ��� ��° �ڸ����� ���� ���
     , TRUNC(1234.5678, 2) AS TRUNC2 -- ��° �ڸ����� ���� 
     , TRUNC(1234.5678, -1) AS TRUNC_M1  -- �ڿ��� ù°�ڸ����� ����
     , TRUNC(1234.5678, -2) AS TRUNC_M2  -- �ڿ��� ��°�ڸ����� ����
  FROM DUAL;  
  
-- 6-21
SELECT CEIL(3.14)
     , FLOOR(3.14)
     , CEIL(-3.14) -- -3
     , FLOOR(-3.14) -- -4
  FROM DUAL;
  
-- 6-22 MOD �Լ� = ������ 
SELECT MOD(15, 6) -- 3
     , MOD(10, 2) -- 0
     , MOD(11, 2) -- 1
  FROM DUAL;
     
-- ��¥ �Լ�
-- 6-23
SELECT SYSDATE AS NOW
     , SYSDATE -1 AS YESTERDAY
     , SYSDATE +1 AS TOMORROW
  FROM DUAL;

-- 6-24
SELECT SYSDATE
     , ADD_MONTHS(SYSDATE, 4)  + 17
  FROM DUAL;
  
--6-25 �Ի� 10�ֳ�
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 120) AS WORK10YEAR
  FROM EMP;
  
SELECT  12 * 38 FROM DUAL;  -- 456

SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
  FROM EMP;
 
 -- 6- 26 �Ի� 38�� �̸��� ��� 
SELECT EMPNO, ENAME, HIREDATE,
       ADD_MONTHS(HIREDATE, 456) AS WORK38YEAR
  FROM EMP
 WHERE ADD_MONTHS(HIREDATE, 456) > SYSDATE;

SELECT SYSDATE, ADD_MONTHS(SYSDATE, 3) EMPL
  FROM DUAL;
-- 6-27
SELECT EMPNO, ENAME, HIREDATE, SYSDATE
    , MONTHS_BETWEEN(SYSDATE, HIREDATE) AS MONTHS
    , TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)) AS MONTHS2
  FROM EMP;
 
-- 6-28
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����'), LAST_DAY(SYSDATE)
  FROM DUAL;
 
-- 6-33
SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD HH24:MI:SS') SYSD
     , TO_CHAR(SYSDATE, 'YYYY') YYYY
     , TO_CHAR(SYSDATE, 'DAY') DAY
     , TO_CHAR(SYSDATE, 'DY') DY
     , TO_CHAR(SYSDATE, 'DD') DD
     , TO_CHAR(SYSDATE, 'MONTH') MONTH
     , TO_CHAR(SYSDATE, 'MON') MON
     , TO_CHAR(SYSDATE, 'MM') MON
  FROM DUAL;
  
-- 6-35
SELECT TO_CHAR(SYSDATE, 'MM') MM
     , TO_CHAR(SYSDATE, 'MON') MM 
     , TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') MON_JPN
     , TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') MON_ENG
  FROM DUAL;

-- 6-38 ��������
SELECT SAL, TO_CHAR(SAL, '999,999') SAL_1
     , TO_CHAR(SAL, '$999,999') SAL_1
     , TO_CHAR(SAL, 'L999,999') SAL_1
     , TO_CHAR(SAL, '0009999999') SAL_2
  FROM EMP;

-- ���ڿ� �� ���ڷ�  
SELECT TO_NUMBER('1,300', '999,999')  
     - TO_NUMBER('1,500', '999,999')
  FROM DUAL;

-- ���ڿ��� ��¥ ����Ÿ ��ȯ
SELECT TO_DATE('2024-06-05', 'YYYY-MM-DD') AS TODATE
     , TO_DATE('20240605', 'YYYY-MM-DD') AS TODATE2
  FROM DUAL;

-- 6-45
SELECT EMPNO, ENAME, SAL, COMM
     , SAL*12+NVL(COMM,0) AS ANNSAL
     , NVL2(COMM, '�ξƴ�', '����') N2
     --         �����ִٸ�, ������
     , NVL2(COMM, SAL*12+COMM, SAL*12) ANN_SAL
  FROM EMP;
  
--6-47
SELECT EMPNO, ENAME, JOB, SAL
     , DECODE(JOB, 'MANAGER', SAL*1.1, 'SALESMAN', SAL*1.05,
                'ANALYST', SAL, SAL*1.03) AS UPSAL
   FROM EMP;
-- CASE ��
SELECT EMPNO, ENAME, JOB, SAL
     , CASE JOB
            WHEN 'MANAGER'  THEN SAL*1.1
            WHEN 'SALESMAN' THEN SAL*1.05
            WHEN 'ANALYST'  THEN SAL
            ELSE SAL*1.03
       END AS UPSAL
   FROM EMP;
   
SELECT EMPNO, ENAME, COMM
     , CASE WHEN COMM IS NULL THEN '�ش���� ����'
            WHEN COMM = 0 THEN '�������'
            WHEN COMM > 0 THEN '���� : ' || COMM
       END AS COMM_TEXT
  FROM EMP;
   


  
  

  
  
