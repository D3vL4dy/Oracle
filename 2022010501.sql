 2022-0105-01)
2. ALTER
 - 생성된 객체의 성격, 구조, 이름 등을 변경
 
 1)컬럼 추가
   ALTER TABLE 테이블명 ADD (컬럼명 데이터타입[(크기)]{,
                           컬럼명 데이터타입[(크기)],...]);
 사용예)상품테이블(GOODS)에 매입가격(COST)컬럼을 추가하시오.
       매입가격은 숫자 7자리 정수임
   ALTER TABLE GOODS ADD(COST NUMBER(7));   
    
 2)컬럼 변경(데이터타입, 크기)    
   ALTER TABLE 테이블명 MODIFY (컬럼명 데이터타입[(크기)]{,
                              컬럼명 데이터타입[(크기)],...]);
 사용예)상품테이블(GOODS)에 매입가격(COST)컬럼의 데이터타입을 변경하시오.
       데이터타입은 가변길이 문자열 7자리로 변경
   ALTER TABLE GOODS MODIFY(COST VARCHAR2(7));

 3)컬럼 삭제
   ALTER TABLE 테이블명 DROP COLUMN 컬럼명;
   
   ALTER TABLE GOODS DROP COLUMN COST;
   
 4)컬럼이름 변경
   ALTER TABLE 테이블명 RENAME COLUMN old_컬럼명 TO new_컬럼명;
 사용예)상품테이블의 단가컬럼명(PRICE)를 G_PRICE로 변경하시오.
   ALTER TABLE GOODS RENAME COLUMN PRICE TO G_PRICE;   

 5)제약사항(기본키 및 외래키) 추가
   ALTER TABLE 테이블명 ADD CONSTRAINT 기본키/외래키인덱스
         PRIMARY/FOREIGN KEY(컬럼명, [컬럼명,...])
         [REFERENCES 테이블명(컬럼명)];

 6)제약사항(기본키 및 외래키) 삭제
   ALTER TABLE 테이블명 DROP CONSTRAINT 기본키/외래키인덱스;
 
 7)테이블 이름 변경 
   ALTER TABLE old_테이블명 RENAME TO new_테이블명;