/* 오라클 함수(function)
    1. 단일 행 함수:
        행(raw)이 하나씩 함수의 argument로 전달되고, 행 마다 하나씩 결과가 리턴되는 함수.
    2. 다중 행 함수:
        여러 개의 행이 함수의 argument로 전달되고, 하나의 결과가 리턴되는 함수.
        (예) 통계 관련 예: count, sum, avg, max, min, variance(분산), stddev(표준편차), ...
    (주의) 단일 행 함수와 그룹 함수는 동시에 select에서 사용할 수 없음.
*/

-- 단일 행 함수의 예 - 문자열을 소문자로 바꾸기
select ename, lower(ename)
from emp;

select ename, upper(ename)
from emp;

select ename, INITCAP(ename)
 from emp;

-- to_char(): 날짜 타입 데이터를 원하는 문자열 포멧으로 출력
select hiredate, to_char(hiredate, 'YYYY-MM-DD')
 FROM emp;

--nvl(컬럼, val): 컬럼이 null이면 val을 리턴하고, null이 아니면 원래 값을 리턴
--nvl2(컬럼, val1, val2): 컬럼이 null이 아니면 val1을 리턴하고, null이면 val2를 리턴
--nvl: null value
select comm, nvl(comm, -1)
    from emp;

select comm, nvl2(comm, comm, -1)
    from emp;
    
-- 다중행 함수
-- count(컬럼): null이 아닌 행의 개수를 리턴
select count(empno), count(mgr), count(comm)
from emp;

-- 테이블의 행(row)의 개수를 리턴. 
select count(*) 
from emp;

-- 통계 함수: 합계, 평균, 최댓값, 최솟값, 분산, 표준편차
select sum(sal), avg(sal), max(sal), min(sal), variance(sal), stddev(sal)
from emp;

-- select의 결과는 테이블로 나와야한다
-- select nvl(sal,0), sum(sal) from emp;
-- 단일 행 함수와 다중 행 함수는 함께 사용할 수 없다.

-- 그룹 별 쿼리:
-- select ... from ... [where ... ] group by ... [having ...] order by ...;
-- 부서별 급여 평균
select deptno, TRUNC(avg(sal),1)
    from emp
    group by deptno -- dept 중 동일한 value만 묶음
    order by deptno;

-- 모든 문제에서 소수점은 반올림해서 소수점이하 2자리까지만 표시하세요
--ex01. 부서별 급여평균, 표준편차를 부서 번호 오름차순으로 출력
select deptno, round(avg(sal),2) as "AVG_SAL", round(stddev(sal),2) as "STD_SAL"
    from emp
    group by deptno
    order by deptno;
    
--ex02. 직무별 직무, 직원수, 급여 최댓값, 최솟값, 평균을 직무 오름차순으로 출력
select job, count(job), max(sal), min(sal), round(avg(sal),2)
    from emp
    group by job
    order by job;
    
--ex03. 부서별, 직무별 부서번호, 직무, 직원수, 급여 평균을 검색
--      정렬순서: (1) 부서번호 (2) 직무
select deptno, job, count(ename), round(avg(sal),2) as "avg(sal)"
    from emp
    group by deptno, job
    order by deptno, job;

--ex04. 입사연도별 사원수를 검색 (힌트) to_char(날짜, 포멧)이용
select to_char(hiredate, 'YYYY') as 입사년도, count(*)
    from emp
    group by to_char(hiredate, 'YYYY')
    order by 입사년도;
    
/* select 문장 순서:
   select 컬럼, ...                                       [5]
   from 테이블                                         [1]
   where 그룹을 묶기 전에 검사할 조건식      [2]
   group by 그룹으로 묶어줄 컬럼, ...            [3]
   having 그룹을 묶은 다음에 검사할 조건식  [4] 
   order by 출력 순서를 결정하기 위한 컬럼   [6]
*/

-- 부서별 급여 평균 검색
select deptno, round(avg(sal), 2) as "부서별 평균급여"
    from emp
    group by deptno
    
    order by "부서별 평균급여";
    
-- mgr 컬럼이 null이 아닌 직원들 중에서 부서별 급여 평균을 검색. 부서번호 오름차순
select deptno, round(avg(sal), 2)
    from emp
    where mgr is not null 
    group by deptno
    order by deptno;
    
-- 직무별 사원수를 검색. PRESIDENT는 검색 제외. 직무별 사원수가 3명 이상인 직무만 검색
select  job, count(job) 
    from emp
    where 'PRESIDENT' not in job
    group by job
    having count(job) >= 3;
    
-- 입사연도, 부서번호, 입사연도별 부서별 사원수 검색
-- 1980년은 검색에서 제외
-- 연도별 부서별 사원수가 2명 이상인 경우만 선택
-- 연도별 오름차순
select to_char(hiredate, 'YYYY') as YEAR, deptno, count(*)
    from emp
    where to_char(hiredate, 'YYYY') !='1980'
    group by to_char(hiredate, 'YYYY'), deptno
    having count(deptno) >= 2
    order by YEAR, deptno;
    
-- 입사연도, 부서번호, 입사연도별 부서별 사원수 검색
-- 1980년은 검색에서 제외
-- 연도별 부서별 사원수가 2명 이상인 경우만 선택
-- 연도별 오름차순
select to_char(hiredate, 'YYYY'), deptno, count(*)
    from emp
    where to_char(hiredate, 'YYYY') != '1980'
    group by












