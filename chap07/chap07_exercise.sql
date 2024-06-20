-- 7�� ������ �Լ��� ������ �׷�ȭ  
-- 7-1 
SELECT SUM(SAL)
  FROM EMP;
  
-- 7-2
SELECT DEPTNO, SUM(SAL)
  FROM EMP;
 --GROUP BY DEPTNO  ;
 
-- 7-3 ������ �Լ� : �ΰ� ���� ó��
SELECT SUM(COMM) AS "�߰� ���� �հ�"
  FROM EMP;  
  
-- 7-4 
SELECT SUM(DISTINCT SAL)
     , SUM(ALL SAL) 
     , SUM(SAL)
     , SUM(DISTINCT SAL) + 4250
  FROM EMP;

SELECT SAL FROM EMP;

SELECT DISTINCT SAL FROM EMP;

-- 7-5 EMP���̺� �� ���� -
SELECT COUNT(COMM)
     , COUNT(MGR)
     , COUNT(EMPNO)
     , COUNT(*)
     , COUNT(1)   -- �ǹ�
  FROM EMP;
  
-- 7-6 �μ���ȣ�� 30�� ������
SELECT COUNT(*)
  FROM EMP
 WHERE DEPTNO = 30;
 
--SELECT *
-- FROM EMP
-- WHERE DEPTNO = 30;
 
-- 7-7 
SELECT COUNT(DISTINCT SAL)
     , COUNT(ALL SAL)
     , COUNT(SAL)
  FROM EMP;  -- NULL �����ʹ� ��ȯ �������� ����
  
-- 7-8
SELECT COUNT(COMM)
  FROM EMP;    -- 4
-- 7-9
SELECT COUNT(COMM)
  FROM EMP
 WHERE COMM IS NOT NULL;  -- 4
 
-- 7-10  10�� �μ����� �ִ�޿� ���
SELECT MAX(SAL)
  FROM EMP
 WHERE DEPTNO = 10;

-- 7-11  10�� �μ����� �ּұ޿� ���
SELECT MIN(SAL)
  FROM EMP
 WHERE DEPTNO = 10; 

-- 7-12 20�� �μ����� ����� �Ի����� ���� �ֱ� �Ի��� ���
SELECT MAX(HIREDATE)
  FROM EMP
 WHERE DEPTNO = 20;    -- 1987/07/13
 
-- 7-13 20�� �μ����� ����� �Ի����� ���� ������ �Ի��� ���
SELECT MIN(HIREDATE)
  FROM EMP
 WHERE DEPTNO = 20;    -- 1980/12/17
 
-- STDDEV ǥ������,   VARIANCE �л� 
SELECT CEIL(STDDEV(SAL)), CEIL(VARIANCE(SAL))
  FROM EMP;
 
 
-- 7-14 �μ���ȣ�� 30 �� ������� ��� �޿� ���
SELECT CEIL(AVG(SAL)) -- �ø��� 
     , FLOOR(AVG(COMM)) -- ������
     , SIGN( 10 - 7 ) 
     , SIGN( 5 - 7 )
     , SIGN( 7 - 7 )
  FROM EMP 
 WHERE DEPTNO = 30;

-- 7-15 DISTINCT �� �ߺ��� ������ �޿� ���� ��� �޿� ���ϱ�
SELECT AVG(DISTINCT SAL)
  FROM EMP
 WHERE DEPTNO = 30;

-- �߰�����
SELECT count(*)
  FROM employees
 WHERE salary >= 8000;

SELECT count(*)
  FROM employees
 WHERE hire_date > '20070101';
 
SELECT sum(max_salary), avg(max_salary)
  FROM jobs;
 
SELECT sum(salary), avg(salary)
  FROM employees
 WHERE job_id = 'IT_PROG';

SELECT MIN(max_salary), MAX(max_salary)
  FROM jobs;
  
SELECT MIN(max_salary), MAX(max_salary)
  FROM jobs
 WHERE job_title = 'Programmer';  

select min(hire_date), max(hire_date)
  from employees
 where department_id = 50;

