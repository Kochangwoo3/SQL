--  잊기 전에 한 번 더 

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
 
 SELECT DECODE(GROUPING(DEPTNO), 1, '총계', DEPTNO) AS DEPTNO
      , DECODE(GROUPING(TO_CHAR(HIREDATE, 'YYYY')), 1, 
                   DECODE(GROUPING(DEPTNO), 1, ' ', '소계'), 
                   TO_CHAR(HIREDATE, 'YYYY') )  AS HIRE_YEAR
      , COUNT(*) AS CNT
      , MAX(SAL) AS MAX_SAL
      , SUM(SAL) AS SUM_SAL
      , TRUNC(AVG(SAL)) AS AVG_SAL
     -- , GROUPING(DEPTNO) DEPTNO
     -- , GROUPING(TO_CHAR(HIREDATE, 'YYYY')) HD
  FROM EMP
 GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY'));
 
 -- 1. 부서번호 10번인 사원들의 사원번호, 사원이름, 월급을 출력하시오.
SELECT EMPNO AS 사원번호, ENAME 사원이름, SAL 월급
  FROM EMP
 WHERE DEPTNO = 10;
 
 
--2. 사원번호 7369인 사원 이름, 입사일, 부서번호를 출력하시오
SELECT  ENAME 사원이름, HIREDATE 입사일, DEPTNO 부서번호
  FROM EMP
 WHERE EMPNO = 7369; 
 
--3. 사원번호 7300 크고 7400 작은 사원 이름, 입사일, 부서번호를 출력하시오. 
SELECT  ENAME 사원이름, HIREDATE 입사일, DEPTNO 부서번호
  FROM EMP
 WHERE  EMPNO > 7300  AND EMPNO < 7400;
 
-- 4. EMPLOYEE 모든 정보를 (사원번호 기준 내림차순으로) 검색하시오.
SELECT *
  FROM EMP
 ORDER BY EMPNO DESC;
      
-- 5. 이름이 S로 시작하는 모든 사람의 사원번호와 이름을 출력하시오.      
SELECT *
  FROM EMP
 WHERE ENAME LIKE 'S%';
 
 


