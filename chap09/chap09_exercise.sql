-- 9�� ��������
--9-1 JONES�� ����� �޿� ���
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
-- 9-2 �޿��� 2975���� ���� ��� ���� ���
SELECT *
  FROM EMP
 WHERE SAL > 2975;
 
-- 9-3 ��������
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES') ;--2975;
-- �������� Ư¡
-- 1. ��ȣ 2. Ư���� ��� ���� �������� ���� ORDER BY ���� ����� �� �����ϴ�.
-- 3. �������� �񱳴�� �� ������ ������ �ڷ��� ���
-- 4. �������� ������, �����࿡���� ������ ���

SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
               WHERE FIRST_NAME = 'Adam') ;  -- David ������ ����

-- 1�� ����  -- ������� �߿��� 
-- ��� �̸��� ALLEN�� ����� �߰�����( COMM )���� ���� �߰������� �޴� �������
SELECT *
  FROM EMP
 WHERE COMM > (SELECT COMM
                 FROM EMP
                WHERE ENAME = 'ALLEN');
                
-- 9-4
SELECT *
  FROM EMP
 WHERE HIREDATE < (SELECT HIREDATE 
                     FROM EMP
                    WHERE ENAME = 'SCOTT');
                    
SELECT *
  FROM EMPLOYEES
 WHERE SALARY > ( SELECT SALARY
                    FROM EMPLOYEES
                   WHERE HIRE_DATE = '20060103');
-- ������ ���������� �Լ�
--9-5  ��������� 20���μ����� ��ձ޿����� ���� �޴� ����� ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL > ( SELECT AVG(SAL) 
                   FROM EMP );

-- 1�� ����
-- ��ü ����� ��ձ޿� ���� �۰ų� ���� �޿��� �ް��ִ�
-- 20�� �μ��� ��� �� �μ������� ���ϵ��� ������ �ۼ��ϼ���
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL <= (SELECT AVG(SAL)
                   FROM EMP );
 
 -- ������ �������� ������: IN , ANY/SOME , ALL , EXISTS
--9-6
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
 -- 9-7 �� �μ��� �ְ� �޿��� ������ �޿��� �޴� ��� ���� ���
 SELECT *
   FROM EMP
  WHERE SAL IN (SELECT MAX(SAL)
                  FROM EMP
                 GROUP BY DEPTNO);

-- ANY, SOME ������
-- (���ǽ��� ����� ����� �ϳ��� true��� 
--  �������� ���ǽ��� true�� ��ȯ���ִ� ������)
-- 9-9
SELECT *
   FROM EMP
  WHERE SAL = ANY (SELECT MAX(SAL)
                     FROM EMP
                    GROUP BY DEPTNO);

-- 9-10
SELECT *
   FROM EMP
  WHERE SAL = SOME (SELECT MAX(SAL)
                     FROM EMP
                    GROUP BY DEPTNO);
                    
-- 30�� �μ� ������� �ִ� �޿����� ���� �޿��� �޴� ������� ����ϱ� 
SELECT *
  FROM EMP
 WHERE SAL < ANY ( SELECT SAL 
                     FROM EMP
                    WHERE DEPTNO = 30 )
  -- SAL < ANY (950, 1600, 2850)                    
 ORDER BY SAL, EMPNO;     -- 2850 ���� �۰� �޴� ���               
             
--[ < ANY ]�� ���������� MAX�Լ��� ����� ���
SELECT *
  FROM EMP
 WHERE SAL <  ( SELECT MAX(SAL)
                     FROM EMP
                    WHERE DEPTNO = 30 )
 ORDER BY SAL, EMPNO; 
 
 
-- 30�� �μ� ������� �ּұ޿� ���� ���� �޿��� �޴� �������
-- ������ ������ ���
SELECT *
  FROM EMP
 WHERE SAL > ANY (SELECT SAL 
                    FROM EMP
                   WHERE DEPTNO = 30);
  -- SAL > ANY (950, 1600, 2850)                  
 -- ALL ������   : ��� ���� 
 -- 9-14  �μ���ȣ�� 30���� ������� �ּ� �޿����� �� ���� �޿��� ���� ��� ���
 SELECT *
   FROM EMP
  WHERE SAL < ALL (SELECT SAL 
                     FROM EMP
                    WHERE DEPTNO = 30);
 -- 9-15 �μ���ȣ�� 30���� ������� �ִ�޿� ���� �� ���� �޿��� �޴� ��� ���
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
 
 -- EXISTS ������ : �������� ��� ���� �����ϴ� ���
 -- �ǽ� 9-16
 SELECT *
   FROM EMP
  WHERE EXISTS (SELECT DNAME 
                  FROM DEPT
                 WHERE DEPTNO = 10);
 
 SELECT *
   FROM EMP
  WHERE EXISTS (SELECT 1 
                  FROM DEPT
                 WHERE DEPTNO = 10);    
