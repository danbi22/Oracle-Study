/* join: 2개 이상의 테이블에서 검색하는 것

join 문법:
    (1) ANSI 표준 문법:
        SELECT 컬럼, ...
        FROM 테이블1
            join 종류 테이블2 on join 조건;
            
    (2) Oracle 문법:
        SELECT 컬럼, ...
        FROM 테이블1, 테이블2, ...
        WHERE join 조건;
        
join 종류:
    (1) inner join
    (2) outer join
        - left outer join
        - right outer join
        - full outer join
*/

-- inner join과 outer join의 차이점을 보기 위해서
insert into emp (empno, ename, deptno) -- emp 테이블에 (empno, ename, deptno) 항목을 넣겠다.
values (1004, '다한', 50); -- 항목에 값을 넣음

commit; -- 넣은 값을 데이터베이스에 넣음

-- 사번, 이름, 부서번호, 부서이름을 검색 - inner join
SELECT e.empno, e.ename, e.deptno, d.dname
    FROM emp e
        inner join dept d on e.deptno = d.deptno;
        
SELECT e.empno, e.ename, e.deptno, d.dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno;
    
SELECT *
    FROM emp;
    
-- left outer join
select e.empno, e.ename, e.deptno, d.dname
    from emp e
        left outer join dept d on e.deptno = d.deptno;

select e.empno, e.ename, e.deptno, d.dname
    from emp e, dept d
    where e.deptno = d.deptno(+);
    
-- right outer join
select e.empno, e.ename, d.deptno, d.dname
    from emp e
        right outer join dept d on e.deptno = d.deptno;
        
select e.empno, e.ename, d.deptno, d.dname
    from emp e, dept d
    where e.deptno(+) = d.deptno;
    
-- full outer join
select e.empno, e.ename, e.deptno, d.deptno, d.dname
    from emp e
        full outer join dept d on e.deptno = d.deptno;

-- Oracle에서는 full outer join 문법을 제공하지 않음
-- left outer join 결과와 right outer join 결과를 합집합(union)하면 됨.
select e.empno, e.ename, e.deptno, d.deptno, d.dname
    from emp e, dept d
    where e.deptno = d.deptno(+) -- left outer join
    union -- 합집합
select e.empno, e.ename, e.deptno, d.deptno, d.dname
    from emp e, dept d
    where e.deptno(+) = d.deptno; -- right outer join;
    
-- inner join에서 inner는 생략 가능. inner join = join
-- left/right/full outer join에서 outer 생략 가능함 left outer join = left join

-- self-join: 같은 테이블에서 join하는 것
-- 사번, 이름, 매니저 사번, 매니저 이름 검색
select e1.empno as "사원 사번", e1.ename as "사원 이름", e2.empno as "매니저 사번", e2.ename as "매니저 이름"
    from emp e1
        join emp e2 on e1.mgr = e2.empno;

-- equi join: join 조건이 =를 사용해서 만들어지는 경우
-- non-equi join: join의 조건이 부등식(>, <, <=, >=, ...)을 사용해서 만들어지는 경우

-- emp, salgrade 테이블을 사용. 사번, 이름 , 급여, 급여 등급을 검색. 사번 오름차순 정렬
select e.empno, e.ename, e.sal, s.grade
    from emp e
        join salgrade s on e.sal BETWEEN s.losal and s.hisal
    order by e.empno;
    
select e.empno, e.ename, e.sal, s.grade
    from emp e, salgrade s
    where e.sal between s.losal and s.hisal
    order by e.empno;

-- ex1. 직원 이름, 직원 근무 도시를 검색. 근무 도시 오름차순 정렬
select e.ename, d.loc
    from emp e
        join dept d on e.deptno = d.deptno
    order by d.loc;
        
-- ex2. 직원이름, 매니저 이름, 급여, 급여 등급을 검색. 매니저 오름차순, 급여 등급 오름차순.
select e1.ename, e2.ename as 매니저이름, e1.sal, s.grade
    from emp e1
        join salgrade s on e1.sal between s.losal and s.hisal
        join emp e2 on e1.mgr = e2.empno
    order by e2.ename, e1.sal;
        
-- ex3. 직원이름, 부서이름, 급여, 급여 등급을 검색. 부서 이름 오름차순, 급여 등급 오름차순.
select e.ename, d.dname, e.sal, s.grade
    from emp e
        join salgrade s on e.sal between s.losal and s.hisal
        join dept d on e.deptno = d.deptno;
    order by d.dname, s.grade;
    
-- ex4. 부서이름, 부서 위치, 부서의 직원수를 검색. 부서 번호 오름차순
select d.dname, d.loc, count(e.deptno) as 직원수
    from emp e
        right join dept d on e.deptno = d.deptno
        group by d.deptno, d.dname, d.loc
    order by d.deptno;

-- ex5. 부서 번호, 부서 이름, 부서 직원수, 부서의 급여 최솟값, 부서의 급여 최댓값 검색
--       부서번호 오름 차순으로 정렬
select d.deptno, d.dname, count(e.deptno), min(sal), max(sal)
    from emp e
        right join dept d on e.deptno = d.deptno
        group by d.deptno, d.dname;

-- ex6. 부서 번호, 부서 이름, 사번, 이름, 매니저 사번, 매니저 이름, 급여, 급여 등급을 검색
        -- 급여가 3000 이상인 직원들만 검색
        -- 정렬 순서: (1) 부서 번호, (2) 사번 오름차순
select e1.deptno, d.dname, e1.empno, e1.ename, e2.empno, e2.ename, e1.sal, s.grade
    from emp e1
        join dept d on e1.deptno = d.deptno
        join emp e2 on e1.mgr = e2.empno
        join salgrade s on e1.sal between s.losal and s.hisal
    where e1.sal >= 3000
    order by e1.deptno, e1.empno;
-- 
















