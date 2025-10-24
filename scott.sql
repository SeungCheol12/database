-- sql 구문은 대소문자를 구별하지 않는다
-- 단, 비밀번호는 대소문자를 구별한다

-- 조회(selcet)
--select : 컬럼명 -- ⑤
--from : 테이블명 --①
--where : 조건절 --②
--group by -- ③
--having -- ④
--order by 컬럼명 : desc or asc -- ⑥

-- emp(사원) 테이블
-- empno(사번) : number(4, 0) => 숫자, 4자리, 소수점 아래 자릿수는 0
-- ename(이름) : varchar2(10) => 문자
-- job(직무)
-- mgr(매니저-상사 사원번호)
-- hiredate(입사일)
-- sal(급여) : number(7, 2)
-- comm(수당)

-- dept(부서) 테이블
-- deptno(부서번호)
-- dname(부서명)
-- loc(부서위치)

-- 조회 기본 구문
-- SELECT 보고싶은열이름....FROM 테이블명;
-- SELECT 보고싶은열이름....FROM 테이블명 WHERE 조건 나열 ;

--1) 전체 사원 조회 시 사원 모든 정보 추출
SELECT * FROM EMP e;

--2) 전체 사원 조회 시 사원 이름만 추출
SELECT ename FROM  EMP e 

--3) 전체 사원 조회 시 사번, 사원명, 부서번호만 추출
SELECT empno, ename, deptno FROM EMP e 

--4) 전체 사원 조회 시 부서번호만 추출
SELECT deptno FROM EMP e 

--5) 전체 사원 조회 시 부서번호만 추출 + 중복된 데이터 제거(distinct) 후 
SELECT DISTINCT deptno FROM EMP e 

--6) alais(별칭)
SELECT ename 사원명 FROM  EMP e 
SELECT ename "사원명" FROM  EMP e
SELECT ename AS "사원명" FROM  EMP e

--연봉 구하기(sal * 12 + comm)
SELECT empno, sal * 12 + comm AS 연봉 FROM EMP e 

--별칭에 공백이 있다면 " "로 묶는다 
SELECT ename "사원 이름" FROM  EMP e 

--오름차순(기본값), 내림차순 정렬 : order by 정렬기준 열이름... ASC(오름), DESC(내림)

--급여의 오름차순 정렬
SELECT * FROM emp ORDER BY sal ASC;

--급여의 내림차순 정렬
SELECT * FROM emp ORDER BY sal DESC;

--급여의 내림차순, 이름의 오름차순
SELECT * FROM emp ORDER BY sal DESC, ename ASC;


--empno : employee_no;
--ename : employee_name
--mgr : manager
--sal : salary
--comm : commission
--deptno : department_no
--별칭 지정, 부서번호를 기준으로 내림차순 정렬, 단 부서번호가 같다면 이름 오름차순

SELECT
	empno employee_no,
	ename employee_name,
	mgr manager,
	sal salary,
	comm commission,
	deptno department_no
FROM
	EMP e
ORDER BY
	deptno DESC,
	ename ASC; 

--부서번호가 30번인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30;

--사번이 7698 인 사원정보 조회
SELECT * FROM emp WHERE empno = 7698;

--부서번호가 30번이고 사원직책이 salesman인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30 AND job='SALESMAN';

--부서번호가 30번이거나 사원직책이 analyst인 사원정보 조회
SELECT * FROM emp WHERE deptno = 30 OR  job='ANALYST';

--연산자
--=, >, <, >=, <=, and, or, !=, <>, ^=
--in, between A and B(~이상 ~ 이하)
--like

--연봉이 36000인 사원 조회
SELECT * FROM EMP e WHERE  sal * 12 = 36000;

--급여가 3000 초과인 사원 조회
SELECT * FROM EMP e WHERE sal > 3000;

-- 이름이 'F' 이후의 문자로 시작하는 사원 조회
SELECT * FROM EMP e WHERE e.ENAME >= 'F';

--직무가 manager, salesman, clerk 인 사원 조회
SELECT * FROM EMP e WHERE e.JOB = 'SALESMAN' OR e.JOB = 'CLERK' OR e.JOB = 'MANAGER';

--sal 이 3000이 아닌 사원 조회
SELECT * FROM EMP e WHERE e.SAL != 3000;
SELECT * FROM EMP e WHERE e.SAL <> 3000;
SELECT * FROM EMP e WHERE e.SAL ^= 3000;

--직무가 manager, salesman, clerk 인 사원 조회 + in
SELECT * FROM EMP e WHERE e.JOB IN ('SALESMAN', 'CLERK' , 'MANAGER');

--직무가 manager, salesman, clerk 가 아닌 사원 조회 + not in
SELECT * FROM EMP e WHERE e.JOB NOT IN ('SALESMAN', 'CLERK' , 'MANAGER');

--부서번호가 10,20 번인 사원 조회 (or, in)
SELECT * FROM EMP e WHERE e.DEPTNO =10 OR e.DEPTNO =20;
SELECT * FROM EMP e WHERE e.DEPTNO IN (10, 20); 

--급여가 2000이상 3000이하인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL BETWEEN 2000 AND 3000;


--LIKE + 와일드카드(%, _)
--% : 길이와 상관없이 (문자 없는 경우도 포함) 모든 문자 데이터를 의미
--_ : 한개의 문자 데이터를 의미
--사원명이 s로 시작하는 사원들의 정보 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME LIKE 'S%';

--사원명의 두번째 글자가 L인 사원들의 정보 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME LIKE '_L%';

--사원명에 AM이 포함된 사원들의 정보 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME LIKE '%AM%';

--사원명에 AM이 포함되지 않은 사원들의 정보 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.ENAME NOT LIKE '%AM%';

--null 값
--null 값은 비교 시 = or != 사용하지 않음
SELECT * FROM emp WHERE comm IS NULL ;