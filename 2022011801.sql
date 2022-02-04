2022-0118-01) TABLE JOIN
 - �����ͺ��̽� ���迡 ����ȭ ������ �����ϸ� ���̺��� ���ҵǰ� �ʿ��� �ڷḦ ��ȸ�ϱ� ���� 
   �������� ���̺��� ������ �÷��� �������� ���꿡 �����ؾ� �� => ���� ����
 - ������ �����ͺ��̽��� �⺻ ����  
 - ����
  . ��������(INNER JOIN)�� �ܺ�����(OUTER JOIN) 
  --��������:ǥ���ϴ� �������� ������ ���� ���� �������� ���� �ڷḦ ��� ���� (90%�̻� ���)
  --�ܺ�����:���� ���� �������� ������ �κ��� NULL�� ä�� ����
  . �Ϲ����ΰ� ANSI JOIN 
  --ANSI JOIN:DBMS ������� �� ���� ����
  . ��������(EQUI JOIN)�� �񵿵�����(NON EQUI JOIN)
  --���� ���ǿ� ���Ǿ����� ���� ���ǿ� ���� (��������:=������)(�񵿵�����:=�̿��� ������) 
 
  
 1. Cartesian Product
  - ���������� �����Ǿ��ų� �߸� ����� ���
  - ANSI JOIN ������ Cross Join �̶�� ��
  - ������ ����� �־��� ��� ����� ���� ����� ���� ���� ���� ��� ��ȯ
  - �Ұ����ϰ� �ʿ��� ��찡 �ƴϸ� ������� ���ƾ� ��
  
  (�������) --�Ϲ�����
   SELECT �÷�list
     FROM ���̺��1 [��Ī1],���̺��2 [��Ī2][,���̺��3 [��Ī3],...]
    WHERE ��������1 --���������� ���̺� ������ n�϶� n-1���� ���;�
    --�� ���̺� ���̿� ������ �÷��� �־�� �����ڸ� ����� �������� 
     [AND ��������2,...]
     [AND �Ϲ�����]
     
   (CROSS JOIN�� ����) --ANSI JOIN
   SELECT �÷�list
     FROM ���̺��1 [��Ī1] 
    CROSS JOIN ���̺��2[��Ī2]
   [CROSS JOIN ���̺��3[��Ī3] --���̺��3�� ���̺��1,2�� ����� ���ε�
                   :
   [WHERE �Ϲ�����];                
     
 ��뿹)
    SELECT COUNT(*) FROM CART;
    SELECT COUNT(*) FROM PROD;
    SELECT 207*74 FROM DUAL; --15318
    
    --Cartesian Product
    SELECT COUNT(*) --15318
      FROM CART, PROD; --��:207*74   ��:4,20
    
    SELECT COUNT(*) --2267000
      FROM CART, PROD, BUYPROD;
     WHERE CART_QTY != PROD_QTYSALE; 
     
    --ANSI JOIN
    SELECT COUNT(*) --2267000
      FROM CART
     CROSS JOIN PROD
     CROSS JOIN BUYPROD;
      
 2. Equi Join --���� ���� ���
  - �������ǹ��� �������('=')�� ���
  - ���� ���̺��� ���� N���϶� ���������� ��� N-1�� �̻�
  - ANSI ������ INNER JOIN ����� �ǰ���
  
  (�������-�Ϲ� ���ι�)
   SELECT [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī][,]
                            :
          [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī]
     FROM ���̺��[��Ī],���̺��[��Ī][,���̺��[��Ī],...]
    WHERE ��������
     [AND ��������]
            :
     [AND �Ϲ�����];       
     
   (�������-ANSI ���ι�)
   SELECT [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī][,]
                            :
          [���̺��.|���̺�Ī.]�÷��� [AS �÷���Ī]
     FROM ���̺��1[��Ī]
    INNER JOIN ���̺��2[��Ī] ON(�������� [AND �Ϲ�����]) --���� ���̺� ���� ����
   [INNER JOIN ���̺��3[��Ī] ON(�������� [AND �Ϲ�����])
    WHERE �Ϲ�����]; --��ü ���̺� ���� ����  
    - ���̺��1�� ���̺��2�� �ݵ�� ���� �����ؾ� ��(���� �÷��� �ݵ�� �־�� ��)
     
     
 ��뿹)��ǰ���̺�� �з����̺��� �̿��Ͽ� �ǸŰ��� 10���� �̻��� ��ǰ�� ��ȸ�Ͻÿ�.
       Alias ��ǰ�ڵ�,��ǰ��,�з��ڵ�,�з���,�ǸŰ�
       
    (�Ϲ� ����)
       SELECT A.PROD_ID AS ��ǰ�ڵ�,
              A.PROD_NAME AS ��ǰ��,
              A.PROD_LGU AS �з��ڵ�, --B.LPROD_GU�� ����
              B.LPROD_NM AS �з���,
              A.PROD_PRICE AS �ǸŰ�
         FROM PROD A, LPROD B
        WHERE A.PROD_PRICE >= 100000 --�Ϲ�����:�ǸŰ��� 10���� �̻�
          AND A.PROD_LGU = B.LPROD_GU --��������:�� ���̺��� ����� �÷��� =���� ����
          --������ �÷��� �ٲ㼭 ����ϸ� �ȵ�
        ORDER BY 5 DESC; 
        
    (ANSI ����)
        SELECT A.PROD_ID AS ��ǰ�ڵ�,
              A.PROD_NAME AS ��ǰ��,
              A.PROD_LGU AS �з��ڵ�, --B.LPROD_GU�� ����
              B.LPROD_NM AS �з���,
              A.PROD_PRICE AS �ǸŰ�
         FROM PROD A --FROM ���̺�1 INNER ���̺�2
        INNER JOIN LPROD B ON(A.PROD_LGU = B.LPROD_GU AND
              A.PROD_PRICE >= 100000)
        ORDER BY 5 DESC;    
         
         
 ��뿹)2005�� 6�� ȸ���� ������Ȳ�� ��ȸ�Ͻÿ�. --����:CART ���̺�
       Alias ȸ����ȣ,ȸ����,���űݾ��հ� --ȸ����:MEMBER ���̺�
       
    (�Ϲ� ����)
       SELECT A.CART_MEMBER AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              SUM(A.CART_QTY * C.PROD_PRICE) AS ���űݾ��հ� --PROD ���̺�
         FROM CART A, MEMBER B, PROD C
        WHERE A.CART_MEMBER = B.MEM_ID --��������:ȸ������ �����ϱ� ����
          AND A.CART_PROD = C.PROD_ID --��������:�ǸŴܰ��� �����ϱ� ����
          AND A.CART_NO LIKE '200506%' --�Ϲ�����
        GROUP BY A.CART_MEMBER, B.MEM_NAME;  --�Ϲ� �÷��� �����Լ��� ���� ���Ǹ� GROUP BY�� ���
     
    (ANSI ����)
       SELECT A.CART_MEMBER AS ȸ����ȣ,
              B.MEM_NAME AS ȸ����,
              SUM(A.CART_QTY * C.PROD_PRICE) AS ���űݾ��հ� 
         FROM CART A
        INNER JOIN MEMBER B ON(A.CART_MEMBER = B.MEM_ID)
        INNER JOIN PROD C ON(C.PROD_ID = A.CART_PROD)
        WHERE A.CART_NO LIKE '200506%' --�Ϲ�����
        GROUP BY A.CART_MEMBER, B.MEM_NAME;    
        
        
 ��뿹)�μ��� �ο����� ����ӱ��� ��ȸ�Ͻÿ�.
       Alias �μ��ڵ�,�μ���,�ο���,����ӱ�
       
    (�Ϲ� ����)
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
              B.DEPARTMENT_NAME AS �μ���,
              COUNT(*) AS �ο���, --*�̳� �÷����̳� ����� ����
              ROUND(AVG(A.SALARY)) AS ����ӱ�
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1; 
        
    (ANSI ����)
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
              B.DEPARTMENT_NAME AS �μ���,
              COUNT(*) AS �ο���,
              ROUND(AVG(A.SALARY)) AS ����ӱ�
         FROM HR.EMPLOYEES A
        INNER JOIN HR.DEPARTMENTS B ON(A.DEPARTMENT_ID = B.DEPARTMENT_ID) --���������� ���� �κ��� �������� ���� �ڷḦ ����
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;        
        
     
 ����1]2005�� 1~6�� �� �ŷ�ó�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias �ŷ�ó�ڵ�,�ŷ�ó��,���Աݾ��հ� --�ŷ�ó��:BUYER  ����:BUYPROD  >������ �÷��� ���� ����X (PROD:�߸ſ���)
     
     (�Ϲ� ����)
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
            A.BUYER_NAME AS �ŷ�ó��,
            SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ��հ�
       FROM BUYER A, PROD B, BUYPROD C
      WHERE A.BUYER_ID = B.PROD_BUYER
        AND B.PROD_ID = C.BUY_PROD
        AND C.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630') --TO_DATE:'����'�� ��¥ �������� ��ȯ (�ּ� 8�ڸ�) 
      GROUP BY A.BUYER_ID, A.BUYER_NAME
      ORDER BY 1;
      
      (ANSI ����)
     SELECT A.BUYER_ID AS �ŷ�ó�ڵ�,
            A.BUYER_NAME AS �ŷ�ó��,
            SUM(C.BUY_QTY * C.BUY_COST) AS ���Աݾ��հ�
       FROM BUYER A
      INNER JOIN PROD B ON (A.BUYER_ID = B.PROD_BUYER)
      INNER JOIN BUYPROD C ON (B.PROD_ID = C.BUY_PROD)
      WHERE C.BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630')
      GROUP BY A.BUYER_ID, A.BUYER_NAME
      ORDER BY 1;
     
 ����2]2005�� 4~6�� �� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias ��ǰ�ڵ�,��ǰ��,��������հ�,����ݾ��հ�
     
     (�Ϲ� ����)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            SUM(B.CART_QTY) AS ��������հ�,
            SUM(A.PROD_PRICE * B.CART_QTY) AS ����ݾ��հ�
       FROM PROD A, CART B
      WHERE A.PROD_ID = B.CART_PROD
        AND SUBSTR(B.CART_NO,1,6) BETWEEN ('200504') AND ('200506')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1; 
      
      (ANSI ����)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            SUM(B.CART_QTY) AS ��������հ�,
            SUM(A.PROD_PRICE * B.CART_QTY) AS ����ݾ��հ�
       FROM PROD A
      INNER JOIN CART B ON (A.PROD_ID = B.CART_PROD)
      WHERE SUBSTR(B.CART_NO,1,6) BETWEEN ('200504') AND ('200506')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
      
     
 ����3]2005�� 4~6�� �� ��ǰ�� ������Ȳ�� ��ȸ�Ͻÿ�.
     Alias ��ǰ�ڵ�,��ǰ��,���Լ����հ�,���Աݾ��հ�     
     
     (�Ϲ� ����)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            SUM(B.BUY_QTY) AS ���Լ����հ�,
            SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�
       FROM PROD A, BUYPROD B
      WHERE A.PROD_ID = B.BUY_PROD
        AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
     
     (ANSI ����)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            SUM(B.BUY_QTY) AS ���Լ����հ�,
            SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�
       FROM PROD A
      INNER JOIN BUYPROD B ON (A.PROD_ID = B.BUY_PROD)
      WHERE B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
     
 ����4]2005�� 4~6�� �� ��ǰ�� ����/������Ȳ�� ��ȸ�Ͻÿ�.
     Alias ��ǰ�ڵ�,��ǰ��,���Աݾ��հ�,����ݾ��հ�     
     
     (�Ϲ� ����)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�,
            SUM(A.PROD_PRICE * C.CART_QTY) AS ����ݾ��հ�
       FROM PROD A, BUYPROD B, CART C 
      WHERE A.PROD_ID = C.CART_PROD
        AND A.PROD_ID = B.BUY_PROD
        AND B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
        AND SUBSTR(C.CART_NO,1,6) BETWEEN ('200504') AND ('200506')
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;
     
     (ANSI ����)
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            SUM(A.PROD_COST * B.BUY_QTY) AS ���Աݾ��հ�,
            SUM(A.PROD_PRICE * C.CART_QTY) AS ����ݾ��հ�
       FROM PROD A
      INNER JOIN BUYPROD B ON (A.PROD_ID = B.BUY_PROD AND  --�����ִ� �͵��� �ϳ��� ����(����+�Ϲ� ����)
                 B.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630'))
      INNER JOIN CART C ON (A.PROD_ID = C.CART_PROD AND
                 SUBSTR(C.CART_NO,1,6) BETWEEN ('200504') AND ('200506'))
      GROUP BY A.PROD_ID, A.PROD_NAME
      ORDER BY 1;  
     
     (SUBQUERY ���) --���� ��� ���Աݾ��հ�*2�� ��µǾ� ���������� ����� �ۼ�
     SELECT A.PROD_ID AS ��ǰ�ڵ�,
            A.PROD_NAME AS ��ǰ��,
            BSUM AS ���Աݾ��հ�,
            CSUM AS ����ݾ��հ�
       FROM PROD A,
            (SELECT CC.BUY_PROD AS BID,
                    SUM(CC.BUY_QTY*BB.PROD_COST) AS BSUM
               FROM PROD BB, BUYPROD CC
              WHERE BB.PROD_ID = CC.BUY_PROD
                AND CC.BUY_DATE BETWEEN TO_DATE('20050401') AND TO_DATE('20050630')
              GROUP BY CC.BUY_PROD) B,
            (SELECT CC.CART_PROD AS CID,  
                    SUM(CC.CART_QTY * BB.PROD_PRICE) AS CSUM
               FROM PROD BB, CART CC
              WHERE BB.PROD_ID = CC.CART_PROD
                AND SUBSTR(CC.CART_NO,1,6) BETWEEN '200504' AND '200506'
              GROUP BY CC.CART_PROD) C  
      WHERE A.PROD_ID = B.BID(+) --(+):�ܺ�����(���� ���� �������� ���)
        AND A.PROD_ID = C.CID(+)
      ORDER BY 1;  
    

     
     
     
     
     
     
     
     
     
     
     
     
     
     
     