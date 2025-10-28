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
SELECT * FROM emp WHERE comm IS NOT NULL ;

--집합 연산자
--합집합(union, union all), 교집합(intersect), 차집합(minus)
-- 합집합 : 출력하려는 열 개수와 자료형이 일치해야한다

--deptno=10 union deptno=20
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION 
SELECT
	*
FROM
	EMP e
WHERE
	e.DEPTNO = 20;

--union all
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10
UNION  
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

--minus
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
MINUS 
SELECT 
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

--intersect
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
INTERSECT 
SELECT 
	e.EMPNO ,
	e.ENAME ,
	e.SAL
FROM
	EMP e
WHERE
	e.DEPTNO = 10;

--
--1. 사원 이름이 S로 끝나는 사원 데이터 조회
SELECT
	*
FROM
	EMP e
WHERE 
e.ENAME LIKE '%S';

--2. 30번 부서에 근무하고 있는 사원 중에 job이 salesman 인 사원의 사원번호, 이름, 직책, 급여, 부서번호 조회
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	e.DEPTNO 
FROM
	EMP e
WHERE 
e.DEPTNO = 30
AND 
e.JOB = 'SALESMAN';

--3. 20번, 30번 부서에 근무하고 있는 사원 중 급여가 2000초과인 사원을 다음 두 방식의 select 문을 사용하여 
-- 사원번호, 이름, 직책, 급여, 부서 번호를 출력
-- 집합 연산자를 사용하는 방식
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	e.DEPTNO 
FROM
	EMP e
WHERE 
e.DEPTNO = 20
AND 
e.SAL > 2000
UNION 
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	e.DEPTNO 
FROM
	EMP e
WHERE 
e.DEPTNO = 30
AND 
e.SAL > 2000;
-- 집합 연산자를 사용하지 않는 방식

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	e.DEPTNO 
FROM
	EMP e
WHERE 
e.DEPTNO IN (20, 30)
AND 
e.SAL > 2000;
--4. not between a and b 연산자를 사용하지 않고 급여열이 2000이상 3000이하 범위 이외의 값을 가진 데이터 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.SAL < 2000
	OR 
e.SAL > 3000;
--5. 사원 이름에 E 가 포함된 30번 부서의 사원 중 급여가 1000~2000 사이가 아닌 사원명, 사번, 급여, 부서번호 조회
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.SAL ,
	e.DEPTNO
FROM
	EMP e
WHERE
	e.ENAME LIKE '%E%'
	AND
e.DEPTNO = 30
	AND 
e.SAL NOT BETWEEN 1000 AND 2000;

--6. 추가 수당이 없고 상급자가 있고 직책이 manager, clerk 인 사원 중에서 사원이름의 두번째 글자가 L이 아닌
--사원의 정보를 조회
SELECT
	*
FROM
	EMP e
WHERE
	e.COMM IS NULL
	AND 
	e.MGR IS NOT NULL
	AND 
	e.JOB IN ('MANAGER', 'CLECK')
	AND 
	e.ENAME NOT LIKE '_L%';

--함수
--1. 문자함수
--upper(문자열) : 대문자 변환
--lower(문자열) : 소문자 변환
--initcap(문자열) : 첫글자는 대문자, 나머지 문자는 소문자
--length(문자열) : 문자열 길이
--lengthb(문자열) : 문자열의 바이트 길이
--substr(문자열데이터, 시작위치, 추출길이) : 문자열 부분추출
--instr(문자열, 위치를 찾으려는 문자, 시작위치, 대상의 위치가 몇 번째인지) : 문자열 데이터 안에서 특정 문자 위치 찾기
--replace(문자열, 찾는 문자, 바꿀 문자)
--concat(문자열1, 문자열2) : 두 문자열 데이터를 합친다
--trim(삭제옵션(선택), 삭제할문자(선택) from 원본 문자열)
--1) 삭제 옵션 : leading or trailing or both
--Ltrim(원본 문자열, 삭제할 문자열)
--Rtrim(원본 문자열, 삭제할 문자열)

SELECT e.ENAME , UPPER(ename), LOWER(ename), INITCAP(ename)
FROM EMP e ;

SELECT e.ENAME , LENGTH(ename), LENGTHB(ename)
FROM EMP e ;

--dual : sys 소유의 더미 테이블
SELECT LENGTH('한글'), LENGTHB('한글')
FROM dual ;

--사원명 길이가 5자 이상인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE 
LENGTH(e.ENAME) >= 5; 

