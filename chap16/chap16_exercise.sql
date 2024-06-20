-- 16-1 PL/SQL ����
SET SERVEROUTPUT ON;  -- ȭ�鿡 ��� Ȱ��ȭ

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;

-- �ּ�����ϱ�
DECLARE
-- �����̸�  �ڷ���  :=  �� �Ǵ� ���� ����Ǵ� ���� ǥ����;
    V_EMPNO NUMBER(4) := 7788;
    V_ENAME VARCHAR2(10);
BEGIN
    V_ENAME := 'SCOTT';
    DBMS_OUTPUT.PUT_LINE('V_EMPNO : ' ||  V_EMPNO);
    DBMS_OUTPUT.PUT_LINE('V_ENAME : ' ||  V_ENAME);
END;
/

-- ����� ���� ������ �� ����ϱ�
DECLARE
    V_TAX CONSTANT NUMBER(1) := 3;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_TAX : ' || V_TAX);
END;
/

-- ������ �⺻�� �����ϱ�

DECLARE
    V_DEPTNO NUMBER(2) DEFAULT 10; -- �⺻�� 10 ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

-- 16-7 ������ NOT NULL �����ϰ� ���� ������ �� ����ϱ�
DECLARE
    V_DEPTNO NUMBER(2) NOT NULL := 10; -- �⺻�� 10 ����
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

-- NOT NULL �� �⺻�� ���� ����
declare
    V_DEPTNO NUMBER(2) NOT NULL DEFAULT 10; -- �⺻�� 10 ���� NOT NULL
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || v_deptno);
END;
/
-- �ĺ��� �̸� ���̴� ��Ģ
--  ��ҹ��ڸ� �������� �ʽ��ϴ�.
--  ���� �� �ȿ��� �ĺ��ڴ� �����ؾ� �ϸ� �ߺ� �Ұ�
--  ���ڷ� ����, 30byte, ($, #, _) ��밡��, sqlŰ���� �Ұ�(select, from ..)

-- ������ �ڷ��� ( �߿� )
--  ��Į�� : ����, ���ڿ�, ��¥ ��� ���� ����Ŭ���� �⺻���� ������ ���� �ڷ���
--  ������ : Ư�� ���̺�  ���� �ڷ����̳�   �ϳ��� �౸���� ����

DECLARE 
    V_DEPTNO DEPT.DEPTNO%TYPE  := 50;
BEGIN
    DBMS_OUTPUT.PUT_LINE('V_DEPTNO : ' || V_DEPTNO);
END;
/

-- 16-10
DECLARE 
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC
      INTO V_DEPT_ROW
      FROM DEPT
     WHERE DEPTNO = 40;
     DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
     DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_ROW.DNAME);
     DBMS_OUTPUT.PUT_LINE('LOC : ' || V_DEPT_ROW.LOC);
END;
/

SELECT * FROM DEPT WHERE DEPTNO = 40;

-- 16-3 ���� ���  - IF �� CASE  �� ��� ����
--   IF ���ǽ� THEN
--   ELSIF ���ǽ� THEN
--   ELSE
--   END IF;

-- ������ �Էµ� ���� Ȧ�� ���� �˾ƺ���
DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    END IF;
END;
/


DECLARE
    V_NUMBER NUMBER := 14;
BEGIN
    IF MOD(V_NUMBER, 2) = 1 THEN
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� Ȧ���Դϴ�!');
    ELSE
        DBMS_OUTPUT.PUT_LINE('V_NUMBER�� ¦���Դϴ�!');
    END IF;
END;
/

-- �Է��� ������ ��� �������� ����ϱ�
DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    IF V_SCORE >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('A����');
    ELSIF V_SCORE >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('B����');
    ELSIF V_SCORE >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('C����');
    ELSIF V_SCORE >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('D����'); 
    ELSE
        DBMS_OUTPUT.PUT_LINE('F����'); 
    END IF;
END;
/
/*
-- ���� 1
��1) ������ȣ�� 7900  �� ���������� ����غ�����
  -- v_no||' '||v_name||' '||v_sal 
-- ��°��: ������ȣ�� 7900  �� �������� : 7900 JAMES 950
*/

DECLARE
    v_no   EMP.EMPNO%TYPE;
    v_name EMP.ENAME%TYPE;
    v_sal  EMP.SAL%TYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
      INTO v_no, v_name, v_sal
      FROM EMP
     WHERE EMPNO = 7900;
     
     DBMS_OUTPUT.PUT_LINE('������ȣ�� 7900  �� �������� : ' || v_no || ' ' || v_name ||  ' ' || v_sal); 
END;
/

��2) ������ȣ�� 7900  �� ����������  ROWTYPE ������ Ȱ���Ͽ� ������ ����غ�����

DECLARE
    v_row EMP%ROWTYPE;
BEGIN
    SELECT EMPNO, ENAME, SAL
      INTO v_row.empno, v_row.ename, v_row.sal
      FROM EMP
     WHERE EMPNO = 7900;
     
     DBMS_OUTPUT.PUT_LINE('������ȣ�� 7900  �� �������� : ' || v_row.empno || ' ' || v_row.ename ||  ' ' || v_row.sal); 
