--9-1 
SELECT E.JOB, E.EMPNO, E.SAL
     , D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.JOB = (SELECT JOB
                  FROM EMP
                 WHERE ENAME = 'ALLEN');
                 
SELECT E.EMPNO, E.ENAME, D.DNAME
     , E.HIREDATE, D.LOC, E.SAL, S.GRADE
  FROM EMP E, DEPT D, SALGRADE S        
 WHERE E.DEPTNO = D.DEPTNO
   AND E.SAL BETWEEN S.LOSAL AND S.HISAL
   AND E.SAL > (SELECT AVG(SAL)
                  FROM EMP)
 ORDER BY E.SAL DESC, E.EMPNO ; 
 
 
 --Q3
 SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 10
    AND E.JOB NOT IN (SELECT DISTINCT JOB FROM EMP WHERE DEPTNO = 30);
 
 SELECT E.EMPNO, E.ENAME, E.JOB, E.DEPTNO, D.DNAME, D.LOC
   FROM EMP E, DEPT D
  WHERE E.DEPTNO = D.DEPTNO
    AND E.DEPTNO = 10
    AND NOT EXISTS (SELECT JOB FROM EMP 
                 WHERE DEPTNO = 30 AND JOB = E.JOB);
 
 SELECT JOB FROM EMP 
                 WHERE DEPTNO = 30 AND JOB = 'CLERK'  
                 ;
                 
-- Q4
--������ ������ ����ϴ� ���
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S 
 WHERE E.SAL  BETWEEN S.LOSAL AND S.HISAL
   AND E.SAL > ALL (SELECT SAL FROM EMP WHERE JOB = 'SALESMAN')
 ORDER BY E.EMPNO;  
 
-- ������ ������ ������� �ʴ� ���
SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE
  FROM EMP E, SALGRADE S 
 WHERE E.SAL  BETWEEN S.LOSAL AND S.HISAL
   AND E.SAL > (SELECT MAX(SAL) FROM EMP WHERE JOB = 'SALESMAN')
 ORDER BY E.EMPNO;   
 
 SELECT E.EMPNO, E.ENAME, E.SAL, S.GRADE, E.JOB
     ,  (SELECT MAX(SAL) FROM EMP WHERE JOB = E.JOB)
  FROM EMP E, SALGRADE S 
 WHERE E.SAL  BETWEEN S.LOSAL AND S.HISAL
   AND E.SAL > 1600
 ORDER BY E.EMPNO;                   