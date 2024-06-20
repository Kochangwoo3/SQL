-- 5��: �� ��Ȯ�ϰ� �پ��ϰ� ����� ����ϴ� WHERE���� ������
-- 5-1  PAGE 94
SELECT *
  FROM EMP;

-- 5-2 �μ���ȣ�� 30�� ������(��)�� ����ϱ�
SELECT *
  FROM EMP
 WHERE DEPTNO = 30 ;    -- '=' �񱳿����� ���ٸ�
 
 -- 1 �� ����
 -- �����ȣ�� 7782�� ��� ������ �������� ������ �ۼ��ϼ���
 SELECT *
   FROM EMP
  WHERE EMPNO = 7782;
 
 --5-3   AND �����ڷ� ���� �� ���ǽ� ����ϱ�
 SELECT *
   FROM EMP
  WHERE DEPTNO = 30
    AND JOB = 'SALESMAN';   -- �� ������ AND, OR
    
-- �����ȣ�� 7499 �̰� �μ���ȣ�� 30�� ��������� �������� ���� �ۼ��ϼ���
SELECT *
  FROM EMP 
 WHERE EMPNO = 7499
   AND DEPTNO = 30;
   
-- 5-4 OR �����ڷ� �������� ��� ���� ����ϱ�
SELECT * 
  FROM EMP
 WHERE DEPTNO = 30
    OR JOB = 'CLERK';
    
SELECT * 
  FROM EMP
 WHERE JOB = 'SALESMAN'
    OR JOB = 'CLERK';    
 
-- 1�� ���� : �μ���ȣ�� 20 �̰ų� ������ SALESMAN �� ������� ��� ���� �ۼ�
SELECT *
  FROM EMP
 WHERE DEPTNO = 20
    OR JOB = 'SALESMAN';
   
-- 5-5 ��������� : �޿� ���� 12�� ���� ���� 36000�� ���� ���
SELECT *
  FROM EMP
 WHERE SAL * 12 = 36000;
 
-- 5-6 �񱳿����� : �޿��� 3000 �̻��� ������� ���
SELECT *
  FROM EMP 
 WHERE SAL >= 3000;
-- 1�к���
-- �޿��� 2500 �̻��̰� ������ ANALYST �� ��������� �������� ���� �ۼ��غ�����
SELECT *
  FROM EMP
 WHERE SAL >= 2500
   AND JOB = 'ANALYST';
   
-- 5-7 ���� ��� �� ����
SELECT *
  FROM EMP
 WHERE ENAME >= 'F';

--5-8
SELECT *
  FROM EMP
 WHERE ENAME <= 'FORZ';

-- � �� ������  �����ʴ� ( '<>', '!=', '^=' )
-- ���� '='
-- 5-9 
SELECT * 
  FROM EMP
 WHERE SAL != 3000;
 
-- 5-10
 SELECT * 
  FROM EMP
 WHERE SAL <> 3000;

-- 5-11
 SELECT * 
  FROM EMP
 WHERE SAL ^= 3000;
 
 -- 5-12 �� ���� ������
 SELECT *
   FROM EMP
  WHERE NOT SAL = 3000;
 
 -- IN ������ : �߿�
 -- OR�����ڸ� ��� ���� �� ������ �����ϴ� ������ ���
 SELECT *
   FROM EMP
  WHERE JOB = 'MANAGER'
     OR JOB = 'SALESMAN'
     OR JOB = 'CLERK';
 
 -- 5-14 
 SELECT * 
   FROM EMP
  WHERE JOB IN ('MANAGER', 'SALESMAN', 'CLERK');
 -- 5-15 � �� �����ڿ� AND ������ ���
 SELECT *
   FROM EMP
  WHERE JOB != 'MANAGER'
    AND JOB <> 'SALESMAN'
    AND JOB ^= 'CLERK'; 
 
 --5-16
 SELECT * 
   FROM EMP
  WHERE JOB NOT IN ('MANAGER', 'SALESMAN', 'CLERK');
 
 -- 1�� ����
 -- �μ� ��ȣ�� 10, 20���� ������� ��� ���� �ۼ��ϼ��� IN
 SELECT * 
   FROM EMP
  WHERE DEPTNO IN (10, 20);
  
  -- 5-17 ��� �񱳿�����
