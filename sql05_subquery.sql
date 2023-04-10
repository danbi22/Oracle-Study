--sub Query: 쿼리의 일부로 다른 쿼리 문이 사용되는 것.

-- (1) 전체 직원의 급여 평균
select avg(sal) from emp;

-- (2) 전체 직원의 급여 평균보다 더 많은 급여를 받는 직원의 레코드:
select *
from emp
where sal > 2073.21;

select *
from emp
where sal > (select avg(sal) from emp)
order by deptno;

-- ALLEN보다 적은 급여를 받는 직원들의 사번, 이름, 급여를 검색
select empno, ename, sal
    from emp
    where sal < (select sal from emp where ename = 'ALLEN');
    
-- ALLEN과 같은 직무의 직원들의 사번, 이름, 부서번호, 직무, 급여를 검색
select empno, ename, deptno, job, sal
    from emp
    where job = (select job from emp where ename = 'ALLEN');
    
-- SALESMAN의 급여 최댓값보다 더 많은 급여를 받는 직원들의 이름, 급여, 직무를 검색
select ename, sal, job
    from emp
    where sal > (select MAX(sal) from emp where job = 'SALESMAN');

-- WARD의 연봉보다 더 많은 연봉을 받는 직원들의 이름, 급여, 수당, 연봉을 검색
-- 연봉계산 sal*12 + comm. comm이 null인 경우에는 0으로 계산에 포함
-- 연봉 내림차순
select ename, sal, comm, (sal*12+nvl(comm, 0)) as 연봉
    from emp
    where (sal*12+nvl(comm, 0)) > (select (sal*12+nvl(comm, 0)) from emp where ename = 'WARD')
    order by 연봉 desc;
    
-- SCOTT과 같은 급여를 받는 직원들의 이름과 급여를 검색
select ename, sal
    from emp
    where sal = (select sal from emp where ename = 'SCOTT');
    
-- 위 결과에서 SCOTT은 제외하고 검색
select ename, sal
    from emp
    where sal = (select sal from emp where ename = 'SCOTT') and ename not in 'SCOTT';

-- ALLEN보다 늦게 입사한 직원들의 이름, 입사날짜를 최근입사일부터 출력
select ename, hiredate
    from emp
    where hiredate > (select hiredate from emp where ename = 'ALLEN')
    order by hiredate desc;

-- 매니저가 KING인 직원들의 사번, 이름, 매니저 사번을 검색
select empno, ename, mgr
    from emp
    where mgr = (select empno from emp where ename = 'KING');

-- ACCOUNTING 부서에 일하는 직원들의 이름, 급여, 부서번호를 검색.
select ename, sal, deptno
    from emp
    where deptno = (select deptno from dept where dname = 'ACCOUNTING');
    
-- CHICAGO에서 근무하는 직원들의 이름, 급여, 부서 번호를 검색
select ename, sal, deptno
    from emp
    where deptno = (select deptno from dept where loc = 'CHICAGO');
    
-- 단일 행 서브쿼리: 서브쿼리의 결과가 행이 1개 이하인 경우.
-- 다중 행 서브쿼리: 서브쿼리의 결과가 2개 이상의 행인 경우.
-- 다중 행 서브쿼리에서는 한 개의 값과 단순 비교(=, !=, >, <, ...)를 할 수 없음
-- 다중 행 서브쿼리에서는 in, any, all과 같은 키워드를 함께 사용해야 함.

-- 각 부서에서 급여를 가장 많이 받는 직원의 모든 정보(사번, 이름, 급여, ...)을 검색
select *
    from emp
    where (deptno, sal) in (
        select deptno, 
        max(sal) 
        from emp 
        group by deptno
    )
    order by deptno;
    
select deptno, max(sal)
    from emp
    group by deptno;
    
-- 각 부서에서 급여가 가장 작은 직원들의 모든 정보를 출력 
select *
    from emp
    where (deptno, sal) in(
        select deptno, min(sal)
        from emp
        group by deptno
    )
    order by sal desc;