END;
/
 ��3 EMP, DEPT �����ؼ� EMPNO 7900�� ����� ������ ����غ�����
 (v_empno || ' ' || v_ename ||  ' ' || v_deptno ||  ' ' || v_dname  )

DECLARE
    v_empno  EMP.EMPNO%TYPE;
    v_ename  EMP.ENAME%TYPE;
    v_deptno DEPT.DEPTNO%TYPE;
    v_dname  DEPT.DNAME%TYPE;
BEGIN
    SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
      INTO v_empno, v_ename, v_deptno, v_dname 
      FROM EMP E, DEPT D
     WHERE E.DEPTNO = D.DEPTNO
       AND E.EMPNO = 7900;

    DBMS_OUTPUT.PUT_LINE(v_empno || ' ' || v_ename ||  ' ' || v_deptno ||  ' ' || v_dname  );   
END;
/

SELECT E.EMPNO, E.ENAME, D.DEPTNO, D.DNAME
  FROM EMP E, DEPT D
 WHERE E.DEPTNO = D.DEPTNO
   AND E.EMPNO = 7900;

����4) 7369����� �޿��� 10000�̻��̸� '��'�� 
5000 �̻��̸� '��'�� �����ϸ� '��' ��� 
(ex.   DBMS_OUTPUT.PUT_LINE( v_empno || '�� ����� �޿�' || v_sal || '�� '|| v_level);   )

DECLARE
    v_level varchar2(10);
    v_sal EMP.SAL%TYPE;
    v_empno EMP.EMPNO%TYPE := 7369;
BEGIN
    SELECT SAL
      INTO v_sal
      FROM EMP
     WHERE EMPNO = v_empno;

    IF(v_sal >= 10000) THEN
        v_level := '��';
    ELSIF (v_sal >= 5000) THEN
        v_level := '��';
    ELSE
        v_level := '��';
    END IF;

    DBMS_OUTPUT.PUT_LINE( v_empno || '�� ����� �޿�(' || v_sal || ')�� '|| v_level); 
END;
/

DECLARE
    V_SCORE NUMBER := 87;
BEGIN
    CASE TRUNC(V_SCORE/10)
        WHEN 10 THEN
            DBMS_OUTPUT.PUT_LINE('A����');
        WHEN  9 THEN
            DBMS_OUTPUT.PUT_LINE('A����');        
        WHEN  8 THEN
            DBMS_OUTPUT.PUT_LINE('B����');
        WHEN  7 THEN
            DBMS_OUTPUT.PUT_LINE('C����');
        WHEN  6 THEN
            DBMS_OUTPUT.PUT_LINE('D����'); 
        ELSE
            DBMS_OUTPUT.PUT_LINE('F����'); 
    END CASE;
END;
/


SELECT 87/10 FROM DUAL;


DECLARE 
    V_SCORE NUMBER := 87;
BEGIN
    CASE
        WHEN V_SCORE >= 90 THEN DBMS_OUTPUT.PUT_LINE('A����');
        WHEN V_SCORE >= 80 THEN DBMS_OUTPUT.PUT_LINE('B����');
        WHEN V_SCORE >= 70 THEN DBMS_OUTPUT.PUT_LINE('C����');
        WHEN V_SCORE >= 60 THEN DBMS_OUTPUT.PUT_LINE('D����');
        ELSE DBMS_OUTPUT.PUT_LINE('F����');
    END CASE;
END;
/

1. (�̸��� TURNER�� ����� ���� ����)�� �ϴ� ����� �����ȣ, �̸�, ����, �޿� ����
SELECT EMPNO, ENAME, JOB, SAL
  FROM EMP
 WHERE JOB = ( SELECT JOB FROM EMP 
                WHERE ENAME = 'TURNER' );

2. EMP ���̺��� �����ȣ�� 7521�� ����� ������ ���� 
�޿��� 7934�� ����� �޿����� ���� ����� 
�����ȣ, �̸�, ������, �Ի���, �޿� ����
SELECT empno, ename, job, hiredate, sal 
  FROM emp
 WHERE JOB = ( SELECT JOB FROM EMP 
                WHERE empno = '7521' )
   AND SAL > ( SELECT SAL FROM EMP 
                WHERE empno = '7934' );
                
3. (EMP ���̺��� �޿��� ���)���� ���� ����� �����ȣ, �̸�, ����, �޿�, �μ���ȣ ����
SELECT empno, ename, job, sal, deptno 
  FROM emp
 WHERE SAL < (SELECT avg(sal) FROM emp);

4. �μ��� �ּұ޿���( 20�� �μ��� �ּұ޿� )���� ū �μ��� �μ���ȣ, �ּ� �޿� ����
select deptno, min(sal)
  from emp
 group by deptno
having min(sal) > (select min(sal) from emp where deptno = 20 ) ;

5. ������ �޿� ��� �� (���� ���� �޿����)�� ������ �޿���� ����
select job, avg(sal)
  from emp
 group by job
having avg(sal) = (select min(avg(sal)) from emp  group by job) ;

select job, avg(sal)
  from emp
 group by job