SELECT *
  FROM EMP
 WHERE SAL >= 2000 AND SAL <= 3000;
 
 -- 5-18   BETWEEN  A  AND  B  ���� ���� ��� 
SELECT *
  FROM EMP
 WHERE SAL BETWEEN 2000 AND 3000;  -- >=,   <=
  
 -- 5-19  
SELECT *
  FROM EMP
 WHERE SAL NOT BETWEEN 2000 AND 3000;  -- >=,   <=
   
-- LIKE �����ڿ� ���ϵ� ī��  : �ſ� �߿� 
-- 5-20   -- �̸��� S�� �����ϴ� ���� ���
SELECT *
  FROM EMP
 WHERE ENAME LIKE 'S%';   -- ���ϵ� ī��: Ư������ OR ���ڿ���ü OR ����
 
 -- LIKE�����ڿ� �Բ� ����� �� �ִ� ���ϵ� ī�� '_' �� '%'
 /*
 _ : � ���̵� �Ѱ��� ���� �����͸� �ǹ�
 % : ���̿� ������� ��� ���� �����͸� �ǹ�
 */
 
 -- ����̸��� �ι�° ���ڰ� L �� ����� ���
 --5-21
SELECT *
  FROM EMP
 WHERE ENAME LIKE '_L%';
 
 -- ����̸��� AM �� ���ԵǾ� �ִ� ��������� �� ���
 -- 5-22
SELECT * 
  FROM EMP
 WHERE ENAME LIKE '%AM%';
 
  -- 5-23
SELECT * 
  FROM EMP
 WHERE ENAME NOT LIKE '%AM%';
 
 --  _�� % ���ڰ�   ����Ÿ�� ���Ե� ��� �� ��Ȥ ����
 SELECT deptno
   FROM EMP;
 
