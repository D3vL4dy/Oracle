2022-0124-02)���� ������
 - �������� QUERY ����� �����Ͽ� ���ο� ����� ��ȯ
 - JOIN ������ ���� �� ����
 - ������(UNION, UNION ALL), ������(INTERSECT), ������(MINUS)����
   . UNION : �� ������ ��� ���Ҹ� �ߺ����� �ʰ� ��ȯ(����)
   . UNION ALL : �ߺ��� ����� �� ������ ��� ���Ҹ� ��ȯ(�������� ����)
   . INTERSECT : �� ������ ����� ���� ��ȯ(����)
   . MINUS : �������տ��� �ǰ������հ���� ������ ��� ��ȯ
  (�������)
    QUERY_1
   UNION|UNION ALL|INTERSECT|MINUS
    QUERY_2
  [UNION|UNION ALL|INTERSECT|MINUS
    QUERY_3]
        :
  [UNION|UNION ALL|INTERSECT|MINUS
    QUERY_n]
   - ��� ������ SELECT ���� �÷��� ���� Ÿ��, ������ �����ؾ���
   - ����� �⺻�� ù ��° SELECT ����
   - ORDER BY ���� �� ������ QUERY�� ��� ����
   
 1. UNION
  - �������� ��� ���
  - �ߺ��� ����
  
  
 ��뿹)������̺����� 2005�⵵�� �Ի��� ����� �μ��� �ÿ�Ʋ�� �ٹ��ϰ� �ִ� ����� ��ȸ�Ͻÿ�.
       Alias �����ȣ,�����,�Ի���,�μ���
 (2005�⵵�� �Ի��� ���)
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.HIRE_DATE AS �Ի���,
          B.DEPARTMENT_NAME AS �μ���
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
      AND EXTRACT(YEAR FROM A.HIRE_DATE) = 2005
      
 (�μ��� �ÿ�Ʋ�� ���)
   SELECT A.EMPLOYEE_ID,
          A.EMP_NAME,
          A.HIRE_DATE,
          B.DEPARTMENT_NAME
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
      AND B.LOCATION_ID = C.LOCATION_ID
      AND C.CITY = 'Seattle';
      
      
      
 (2005�⵵�� �Ի��� ���) --47���� ��ġ�� ��� �����ϰ� 42�� ���
   SELECT A.EMPLOYEE_ID AS �����ȣ,
          A.EMP_NAME AS �����,
          A.HIRE_DATE AS �Ի���,
          B.DEPARTMENT_NAME AS �μ���
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
      AND EXTRACT(YEAR FROM A.HIRE_DATE) = 2005
  UNION   
-- (�μ��� �ÿ�Ʋ�� ���)
   SELECT A.EMPLOYEE_ID,
          A.EMP_NAME,
          A.HIRE_DATE,
          B.DEPARTMENT_NAME
     FROM HR.EMPLOYEES A, HR.DEPARTMENTS B, HR.LOCATIONS C
    WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
      AND B.LOCATION_ID = C.LOCATION_ID
      AND C.CITY = 'Seattle';
      
      
      
 ��뿹)2005�� 4���� ���ԵȻ�ǰ�� ����Ȼ�ǰ�� �ߺ����� �ʰ�(UNION) ��� ��ȸ�Ͻÿ�.     
       Alias ��ǰ�ڵ�,��ǰ��,�ŷ�ó��
 (2005�� 4�� ���Ի�ǰ)      
       SELECT DISTINCT A.BUY_PROD AS ��ǰ�ڵ�,
              B.PROD_NAME AS ��ǰ��,
              C.BUYER_NAME AS �ŷ�ó��
         FROM BUYPROD A, PROD B, BUYER C    
        WHERE A.BUY_PROD = B.PROD_ID
          AND B.PROD_BUYER = C.BUYER_ID
          AND A.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050430')
      UNION      