having avg(sal) = 1037.5 ;


6. ������ �ִ� �޿��� �޴� ����� �����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ ����

SELECT empno, ename, hiredate, sal, deptno 
  from emp
 where (job, sal) in ( select job, max(sal) from emp group by job );

7. (30�� �μ��� �ּұ޿�)�� �޴� ������� ���� �޿��� �޴� ����� 
�����ȣ, �̸�, ����, �Ի���, �޿�, �μ���ȣ, �� 30�� �μ��� �����ϰ� ����
SELECT empno, ename, hiredate, sal, deptno 
  from emp
 where sal > (select min(sal) from emp where deptno = 30)
   and deptno != 30;


8. BLAKE�� ���� ��縦 ���� ����� �̸�,����, ����ȣ ����
SELECT ENAME, JOB, MGR FROM EMP
WHERE MGR = (select mgr from emp where ename = 'BLAKE')
  AND ename != 'BLAKE' 
        
SET SERVEROUTPUT ON;        
                      
-- 16-17
DECLARE
    V_NUM NUMBER := 0;  -- �ʱ��
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1;   -- ������
        --EXIT WHEN V_NUM > 4;  -- ���ǽ�
        IF V_NUM > 4 THEN
            EXIT;
        END IF;
    END LOOP;
END;
/
-- WHILE LOOP 
DECLARE
    V_NUM NUMBER := 0;   -- �ʱ��
BEGIN
    WHILE V_NUM < 4 LOOP -- ���ǽ�
        DBMS_OUTPUT.PUT_LINE('���� V_NUM : ' || V_NUM);
        V_NUM := V_NUM + 1; -- ������
    END LOOP; 
END;
/

-- 16-19 FOR LOOP
BEGIN
    FOR i IN 0..4 LOOP   -- 0���� 4���� ����   java for(int i=0; i<=4; i++){
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
    END LOOP;
END;


BEGIN
    FOR i IN REVERSE 0..4 LOOP   -- 0���� 4���� ����   java for(int i=0; i<=4; i++){
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
    END LOOP;
END;

-- 16-21  CONTINUE��
BEGIN
    FOR i IN 0..4 LOOP 
        CONTINUE WHEN MOD(i, 2) = 1;
        DBMS_OUTPUT.PUT_LINE('���� i�� �� : ' || i);
    END LOOP;
END;

-- Q1 ���� 1���� 10������ ������ Ȧ���� ����ϴ� PL/SQL �ۼ�
���� i�� �� : 1
���� i�� �� : 3
.
.
���� i�� �� : 9


BEGIN
    FOR i IN 0..10 LOOP 
        CONTINUE WHEN MOD(i, 2) = 0;
        DBMS_OUTPUT.PUT_LINE('FOR ���� i�� �� : ' || i);
    END LOOP;
END;
                      
DECLARE
    i NUMBER := 0;
BEGIN
    WHILE i < 10 LOOP
        i := i+1;
        IF MOD(i, 2) = 0 THEN
            CONTINUE;
        END IF;
        -- CONTINUME WHEN  MOD(i, 2) = 0;
        DBMS_OUTPUT.PUT_LINE('WHILE ���� i�� �� : ' || i);
    END LOOP;
END;
/

SELECT * FROM DEPT;
/*
10	ACCOUNTING
20	RESEARCH
30	SALES
40	OPERATIONS
*/
DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 10;
BEGIN
    IF V_DEPTNO = 10 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ACCOUNTING');
    ELSIF V_DEPTNO = 20 THEN DBMS_OUTPUT.PUT_LINE('DNAME : RESEARCH');
    ELSIF V_DEPTNO = 30 THEN DBMS_OUTPUT.PUT_LINE('DNAME : SALES');
    ELSIF V_DEPTNO = 40 THEN DBMS_OUTPUT.PUT_LINE('DNAME : OPERATIONS');
    ELSE DBMS_OUTPUT.PUT_LINE('DNAME : N/A');
    END IF;
END;
/


DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 50;
BEGIN
    CASE V_DEPTNO
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('DNAME : ACCOUNTING');
        WHEN 20 THEN DBMS_OUTPUT.PUT_LINE('DNAME : RESEARCH');
        WHEN 30 THEN DBMS_OUTPUT.PUT_LINE('DNAME : SALES');
        WHEN 40 THEN DBMS_OUTPUT.PUT_LINE('DNAME : OPERATIONS');
        ELSE DBMS_OUTPUT.PUT_LINE('DNAME : N/A');
    END CASE;        
END;
/

SET SERVEROUTPUT ON;

DECLARE
    V_DEPTNO DEPT.DEPTNO%TYPE := 30;
    V_DEPT_NAME DEPT.DNAME%TYPE;
BEGIN
    SELECT DNAME
      INTO V_DEPT_NAME
      FROM DEPT
     WHERE DEPTNO = V_DEPTNO;
     
    DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_NAME);
    
    EXCEPTION WHEN NO_DATA_FOUND THEN
        V_DEPT_NAME := 'N/A';
        DBMS_OUTPUT.PUT_LINE('DNAME : ' || V_DEPT_NAME);
END;
/





                      
                          