INSERT INTO EMP VALUES
(7999,'A_ADAM','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
COMMIT;

SELECT * FROM EMP
 WHERE ENAME LIKE 'A_A%'; -- 
 
 
 
 
INSERT INTO EMP VALUES
(7999,'A_ADAM','CLERK',    7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);

COMMIT;
 
SELECT * FROM EMP WHERE ENAME LIKE 'A_%';

SELECT * FROM EMP WHERE ENAME LIKE 'A@_A%' ESCAPE '@';
-- 7999	A_ADAM	CLERK	7902	1980/12/17	800		20
-- " \"hI HELLO\"    " 

DELETE FROM EMP WHERE ENAME LIKE 'A\_A%' ESCAPE '\'; 
COMMIT;

SELECT * FROM EMP;

-- 5�� �߰����� ----------------------------------------
SELECT *
  FROM EMPLOYEES
 WHERE FIRST_NAME like 'Da%';

SELECT *
  FROM JOBS
 WHERE min_salary = 4000;
 
SELECT *
  FROM JOBS
 WHERE min_salary > 8000;

SELECT *
  FROM JOBS
 WHERE max_salary <= 10000;

SELECT *
  FROM JOBS
 WHERE min_salary >= 4000
   AND max_salary <= 10000;
 
 
SELECT *
  FROM EMPLOYEES
 WHERE JOB_ID = 'IT_PROG'
   AND SALARY > 5000;

-- 5-24 PAGE 114
SELECT ENAME, SAL, SAL*12+COMM AS ANNSAL, COMM
  FROM EMP;

-- 5-25
SELECT *
  FROM EMP
 WHERE COMM = NULL;  -- ���� ����Ÿ�� NULL �Է°� ã�°�

-- 5-26
SELECT *
  FROM EMP
 WHERE COMM  IS NULL;
  
--5-27  ���ӻ���� �ִ� ��� ����Ÿ�� ���
SELECT *
  FROM EMP
 WHERE MGR IS NOT NULL; -- NULL �� �ƴϴ� = �����Ѵ�.
 
 -- 5-28 AND �����ڿ� IS NULL
 SELECT *
   FROM EMP
  WHERE SAL > NULL  -- false
    AND COMM IS NULL;
    
-- 5-28 or �����ڿ� is null ������
 SELECT *
   FROM EMP
  WHERE SAL > NULL  -- false
     OR COMM IS NULL;
     
-- ���� ������ : UNION, UNION ALL, MINUS, INTERSECT    
SELECT EMPNO, ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE DEPTNO = 10  
UNION -- �ߺ��Ȱ� �ѹ���
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10
 ;

 -- 5-35
 SELECT EMPNO, ENAME, SAL, DEPTNO 
  FROM EMP
 WHERE DEPTNO = 10  
UNION ALL-- �ߺ��Ǵ��� ��� ���
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10
 ;

SELECT DISTINCT DEPTNO FROM EMP;
-- 5-36
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
MINUS
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10;
  
-- INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
INTERSECT
SELECT EMPNO, ENAME, SAL, DEPTNO
  FROM EMP
 WHERE DEPTNO = 10;
 
 
 -- ������ �켱����
 -- ������ : ��� -> ��Һ� -> �׿ܺ�(IS NULL, LIKE, IN) -> BETWEEN -> ��
  
SELECT * 
  FROM EMP
 WHERE ENAME LIKE '%S';

SELECT empno, ename, job, sal, deptno
  FROM emp
 WHERE deptno = 30
   AND JOB = 'SALESMAN';

-- ���տ����� �̻�� ����
SELECT empno, ename, sal, deptno
  FROM emp
 WHERE deptno in (20, 30) -- deptno = 20 or deptno = 30
   AND sal > 2000;
   
-- ���տ����� ���
SELECT empno, ename, sal, deptno
  FROM emp
 WHERE deptno = 20 
   AND sal > 2000
UNION   
SELECT empno, ename, sal, deptno
  FROM emp
 WHERE deptno = 30
   AND sal > 2000   
   ;
   
 SELECT *
   FROM EMP
  WHERE SAL < 2000
     OR SAL > 3000;
 
 SELECT ename, empno, sal, deptno
   FROM emp
  WHERE ename like '%E%'
    AND deptno = 30
    AND SAL NOT BETWEEN 1000 AND 2000; 
 
 SELECT *
   FROM EMP
  WHERE COMM IS NULL  -- ������ ����
    AND MGR IS NOT NULL  -- ����� ����
    AND JOB IN ('MANAGER', 'CLERK')
    AND ENAME NOT LIKE '_L%';
    
-- �߰� ���� 
SELECT job_title
  FROM jobs
 ORDER BY job_title ;

SELECT country_name
  FROM countries
 ORDER BY country_name desc ;
 
SELECT *
  FROM employees
 WHERE salary  BETWEEN 10000 AND 12000 ;
 
SELECT *
  FROM employees
 WHERE job_id IN ('IT_PROG', 'ST_MAN');
 
SELECT *
  FROM employees
 WHERE manager_id IS NULL;

SELECT *
  FROM departments
 WHERE manager_id IS not NULL;

SELECT *
  FROM employees
 WHERE job_id like 'AD%' ;

SELECT *
  FROM employees
 WHERE first_name like '%ni%' ;
 
SELECT location_id, street_address, city
  FROM locations
 WHERE location_id <= 3000 
union all 
SELECT location_id, street_address, city
  FROM locations
 WHERE location_id >= 2000 ;

SELECT location_id, street_address, city
  FROM locations
 WHERE location_id <= 3000 
minus 
SELECT location_id, street_address, city
  FROM locations
 WHERE location_id >= 2000 ;

SELECT location_id, street_address, city
  FROM locations
 WHERE location_id <= 3000 
intersect 
SELECT location_id, street_address, city
  FROM locations
 WHERE location_id >= 2000 ;    
    
    