-- (2005�� 4�� �����ǰ)
       SELECT DISTINCT A.CART_PROD,
              B.PROD_NAME,
              C.BUYER_NAME
         FROM CART A, PROD B, BUYER C    
        WHERE A.CART_PROD = B.PROD_ID
          AND B.PROD_BUYER = C.BUYER_ID
          AND A.CART_NO LIKE '200504%';
          
          
          
 ��뿹)2005�� 6���� 7���� ��ǰ�� ������ ȸ���� ��ȸ�Ͻÿ�.
       Alias ȸ����ȣ,ȸ����,�ּ�,���ϸ���
 (2005�� 6�� ��ǰ�� ������ ȸ��)       
       SELECT DISTINCT A.CART_MEMBER AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              B.MEM_ADD1||''||MEM_ADD2 AS �ּ�,
              B.MEM_MILEAGE AS ���ϸ���
         FROM CART A, MEMBER B 
        WHERE A.CART_MEMBER = B.MEM_ID
          AND A.CART_NO LIKE '200506%'
      UNION    
-- (2005�� 7�� ��ǰ�� ������ ȸ��)      
       SELECT DISTINCT A.MEM_ID AS ȸ����ȣ,
              A.MEM_NAME AS ȸ����,
              A.MEM_ADD1||''||MEM_ADD2 AS �ּ�,
              A.MEM_MILEAGE AS ���ϸ���
         FROM MEMBER A, CART B
        WHERE A.MEM_ID = B.CART_MEMBER
          AND B.CART_NO LIKE '200507%' 
        ORDER BY 1;  
       
       
 2. INTERSECT
  - �� SQL ����� ������(����� ����)�� ��ȯ
  
 ��뿹)2005�⵵ �ݾױ��� ���Լ��� ���� 5�� ǰ��� ������� ���� 5�� ǰ���� ��ȸ�Ͽ� ���� ��θ� �����ϴ� ��ǰ������ ����Ͻÿ�.
       Alias ��ǰ�ڵ�,��ǰ��,�з���(LPROD)
       
 (2005�⵵ �ݾױ��� ���Լ��� ���� 5�� ǰ��)  
   SELECT C.BID AS ��ǰ�ڵ�,
          C.BNAME AS ��ǰ��,
          C.BSUM AS �ݾ�,
          C.BRANK AS ����
     FROM (SELECT A.BUY_PROD AS BID,
                  B.PROD_NAME AS BNAME,
                  SUM(A.BUY_QTY * B.PROD_COST) AS BSUM,
                  RANK() OVER(ORDER BY SUM(A.BUY_QTY * B.PROD_COST) DESC) AS BRANK
             FROM BUYPROD A, PROD B
            WHERE A.BUY_PROD = B.PROD_ID
              AND EXTRACT(YEAR FROM A.BUY_DATE)=2005
            GROUP BY A.BUY_PROD, B.PROD_NAME) C
     WHERE C.BRANK <= 5       
  INTERSECT     
--(2005�⵵ �ݾױ��� ������� ���� 5�� ǰ��)  
   SELECT D.CID AS ��ǰ�ڵ�,
          D.CNAME AS ��ǰ��,
          D.CSUM AS �ݾ�,
          D.CRANK AS ����
     FROM (SELECT A.CART_PROD AS CID,
                  B.PROD_NAME AS CNAME,
                  SUM(A.CART_QTY * B.PROD_COST) AS CSUM,
                  RANK() OVER(ORDER BY SUM(A.CART_QTY * B.PROD_COST) DESC) AS CRANK
             FROM CART A, PROD B
            WHERE A.CART_PROD = B.PROD_ID
              AND A.CART_NO LIKE '2005%'
            GROUP BY A.CART_PROD, B.PROD_NAME) D
     WHERE D.CRANK <= 5;  
     
 ��뿹)2005�� 1���� 5���� ���Ե� ��ǰ������ ��ȸ�Ͻÿ�.
       Alias ��ǰ�ڵ�,��ǰ��,�з���
 (2005�� 1���� ���Ե� ��ǰ)
   SELECT DISTINCT(A.BUY_PROD) AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          C.LPROD_NM AS �з���
     FROM BUYPROD A, PROD B, LPROD C
    WHERE A.BUY_PROD = B.PROD_ID
      AND B.PROD_LGU = C.LPROD_GU
      AND A.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
 INTERSECT 