--직책명이 6자 이상인 사원 조회
SELECT
	*
FROM
	EMP e
WHERE 
LENGTH(e.JOB) >= 6; 

SELECT job, SUBSTR(e.JOB, 1, 2), SUBSTR(e.JOB, 3, 2), SUBSTR(e.JOB, 5)   
FROM EMP e ;

--emp 테이블에서 사원명을 세번째 글자부터 끝까지 출력
SELECT e.ENAME , SUBSTR(e.ENAME ,3) 
FROM EMP e ;

-- -8    -1
-- salesman
SELECT job, SUBSTR(e.JOB,-LENGTH(e.job)), SUBSTR(e.JOB, -LENGTH(e.JOB ), 2), SUBSTR(e.JOB, -3)   
FROM EMP e ;

--instr
SELECT
	INSTR('HELLO ORACLE!', 'L') AS 첫번째,
	INSTR('HELLO ORACLE!', 'L', 5) AS 두번째,
	INSTR('HELLO ORACLE!', 'L', 2, 2) AS 세번째
FROM
	DUAL;

--사원명에 문자 S 가 포함된 사원 조회
--1) LIKE 2) INSTR

SELECT 
E.ENAME 
FROM EMP e 
WHERE
INSTR(E.ENAME , 'S') > 0;

--010-4526-7858 => 010 4526 7858 or 01045267858
SELECT
	'010-4526-7858' AS BEFORE,
	REPLACE('010-4526-7858', '-', ' ') AS replace1,
	REPLACE('010-4526-7858', '-', '') AS replace2
FROM
	dual;

--empno, ename 합치기
SELECT CONCAT(e.EMPNO , e.ENAME ), CONCAT(e.EMPNO , CONCAT(':', e.ENAME )), e.ENAME || e.EMPNO 
FROM EMP e ;

--trim
SELECT
	'[' || TRIM(' __Oracle__ ') || ']' AS trim,
	'[' || TRIM(LEADING FROM ' __Oracle__ ') || ']' AS trim_leading,
	'[' || TRIM(TRAILING FROM ' __Oracle__ ') || ']' AS trim_trailing,
	'[' || TRIM(BOTH FROM ' __Oracle__ ') || ']' AS trim_both
FROM
	dual;

--2. 숫자 함수
--round(숫자, 반올림 위치)
--trunc(숫자, 버림 위치)
--ceil(숫자) : 지정된 숫자보다 큰 정수 중 가장 작은 정수 반환
--floor(숫자) : : 지정된 숫자보다 큰 정수 중 가장 큰 정수 반환
--mod(숫자, 나눌 숫자) : 지정된 숫자를 나눈 나머지 반환

SELECT ROUND(1234.5678) AS round,
ROUND(1234.5678, 0) AS round0,
ROUND(1234.5678, 1) AS round1,
ROUND(1234.5678, 2) AS round2,
ROUND(1234.5678, -1) AS round_minus1,
ROUND(1234.5678, -2) AS round_minus2
FROM dual;

--trunc
SELECT trunc(1234.5678) AS trunc,
trunc(1234.5678, 0) AS trunc0,
trunc(1234.5678, 1) AS trunc1,
trunc(1234.5678, 2) AS trunc2,
trunc(1234.5678, -1) AS trunc_minus1,
trunc(1234.5678, -2) AS trunc_minus2
FROM dual;

SELECT ceil(3.14), FLOOR(3.14), ceil(-3.14), FLOOR(-3.14)
FROM dual;

--날짜 함수
--날짜 데이터 + 숫자 : 이후 날짜 반환
--날짜 데이터 - 숫자 : 이전 날짜 반환
--날짜 데이터 - 날짜 데이터 : 두 날짜 데이터 간의 일수 차이 반환
--날짜 데이터 + 날짜 데이터 : 연산 불가
--add_months(날짜 데이터, 더할 개월수)
--months_between(날짜 데이터1, 날짜 데이터2)
--next_day(날짜 데이터1, 요일 문자)
--last_day(날짜 데이터)

--오라클에서 시스템 날짜 출력 : sysdate
SELECT sysdate, sysdate +1, sysdate -1, CURRENT_DATE, CURRENT_TIMESTAMP
FROM dual;

SELECT sysdate, ADD_MONTHS(sysdate, 3)
FROM dual;

--입사 50주년이 되는 날짜 구하기
SELECT e.HIREDATE , ADD_MONTHS(e.HIREDATE , 600)
FROM EMP e ;

--입사한지 40년이 넘은 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
ADD_MONTHS(e.HIREDATE, 480) < sysdate;

