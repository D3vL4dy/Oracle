2022-0114-01)�����Լ�(�׷��Լ�)
 - �־��� �ڷḦ Ư�� �÷�(��)�� �������� �׷�ȭ�ϰ� �� �׷쿡�� 
   �հ�(SUM),���(AVG),�󵵼�(COUNT),�ִ밪(MAX),�ּҰ�(MIN)�� ��ȯ�ϴ� �Լ�
 - SELECT ���� �����Լ��� ������ �Ϲ� �÷��� ���� ���Ǹ� �ݵ�� GROUP BY ���� ���Ǿ�� ��
 - �����Լ��� ���� �÷�(����)�� ������ �ο��� ��� HAVING ���� ó��
 - �����Լ��� �ٸ� �����Լ��� ������ �� ����
 
 (�������)
    SELECT [�÷�list,]
           �׷��Լ�     
      FROM ���̺��
    [WHERE ����]
    [GROUP BY �÷���[,�÷���2,...]
   [HAVING ����]
   [ORDER BY �÷���|�÷��ε��� [ASC|DESC][,...]
   . GROUP BY �÷���1[,�÷���2,...]:�÷��� 1�� �������� �׷�ȭ�ϰ� �� �׷쿡�� �ٽ� '�÷���2'�� �׷�ȭ
   . SELECT ���� ���� �Ϲ��÷��� �ݵ�� GROUP BY ���� ����ؾ��ϸ�, 
     SELECT ���� ������� ���� �÷��� GROUP BY ���� ��� ����
   . SELECT ���� �׷��Լ��� ���� ��� GROUP BY �� ����(���̺� ��ü�� �ϳ��� �׷����� ����)
   . SUM(expr),AVG(expr),COUNT(*|expr),MAX(expr),MIN(expr)
   
   --��1:GROUP BY �÷�1 /��2:GROUP BY �÷�2
 ��뿹)������̺��� �� �μ��� �޿��հ踦 ���Ͻÿ�. --������̺��� �μ��� �������� �׷�ȭ 
       Alias �μ��ڵ�,�޿��հ�
       SELECT DEPARTMENT_ID AS �μ��ڵ�,
              SUM(SALARY)
         FROM HR.EMPLOYEES
        GROUP BY DEPARTMENT_ID --�����Լ��� ������ SELECT ���� ����� �÷� �ʼ� 
        ORDER BY 1;  
       
 ��뿹)������̺��� �� �μ��� �޿��հ踦 ���ϵ� �޿��հ谡 100000�̻��� �μ��� ��ȸ�Ͻÿ�.
       Alias �μ��ڵ�,�޿��հ�
       SELECT DEPARTMENT_ID AS �μ��ڵ�,
              SUM(SALARY) AS �޿��հ�
         FROM HR.EMPLOYEES
        --WHERE SUM(SALARY)>=100000 //WHERE���� �׷��Լ��� ���� ���� ó���� �Ұ��� 
        GROUP BY DEPARTMENT_ID
       HAVING SUM(SALARY)>=100000  
        ORDER BY 1;
                
 ��뿹)������̺��� �� �μ��� ��ձ޿��� ���Ͻÿ�.  
       Alias �μ��ڵ�,�μ���(DEPARTMENTS),��ձ޿�(EMPLOYEES) --���ο����� ������ ��Ī ���
       SELECT A.DEPARTMENT_ID AS �μ��ڵ�,
              B.DEPARTMENT_NAME AS �μ���,
              ROUND(AVG(A.SALARY),1) AS ��ձ޿�
         FROM HR.EMPLOYEES A, HR.DEPARTMENTS B --��Ī�� ������� ������ ���̺� �̸��� ��� ������
        WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID --�����Լ��� ������ SELECT ���� ����� �÷� �ʼ� 
        GROUP BY A.DEPARTMENT_ID, B.DEPARTMENT_NAME
        ORDER BY 1;
        
 ��뿹)��ü����� ��ձ޿��� ���
       SELECT ROUND(AVG(SALARY)) AS ��ձ޿�, --��ü�� �ϳ��� �׷��̱� ������ GROUP BY�� ������� ����
              SUM(SALARY) AS �޿��հ�,
              COUNT(*) AS �ο���
         FROM HR.EMPLOYEES;
         
 ��뿹)������� �޿��� ��ձ޿����� ���� ��������� ��ȸ�Ͻÿ�.   
       Alias �����ȣ,�����,�μ��ڵ�,�����ڵ�,�޿�,��ձ޿�  --SELECT�� ���� ������ �׷��� ������� �ʰڴ� 
       SELECT A.EMPLOYEE_ID AS �����ȣ,
              A.EMP_NAME AS �����,
              A.DEPARTMENT_ID AS �μ��ڵ�,
              A.JOB_ID AS �����ڵ�,
              A.SALARY AS �޿�,
              B.ASAL AS ��ձ޿�
         FROM HR.EMPLOYEES A, (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES) B  
        WHERE A.SALARY < B.ASAL
        ORDER BY 3;
        
        SELECT EMPLOYEE_ID AS �����ȣ,
              EMP_NAME AS �����,
              DEPARTMENT_ID AS �μ��ڵ�,
              JOB_ID AS �����ڵ�,
              SALARY AS �޿�,
              (SELECT ROUND(AVG(SALARY)) FROM HR.EMPLOYEES) AS ��ձ޿�
         FROM HR.EMPLOYEES
        WHERE SALARY < (SELECT ROUND(AVG(SALARY)) AS ASAL FROM HR.EMPLOYEES) 
        ORDER BY 3;

 
 ����1] ��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż������踦 ���Ͻÿ�.
      SELECT CART_PROD AS ��ǰ�ڵ�,
             SUM(CART_QTY) AS �Ǹż�������
        FROM CART
       WHERE SUBSTR(CART_NO,1,6) = '200504' --CART_NO LIKE '200504%'  �� ����
       --LIKE:���Ϻ� (%,_ ���) 
       --SUBSTR:�ڸ� ��� =������ ��� 
       GROUP BY CART_PROD
       ORDER BY 1;
 
 ����2] ��ٱ������̺��� 2005�� 4�� ��ǰ�� �Ǹż��� �հ谡 10�� �̻��� ��ǰ�� ��ȸ�Ͻÿ�.
      SELECT CART_PROD AS ��ǰ��,
             SUM(CART_QTY) AS �Ǹż�������
        FROM CART 
       WHERE SUBSTR(CART_NO,1,6) LIKE '200504%'
       GROUP BY CART_PROD
       HAVING SUM(CART_QTY) >= 10
       ORDER BY 1; 
       
 ����3] �������̺��� 2005�� 1~6�� ���� �������踦 ���Ͻÿ�. 
       ��,���Լ����հ�,���Աݾ��հ� 
      SELECT EXTRACT(MONTH FROM BUY_DATE) AS ��,
             SUM(BUY_QTY) AS ���Լ����հ�,
             SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ�
        FROM BUYPROD
       WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630') --TO_DATE:��¥ �������� ��ȯ
       GROUP BY EXTRACT(MONTH FROM BUY_DATE)
       ORDER BY 1;
       
 ����4] �������̺��� 2005�� 1~6�� ����, ��ǰ�� ���Աݾ� �հ谡 1000���� �̻��� ������ ��ȸ�Ͻÿ�.      
      SELECT EXTRACT(MONTH FROM BUY_DATE) AS ��,
             BUY_PROD AS ��ǰ�ڵ�,
             SUM(BUY_QTY) AS ���Լ����հ�,
             SUM(BUY_QTY * BUY_COST) AS ���Աݾ��հ�
        FROM BUYPROD
       WHERE BUY_DATE BETWEEN TO_DATE('20050101') AND TO_DATE('20050630') --TO_DATE:��¥ �������� ��ȯ
       GROUP BY EXTRACT(MONTH FROM BUY_DATE),BUY_PROD
      HAVING SUM(BUY_QTY * BUY_COST)>=10000000 
       ORDER BY 1; 
 
 ����5]ȸ�����̺��� ���� ���ϸ��� �հ踦 ���Ͻÿ�.
      Alias ����, ���ϸ����հ��̸�, ���п��� '����ȸ��'�� '����ȸ��'�� ���
      SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR 
                        SUBSTR(MEM_REGNO2,1,1) = '3' THEN 
                        '����ȸ��'
              ELSE 
                        '����ȸ��'
              END AS ����,
             SUM(MEM_MILEAGE) AS ���ϸ����հ�
        FROM MEMBER
       GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR 
                        SUBSTR(MEM_REGNO2,1,1) = '3' THEN 
                        '����ȸ��'
                 ELSE 
                        '����ȸ��'
                 END 
       ORDER BY 2;          
      
 ����6]ȸ�����̺��� ���ɴ뺰 ���ϸ��� �հ踦 ��ȸ�Ͻÿ�.  
      Alias ����, ���ϸ����հ��̸� ���ж����� '10'��,..,'70��' ������ ���ɴ븦 ����Ͻÿ�.
      SELECT TRUNC(EXTRACT(YEAR FROM SYSDATE) -  ------------------------------����
                   EXTRACT(YEAR FROM MEM_BIR),-1)||'��' AS ����,
             SUM(MEM_MILEAGE) AS ���ϸ����հ�
        FROM MEMBER 
       GROUP BY TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
                      EXTRACT(YEAR FROM MEM_BIR),-1)
       ORDER BY 1;             
      
      SELECT CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR 
                       SUBSTR(MEM_REGNO2,1,1) = '2' THEN 
                  TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
                   (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900), -1) --TRUNC -1:1���ڸ� ����
                    
             ELSE TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
                   (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000), -1)
                        
             END ||'��' AS ����,
             SUM(MEM_MILEAGE) AS ���ϸ����հ�
        FROM MEMBER
       GROUP BY CASE WHEN SUBSTR(MEM_REGNO2,1,1) = '1' OR 
                       SUBSTR(MEM_REGNO2,1,1) = '2' THEN 
                  TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
                   (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+1900), -1)
                    
                ELSE TRUNC(EXTRACT(YEAR FROM SYSDATE) - 
                   (TO_NUMBER(SUBSTR(MEM_REGNO1,1,2))+2000), -1)
                        
                END 
       ORDER BY 1;         
      
        
 ��뿹)��ǰ���̺��� �з��� ��ո��԰��� ��ȸ�Ͻÿ�.
       Alias ��ǰ�з��ڵ�,��ǰ���Դܰ�
       SELECT PROD_LGU AS ��ǰ�з��ڵ�,
              ROUND( AVG(PROD_COST),-1) AS ��ո��԰�
         FROM PROD 
        GROUP BY PROD_LGU
        ORDER BY 1;
                
 ��뿹)������̺��� �� �μ��� ������� ���Ͻÿ�.  
       Alias �μ��ڵ�,�μ���,�����
       
         
       
 ��뿹)������̺��� �� �μ��� �ִ�޿��� �ּұ޿�  
       Alias �μ��ڵ�,�μ���,�ִ�޿�,�ּұ޿�
