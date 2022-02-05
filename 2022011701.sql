2022-0117-01)
 ��뿹)��ǰ���̺��� ��ǰ�з��� ����ǸŰ�,��ո��԰��� ��ȸ�Ͻÿ�.
    SELECT PROD_LGU AS ��ǰ�з��ڵ�,
           ROUND(AVG(PROD_PRICE)) AS ����ǸŰ�,
           ROUND(AVG(PROD_COST)) AS ��ո��԰�,
           ROUND(AVG(PROD_PRICE) - AVG(PROD_COST)) AS ���������
      FROM PROD
     GROUP BY PROD_LGU
     ORDER BY 1;
     
 ��뿹)������̺��� �ٹ����� �̱� �̿��� �μ��� �ٹ��ϴ� ������� ��ձ޿��� ��ձټӳ���� ��ȸ�Ͻÿ�.
       �μ��ڵ�,�μ���,��ձ޿�,��ձټӳ�� --�μ��� �μ��ڵ忡�� ã�� ��ġ�ڵ带 LOCATIONS���̺��� ã�� COUNTRYY_ID���� �̱��� US�� �Ǿ�����
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
              B.DEPARTMENT_NAME AS �μ���,
              ROUND(AVG(A.SALARY),1) AS ��ձ޿�,
              ROUND(AVG(EXTRACT(YEAR FROM SYSDATE)
              -EXTRACT(YEAR FROM A.HIRE_DATE))) AS ��ձټӳ��
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
              HR.LOCATIONS C
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID --����� �ٹ��ϰ� �ִ� �ּҸ� �˾Ƴ��� ���� ����
          AND B.LOCATION_ID = C.LOCATION_ID
          AND C.COUNTRY_ID!='US'
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME 
        ORDER BY 1;
          
 **COUNT �Լ�
  - �� �׷쳻�� ���� ��(�ڷ� ��)�� ��ȯ
  (�������)
    COUNT(�÷���|*)
     . �ܺ����ΰ� ���� Ư���� ��츦 �����ϰ� '*'�� ����ϸ�, �� ��� ��� �÷��� NULL�� �൵ COUNT��
     . '�÷���' : �ش� �÷��� NULL�� �ƴ� �ڷ��� ���� ��ȯ�ϸ�, �ַ� �ܺ����ο� ���.
                 �̶����� �ش� ���̺��� �⺻Ű�� ����ϴ� ���� ������
         
 ��뿹)������̺��� �� �μ��� ������� ��ȸ�Ͻÿ�.
    SELECT DEPARTMENT_ID AS �μ��ڵ�,
           COUNT(*) AS �����,
           COUNT(EMPLOYEE_ID) AS �����2,
           COUNT(SALARY) AS �����3
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;     
    
 ��뿹)������̺��� �μ��� �ٹ��ϴ� ������� 5�� �̻��� �μ��� ��ȸ�Ͻÿ�.
    SELECT DEPARTMENT_ID AS �μ��ڵ�,
           COUNT(*) AS �����
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
    HAVING COUNT(*) >= 5
     ORDER BY 1; 
     
 ��뿹)��ǰ���̺��� �з��� ��ǰ���� ��ȸ�Ͻÿ�.
    SELECT PROD_LGU AS ��ǰ�ڵ�,
           COUNT(*) AS ��ǰ��
      FROM PROD
     GROUP BY PROD_LGU
     ORDER BY 1; 
 
 ��뿹)2005�� 5~7�� ��ٱ������̺��� ���� ����Ǽ��� ��ȸ�Ͻÿ�.
    SELECT SUBSTR(A.CNO,5,2)||'��' AS ��,
           COUNT(*) AS ����Ǽ� 
      FROM (SELECT DISTINCT CART_NO AS CNO
              FROM CART
             WHERE SUBSTR(CART_NO,1,6) BETWEEN '200505' AND '200507'
             GROUP BY CART_NO) A
     GROUP BY SUBSTR(A.CNO,5,2)
     ORDER BY 1;          
         
         
 **MAX(�÷���|����), MIN(�÷���|����)        
         
 ��뿹)������̺��� �� �μ��� �ִ�޿���, �ּұ޿��� ��ȸ�Ͻÿ�.
    SELECT DEPARTMENT_ID AS �μ��ڵ�,
           MAX(SALARY) AS �ִ�޿�,
           MIN(SALARY) AS �ּұ޿�
      FROM HR.EMPLOYEES
     GROUP BY DEPARTMENT_ID
     ORDER BY 1;
    
 ��뿹)������̺��� �� �μ��� �ִ�޿���, �ּұ޿��� �����ϴ� ����� ��ȸ�Ͻÿ�.         
    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
           A.EMP_NAME AS �����, 
           B.MXS AS �ִ�޿���
      FROM HR.EMPLOYEES A,
           (SELECT DEPARTMENT_ID AS DID,
                   MAX(SALARY) AS MXS
              FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID) B
     WHERE B.DID = A.DEPARTMENT_ID
       AND A.SALARY = B.MXS
     ORDER BY 1;    
         
    SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
           A.EMP_NAME AS �����, 
           B.MNS AS �ּұ޿���
      FROM HR.EMPLOYEES A,
           (SELECT DEPARTMENT_ID AS DID,
                   MIN(SALARY) AS MNS
              FROM HR.EMPLOYEES
             GROUP BY DEPARTMENT_ID) B
     WHERE B.DID = A.DEPARTMENT_ID
       AND A.SALARY = B.MNS
     ORDER BY 1;    
     
 ��뿹)2005�� 1�� ��ǰ�� �ּ� ���Աݾ��� ��ȸ�Ͻÿ�. 
    (��ǰ�� ���Ծ�)
    SELECT A.BID AS ��ǰ�ڵ�,
           MIN(A.SQC) AS �ּҸ��Աݾ�
      FROM (SELECT BUY_PROD AS BID,
                   SUM(BUY_QTY * BUY_COST) AS SQC --MIN(SUM):�׷��Լ��� �׷��Լ��� ������ �� ����
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131') 
             GROUP BY BUY_PROD) A
     GROUP BY A.BID
     ORDER BY 1;
         
 ��뿹)2005�� 1�� ��ǰ�� ���Աݾ��հ� �� �ּ� �ݾ��� ����� ��ǰ�� ��ȸ�Ͻÿ�.
       Alias ��ǰ�ڵ�,���Աݾ�  
    (��ǰ�� ���Ծ�)
    SELECT C.BID AS ��ǰ�ڵ�,
           C.SQC AS ���Աݾ�
      FROM (SELECT MIN(A.SQC) AS MBS 
              FROM (SELECT BUY_PROD AS BID, --�� ��ǰ�� 1�� ���Աݾ� ���� ���(��ǰ�ڵ�,���Աݾ��հ�)
                           SUM(BUY_QTY * BUY_COST) AS SQC 
                      FROM BUYPROD
                     WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131') 
                     GROUP BY BUY_PROD) A)B,
           (SELECT BUY_PROD AS BID,
                   SUM(BUY_QTY * BUY_COST) AS SQC
              FROM BUYPROD
             WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050131')
             GROUP BY BUY_PROD) C
     WHERE C.SQC = B.MBS;        