SELECT
	e.EMPNO ,
	e.HIREDATE,
	sysdate,
	MONTHS_BETWEEN(e.HIREDATE , sysdate) AS month1,
	MONTHS_BETWEEN(sysdate, e.HIREDATE) AS month2,
	trunc(MONTHS_BETWEEN(sysdate, e.HIREDATE)) AS month3
FROM
	EMP e
	
SELECT sysdate, LAST_DAY(sysdate), NEXT_DAY(sysdate, '월요일')
FROM dual;

--형변환 함수
--to_char : 날짜, 숫자 데이터를 문자로 변환
--to_number : 문자 데이터를 숫자로 변환
--to_date : 문자 데이터를 날짜 데이터로 변환

SELECT sysdate, TO_CHAR(sysdate, 'yyyy/mm/dd')
FROM dual;

--자동 형 변환
SELECT e.EMPNO , e.ENAME , e.EMPNO +'500'
FROM EMP e 
WHERE e.ENAME  = 'SMITH';

SELECT
	sysdate,
	TO_CHAR(sysdate, 'mm'),
	TO_CHAR(sysdate, 'mon'),
	TO_CHAR(sysdate, 'month'),
	TO_CHAR(sysdate, 'dd'),
	TO_CHAR(sysdate, 'day')
FROM
	dual;

SELECT
	sysdate,
	TO_CHAR(sysdate, 'hh24:mi:ss'),
	TO_CHAR(sysdate, 'hh12:mi:ss am'),
	TO_CHAR(sysdate, 'hh:mi:ss p.m.')
FROM
	dual;
--L : 지역 화폐 단위
SELECT e.SAL , TO_CHAR(e.SAL , 'L999,999')
FROM EMP e ;

--자동 형 변환
SELECT '1300' - '1500', '1300' +1500
FROM dual;

--to_number 안에 두번째 인자를 추가해 ,가 있는지 알려줘야한다
SELECT TO_NUMBER('1,300', '999,999') - '1500', '1300' +1500
FROM dual;

SELECT TO_DATE('20251027', 'yyyy-mm-dd')
FROM dual;

SELECT TO_DATE('2025-10-27') - TO_DATE('2025-09-23')
FROM dual;

--null 처리 함수
--1. NVL(null에 해당하는 열, 반환할 데이터) : null인 경우만 반환할 데이터로 돌아옴
--2. NVL2(null에 해당항는 열, null이 아닐 때 반환할 데이터, 반환할 데이터)

--null + null = null
--숫자 + null = null
SELECT empno, ename, sal, comm, comm + sal FROM EMP e;
SELECT empno, ename, sal, NVL(comm, 0) + sal FROM EMP e;
SELECT empno, ename, sal, NVL2(comm, '0', 'X'), NVL2(comm, sal * 12 + comm, sal * 12) FROM EMP e;

-- DECODE, CASE 함수 : 상황에 따라 다른 데이터를 반환
-- 직책이 manager 인 사원은 급여의 10%, salesman 인 사원은 급여의 5%, analyst 인 사원은 그대로, 나머지는 3% 만큼 인상된 급여 구하기
-- DECODE : (검사 대상이 될 열 또는 데이터,
-- [조건1], [조건1과 일치할 때 반환할 결과]
-- [조건2], [조건2와 일치할 때 반환할 결과]
-- ....
-- [위에 나열한 조건과 일치하지 않을 경우 반환할 결과])

-- CASE 검사 대상이 될 열 또는 데이터
-- WHEN [조건1] THEN [조건1과 일치할 때 반환할 결과]
-- WHEN [조건2] THEN [조건2과 일치할 때 반환할 결과]
-- ...
-- ELSE [위에 나열한 조건과 일치하지 않을 경우 반환할 결과]
-- END
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.JOB ,
	e.SAL ,
	DECODE(e.JOB , 'MANAGER', E.SAL * 1.1,
	'SALESMAN', E.SAL * 1.05,
	'ANALYST', E.SAL,
	E.SAL *1.03) AS 급여
FROM
	EMP e
	
-- COMM 이 NULL 인 경우에는 해당없음, 0인 경우에는 수당없음, 0보다 큰 경우에는 수당 : 800
	SELECT 
	E.EMPNO ,
	E.ENAME ,
	E.COMM ,
	CASE
		WHEN e.COMM IS NULL THEN '해당없음'
		WHEN e.COMM = 0 THEN '수당없음'
		WHEN e.COMM > 0 THEN '수당 : ' || e.COMM 
		END 
	FROM
		EMP e ;

