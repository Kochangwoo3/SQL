-- 7장 다중행 함수와 데이터 그룹화  
-- 7-1 
SELECT SUM(SAL)
  FROM EMP;
  
-- 7-2
SELECT DEPTNO, SUM(SAL)
  FROM EMP;
 --GROUP BY DEPTNO  ;
 
-- 7-3 다중행 함수 : 널값 제외 처리
SELECT SUM(COMM) AS "추가 수당 합계"
  FROM EMP;  
  
-- 7-4 
SELECT SUM(DISTINCT SAL)
     , SUM(ALL SAL) 
     , SUM(SAL)
     , SUM(DISTINCT SAL) + 4250
  FROM EMP;

SELECT SAL FROM EMP;

SELECT DISTINCT SAL FROM EMP;

-- 7-5 EMP테이블 행 갯수 -
SELECT COUNT(COMM)
     , COUNT(MGR)
     , COUNT(EMPNO)
     , COUNT(*)
     , COUNT(1)   -- 실무
  FROM EMP;
  
-- 7-6 부서번호가 30번 직원수
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
  FROM EMP;  -- NULL 데이터는 반환 개수에서 제외
  
-- 7-8
SELECT COUNT(COMM)
  FROM EMP;    -- 4
-- 7-9
SELECT COUNT(COMM)
  FROM EMP
 WHERE COMM IS NOT NULL;  -- 4
 
-- 7-10  10번 부서에서 최대급여 출력
SELECT MAX(SAL)
  FROM EMP
 WHERE DEPTNO = 10;

-- 7-11  10번 부서에서 최소급여 출력
SELECT MIN(SAL)
  FROM EMP
 WHERE DEPTNO = 10; 

-- 7-12 20번 부서에서 사원의 입사일중 제일 최근 입사일 출력
SELECT MAX(HIREDATE)
  FROM EMP
 WHERE DEPTNO = 20;    -- 1987/07/13
 
-- 7-13 20번 부서에서 사원의 입사일중 제일 오래된 입사일 출력
SELECT MIN(HIREDATE)
  FROM EMP
 WHERE DEPTNO = 20;    -- 1980/12/17
 
-- STDDEV 표준편차,   VARIANCE 분산 
SELECT CEIL(STDDEV(SAL)), CEIL(VARIANCE(SAL))
  FROM EMP;
 
 
-- 7-14 부서번호가 30 인 사원들의 평균 급여 출력
SELECT CEIL(AVG(SAL)) -- 올림값 
     , FLOOR(AVG(COMM)) -- 내림값
     , SIGN( 10 - 7 ) 
     , SIGN( 5 - 7 )
     , SIGN( 7 - 7 )
  FROM EMP 
 WHERE DEPTNO = 30;

-- 7-15 DISTINCT 로 중복을 제거한 급여 열의 평균 급여 구하기
SELECT AVG(DISTINCT SAL)
  FROM EMP
 WHERE DEPTNO = 30;

-- 중간문제
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

-- 07-2 절  결과값을 원하는 열로 묶어 출력하는 GROUP BY 절
-- 7-16 집합 연산자
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

-- 7-18 부서번호 및 직책별 평균 급여 , 부서번호 및 직책별 정렬
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
 GROUP BY DEPTNO, JOB
 ORDER BY DEPTNO, JOB;
 
-- 7-19   GROUP BY 절에 없는 열을 SELECT 절에 포함 시 오류  밠생
SELECT DEPTNO, JOB, AVG(SAL)
  FROM EMP
 GROUP BY DEPTNO;   -- 오류: ORA-00979: GROUP BY 표현식이  아닙니다
 
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

-- 07-4 그룹화와 관련된 여러 함수 =  ROLLUP, CUBE, GROUPING SETS함수
-- 7-24  기존 GROUP BY 절만 사용한 그룹화
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
    1. A그룹별 B그룹에 해당하는 결과출력
    2. A그룹에 해당하는 결과 출력
    3. 전체 데이터 결과 출력
*/    
 
 --7-26  CUBE
 SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
  FROM EMP
 GROUP BY CUBE( DEPTNO, JOB )
 ORDER BY DEPTNO, JOB;
 /* CUBE(A, B) - 해당 항목 모든 경우의 수를 모드 집계출력
    1. A그룹별 B그룹에 해당하는 결과출력
    2. A그룹에 해당하는 결과 출력
    3. B그룹에 해당하는 결과 출력
    4. 전체 데이터 결과 출력
*/ 

-- 7- 27 DEPTNO 를 먼저 그룹화한 후 ROLLUP 함수에 JOB 지정하기
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY DEPTNO, ROLLUP(JOB);
 
 SELECT  JOB, DEPTNO, COUNT(*)
  FROM EMP
 GROUP BY JOB, ROLLUP(DEPTNO);
  
  
--7-29 GROUPING SETS 함수
SELECT DEPTNO, JOB, COUNT(*)
  FROM EMP
 GROUP BY GROUPING SETS(DEPTNO, JOB)
 ORDER BY DEPTNO, JOB;
 
 -- 7-30 DEPTNO, JOB 열의 그룹화 여부 확인  : GROUPING
SELECT DEPTNO, JOB, COUNT(*), MAX(SAL), SUM(SAL), TRUNC(AVG(SAL))
     , GROUPING(DEPTNO)
     , GROUPING(JOB)
  FROM EMP
 GROUP BY ROLLUP( DEPTNO, JOB );   


SELECT DECODE(GROUPING(DEPTNO), 1, '총계', DEPTNO) AS DEPTNO
     , DECODE(GROUPING(JOB), 1, DECODE(GROUPING(DEPTNO),1,' ', '소계'), JOB) AS JOB
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
 -- LISTAGG()  :부서별 사원이름을 나란히 나열하여 출력
 -- 7-34
 SELECT DEPTNO
      , LISTAGG(ENAME, ', ')
        WITHIN GROUP (ORDER BY SAL DESC) AS ENAMES
   FROM EMP
  GROUP BY DEPTNO;
 
 -- 7-38  DECODE문을 활용하여 PIVOT 함수와 같은 출력 구현
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
  
  
  
  
 
 -- 7-36 PIVOT함수  :직책별 부서 최고 급여
 SELECT *
   FROM ( SELECT DEPTNO, JOB, SAL
            FROM EMP )
   PIVOT( MAX(SAL)
          FOR DEPTNO IN (10, 20, 30) )
   ORDER BY JOB;
 
-- 7-37 부서별 직책 최고 급여 2차원 표 형태로 출력
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

 SELECT DECODE(GROUPING(DEPTNO), 1, '총계', DEPTNO) AS DEPTNO
     , DECODE(GROUPING( TO_CHAR(HIREDATE, 'YYYY')), 1, DECODE(GROUPING(DEPTNO),1,' ', '소계'), TO_CHAR(HIREDATE, 'YYYY')) AS HIRE_YEAR
     , COUNT(*) AS CNT
     , MAX(SAL) AS MAX_SAL
     , SUM(SAL) AS SUM_SAL
     , TRUNC(AVG(SAL)) AS AVG_SAL
  FROM EMP
GROUP BY ROLLUP(DEPTNO, TO_CHAR(HIREDATE, 'YYYY')); 










 