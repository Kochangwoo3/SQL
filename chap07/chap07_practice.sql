--  �ر� ���� �� �� �� 

-- 7-1
SELECT DEPTNO
     , TRUNC(AVG(SAL)) AS AVG_SAL
     , MAX(SAL) MAX_SAL
     , MIN(SAL) MIN_SAL
     , COUNT(*) CNT
  FROM EMP
 GROUP BY DEPTNO;

-- 2
SELECT JOB, COUNT(*)
  FROM EMP
 GROUP BY JOB
 HAVING COUNT(*) >= 3;
 
DESC EMP;
 
SELECT TO_CHAR(HIREDATE, 'YYYY') AS HIRE_YEAR
     , DEPTNO
     , COUNT(*) AS CNT
  FROM EMP
 GROUP BY  TO_CHAR(HIREDATE, 'YYYY')
     , DEPTNO ;
 
 SELECT NVL2(COMM, 'O', 'X') AS EXIST_COMM
      , COUNT(*) AS CNT
   FROM EMP
  GROUP BY NVL2(COMM, 'O', 'X');
 
 SELECT DECODE(GROUPING(DEPTNO), 1, '�Ѱ�', DEPTNO) AS DEPTNO
      , DECODE(GROUPING(TO_CHAR(HIREDATE, 'YYYY')), 1, 
                   DECODE(GROUPING(DEPTNO), 1, ' ', '�Ұ�'), 
                   TO_CHAR(HIREDATE, 'YYYY') )  AS HIRE_YEAR
      , COUNT(*) AS CNT
      , MAX(SAL) AS MAX_SAL
      , SUM(SAL) AS SUM_SAL
      , TRUNC(AVG(SAL)) AS AVG_SAL
     -- , GROUPING(DEPTNO) DEPTNO
     -- , GROUPING(TO_CHAR(HIREDATE, 'YYYY')) HD
  FROM EMP
 GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
 
 -- 1. �μ���ȣ 10���� ������� �����ȣ, ����̸�, ������ ����Ͻÿ�.
SELECT EMPNO AS �����ȣ, ENAME ����̸�, SAL ����
  FROM EMP
 WHERE DEPTNO = 10;
 
 
--2. �����ȣ 7369�� ��� �̸�, �Ի���, �μ���ȣ�� ����Ͻÿ�
SELECT  ENAME ����̸�, HIREDATE �Ի���, DEPTNO �μ���ȣ
  FROM EMP
 WHERE EMPNO = 7369; 
 
--3. �����ȣ 7300 ũ�� 7400 ���� ��� �̸�, �Ի���, �μ���ȣ�� ����Ͻÿ�. 
SELECT  ENAME ����̸�, HIREDATE �Ի���, DEPTNO �μ���ȣ
  FROM EMP
 WHERE  EMPNO > 7300  AND EMPNO < 7400;
 
-- 4. EMPLOYEE ��� ������ (�����ȣ ���� ������������) �˻��Ͻÿ�.
SELECT *
  FROM EMP
 ORDER BY EMPNO DESC;
      
-- 5. �̸��� S�� �����ϴ� ��� ����� �����ȣ�� �̸��� ����Ͻÿ�.      
SELECT *
  FROM EMP
 WHERE ENAME LIKE 'S%';
 
 


