 2022-0107-02)������ �˻�����(SELECT)
 
 ** ��ü���� (DROP)
  . ���̺� ����
    DROP TABLE ���̺���;
    
 ��뿹)���θ� ���̺�(BUYER,BUYPROD,CART,LPROD,PROD,MEMBER)��
       ������ ��� ���̺� ����
    DROP TABLE ORDER_GOODS;
    DROP TABLE ORDERS;
    DROP TABLE CUSTOMERS;
    DROP TABLE GOODS;
    
    DROP TABLE TEMP_01;
    DROP TABLE TEMP_02;
    DROP TABLE TEMP_03;
    DROP TABLE TEMP_04;
    DROP TABLE TEMP_05;
    DROP TABLE TEMP_06;
    DROP TABLE TEMP_07;
    DROP TABLE TEMP_08;
    DROP TABLE TEMP_09;
    
 **HR���� Ȱ��ȭ
  1. HR������ �������
     ALTER USER HR ACCOUNT UNLOCK;
     
  2. HR���� ��ȣ����
     ALTER USER HR IDENTIFIED BY java;
     
     
 **������ �˻� ����     
  - SELECT ���� ����
  - SQL���� �� ���� ���� ���Ǵ� ����
  (�������)
  --���� ����:FROM -> WHERE -> SELECT
   SELECT *|[DISTINCT]�÷��� [AS �÷���Ī][,] --DISTINCT:�ߺ��ڷ� ����
          �÷��� [AS �÷���Ī][,]
                    :
          �÷��� [AS �÷���Ī][,]]
     FROM ���̺���
   [WHERE ����
     [AND ����,...]]
   [GROUP BY �÷���[,�÷���,...]] --Ư�� �÷��� �������� ����
  [HAVING ����] 
   [ORDER BY �÷���|�÷�index [ASC|DESC][, --����
          �÷���|�÷�index [ASC|DESC],...]];  
  
   . 'DISTINCT':�ߺ�����
   . 'AS �÷���Ī':�÷��� �ο��� �� �ٸ� �̸�. �÷��� ���� ���
   . '�÷���Ī'�� Ư������(���� ��)�� ����� ���� ���Ե� ��� �ݵ�� " "�� ���� �־�� ��.
   . Ư�� ���̺��� ���ų� ���ʿ��� ��� �ý����� �����ϴ� ����(DUMMY)���̺��� DUAL�� ���
   
 ��뿹)ȸ�����̺�(MEMBER)���� ����ȸ������ ������ ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ,ȸ����,�ּ�,����,���ϸ����̴�.
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_ADD1||' '||MEM_ADD2 AS �ּ�,--||�� +
              EXTRACT(YEAR FROM SYSDATE) - --SYSDATE���� YEAR�� ����
                EXTRACT(YEAR FROM MEM_BIR) AS ����,
              MEM_MILEAGE AS ���ϸ���
         FROM MEMBER
        WHERE SUBSTR(MEM_REGNO2,1,1)='2' --�ֹι�ȣ ���ڸ�����,ù����,�ϳ�
  
 ��뿹) 2636363*24242 ���� ���
    SELECT 2636363*24242 FROM DUAL; 
    
    SELECT SYSDATE FROM DUAL;
    
 1)������
  - ���������(+,-,/,*,)
  - ��(����)������(>,<,=,>=,<=,!=(<>))
  - ����������(NOT,AND,OR) 
  
 ��뿹)HR ������ ������̺�(EMPLOYEES)���� ���ʽ��� ���ϰ� �� ����� �޿� ���޾��� ���Ͻÿ�.
       ���ʽ�=�⺻��(SALARY)*��������(COMMISSION_PCT)
       ���޾�=�⺻��+���ʽ�
       Alias�� �����ȣ,�����,�⺻��,���ʽ�,���޾��̴�.
       --NULL�� �����ϸ� +-*/���� �׻� NULL
       SELECT EMPLOYEE_ID AS �����ȣ,
              FIRST_NAME||' '||LAST_NAME AS �����,
              SALARY AS �⺻��,
              COMMISSION_PCT AS ��������,
              NVL(SALARY * COMMISSION_PCT,0) AS ���ʽ�, --NVL:NULLó�� �Լ�
              SALARY + NVL(SALARY * COMMISSION_PCT,0) AS ���޾�
         FROM HR.EMPLOYEES; --HR.���� �����߱� ������ SELECT������ HR�� ���� ����
         --�ٸ� ������ ���̺��� �̿��Ϸ��� �������� ������� ��(.���� ����)
         
 ��뿹)ȸ�����̺����� ���ϸ����� 3000�̻��� ȸ���� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ,ȸ����,���ϸ���,����
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_MILEAGE AS ���ϸ���,
              MEM_JOB AS ����
         FROM MEMBER
        WHERE MEM_MILEAGE>=3000
        ORDER BY 3 DESC; --�������� ����
       
 ��뿹)ȸ�����̺����� ���ϸ����� 3000�̻��̸鼭 �������� '����'�� ȸ���� ��ȸ�Ͻÿ�.
       Alias�� ȸ����ȣ,ȸ����,���ϸ���,����,���� --AS:Alias�� �����
       ���������� '����ȸ��', '����ȸ��' �� �ϳ��� ���
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_MILEAGE AS ���ϸ���,
              MEM_JOB AS ����,
              CASE WHEN SUBSTR(MEM_REGNO2,1,1)='1' THEN
                        '����ȸ��'
              ELSE
                        '����ȸ��'
              END AS ����          
         FROM MEMBER
        WHERE MEM_MILEAGE>=3000 
          AND MEM_ADD1 LIKE '����%'; --�������� �����ϸ� �� ����
              
 ��뿹)�⵵�� �Է¹޾� ����� ����� �����Ͻÿ�.
 
       ACCEPT P_YEAR PROMPT '�⵵�Է� : '
       DECLARE
        V_YEAR NUMBER := TO_NUMBER('&P_YEAR');
        V_RES VARCHAR2(100);
       BEGIN
        IF (MOD(V_YEAR,4)=0 AND MOD(V_YEAR,100)!=0) OR
           (MOD(V_YEAR,400)=0) THEN
           V_RES:=V_YEAR||'�⵵�� �����Դϴ�.';
        ELSE 
           V_RES:=V_YEAR||'�⵵�� ����Դϴ�.';
        END IF;
        DBMS_OUTPUT.PUT_LINE(V_RES);
       END;
       
 2)��Ÿ������
  - ���������̳� �������� ǥ������ ������ �� ���� ǥ��
  - IN, ANY, SOME, ALL, BETWEEN, LIKE, EXISTS ���� ����
  (1)IN ������ --IN �տ� ���迬���� ��� �Ұ�(IN �տ� =�� ������)
    . ���� Ž���� ���� ���� �� �̻��� ǥ������ ����
    . ���õ� �������� �ڿ� �� ��� �ϳ��� ��ġ�ϸ� ��ü ����� ���� ��ȯ
    (�������)
    �÷��� IN (��1[, ��2,...])
     - '�÷���'�� ����� ���� '��1[, ��2,...]'�� ��� �ϳ��� ��ġ�ϸ� ����� ��(true)�� ��ȯ
     - =ANY, =SOME ���� �ٲپ� ��� ������
     - ���ӵ� ���� BETWEEN����, �ҿ������� ���� �񱳴� IN���� ����
     - OR �����ڷ� ġȯ ����
     
 ��뿹)������̺����� �μ���ȣ 20, 50, 90, 110�� ���� ��������� ��ȸ�Ͻÿ�.
       Alias�� �����ȣ,�����,�μ���ȣ,�޿�
    (OR ������ ���)
        SELECT EMPLOYEE_ID AS �����ȣ,
               FIRST_NAME||' '||LAST_NAME AS �����,
               DEPARTMENT_ID AS �μ���ȣ,
               SALARY AS �޿�
          FROM HR.EMPLOYEES
         WHERE DEPARTMENT_ID = 20
            OR DEPARTMENT_ID = 50
            OR DEPARTMENT_ID = 90 
            OR DEPARTMENT_ID = 110
         ORDER BY 3; --ASC �⺻ --3:DEPARTMENT_ID
         
    (IN ������ ���)
        SELECT EMPLOYEE_ID AS �����ȣ,
               FIRST_NAME||' '||LAST_NAME AS �����,
               DEPARTMENT_ID AS �μ���ȣ,
               SALARY AS �޿�
          FROM HR.EMPLOYEES
         WHERE DEPARTMENT_ID IN (20,50,90,110) --WHERE�� ���̾�� SELECT ����
         ORDER BY 3;

  (2)ANY(SOME) ������ 
    . IN �����ڿ� ������ ��� ����
    . �־��� ������ �� ��� �ϳ��� ���� ANY(SOME)�տ� 
      ����� ���迬���ڸ� �����ϸ� ��(true)�� ����� ��ȯ 
    (�������)
    �÷��� ���迬����ANY|SOME(��1[,��2,...])
     
 ��뿹)������̺����� �μ���ȣ 20, 50, 90, 110�� ���� ��������� ��ȸ�Ͻÿ�.
       Alias�� �����ȣ,�����,�μ���ȣ,�޿�     
    (ANY ������ ���)
        SELECT EMPLOYEE_ID AS �����ȣ,
               FIRST_NAME||' '||LAST_NAME AS �����,
               DEPARTMENT_ID AS �μ���ȣ,
               SALARY AS �޿�
          FROM HR.EMPLOYEES
         WHERE DEPARTMENT_ID =ANY(20,50,90,110) --=ANY ���̿� ������ ������ �ȵ�
         ORDER BY 3;  

 ��뿹)ȸ�����̺����� ������ �������� ȸ������ ������ ���ϸ������� ���� ���ϸ����� ������ ȸ������ ��ȸ�Ͻÿ�.
       --���� ���� ������� ������ ��
       Alias�� ȸ����ȣ,ȸ����,����,���ϸ���
       SELECT MEM_ID AS ȸ����ȣ,
              MEM_NAME AS ȸ����,
              MEM_JOB AS ����,
              MEM_MILEAGE AS ���ϸ���
         FROM MEMBER
        WHERE MEM_MILEAGE >ANY(SELECT MEM_MILEAGE --ANY=SOME
                                FROM MEMBER
                               WHERE MEM_JOB='������'); 
       
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  