-- emp 테이블에서 사원의 월 평균 근무일수는 21.5일 이다
-- 하루 근무시간을 8시간으로 보았을 때 사원의 하루 급여(DAY_PAY), 시급(TIME_PAY)를 계산하여 결과를 출력
-- 하루 급여는 소수 셋째 자리에서 버리고, 시급은 소수 둘째 자리에서 반올림
SELECT 
E.ENAME ,
TRUNC((E.SAL / 21.5), 2) AS DAY_PAY,
ROUND((e.SAL / (21.5 * 8)), 1) AS TIME_PAY
FROM EMP e ;

-- emp 테이블에서 사원은 입사일을 기준으로 3개월이 지난 후 첫 월요일에 정직원이 된다 
-- 사원이 정직원이 되는 날짜(R_JOB)을 yyyy-mm-dd 형식으로 출력. 단, 추가 수당이 없는 사원의 추가 수당은 N/A로 출력
-- EMPNO, ENAME, HIREDATE, R_JOB, COMM 출력
SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE ,
	TO_CHAR(NEXT_DAY(ADD_MONTHS(E.HIREDATE , 3), '월요일'), 'YYYY-MM-DD') AS R_JOB,
	NVL(TO_CHAR(COMM), 'N/A') AS COMM
FROM
	EMP e ;



-- emp 테이블의 모든 사원을 대상으로 직속 상관의 사원번호 (MGR)을 아래의 조건을 기준으로 변환해서 CHG_MGR 열에 출력
-- 조건
-- 직속 상관의 번호가 없는 경우 0000
-- 직속 상관의 사원번호 잎 두자리가 75 일 때 5555
-- 직속 상관의 사원번호 잎 두자리가 76 일 때 6666
-- 직속 상관의 사원번호 잎 두자리가 77 일 때 7777
-- 직속 상관의 사원번호 잎 두자리가 78 일 때 8888
-- 그 외 직속상관 사원 번호일 때 : 본래 직속 성관의 사원번호 그대로 출력

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE ,
	E.MGR,
	CASE
		SUBSTR(TO_CHAR(NVL(E.MGR, 0)), 1, 2)
		WHEN '0' THEN '0000'
		WHEN '75' THEN '5555'
		WHEN '76' THEN '6666'
		WHEN '77' THEN '7777'
		WHEN '78' THEN '8888'
		ELSE TO_CHAR(e.MGR)
	END AS CHG_MGR
FROM
	EMP e;

SELECT
	e.EMPNO ,
	e.ENAME ,
	e.HIREDATE,
	DECODE(
		SUBSTR(TO_CHAR(E.MGR), 1, 2),
		 '75', '5555',
		 '76' , '6666',
		 '77' , '7777',
		 '78' , '8888',
		NVL(TO_CHAR(e.MGR), '0000')
	 )AS CHG_MGR
FROM
	EMP e;

-- 다중행 함수
-- SUM, AVG, COUNT, MAX, MIN

SELECT SUM(E.SAL )
FROM EMP e ;

-- 10번 부서의 급여 총계, 평균
SELECT SUM(E.SAL ), AVG(E.SAL )
FROM EMP e
WHERE 
E.DEPTNO = 10;

-- 20 번 붜의 제일 오래된 입사일
SELECT MIN(E.HIREDATE )
FROM EMP e
WHERE 
E.DEPTNO = 20;



-- GROUP BY
-- 부서별 급여 평균 조회

SELECT AVG(E.SAL ), E.DEPTNO 
FROM EMP e 
GROUP BY E.DEPTNO ;

-- 부서별, 직무별 급여 평균 조회
SELECT
	AVG(E.SAL),
	E.DEPTNO ,
	E.JOB
FROM
	EMP e
GROUP BY
	E.DEPTNO,
	E.JOB
ORDER BY
	E.DEPTNO ,
	E.JOB  ;

-- 부서별 추가수당 평균 조회
SELECT
	ROUND(AVG(NVL(E.COMM, 0))) ,
	E.DEPTNO 
FROM
	EMP e
GROUP BY
	E.DEPTNO
ORDER BY
	E.DEPTNO ;

-- GROUP BY 열이름 HAVING 출력그룹제합
-- 부서별, 직무별 급여 평균 조회 단, 평균이 2000이상 그룹 조회
SELECT
	AVG(E.SAL),
	E.DEPTNO ,
	E.JOB
FROM
	EMP e
