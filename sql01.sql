/*
* Block comment
*/

 -- inline comment
 -- SQL 문장은 세미콜론(;)으로 끝남.
 -- Ctrl+Enter: 현재 커서가 있는 위치의 SQL 한 문장(세미콜론 기준)을 실행.
 -- F5: 스크립트(확장자가 sql인 파일) 전체를 실행.
 
 -- SELECT로 시작하는 문장을 쿼리라고한다?
 -- dual 실제 테이블은 아니고, 문법을 맞추기 위한 가상의 테이블(실제 테이블을 대체한 것) oracle에서만 쓴다.
 SELECT sysdate from dual;
 
 --EMP 테이블의 모든 내용을 검색:
 -- * 별표: 전부, 모든 것, 모든 컬럼
 -- emp의 모든 것을 선택하겠다
 select * from emp;
 
 -- DQL(Data Query Language): 테이블의 내용을 검색
 -- select 컬럼 이름, ... from 테이블 이름;
 -- dual: 오라클 데이터베이스에서 select 문장의 문법을 맞추기 위해서 사용하는 가상의 테이블 이름.
 select sysdate from dual;
 
 -- SQL 명령어(키워드), 테이블 이름, 컬럼 이름은 대/소문자를 구분하지 않는다.
 -- 대/소문자를 섞어 쓰는 것은 지양하자
 SELECT * FROM EMP;
 Select * From Emp;
SELECT * FROM emp;
select * from EMP; -- 개발자마다 대/소문자를 쓰는 법이 다르다

-- 테이블에 저장된 데이터는 대/소문자를 구분한다.








