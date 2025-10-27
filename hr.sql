--1. 사원번호가 176인 사원의 LAST_NAME;, 부서번호 정보 조회
SELECT
	LAST_NAME,
	DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	EMPLOYEE_ID = 176;

--2. 연봉이 12000 이상 되는 직원들의 LAST_NAME, 급여 조회
SELECT
	LAST_NAME,
	SALARY
FROM
	EMPLOYEES e
WHERE
	SALARY >= 12000;

--3. 연봉이 5000~12000 범위가 아닌 사람들의 LAST_NAME, 급여 조회
SELECT
	e.LAST_NAME ,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	e.SALARY < 5000
	OR e.SALARY >12000;

--4. 20번, 50번 부서에 근무하는 사원들의 LAST_NAME, 부서번호를 오름차순 조회
SELECT
	LAST_NAME,
	DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	DEPARTMENT_ID IN (20, 50)
ORDER BY
	DEPARTMENT_ID ASC;

--5. 커미션을 받는 모든 사원들의 LAST_NAME, 급여(내림차순), 커미션(내림차순)을 조회
SELECT
	LAST_NAME,
	SALARY,
	COMMISSION_PCT
FROM
	EMPLOYEES e
WHERE
	COMMISSION_PCT > 0
ORDER BY
	SALARY DESC,
	COMMISSION_PCT DESC;

--6. 연봉이 2500, 3500, 7000이 아니며 직무가 SA_REP, ST_CLERK인 사원조회
SELECT
	*
FROM
	EMPLOYEES e
WHERE
	e.SALARY NOT IN (2500, 3500, 7000) AND 
	e.JOB_ID IN ('SA_REP', 'ST_CLERK');
	
--7. 2015/02/20 ~ 2015/05/01 사이에 고용된 사원들의 LAST_NAME, 사번, 고용일자(내림차순) 조회
SELECT
	e.LAST_NAME ,
	e.EMPLOYEE_ID ,
	e.HIRE_DATE
FROM
	EMPLOYEES e
WHERE
	e.HIRE_DATE BETWEEN '2015/02/20' AND '2015/05/01'
ORDER BY
	e.HIRE_DATE DESC;

--8. 20번, 50번 부서에 근무하는 사원들 중에서 연봉이 5000~12000 인 사원들의 last_name, 급여(오름차순)를 조회
SELECT
	e.LAST_NAME ,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	 e.DEPARTMENT_ID IN (20, 50)
	AND 
	e.SALARY BETWEEN 5000 AND 12000
ORDER BY
	e.SALARY ASC ;

--9.연봉이 5000~12000 이 아닌 사원들의 last_name, 급여(오름차순)를 조회
SELECT
	e.LAST_NAME ,
	e.SALARY
FROM
	EMPLOYEES e
WHERE
	 e.DEPARTMENT_ID IN (20, 50)
	AND 
	e.SALARY NOT BETWEEN 5000 AND 12000
ORDER BY
	e.SALARY ASC;

--10. 2015/02/20 ~ 2015/05/01 사이에 고용된 사원들의 LAST_NAME, 사번, 고용일자(내림차순) 조회 between a and b 사용

--11. last_name 에 u가 포함되는 사원들의 사번, LAST_NAME 조회
SELECT
	e.LAST_NAME, 
	e.EMPLOYEE_ID
FROM 
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%u%';
--12. last_name 의 4번째 글자가 a인 사원들의 LAST_NAME 조회
SELECT
	e.LAST_NAME  
FROM 
	EMPLOYEES e 
WHERE 
e.LAST_NAME LIKE '___a%';

--13. last_name 에 a 혹은 e 글자가 포함되는 사원들의 LAST_NAME(오름차순) 조회
SELECT
	e.LAST_NAME
FROM 
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%a%'
	OR e.LAST_NAME LIKE '%e%'
ORDER BY
	e.LAST_NAME ASC;

--14. last_name 에 a와 e 가 포함되는 사원들의 LAST_NAME(오름차순) 조회
SELECT
	e.LAST_NAME
FROM 
	EMPLOYEES e
WHERE
	e.LAST_NAME LIKE '%a%e%'
	OR e.LAST_NAME LIKE '%e%a%'
ORDER BY
	e.LAST_NAME ASC;

--15. 매니저 아이디가 없는 사원들의 last_name, job_id 조회
SELECT
	e.LAST_NAME ,
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.MANAGER_ID IS NULL ;

--16. 직무가 ST_CLERK 인 사원이 근무하고 있지 않은 부서 id 조회 단, 부서번호가 null인 곳은 제외
SELECT
	DISTINCT 
	e.JOB_ID
FROM
	EMPLOYEES e
WHERE
	e.JOB_ID NOT IN ('ST_CLERK')
	AND e.DEPARTMENT_ID IS NOT NULL ;

--17. commission_pct 가 null 이 아닌 사원들 중에서 commission = salary * commission_pct 를 구하여 사번, first_name, job_id 조회
SELECT
	e.JOB_ID,
	e.EMPLOYEE_ID,
	e.FIRST_NAME,
	salary * commission_pct AS commission
FROM
	EMPLOYEES e
WHERE
	e.COMMISSION_PCT IS NOT NULL;

--함수
--18.first name 이 curtis 인 사람의 first_name, last_name, email, phone_number, job_id 조회
--단, job_id 결과는 소문자로 출력
SELECT
	LOWER(e.JOB_ID),
	e.EMAIL,
	e.FIRST_NAME,
	e.LAST_NAME,
	e.PHONE_NUMBER
FROM
	EMPLOYEES e
WHERE
	e.FIRST_NAME = 'Curtis';
	--19. 부서번호가 60,70,80,90 인 사원들의 사원번호, first_name, hire_date, job_id 조회
	--단, job_id가 it_prog 인 사원의 경우 프로그래머로 변경하여 출력
SELECT
	REPLACE(e.JOB_ID, 'IT_PROG', '프로그래머'),
	e.HIRE_DATE ,
	e.FIRST_NAME,
	e.EMPLOYEE_ID
FROM
	EMPLOYEES e
WHERE
	e.DEPARTMENT_ID IN (60, 70, 80, 90);

--20. job_id 가 ad_pres, pu_clerk 인 사원들의 사원번호, first_name, last_name, 부서번호, job_id 조화
--단, 사원명은 first_name과 last_name 을 연결하여 출력
SELECT
	e.JOB_ID,
	e.FIRST_NAME || ' ' || e.LAST_NAME,
	e.EMPLOYEE_ID,
	e.DEPARTMENT_ID
FROM
	EMPLOYEES e
WHERE
	e.JOB_ID IN ('AD_PRES', 'PU_CLERK');