WHERE
	E.SAL <= 3000 -- WHERE에서 다중행 함수를 빼버리니 사용 가능
	-- 그룹 함수에선 WHERE 을 쓸 수 없다 대신 HAVING 을 쓴다
GROUP BY
	E.DEPTNO,
	E.JOB
HAVING
	AVG(E.SAL) >= 2000
ORDER BY
	E.DEPTNO ,
	E.JOB ;

-- EMP 테이블을 이용하여 부서번호, (평균, 최고, 최저) 급여, 사원수 조회
-- 단, 평균급여 출력 시 소수점을 제외하고 각 부서번호별로 출력
SELECT
	E.DEPTNO ,
	ROUND(AVG(E.SAL)) AS AVG_SAL,
	MAX(SAL) AS MAX_SAL,
	MIN(SAL) AS MIN_SAL,
	COUNT(E.EMPNO) AS CNT
FROM
	EMP e
GROUP BY
	E.DEPTNO
ORDER BY
	E.DEPTNO ;

-- 같은 직책에 종사하는 사원이 3명 이상인 직책과 인원수 출력
SELECT
	COUNT(E.JOB) AS CNT,
	E.JOB
FROM
	EMP e
GROUP BY
	E.JOB
HAVING 
	COUNT(E.JOB) >= 3 ;


-- 사원들의 입사연도를 기준으로 부서별로 몇 명이 입사했는지 출력
-- TO_CHAR(1981-09-28, 'YYYY')
SELECT
	E.DEPTNO,
	TO_CHAR(E.HIREDATE , 'YYYY'),
	COUNT(E.JOB) AS CNT
FROM
	EMP e
GROUP BY
	TO_CHAR(E.HIREDATE , 'YYYY'),
	E.DEPTNO
ORDER BY 
	E.DEPTNO, TO_CHAR(E.HIREDATE , 'YYYY') ;

-- 조회 : JOIN / SUBQUERY
-- JOIN : 여러 테이블을 하나의 테이블 처럼 사용
-- 1. 내부조인(INNER JOIN)
-- 2. 외부조인(OUTER JOIN)
-- 		(1) LEFT OUTER JOIN
-- 		(2) RIGHT OUTER JOIN
-- 		(3) FULL OUTER JOIN

-- 사원정보 + 부서정보 조회
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.DEPTNO ,
	D.DNAME
FROM
	EMP e
INNER JOIN DEPT d ON
	e.DEPTNO = d.DEPTNO;

SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.DEPTNO ,
	D.DNAME
FROM
	EMP e,
	DEPT d 
WHERE
E.DEPTNO = D.DEPTNO ;

-- 비등가 조인 + 내부 조인
SELECT
	*
FROM
	EMP e
JOIN SALGRADE s ON
	E.SAL BETWEEN S.LOSAL AND S.HISAL ;

-- 셀프 조인
SELECT
	E1.EMPNO ,
	E1.ENAME ,
	E1.MGR ,
	E2.ENAME AS 매니저명
FROM
	EMP e1
JOIN EMP e2 ON
	E1.MGR = E2.EMPNO ;

-- 외부 조인
SELECT
	E1.EMPNO ,
	E1.ENAME ,
	E1.MGR ,
	E2.ENAME AS 매니저명
FROM
	EMP e1
LEFT JOIN EMP e2 ON
	E1.MGR = E2.EMPNO ;

SELECT
	E1.EMPNO ,
	E1.ENAME ,
	E1.MGR ,
	E2.ENAME AS 매니저명
FROM
	EMP e1
RIGHT JOIN EMP e2 ON
	E1.MGR = E2.EMPNO ;

-- 부서명
SELECT
	E.DEPTNO ,D.DNAME ,
	ROUND(AVG(E.SAL)) AS AVG_SAL,
	MAX(SAL) AS MAX_SAL,
	MIN(SAL) AS MIN_SAL,
	COUNT(E.EMPNO) AS CNT
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
GROUP BY
	E.DEPTNO , D.DNAME 
ORDER BY
	E.DEPTNO ;

-- 테이블 3개 연동
-- 부서번호, 부서명, 사번, 사원명, 매니저번호, 급여, 급여등급
-- 부서명 : DEPT
-- 사번, 사원명, 매니저번호, 급여, 부서번호 : EMP
-- 급여등급 : SALGRADE

SELECT
	E.DEPTNO ,
	D.DNAME ,
	E.EMPNO ,
	E.ENAME ,
	E.MGR ,
	E.SAL ,
	S.GRADE
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
JOIN SALGRADE s ON
	E.SAL BETWEEN S.LOSAL AND S.HISAL ;

