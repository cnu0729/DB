--[ORDER BY]
--1.  DEPARTMENT 테이블에서 DEPT_TITLE을 기준으로 정렬하여 모든 데이터 조회
SELECT *
FROM DEPARTMENT
ORDER BY DEPT_TITLE;

--2. EMPLOYEE 테이블에서 SALARY를 기준으로 내림차순 정렬하여 모든 데이터
SELECT *
FROM EMPLOYEE
ORDER BY SALARY DESC;

--3. EMPLOYEE 테이블에서 EMP_NAME과 HIRE_DATE를 조회하고, HIRE_DATE를 기준으로 정렬
SELECT EMP_NAME, HIRE_DATE
FROM EMPLOYEE
ORDER BY HIRE_DATE;

--4. LOCATION 테이블에서 LOCAL_NAME을 조회하고, NATIONAL_CODE를 기준으로 정렬
SELECT LOCAL_NAME
FROM LOCATION
ORDER BY NATIONAL_CODE;

--5. EMPLOYEE 테이블에서 EMP_ID와 EMP_NAME을 조회하고, EMP_NAME을 기준으로 정렬
SELECT EMP_ID, EMP_NAME
FROM EMPLOYEE
ORDER BY EMP_NAME;

--------------------------------------------------------------------------------
--[HAVING]
--1. EMPLOYEE 테이블에서 DEPT_CODE별 평균 급여를 구하고, 평균 급여가 3,000,000보다 큰 부서만 조회
SELECT DEPT_CODE, AVG(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING AVG(SALARY) > 3000000;
-- where 조건에 해당하는 사람들을 검색한 다음 조건에 부합하는 것 처럼 보임
-- group having 모든 사람들ㅇ르 조회하고 조건에 맞는 부서만 선별


--2. EMPLOYEE 테이블에서 JOB_CODE별 직원 수를 구하고, 직원 수가 3명 이상인 직급만 조회
SELECT JOB_CODE, COUNT(*) AS "직원 수"
FROM EMPLOYEE
GROUP BY JOB_CODE
HAVING COUNT(*) >= 3; 
-- from 찾을 테이블 위치 선정 -> group by 묶을 그룹 선정 -> select 그룹 조건에 맞는 내용 조회

--3. EMPLOYEE 테이블에서 DEPT_CODE별 급여 합계를 구하고, 급여 합계가 10,000,000 이상인 부서만 조회
SELECT DEPT_CODE, SUM(SALARY) AS "급여합계"
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING SUM(SALARY) >= 10000000;

--4. EMPLOYEE 테이블에서 SAL_LEVEL별 최대 급여를 구하고, 최대 급여가 5,000,000 미만인 급여 등급만 조회
SELECT SAL_LEVEL, MAX(SALARY)
FROM EMPLOYEE
GROUP BY SAL_LEVEL
HAVING MAX(SALARY) < 5000000;

--5. EMPLOYEE 테이블에서 DEPT_CODE별 최소 급여를 구하고, 최소 급여가 2,000,000 이상인 부서만 조회
SELECT DEPT_CODE, MIN(SALARY)
FROM EMPLOYEE
GROUP BY DEPT_CODE
HAVING MIN(SALARY) >= 2000000;

--------------------------------------------------------------------------------
--[GROUP BY]
--1. EMPLOYEE 테이블에서 DEPT_CODE별 직원 수를 조회
SELECT DEPT_CODE, COUNT(*) AS "직원 수"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--2. EMPLOYEE 테이블에서 JOB_CODE별 평균 급여를 조회
SELECT JOB_CODE, AVG(SALARY) AS "평균 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;

--3. EMPLOYEE 테이블에서 SAL_LEVEL별 보너스 합계를 조회
SELECT SAL_LEVEL, SUM(BONUS) AS "보너스 합계"
FROM EMPLOYEE
GROUP BY SAL_LEVEL;

--4. EMPLOYEE 테이블에서 DEPT_CODE별 최대 급여를 조회
SELECT DEPT_CODE, MAX(SALARY) AS "최대 급여"
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--5. EMPLOYEE 테이블에서 JOB_CODE별 최소 급여를 조회
SELECT JOB_CODE, MIN(SALARY) AS "최소 급여"
FROM EMPLOYEE
GROUP BY JOB_CODE;

--6. LOCATION 테이블에서 NATIONAL_CODE별 지역 수를 조회
SELECT NATIONAL_CODE, COUNT(*) AS "지역 수"
FROM LOCATION
GROUP BY NATIONAL_CODE;

--7. DEPARTMENT 테이블에서 LOCAL_CODE별 부서 수를 조회
SELECT LOCATION_ID, COUNT(*) AS "부서 수"
FROM DEPARTMENT
GROUP BY LOCATION_ID;

--8. EMPLOYEE 테이블에서 DEPT_CODE별 평균 보너스를 조회
SELECT DEPT_CODE, AVG(BONUS)
FROM EMPLOYEE
GROUP BY DEPT_CODE;

--9. EMPLOYEE 테이블에서 SAL_LEVEL별 직원 수를 조회
SELECT SAL_LEVEL, COUNT(*) AS "직원수"
FROM EMPLOYEE
GROUP BY SAL_LEVEL;

--10. EMPLOYEE 테이블에서 JOB_CODE별 급여 합계를 조회
SELECT JOB_CODE, SUM(SALARY)
FROM EMPLOYEE
GROUP BY JOB_CODE;

--------------------------------------------------------------------------------
--[WHERE]
--1. EMPLOYEE 테이블에서 급여가 3,000,000 이상인 직원들을 조회
SELECT *
FROM EMPLOYEE
WHERE SALARY >= 3000000;

--2. EMPLOYEE 테이블에서 DEPT_CODE가 'D1'인 직원들을 조회
SELECT *
FROM EMPLOYEE
WHERE DEPT_CODE = 'D1';

--3. EMPLOYEE 테이블에서 JOB_CODE가 'J2'인 직원들을 조회
SELECT *
FROM EMPLOYEE
WHERE JOB_CODE = 'J2';

--4. EMPLOYEE 테이블에서 SAL_LEVEL이 'S4'인 직원들을 조회
SELECT *
FROM EMPLOYEE
WHERE SAL_LEVEL = 'S4';

--5. DEPARTMENT 테이블에서 LOCATION_ID가 'L1'인 부서를 조회
SELECT  DEPT_TITLE
FROM DEPARTMENT
WHERE LOCATION_ID = 'L1';

--6. LOCATION 테이블에서 NATIONAL_CODE가 'US'인 지역을 조회
SELECT LOCAL_CODE
FROM LOCATION
WHERE NATIONAL_CODE = 'US';

--7. NATIONAL 테이블에서 NATIONAL_NAME이 '한국'인 국가를 조회
SELECT *
FROM NATIONAL
WHERE NATIONAL_NAME = '한국';

--8. SAL_GRADE 테이블에서 MIN_SAL이 2,000,000 이상인 급여 등급을 조회
SELECT *
FROM SAL_GRADE
WHERE MIN_SAL >= 2000000;

--9. EMPLOYEE 테이블에서 보너스가 NULL이 아닌 직원들을 조회
SELECT *
FROM EMPLOYEE
WHERE BONUS IS NOT NULL;

--10. DEPARTMENT 테이블에서 DEPT_TITLE이 '해외'로 시작하는 부서를 조회
SELECT *
FROM DEPARTMENT
WHERE DEPT_TITLE = '해외';

--11. EMPLOYEE 테이블에서 ENT_YN이 'N'인 직원을 조회
--12. EMPLOYEE 테이블에서 HIRE_DATE가 2000-01-01 이후인 직원을 조회
--13. EMPLOYEE 테이블에서 PHONE이 '010'으로 시작하는 직원을 조회
--14. EMPLOYEE 테이블에서 EMAIL이 '@or.kr'로 끝나는 직원을 조회
--15. EMPLOYEE 테이블에서 MANAGER_ID가 NULL인 직원을 조회
--16. EMPLOYEE 테이블에서 급여가 2,000,000과 3,000,000 사이인 직원을 조회
--17. EMPLOYEE 테이블에서 JOB_CODE가 'J5', 'J6', 'J7'인 직원을 조회
--18. EMPLOYEE 테이블에서 DEPT_CODE가 'D1'이고 JOB_CODE가 'J7'인 직원을 조회
--19. EMPLOYEE 테이블에서 급여가 3,000,000 이상이고 보너스가 NULL이 아닌 직원을 조회
--20. EMPLOYEE 테이블에서 DEPT_CODE가 'D5' 또는 'D6'인 직원을 조회
--21. EMPLOYEE 테이블에서 HIRE_DATE가 2000-01-01 이전인 직원을 조회
--22. EMPLOYEE 테이블에서 PHONE이 NULL인 직원을 조회
--23. DEPARTMENT 테이블에서 LOCATION_ID가 'L1', 'L2', 'L3'인 부서를 조회
--24. EMPLOYEE 테이블에서 급여가 3,000,000 이상이고 ENT_YN이 'N'인 직원을 조회
--25. EMPLOYEE 테이블에서 DEPT_CODE가 'D2'이고 ENT_DATE가 NULL인 직원을 조회
--
--------------------------------------------------------------------------------
