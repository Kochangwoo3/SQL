-- 9장 서브쿼리
--9-1 JONES인 사원의 급여 출력
SELECT SAL
  FROM EMP
 WHERE ENAME = 'JONES';
 
-- 9-2 급여가 2975보다 높은 사원 정보 출력
SELECT *
  FROM EMP
 WHERE SAL > 2975;
 
-- 9-3 서브쿼리
SELECT *
  FROM EMP
 WHERE SAL > (SELECT SAL
                FROM EMP
               WHERE ENAME = 'JONES') ;--2975;
-- 서브쿼리 특징
-- 1. 괄호 2. 특수한 경우 제외 서브쿼리 에는 ORDER BY 절을 사용할 수 없습니다.
-- 3. 메인쿼리 비교대상 과 데이터 개수와 자료형 고려
-- 4. 서브쿼리 단일행, 다중행에따라 연산자 고려

SELECT *
  FROM EMPLOYEES
 WHERE SALARY > (SELECT SALARY
                FROM EMPLOYEES
               WHERE FIRST_NAME = 'Adam') ;  -- David 다중행 오류

-- 1분 복습  -- 사원정보 중에서 
-- 사원 이름이 ALLEN인 사원의 추가수당( COMM )보다 많은 추가수당을 받는 사원정보
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
-- 단일행 서브쿼리와 함수
--9-5  사원정보에 20번부서에서 평균급여보다 많이 받는 사람을 출력
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL > ( SELECT AVG(SAL) 
                   FROM EMP );

-- 1분 복습
-- 전체 사원의 평균급여 보다 작거나 같은 급여를 받고있는
-- 20번 부서의 사원 및 부서정보를 구하도록 쿼리를 작성하세요
SELECT E.EMPNO, E.ENAME, E.JOB, E.SAL
     , D.DEPTNO, D.DNAME, D.LOC
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.DEPTNO = 20
   AND E.SAL <= (SELECT AVG(SAL)
                   FROM EMP );
 
 -- 다중행 서브쿼리 연산자: IN , ANY/SOME , ALL , EXISTS
--9-6
SELECT *
  FROM EMP
 WHERE DEPTNO IN (20, 30);
 
 -- 9-7 각 부서별 최고 급여와 동일한 급여를 받는 사원 정보 출력
 SELECT *
   FROM EMP
  WHERE SAL IN (SELECT MAX(SAL)
                  FROM EMP
                 GROUP BY DEPTNO);

-- ANY, SOME 연산자
-- (조건식을 사용한 결과가 하나라도 true라면 
--  메인쿼리 조건식을 true로 반환해주는 연산자)
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
                    
-- 30번 부서 사원들의 최대 급여보다 적은 급여를 받는 사원정보 출력하기 
SELECT *
  FROM EMP
 WHERE SAL < ANY ( SELECT SAL 
                     FROM EMP
                    WHERE DEPTNO = 30 )
  -- SAL < ANY (950, 1600, 2850)                    
 ORDER BY SAL, EMPNO;     -- 2850 보다 작게 받는 사원               
             
--[ < ANY ]는 서브쿼리에 MAX함수를 사용한 경우
SELECT *
  FROM EMP
 WHERE SAL <  ( SELECT MAX(SAL)
                     FROM EMP
                    WHERE DEPTNO = 30 )
 ORDER BY SAL, EMPNO; 
 
 
-- 30번 부서 사원들의 최소급여 보다 많은 급여를 받는 사원정보
-- 다중행 연산자 사용
SELECT *
  FROM EMP
 WHERE SAL > ANY (SELECT SAL 
                    FROM EMP
                   WHERE DEPTNO = 30);
  -- SAL > ANY (950, 1600, 2850)                  
 -- ALL 연산자   : 모두 만족 
 -- 9-14  부서번호가 30번인 사원들의 최소 급여보다 더 적은 급여를 맏는 사원 출력
 SELECT *
   FROM EMP
  WHERE SAL < ALL (SELECT SAL 
                     FROM EMP
                    WHERE DEPTNO = 30);
 -- 9-15 부서번호가 30번인 사원들의 최대급여 보다 더 많은 급여를 받는 사원 출력
SELECT *
  FROM EMP
 WHERE SAL > ALL (SELECT SAL
                    FROM EMP
                   WHERE DEPTNO = 30);
 
 -- EXISTS 연산자 : 서브쿼리 결과 값이 존재하는 경우
 -- 실습 9-16
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

-- 다중행연산자 사용
-- EMP 테이블의 사원중에 10번 부서에 속한 모든 사원들보다 
-- 일찍 입사한 사원 정보를 출력
SELECT *
  FROM EMP
 WHERE HIREDATE < ALL (SELECT HIREDATE
                         FROM EMP
                        WHERE DEPTNO = 10);
                 
-- 상관 쿼리
-- : 메인쿼리와 서브쿼리 간에 서로 상관 참조하는 쿼리
-- 사원이 한명이라도 있는 부서명 출력
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

-- 비교할 열이 여러개인 다중열 서브쿼리
-- 9-18 
SELECT *
  FROM EMP
 WHERE (DEPTNO, SAL) IN (SELECT DEPTNO, MAX(SAL)
                           FROM EMP
                          GROUP BY DEPTNO);
-- 각부서의 최대급여를 받는 사원의 부서코드, 이름, 급여를
-- 출력하는데 부서코드 순으로 오름차순 정렬하여 출력하는 쿼리를 작성하세요
SELECT DEPTNO, ENAME, SAL
  FROM EMP e
 WHERE SAL = (SELECT MAX(SAL) 
                FROM EMP 
               WHERE DEPTNO = e.DEPTNO)
 ORDER BY DEPTNO;               


                          
                          
-- SELECT절의 서브쿼리 :  스칼라쿼리 , 상관쿼리
SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , (SELECT DNAME FROM DEPT WHERE DEPTNO = E.DEPTNO) DNAME
  FROM EMP E;

SELECT E.EMPNO, E.ENAME, E.DEPTNO
     , D.DNAME  
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO;
 
 
--9-05 FROM절에 사용하는 서브쿼리와 WITH절

SELECT E10.EMPNO, E10.ENAME, E10.DEPTNO
     , D.DNAME, D.LOC
  FROM (SELECT * FROM EMP WHERE DEPTNO = 10) E10
     , (SELECT * FROM DEPT) D
 WHERE E10.DEPTNO = D.DEPTNO;
 
 
  -- WITH 절 사용하기
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
  
 -- 한발 더 나기기 : 상호 연관 서브쿼리
 SELECT *
   FROM EMP E1
  WHERE SAL > ( SELECT MIN(SAL)
                  FROM EMP E2
                 WHERE E2.DEPTNO = E1.DEPTNO)
 ORDER BY DEPTNO, SAL;
 
-- 9-21 SELECT 절에 서브쿼리(스칼라 쿼리) 사용하기
SELECT EMPNO, ENAME, JOB, SAL
     , ( SELECT GRADE FROM SALGRADE
          WHERE E.SAL BETWEEN LOSAL AND HISAL ) AS SALGRADE
     , DEPTNO
     , ( SELECT DNAME FROM DEPT
          WHERE DEPTNO = E.DEPTNO ) AS DNAME
     , (SELECT ENAME FROM EMP WHERE EMPNO =  E.MGR) MGR    
  FROM EMP E;
 
 
-- 중간문제\
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

