SELECT first_name, salary, 
       VARIANCE(salary) OVER ( ORDER BY hire_date ) 
  FROM employees
 WHERE department_id = 100;



SELECT first_name, last_name, salary
     , round(avg(nvl(commission_pct,0)) 
             over (order by first_name), 10.2)  com_avg   
     , nvl(commission_pct,0)
  FROM employees
 WHERE department_id between 50 and 80 
   and first_name = 'David'  ;

select (0 + 0.25 + 0.1) / 3 from dual; -- 0.11666666667


select first_name, salary, commission_pct
  from employees  WHERE department_id between 50 and 80  ;

-- 07-2 ��  ������� ���ϴ� ���� ���� ����ϴ� GROUP BY ��
-- 7-16 ���� ������
SELECT CEIL(AVG(SAL)), '10' AS DEPTNO FROM EMP WHERE DEPTNO = 10
UNION
SELECT CEIL(AVG(SAL)), '20' AS DEPTNO FROM EMP WHERE DEPTNO = 20
UNION
SELECT CEIL(AVG(SAL)), '30' AS DEPTNO FROM EMP WHERE DEPTNO = 30
;
-- 7-17
SELECT CEIL(AVG(SAL)), DEPTNO
  FROM EMP
 GROUP BY DEPTNO;

-- 7-18 �μ���ȣ �� ��å�� ��� �޿� , �μ���ȣ �� ��å�� ����
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
 GROUP BY DEPTNO, JOB
 ORDER BY DEPTNO, JOB;
 
-- 7-19   GROUP BY ���� ���� ���� SELECT ���� ���� �� ����  �M��
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
 GROUP BY DEPTNO;   -- ����: ORA-00979: GROUP BY ǥ������  �ƴմϴ�
 
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
 GROUP BY DEPTNO, JOB; 
 
 SELECT DISTINCT DEPTNO, CHG_SAL
   FROM (
     SELECT DEPTNO
          , CEIL( AVG(SAL) OVER (ORDER BY DEPTNO) ) AS CHG_SAL
       FROM EMP
);
-- 7-21   
SELECT DEPTNO 
     , CEIL(AVG(SAL))
  FROM EMP
-- WHERE AVG(SAL) > 2200 
 GROUP BY DEPTNO
 HAVING AVG(SAL) > 2200;

--7-22 
SELECT DEPTNO 
     , CEIL(AVG(SAL))
  FROM EMP
 GROUP BY DEPTNO
 HAVING AVG(SAL) >= 2000
 ORDER BY DEPTNO;

-- 7-23
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
 WHERE SAL <= 3000
 GROUP BY DEPTNO, JOB
HAVING AVG(SAL) >= 2000
 ORDER BY DEPTNO, JOB;

-- 07-4 �׷�ȭ�� ���õ� ���� �Լ� =  ROLLUP, CUBE, GROUPING SETS�Լ�
-- 7-24  ���� GROUP BY ���� ����� �׷�ȭ
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), AVG(SAL)
  FROM EMP
 GROUP BY DEPTNO, JOB
 ORDER BY DEPTNO, JOB;
 
-- 7-25 ROLLUP
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );  
 -- ROLLUP(A, B)
 /*  
    1. A�׷캰 B�׷쿡 �ش��ϴ� ������
    2. A�׷쿡 �ش��ϴ� ��� ���
    3. ��ü ������ ��� ���
*/    
 
 --7-26  CUBE
 SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
 GROUP BY CUBE( DEPTNO, JOB )
 ORDER BY DEPTNO, JOB;
 /* CUBE(A, B) - �ش� �׸� ��� ����� ���� ��� �������
    1. A�׷캰 B�׷쿡 �ش��ϴ� ������
    2. A�׷쿡 �ش��ϴ� ��� ���
    3. B�׷쿡 �ش��ϴ� ��� ���
    4. ��ü ������ ��� ���
*/ 

-- 7- 27 DEPTNO �� ���� �׷�ȭ�� �� ROLLUP �Լ��� JOB �����ϱ�
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY DEPTNO, ROLLUP(JOB);
 
 SELECT  JOB, DEPTNO, COUNT(*)
  FROM EMP
 GROUP BY JOB, ROLLUP(DEPTNO);
  
  