-- 서브 쿼리 : 메인 쿼리 외에 SELECT 구문이 여러개 존재
-- 1) 단일 행 서브쿼리 : 서브쿼리 실행 결과가 행 하나
--	 연산자 종류 : >, <, >=, <=, <>, != 
-- 2) 다중 행 서브쿼리 : 서브쿼리 실행 결과가 여러 행
-- 	 연산자 종류 : IN, ANY, ALL
-- SELECT E.ENAME, (SELECT * FROM EMP E2)
-- FROM EMP E JOIN (SELECT)
-- WHERE E.DEPNO = (SELECT)

-- JONES 의 급여보다 높은 급여를 받는 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	E.SAL > (
	SELECT
		E2.SAL
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'JONES');

-- WARD 사원보다 빨리 입사한 사원 조회
SELECT
	*
FROM
	EMP e
WHERE
	E.HIREDATE  < (
	SELECT
		E2.HIREDATE 
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'WARD');

-- 20번 부서에 속한 사원 중 전체 사원의 평균급여보다 높은 급여를 받는 사원 조회
-- 부서정보 추가로 조회
SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	D.DEPTNO ,
	D.DNAME ,
	D.LOC
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE
	D.DEPTNO = 20
	AND E.SAL > (
	SELECT
		AVG(E2.SAL)
		FROM EMP e2 );

SELECT * FROM EMP e WHERE E.SAL  IN (SELECT MAX(SAL) FROM EMP e2 GROUP BY E2.DEPTNO );


-- 30번 부서의 최대 급여보다 작은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE E.SAL  < ANY (SELECT SAL FROM EMP e2 WHERE E2.DEPTNO =30 );

-- 30번 부서의 최소 급여보다 많은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE E.SAL  > ANY (SELECT SAL FROM EMP e2 WHERE E2.DEPTNO =30 );

-- 30번 부서의 최소 급여보다 작은 급여를 받는 사원 조회
SELECT * FROM EMP e WHERE E.SAL  < ALL (SELECT SAL FROM EMP e2 WHERE E2.DEPTNO =30 );

-- 서브쿼리 결과가 하나 이상 나오면 TRUE 반환
SELECT * FROM EMP e WHERE EXISTS (SELECT SAL FROM EMP e2 WHERE E2.DEPTNO =30 );

-- 다중열 서브쿼리
SELECT
	*
FROM
	EMP e
WHERE
	(E.DEPTNO ,
	E.SAL ) IN (
	SELECT
		E.DEPTNO ,
		MAX(E.SAL)
	FROM
		EMP e2
	GROUP BY
		E2.DEPTNO );

-- FROM 절 서브쿼리 (= 인라인 뷰)
SELECT *
FROM (SELECT * FROM EMP e WHERE E.DEPTNO = 10) E10, (SELECT * FROM DEPT d ) D
WHERE E10.DEPTNO  = D.DEPTNO ;

-- SELECT 절 서브쿼리(= 스칼라 서브쿼리)
SELECT
	E.ENAME ,
	E.EMPNO ,
	E.JOB,
	(
	SELECT
		S.GRADE
	FROM
		SALGRADE s
	WHERE
		E.SAL BETWEEN S.LOSAL AND S.HISAL )AS SALGRADE,
		E.DEPTNO ,
	(
	SELECT
		D.DNAME
	FROM
		DEPT d
	WHERE
		E.DEPTNO = D.DEPTNO )AS DNAME
FROM
	EMP e 

-- 전체 사원 중 ALLEN 과 같은 직책인 사원들의 사원정보, 부서정보 조회
-- 정보 : 사번, 이름, 직무, 급여, 부서번호, 부서명
	SELECT
	E.EMPNO ,
	E.ENAME ,
	E.JOB ,
	E.SAL ,
	E.DEPTNO ,
	D.DNAME
FROM
	EMP e
JOIN DEPT d ON
	E.DEPTNO = D.DEPTNO
WHERE
	E.JOB = (
	SELECT
	E2.JOB 
	FROM
		EMP e2
	WHERE
		E2.ENAME = 'ALLEN');

-- 자신의 부서 내에서 최고 연봉과 동일한 급여를 받는 사원조회
	
-- 10번 부서에 근무하는 사원 중 30번 부서에 없는 직책인 사원의 사번, 이름, 직무, 부서번호, 부서명, 부서위치 조회













	
	
	
	
	
	
	
	