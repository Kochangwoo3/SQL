SET SERVEROUTPUT ON;
-- 18�� Ŀ���� ����ó��
-- 18-1
DECLARE
    V_DEPT_ROW DEPT%ROWTYPE;
BEGIN
    SELECT DEPTNO, DNAME, LOC
      INTO V_DEPT_ROW
      FROM DEPT
     WHERE DEPTNO = 40;
     DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
     DBMS_OUTPUT.PUT_LINE ('DNAME : ' || V_DEPT_ROW.DNAME);
     DBMS_OUTPUT.PUT_LINE ('LOC : ' || V_DEPT_ROW.LOC);
END;
/

-- 18-2 ����� Ŀ�� ����
DECLARE
    -- ROW���� <- Ŀ�� ������ �ο� �Է¹��� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    -- 1. ����� Ŀ�� ����
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = 40;
BEGIN
    -- 2. Ŀ�� ����
    OPEN C1;
    LOOP
        -- 3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO);
        DBMS_OUTPUT.PUT_LINE ('DNAME : ' || V_DEPT_ROW.DNAME);
        DBMS_OUTPUT.PUT_LINE ('LOC : ' || V_DEPT_ROW.LOC);
        
    END LOOP;
    -- 4. Ŀ�� �ݱ�
    CLOSE C1;
END;
/

--18-3 ����� Ŀ�� ����
DECLARE
    -- ROW���� <- Ŀ�� ������ �ο� �Է¹��� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    -- 1. ����� Ŀ�� ����
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    -- 2. Ŀ�� ����
    OPEN C1;
    LOOP
        -- 3. FETCH
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO
         || ', DNAME : ' || V_DEPT_ROW.DNAME
         || ', LOC : ' || V_DEPT_ROW.LOC);
         
        /*
        
        */
        
    END LOOP;
    -- 4. Ŀ�� �ݱ�
    CLOSE C1;
END;
/
-- 18-4
DECLARE 
    -- ����� Ŀ�� ����
    CURSOR C1 IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT;
BEGIN
    FOR c1_rec IN C1 LOOP
        DBMS_OUTPUT.PUT_LINE('DEPTNO : ' || c1_rec.DEPTNO
         || ', DNAME : ' || c1_rec.DNAME
         || ', LOC : ' || c1_rec.LOC);
    END LOOP;
END;
/

--18-5  
DECLARE
    -- Ŀ�� �����͸� �Է��� ���� ����
    V_DEPT_ROW DEPT%ROWTYPE;
    -- ����� Ŀ�� ����
    CURSOR C1 (p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = p_deptno;
BEGIN
-- 10�� �μ� ó���� ���� Ŀ�� ���
    OPEN C1(10);
    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO
         || ', DNAME : ' || V_DEPT_ROW.DNAME
         || ', LOC : ' || V_DEPT_ROW.LOC);
    END LOOP;
    CLOSE C1;
-- 20�� �μ� ó���� ���� Ŀ�� ���
    OPEN C1(20);
    LOOP
        FETCH C1 INTO V_DEPT_ROW;
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || V_DEPT_ROW.DEPTNO
         || ', DNAME : ' || V_DEPT_ROW.DNAME
         || ', LOC : ' || V_DEPT_ROW.LOC);
    END LOOP;
    CLOSE C1;
END;
/

-- FOR IN �� ���  �Ķ���� �ִ� Ŀ�� ���
DECLARE
    -- Ŀ�� �����͸� �Է��� ���� ����
    v_deptno DEPT.DEPTNO%TYPE;
    -- ����� Ŀ�� ����
    CURSOR C1 (p_deptno DEPT.DEPTNO%TYPE) IS
        SELECT DEPTNO, DNAME, LOC
          FROM DEPT
         WHERE DEPTNO = p_deptno;
BEGIN
    -- INPUT_DEPTNO �� �μ���ȣ �Է¹ް� v_deptno �� ����
    v_deptno := &INPUT_DEPTNO;
    FOR c1_rec IN  C1(v_deptno) LOOP
         DBMS_OUTPUT.PUT_LINE ('DEPTNO : ' || c1_rec.DEPTNO
         || ', DNAME : ' || c1_rec.DNAME
         || ', LOC : ' || c1_rec.LOC);
    END LOOP;
END;
/

-- 18-7
BEGIN
    UPDATE DEPT SET DNAME = 'DATABASE'
     WHERE DEPTNO = 50;
    DBMS_OUTPUT.PUT_LINE('���ŵ� ���� �� : ' || SQL%ROWCOUNT);
    
    IF(SQL%FOUND) THEN
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���翩�� : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���� ��� �� ���翩�� : false');
    END IF;
    
    IF(SQL%ISOPEN) THEN
        DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ���� : true');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Ŀ���� OPEN ���� : false');
    END IF;
END;        
/

-- ����ó��:
-- ���� �� �߻��ص� ���α׷��� ������ ���� ���� �ʵ��� �ϴ� ó��

DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
END;
/


DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
     
    EXCEPTION
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');    
END;
/

-- 18-10 ���ܹ߻� �� �� �ڵ� ���� ���� Ȯ���ϱ�
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �� ������ ������� �ʽ��ϴ�.');   
     
    EXCEPTION
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�');    
END;
/