--7-29 GROUPING SETS �Լ�
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY GROUPING SETS(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
 -- 7-30 DEPTNO, JOB ���� �׷�ȭ ���� Ȯ��  : GROUPING
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
     , GROUPING(DEPTNO)
     , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );   


SELECT DECODE(GROUPING(DEPTNO), 1, '�Ѱ�', DEPTNO) AS DEPTNO
     , DECODE(GROUPING(JOB), 1, DECODE(GROUPING(DEPTNO),1,' ', '�Ұ�'), JOB) AS JOB
     , COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL)) AS AVG
    -- , GROUPING(DEPTNO)
    -- , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );  
 
SELECT DEPTNO
  FROM EMP
 GROUP BY DEPTNO;

-- 7-33
SELECT DEPTNO, ENAME
  FROM EMP
 GROUP BY DEPTNO, ENAME;
 
 -- 11G 
 -- LISTAGG()  :�μ��� ����̸��� ������ �����Ͽ� ���
 -- 7-34
 SELECT DEPTNO
      , LISTAGG(ENAME, ', ')
        WITHIN GROUP (ORDER BY SAL DESC) AS ENAMES
   FROM EMP
  GROUP BY DEPTNO;
 
 -- 7-38  DECODE���� Ȱ���Ͽ� PIVOT �Լ��� ���� ��� ����
 SELECT DEPTNO
      , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
      , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
      , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
      , MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
      , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
   FROM EMP
  GROUP BY DEPTNO
  ORDER BY DEPTNO;
  
  SELECT DEPTNO, JOB, MAX(SAL) 
    FROM EMP
   GROUP BY DEPTNO, JOB;
  
  -- 7-39
SELECT *
  FROM (
    SELECT DEPTNO
          , MAX(DECODE(JOB, 'CLERK', SAL)) AS "CLERK"
          , MAX(DECODE(JOB, 'SALESMAN', SAL)) AS "SALESMAN"
          , MAX(DECODE(JOB, 'PRESIDENT', SAL)) AS "PRESIDENT"
          , MAX(DECODE(JOB, 'MANAGER', SAL)) AS "MANAGER"
          , MAX(DECODE(JOB, 'ANALYST', SAL)) AS "ANALYST"
       FROM EMP
      GROUP BY DEPTNO
      ORDER BY DEPTNO
  )
  UNPIVOT(
    SAL FOR JOB IN (CLERK, SALESMAN, PRESIDENT, MANAGER, ANALYST)
  )
  ;
  
  
  
  
 
 -- 7-36 PIVOT�Լ�  :��å�� �μ� �ְ� �޿�
 SELECT *
   FROM ( SELECT DEPTNO, JOB, SAL
            FROM EMP )
   PIVOT( MAX(SAL)
          FOR DEPTNO IN (10, 20, 30) )
   ORDER BY JOB;
 
-- 7-37 �μ��� ��å �ְ� �޿� 2���� ǥ ���·� ���
SELECT *
   FROM ( SELECT  JOB, DEPTNO, SAL
            FROM EMP )
   PIVOT( MAX(SAL)
          FOR JOB IN ( 'CLERK' AS CLERK,
                        'SALESMAN' AS SALESMAN,
                        'PRESIDENT' AS PREISDENT,
                        'MANAGER' AS MANAGER,
                        'ANALYST' AS ANALYST
          ) )
   ORDER BY DEPTNO;

 SELECT DECODE(GROUPING(DEPTNO), 1, '�Ѱ�', DEPTNO) AS DEPTNO
     , DECODE(GROUPING( TO_CHAR(HIREDATE, 'YYYY')), 1, DECODE(GROUPING(DEPTNO),1,' ', '�Ұ�'), TO_CHAR(HIREDATE, 'YYYY')) AS HIRE_YEAR
     , COUNT(*) AS CNT
     , MAX(SAL) AS MAX_SAL
     , SUM(SAL) AS SUM_SAL
     , TRUNC(AVG(SAL)) AS AVG_SAL
  FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY')); 










 