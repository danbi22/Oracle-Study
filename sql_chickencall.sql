-- 치킨 주문 분석:
-- 1. https://github.com/JakeOh/20230228_itwill_java140_lab_java/blob/master/lab-oracle/call_chicken.csv
-- 파일의 내용을 저장할 수 있는 테이블을 생성하는 SQL 문을 작성하세요.
create table ch1( -- 테이블을 만든다 create table (컬럼이름 데이터타입, ...);
    date1               date, -- 
    weekday          varchar2(100 char),
    loc                  varchar2(5 char),
    age                 varchar2(10 char),
    gender            varchar2(2 char), -- varchar2(자리수 타입 ex char) (자리수)만 쓸 경우 byte단위
    calling             number(10) -- 10개의 자리 ex) 1000000000
);


    
-- 2. SQLDeveloper에서 '데이터 임포트' 기능을 사용해서 CSV 파일의 내용을 테이블에 저장하세요.
insert into ch1 -- ch1에 데이터를 넣는다.
select * from checkencall; -- 치킨콜에서 모든데이터를 선택한다 

-- 3. 통화건수의 최솟값, 최댓값을 찾으세요.
select min(calling), max(calling) -- 
from ch1; -- ch1 테이블에서 calling의 최소값과 최대값을 선택한다.

-- 4. 통화건수가 최솟값이거나 최댓값인 레코드(행 전체)를 출력하세요.
select *-- 모든 값을 선택한다.
from ch -- ch1 테이블에서
where 통화건수 = (select min(통화건수) from ch) or 통화건수 = (select max(통화건수) from ch) -- 조건은 통화건수가 최소값이거나 통화건수가 최대값일 경우
order by trunc(avg(통화건수), 1) DESC; -- 

-- 5. 평균적으로 어떤 요일에서 치킨 주문이 많을까요?
select 요일, avg(통화건수) --   having 요일별 통화건수 평균의 최대값을 찾음 -> 요일별 통화건수의 평균을 요일별 최대 통화건수의 평균으로 바꿈
from ch
group by 요일
having avg(통화건수) = (select max(avg(통화건수)) from ch group by 요일);

select weekday, avg(calling)
    from ch1
    group by weekday
    having avg(calling) = (select max(avg(calling)) from ch1 group by weekday);


-- 6. 평균적으로 어떤 연령대가 치킨 주문을 많이 할까요?
select 연령대, avg(통화건수)
from ch
group by 연령대
having  avg(통화건수) = (select max(avg(통화건수)) from ch group by 연령대) ;


-- 7. 평균적으로 어느 지역에서 치킨 주문을 많이 할까요?
select 시군구, avg(통화건수)
from ch
group by 시군구
having avg(통화건수) = (select max(avg(통화건수)) from ch group by 시군구);


-- 8. 치킨 주문에 성별 차이가 있을까요?
select 성별, sum(통화건수)
from ch
group by 성별
order by trunc(sum(통화건수), 1) DESC;


-- 9. 요일별, 연령대별 통화건수의 평균을 찾으세요.
select 요일, 연령대, avg(통화건수)
from ch
group by 요일, 연령대
order by trunc(avg(통화건수), 1) DESC;


-- 10. 구별, 성별 통화건수의 평균을 찾으세요.
select 시군구, 성별, trunc(avg(통화건수),1)
from ch
group by 시군구, 성별
order by trunc(avg(통화건수), 1) DESC;

-- 11. 요일별, 구별, 연령대별 통화건수의 평균을 찾으세요.
select 요일, 시군구, 연령대, trunc(avg(통화건수), 1)
from ch
group by 요일, 시군구, 연령대
order by trunc(avg(통화건수), 1) DESC;

-- 3 ~ 11 문제의 출력은 통화건수 평균의 내림차순 정렬, 소숫점 2자리까지 반올림.