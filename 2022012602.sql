2022-0126-02)PL/SQL(Procedural Language SQL)
 - 표준 SQL에 절차적 언어의 특징이 추가
 - block 구조로 구성됨
 - DBMS에 미리 컴파일되어 저장되므로 빠른 실행과 네트워크를 효율적으로 이용하여 전체 SQL 실행 효율을 증대
 - 변수, 상수, 반복처리, 비교판단, 에러처리 가능
 - 표준 문법이 없음
 - User Defined Function(반환값이 있는 모듈), Stored Procedure, Trigger, Package, Anonymous block 등이 제공 --익명블록이 기본 구조
 
 1.Anonymous Block(익명블록)
  - PL/SQL의 기본 구조
  - 재 사용할 수 없음
 (사용형식)
    DECLARE
      선언부 - 변수,상수,커서 선언;
    BEGIN
      실행부 - 문제해결을 위한 비지니스 로직처리 SQL문;
      
      [EXCEPTION
        예외처리부;]
    END;    
    