-- ���� �̸�
/*
DUP_VAL_ON_INDEX : UNIQUE �ε����� �ִ� ���� �ߺ� ���� ���� ��
NO_DATA_FOUND : SELECT  INTO ������ ��� ���� �ϳ��� ���� ���
VALUE_ERROR: ���, ��ȯ, �߸�, ���� ���� ���� �� �߻� ��
TOO_MANY_ROWS : SELECT INTO ���� ��� ���� ������ ��� ��
*/

DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �� ������ ������� �ʽ��ϴ�.');   
     
    EXCEPTION
        WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : �䱸���� ���� �� ���� ���� �߻�');    
        WHEN VALUE_ERROR THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ��ġ �Ǵ� �� ���� �߻�'); 
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ���� ���� �� ���� �߻�');    
END;
/

-- 18-12
DECLARE
    v_wrong NUMBER;
BEGIN
    SELECT DNAME INTO v_wrong
      FROM DEPT
     WHERE DEPTNO = 10;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� �� ������ ������� �ʽ��ϴ�.');   
     
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('����ó�� : ���� ���� �� ���� �߻�');
            DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
            DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/

-- �߰�����
-- Q1-1
���� 5 ) 1���� ������ Ȧ�� 10���� ����ϱ�
(IF  ���ǹ� ���� 
�ݺ���  BASIC LOOP �� WHILE LOOP ������ ������� ����غ�����)

DECLARE
    v_num NUMBER := 1; -- �ʱ��
    v_cnt NUMBER := 1;
BEGIN
    LOOP
        EXIT WHEN v_cnt > 10;  --���ǽ�
        DBMS_OUTPUT.PUT_LINE(v_num);
        v_num := v_num + 2;
        v_cnt := v_cnt + 1;
    END LOOP;
END;

-- Q1-2
DECLARE
    v_num NUMBER := 1; -- �ʱ��
    v_cnt NUMBER := 1;
BEGIN
    WHILE v_cnt <= 10 LOOP
        DBMS_OUTPUT.PUT_LINE(v_num);
        v_num := v_num + 2;
        v_cnt := v_cnt + 1;
    END LOOP; 
END;
/

-- Q2-1
����6) ������̺��� 30�� �μ��� ����� �����ȣ, �̸�, ��å ����ϱ�
 (cursor ���)
 (v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job)
 
DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP WHERE DEPTNO = 30;  -- 1
BEGIN
    OPEN C1;  -- 2
    LOOP
        FETCH C1 INTO v_emp;  -- 3
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job);
    END LOOP;
    CLOSE C1; -- 4
END;
/

-- 2-2  FOR IN

DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP WHERE DEPTNO = 30;  -- 1
BEGIN
    FOR v_emp IN C1 LOOP
       -- EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_emp.EMPNO || '  ' || v_emp.ENAME || '  ' || v_emp.job);
    END LOOP;
END;
/
-- �ر����� �ѹ���
-- 1
DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP;  -- 1 ����� Ŀ�� ����
BEGIN
    OPEN C1;  -- 2 Ŀ�� ����
    LOOP
        FETCH C1 INTO v_emp;  -- 3 Ŀ�� ��ġ ���
        EXIT WHEN C1%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
                    'EMPNO : '  ||  v_emp.EMPNO 
               || ', ENAME : '  || v_emp.ENAME 
               || ', JOB : '    || v_emp.JOB
               || ', SAL : '    || v_emp.SAL 
               || ', DEPTNO : ' || v_emp.DEPTNO );
    END LOOP;
    CLOSE C1; -- 4 Ŀ�� �ݱ�
END;
/

DECLARE
    v_emp EMP%ROWTYPE;
    CURSOR C1 IS
        SELECT * FROM EMP;  -- 1 ����� Ŀ�� ����
BEGIN
--    OPEN C1;  -- 2 Ŀ�� ����
--    LOOP
--        FETCH C1 INTO v_emp;  -- 3 Ŀ�� ��ġ ���
    FOR v_emp IN C1 LOOP        
        DBMS_OUTPUT.PUT_LINE(
                    'EMPNO : '  ||  v_emp.EMPNO 
               || ', ENAME : '  || v_emp.ENAME 
               || ', JOB : '    || v_emp.JOB
               || ', SAL : '    || v_emp.SAL 
               || ', DEPTNO : ' || v_emp.DEPTNO );
    END LOOP;
--    CLOSE C1; -- 4 Ŀ�� �ݱ�
END;
/

-- Q2
DECLARE
    v_wrong DATE;  -- VARCHAR2(20);
BEGIN
    SELECT ENAME    
      INTO v_wrong   -- INTO �� ������ ����� ���� ���� �� ����
      FROM EMP
     WHERE EMPNO = 7369;
    DBMS_OUTPUT.PUT_LINE('���ܰ� �߻��ϸ� ���� ������ ������� �ʽ��ϴ�. ' || v_wrong);
    
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('������ �߻��Ͽ����ϴ�.' ||
                TO_CHAR(SYSDATE, '[YYYY"��"MM"��"DD"��" HH24"��"MI"��"SS"��"]'));
        DBMS_OUTPUT.PUT_LINE('SQLCODE : ' || TO_CHAR(SQLCODE));
        DBMS_OUTPUT.PUT_LINE('SQLERRM : ' || SQLERRM);
END;
/