--(2005�� 5���� ���Ե� ��ǰ)
   SELECT DISTINCT A.BUY_PROD AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          C.LPROD_NM AS �з���
     FROM BUYPROD A, PROD B, LPROD C
    WHERE A.BUY_PROD = B.PROD_ID
      AND B.PROD_LGU = C.LPROD_GU
      AND A.BUY_DATE BETWEEN TO_DATE('20050501') AND LAST_DAY(TO_DATE('20050501')) --���� ������ ��¥ ��ȯ
    ORDER BY 1;         
       
 3. MINUS
  - �� ������ �����հ���� ��ȯ
  - ��� ������ �߿�
  
 ��뿹)2005�� 6,7�� �� 6���޿��� �Ǹŵ� ��ǰ������ ��ȸ�Ͻÿ�.
       Alias ��ǰ�ڵ�,��ǰ��,�ǸŰ�,���԰�
 (2005�� 6�� �Ǹŵ� ��ǰ)
   SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          B.PROD_PRICE AS �ǸŰ�,
          B.PROD_COST AS ���԰�
     FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200506%'
 MINUS--������ 2�� ����
-- INTERSECT:������ 2�� MINUS�� �ݴ�
-- (2005�� 7�� �Ǹŵ� ��ǰ)
   SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          B.PROD_PRICE AS �ǸŰ�,
          B.PROD_COST AS ���԰�
     FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200507%'   
    ORDER BY 1;
  
 (EXISTS ������)  
   SELECT DISTINCT A.CART_PROD AS ��ǰ�ڵ�,
          B.PROD_NAME AS ��ǰ��,
          B.PROD_PRICE AS �ǸŰ�,
          B.PROD_COST AS ���԰�
     FROM CART A, PROD B
    WHERE A.CART_PROD = B.PROD_ID
      AND A.CART_NO LIKE '200506%'
      AND NOT EXISTS (SELECT 1 --NOT���� ���� ������ �� (NOT�� ������ INTERSECT�� ����)
                        FROM CART C
                       WHERE C.CART_PROD = A.CART_PROD --���� ��ǰ�ڵ带 ������ ��(SELECT 1)
                         AND C.CART_NO LIKE '200507%')
    ORDER BY 1;              
                
    
    
 **�����Լ�(RANK OVER)
  - Ư���÷��� �������� ����ȭ��Ű�� ����ο�
  - RANK OVER, DENSE_RANK ���� �ִ�.
  1) RANK
   . ������ �ο�
   . ���� ���� ���� ������ �ο��ϰ� �� ������ �ߺ��� ������ŭ ������ �����Ͽ� �ο�
     (ex 1, 2, 2, 2, 5, 6...)
   . SELECT ���� ���
   (�������)
    RANK() OVER(ORDER BY �÷��� [ASC|DESC]) [AS ��Ī]
     - '�÷���'�� �������� ����ο�
     
 ��뿹)2005�� 5�� ���űݾ��� ���� 5���� ȸ���� ��ȸ�Ͻÿ�.
       Alias ȸ����ȣ,ȸ����,���űݾ�
       SELECT A.CART_MEMBER AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              SUM(A.CART_QTY * C.PROD_PRICE) AS ���űݾ�
         FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID
          AND A. CART_PROD = C.PROD_ID
          AND ROWNUM <= 5 --�����ű��:5�� �߷��� ORDER BY �����ϸ� 
        GROUP BY A.CART_MEMBER, B.MEM_NAME
        ORDER BY 3 DESC;
        
 (�������� ���)
 
    (�������� : 2005�� ȸ���� ���űݾ� ���, ���űݾ��� ������ ������������)
     SELECT A.CART_MEMBER AS CID,
            SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
       FROM CART A, PROD B
      WHERE A.CART_PROD = B.PROD_ID
        AND A.CART_NO LIKE '2005%'
      GROUP BY A.CART_MEMBER
      ORDER BY 2 DESC
       
    (�������� : ���űݾ��� ���� 5���� ȸ���� ȸ����ȣ,ȸ����,���űݾ��� ��ȸ�Ͻÿ�.)
     SELECT M.MEM_ID AS ȸ����ȣ,
            M.MEM_NAME AS ȸ����,
            C.CSUM AS ���űݾ�
       FROM MEMBER M, 
           (SELECT A.CART_MEMBER AS CID,
                   SUM(A.CART_QTY * B.PROD_PRICE) AS CSUM
              FROM CART A, PROD B
             WHERE A.CART_PROD = B.PROD_ID
               AND A.CART_NO LIKE '2005%'
             GROUP BY A.CART_MEMBER
             ORDER BY 2 DESC) C
      WHERE M.MEM_ID = C.CID
        AND ROWNUM <= 5 --5���� �߷��� ���
             
             
 ��뿹)2005�� 5�� ���űݾ��� ���� ȸ������ ����� �ο��Ͽ� ��ȸ�Ͻÿ�.
       Alias ȸ����ȣ,ȸ����,���űݾ�,���
       SELECT A.CART_MEMBER AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              SUM(A.CART_QTY * C.PROD_PRICE) AS ���űݾ�,
              RANK() OVER(ORDER BY SUM(A.CART_QTY * C.PROD_PRICE) DESC) AS ���
         FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID
          AND A.CART_PROD = C.PROD_ID
          AND A.CART_PROD = C.PROD_ID
        GROUP BY A.CART_MEMBER, B.MEM_NAME;   
       
  2) �׷쳻���� ����
   (�������)
   RANK() OVER(PARTITION BY �÷���[,�÷���,...]
               ORDER BY �÷���[,�÷���...][ASC|DESC])
   . PARTITION BY �÷��� : �׷����� ���� �÷��� ��� --������ �ο��ϱ� ����
   
 ��뿹)������̺����� �� �μ��� ������� �޿��� ������ ������ �ο��Ͽ� ����Ͻÿ�.
       ������ �޿��� ���� ��� ������ �ο��ϰ� ���� �޿��̸� �Ի����� ���� ������ �ο��Ͻÿ�.
       Alias �����ȣ,�����,�μ���,�޿�,����
       
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              B.DEPARTMENT_NAME AS �μ���,
              A.SALARY AS �޿�,
              A.HIRE_DATE AS �Ի���,
              RANK() OVER(PARTITION BY A.DEPARTMENT_ID 
                          ORDER BY A.SALARY DESC, HIRE_DATE ASC) AS ����
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID;
 
  3) �׷쳻���� ���� 
   - ���� �ο�
   - ���� ���̸� ���� ���� �ο��ϸ�, �������� ���� ���� ������ ������� ���� ���� �ο�(ex, 1,1,1,2,3,4,...)
   - ������ Ư¡�� RANK()�� ����
   
  4) ROW_NUMBER() 
   - ���� �ο�                     �� 9 9 9 8 7 6
   - ���� ���̶� �������� ���� �ο�(ex, 1,2,3,4,5,6,...)
   - ������ Ư¡�� RANK()�� ����   
   
 ��뿹)ȸ�����̺����� �������� '����'�� ȸ������ ���ϸ����� ��ȸ�ϰ� ���� ���� ������ �ο��Ͻÿ�.
 
 
 ��뿹)������̺����� �޿��� 5000������ ������� ��ȸ�ϰ� �޿��� ���� ������ �ο��Ͻÿ�.
 (RANK() �Լ� ���)
   SELECT EMPLOYEE_ID AS �����ȣ,
          EMP_NAME AS �����,
          DEPARTMENT_ID AS �μ��ڵ�,
          SALARY AS �޿�,
          RANK() OVER(ORDER BY SALARY DESC) AS ����   
     FROM HR.EMPLOYEEs
    WHERE SALARY <= 5000;
    
 (DENSE_RANK() �Լ� ���) --�������� ���� ���� ������ ������� ���� ���� �ο�
   SELECT EMPLOYEE_ID AS �����ȣ,
          EMP_NAME AS �����,
          DEPARTMENT_ID AS �μ��ڵ�,
          SALARY AS �޿�,
          DENSE_RANK() OVER(ORDER BY SALARY DESC) AS ����
     FROM HR.EMPLOYEEs
    WHERE SALARY <= 5000;    
    
 (ROW_NUMBER() �Լ� ���) --���� ����� ���ʴ�� �� �ο� (���� ����� ����)
   SELECT EMPLOYEE_ID AS �����ȣ,
          EMP_NAME AS �����,
          DEPARTMENT_ID AS �μ��ڵ�,
          SALARY AS �޿�,
          ROW_NUMBER() OVER(ORDER BY SALARY DESC) AS ����
     FROM HR.EMPLOYEEs
    WHERE SALARY <= 5000; 