-- 9-17
 SELECT *
   FROM EMP
  WHERE EXISTS (SELECT 1 
                  FROM DEPT
                 WHERE DEPTNO = 50);   

-- �����࿬���� ���
-- EMP ���̺��� ����߿� 10�� �μ��� ���� ��� ����麸�� 
-- ���� �Ի��� ��� ������ ���
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL (SELECT HIREDATE
                         FROM EMP
                        WHERE DEPTNO = 10);
                 
-- ��� ����
-- : ���������� �������� ���� ���� ��� �����ϴ� ����
-- ����� �Ѹ��̶� �ִ� �μ��� ���
SELECT DNAME 
  FROM DEPT D
 WHERE EXISTS ( SELECT 1 FROM EMP WHERE DEPTNO = D.DEPTNO);

SELECT DNAME 
  FROM DEPT D
 WHERE DEPTNO IN ( SELECT DISTINCT DEPTNO FROM EMP);
-- WHERE DEPTNO IN ( 10, 20, 30 );

SELECT EMPNO FROM EMP WHERE DEPTNO = 10;  -- ACCOUNTING
SELECT EMPNO FROM EMP WHERE DEPTNO = 20;  -- RESEARCH
SELECT EMPNO FROM EMP WHERE DEPTNO = 30;  -- SALES
SELECT EMPNO FROM EMP WHERE DEPTNO = 40; 

SELECT * FROM EMP;

-- ���� ���� �������� ���߿� ��������
-- 9-18 
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                          GROUP BY DEPTNO);
-- ���μ��� �ִ�޿��� �޴� ����� �μ��ڵ�, �̸�, �޿���
-- ����ϴµ� �μ��ڵ� ������ �������� �����Ͽ� ����ϴ� ������ �ۼ��ϼ���
SELECT DEPTNO, ENAME, SAL
  FROM EMP e
 WHERE SAL = (SELECT MAX(SAL) 
                FROM EMP 
               WHERE DEPTNO = e.DEPTNO)
 ORDER BY DEPTNO;               


                          
                          
-- SELECT���� �������� :  ��Į������ , �������
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
  FROM EMP E;

SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , D.DNAME  
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
 
 
--9-05 FROM���� ����ϴ� ���������� WITH��

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
     , (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
 
  -- WITH �� ����ϱ�
 WITH
 E10 AS ( 
    SELECT * 
      FROM EMP 
     WHERE DEPTNO = 10 ),
 D AS (
    SELECT *
      FROM DEPT )
SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO, D.DNAME, D.LOC
  FROM E10, D
 WHERE E10.DEPTNO = D.DEPTNO;
  
 -- �ѹ� �� ����� : ��ȣ ���� ��������
 SELECT *
   FROM EMP E1
  WHERE SAL > ( SELECT MIN(SAL)
                  FROM EMP E2
                 WHERE E2.DEPTNO = E1.DEPTNO)
 ORDER BY DEPTNO, SAL;
 
-- 9-21 SELECT ���� ��������(��Į�� ����) ����ϱ�
SELECT EMPNO, ENAME, JOB, SAL
     , ( SELECT GRADE FROM SALGRADE
          WHERE E.SAL BETWEEN LOSAL AND HISAL ) AS SALGRADE
     , DEPTNO
     , ( SELECT DNAME FROM DEPT
          WHERE DEPTNO = E.DEPTNO ) AS DNAME
     , (SELECT ENAME FROM EMP WHERE EMPNO =  E.MGR) MGR    
  FROM EMP E;
 
 
-- �߰�����\
--Q1
SELECT first_name, last_name, job_id, salary
  FROM employees
 WHERE department_id = ( SELECT department_id
                          FROM departments
                         WHERE department_name = 'IT');

--Q2
SELECT department_id, department_name
  FROM departments
 WHERE location_id = ( SELECT location_id
                        FROM locations
                       WHERE state_province = 'California');
--Q3
SELECT city, state_province, street_address
  FROM locations
 WHERE country_id IN ( SELECT country_id
                        FROM countries
                       WHERE region_id  = 3);

-- Q4
SELECT first_name, last_name, job_id, salary
  FROM employees
WHERE department_id IN ( SELECT department_id
                           FROM departments
                          WHERE manager_id IS NOT NULL );

-- Q5
SELECT department_id, department_name
  FROM departments
WHERE location_id  NOT IN ( SELECT location_id
                              FROM locations
                             WHERE city = 'Seattle' );

-- Q6
select city, state_province, street_address
  from locations
 where country_id in (select country_id
                        from countries
                       where REGION_ID = (SELECT REGION_ID
                                            FROM REGIONS
                                           WHERE REGION_NAME = 'Europe'));

















