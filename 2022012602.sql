2022-0126-02)PL/SQL(Procedural Language SQL)
 - ǥ�� SQL�� ������ ����� Ư¡�� �߰�
 - block ������ ������
 - DBMS�� �̸� �����ϵǾ� ����ǹǷ� ���� ����� ��Ʈ��ũ�� ȿ�������� �̿��Ͽ� ��ü SQL ���� ȿ���� ����
 - ����, ���, �ݺ�ó��, ���Ǵ�, ����ó�� ����
 - ǥ�� ������ ����
 - User Defined Function(��ȯ���� �ִ� ���), Stored Procedure, Trigger, Package, Anonymous block ���� ���� --�͸����� �⺻ ����
 
 1.Anonymous Block(�͸���)
  - PL/SQL�� �⺻ ����
  - �� ����� �� ����
 (�������)
    DECLARE
      ����� - ����,���,Ŀ�� ����;
    BEGIN
      ����� - �����ذ��� ���� �����Ͻ� ����ó�� SQL��;
      
      [EXCEPTION
        ����ó����;]
    END;    
    