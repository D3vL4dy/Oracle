2022-0119-02)
    �������� : 2022�� 1�� 28��
    ������ : ��������(\\Sem\��������\Oracle\homework01)
    ���ϸ� : �޸��� ���� Ȱ���Ͽ� txt �Ǵ� doc �Ǵ� hwp ���Ϸ� �����Ͽ� ����
            ���ϸ��� �̸��ۼ�����.txt(ex ȫ�浿20220127.txt)
            
            
 ����]������̺��� �μ��� ����ӱ��� ���ϰ� �ش�μ��� ���� ��� �� �ڱ�μ��� ��� �޿����� ���� �޿��� �޴� ����� ��ȸ�Ͻÿ�.          
     Alias �����ȣ,�����,�μ���,�μ���ձ޿�,�޿�  --(�μ���ձ޿�<=�޿�)
    
       --���� ���� ������ ��� �޿����� �� ���� �޿��� �ް� �ִ� �����
     SELECT A.EMPLOYEE_ID AS �����ȣ,
            A.EMP_NAME AS �����,
            B.DEPARTMENT_NAME AS �μ���,
            C.ASAL AS �μ���ձ޿�,
            A.SALARY AS �޿�
       FROM HR.EMPLOYEES A, HR.DEPARTMENTS B,
            (SELECT DEPARTMENT_ID AS BID,
                    AVG(SALARY) AS ASAL
               FROM HR.EMPLOYEES
              GROUP BY DEPARTMENT_ID) C 
      WHERE A.DEPARTMENT_ID = B.DEPARTMENT_ID
        AND B.DEPARTMENT_ID = C.BID
        AND A.SALARY >= C.ASAL
      ORDER BY 1;
    
    
            
            
            