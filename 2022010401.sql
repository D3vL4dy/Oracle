2022-0104-01) 사용자 생성
  ~:1의 보수   @:at    ^:거듭제곱  &:AND   *:ALL   [생략 가능..]
 . CREATE USER - 사용자 생성
 . GRANT - 권한부여
 
 1)사용자 생성
  CREATE USER 유저명 IDENTIFIED BY 암호;
  
  CREATE USER KJI97 IDENTIFIED BY java;
  
 2)권한부여
  GRANT 권한명1, [권한명2,...] TO 유저명;
  
  GRANT CONNECT, RESOURCE, DBA TO KJI97;