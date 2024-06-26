--사원  = EMPLOYEE2
--부서 = DEPARTMENT2
--INSERT 실습
--
--1. 사원 번호 '223', 이름 '김영수', 주민등록번호 '850101-1234567', 이메일 'kim_ys@or.kr', 전화번호 '01012345678', 부서 코드 'D1', 직무 코드 'J4', 급여 수준 'S2', 급여 3500000, 보너스율 0.1, 매니저 ID '200', 입사일 '15/06/20', 퇴사여부 'N'.
--
--2. 부서 코드 'D10', 부서명 '연구개발부', 지역 코드 'L6'.
INSERT
INTO DEPARTMENT2
VALUES('D10','연구개발부','L6');
/*
오류보고 (actual:3, maximum: 2)
컬럼의 최대 크기가 2byte로 영어나 숫자로 2글자까지만 가능하지만
3글자를 작성하려 했기 때문에 에러발생
→ department2 테이블엣 "dept_id"에 해당하는 컬럼의 크기를
    2에서 3으로 늘려주거나
    varchar2로 변경해서 255까지 늘려주는 방법 존재 -> varchar 알아서 공간 조정
*/
--
--3. 사원 번호 '224', 이름 '이수진', 주민등록번호 '900101-2345678', 이메일 'lee_sj@or.kr', 전화번호 '01098765432', 부서 코드 'D2', 직무 코드 'J2', 급여 수준 'S3', 급여 3000000, 보너스율 0.15, 매니저 ID '201', 입사일 '16/07/01', 퇴사여부 'N'.
--
--4. 부서 코드 'D11', 부서명 '품질관리부', 지역 코드 'L7'.
--
--5. 사원 번호 '225', 이름 '박민수', 주민등록번호 '750303-3456789', 이메일 'park_ms@or.kr', 전화번호 '01123456789', 부서 코드 'D3', 직무 코드 'J5', 급여 수준 'S1', 급여 2800000, 보너스율 0.05, 매니저 ID '202', 입사일 '17/08/15', 퇴사여부 'N'.
--
--6. 부서 코드 'D12', 부서명 '재무부', 지역 코드 'L8'.
--
--7. 사원 번호 '226', 이름 '최은지', 주민등록번호 '860404-4567890', 이메일 'choi_ej@or.kr', 전화번호 '01056789012', 부서 코드 'D4', 직무 코드 'J3', 급여 수준 'S4', 급여 4200000, 보너스율 0.2, 매니저 ID '203', 입사일 '18/09/25', 퇴사여부 'N'.
--
--8. 부서 코드 'D13', 부서명 '홍보부', 지역 코드 'L9'.
--
--9. 사원 번호 '227', 이름 '장영호', 주민등록번호 '950505-5678901', 이메일 'jang_yh@or.kr', 전화번호 '01067890123', 부서 코드 'D5', 직무 코드 'J1', 급여 수준 'S5', 급여 5000000, 보너스율 0.25, 매니저 ID '204', 입사일 '19/10/30', 퇴사여부 'N'.
--
--10. 부서 코드 'D14', 부서명 '전략기획부', 지역 코드 'L10'.
--
--11. 사원 번호 '228', 이름 '윤지혜', 주민등록번호 '760606-6789012', 이메일 'yoon_jh@or.kr', 전화번호 '01734567890', 부서 코드 'D6', 직무 코드 'J2', 급여 수준 'S2', 급여 3200000, 보너스율 0.1, 매니저 ID '205', 입사일 '20/11/05', 퇴사여부 'N'.
--12. 부서 코드 'D15', 부서명 '법무부', 지역 코드 'L11'.
--
--13. 사원 번호 '229', 이름 '김도현', 주민등록번호 '830707-7890123', 이메일 'kim_dh@or.kr', 전화번호 '01078901234', 부서 코드 'D7', 직무 코드 'J4', 급여 수준 'S3', 급여 3600000, 보너스율 0.15, 매니저 ID '206', 입사일 '21/12/10', 퇴사여부 'N'.
--
--14. 부서 코드 'D16', 부서명 '고객지원부', 지역 코드 'L12'.
--
--15. 사원 번호 '230', 이름 '이성민', 주민등록번호 '910808-8901234', 이메일 'lee_sm@or.kr', 전화번호 '01089012345', 부서 코드 'D8', 직무 코드 'J3', 급여 수준 'S4', 급여 3800000, 보너스율 0.2, 매니저 ID '207', 입사일 '22/01/15', 퇴사여부 'N'.
--
--16. 부서 코드 'D17', 부서명 '기술혁신부', 지역 코드 'L13'.
--17. 사원 번호 '231', 이름 '박소연', 주민등록번호 '920909-9012345', 이메일 'park_sy@or.kr', 전화번호 '01145678901', 부서 코드 'D9', 직무 코드 'J5', 급여 수준 'S1', 급여 3000000, 보너스율 0.05, 매니저 ID '208', 입사일 '23/02/20', 퇴사여부 'N'.
--
--18. 부서 코드 'D18', 부서명 '경영지원부', 지역 코드 'L14'.
--
--19. 사원 번호 '232', 이름 '최민준', 주민등록번호 '930101-1234567', 이메일 'choi_mj@or.kr', 전화번호 '01012345678', 부서 코드 'D10', 직무 코드 'J2', 급여 수준 'S2', 급여 3100000, 보너스율 0.1, 매니저 ID '209', 입사일 '24/03/25', 퇴사여부 'N'.
--
--20. 부서 코드 'D19', 부서명 '정보기술부', 지역 코드 'L15'.
--
--21. 사원 번호 '233', 이름 '김하늘', 주민등록번호 '940202-2345678', 이메일 'kim_hn@or.kr', 전화번호 '01023456789', 부서 코드 'D11', 직무 코드 'J1', 급여 수준 'S3', 급여 3400000, 보너스율 0.15, 매니저 ID '210', 입사일 '25/04/30', 퇴사여부 'N'.
--22. 부서 코드 'D20', 부서명 '자원관리부', 지역 코드 'L16'.
--
--23. 사원 번호 '234', 이름 '박지훈', 주민등록번호 '950303-3456789', 이메일 'park_jh@or.kr', 전화번호 '01034567890', 부서 코드 'D12', 직무 코드 'J4', 급여 수준 'S4', 급여 3700000, 보너스율 0.2, 매니저 ID '211', 입사일 '26/05/15', 퇴사여부 'N'.
--
--24. 부서 코드 'D21', 부서명 '연구소', 지역 코드 'L17'.
--
--25. 사원 번호 '235', 이름 '최수민', 주민등록번호 '960404-4567890', 이메일 'choi_sm@or.kr', 전화번호 '01045678901', 부서 코드 'D13', 직무 코드 'J3', 급여 수준 'S2', 급여 3300000, 보너스율 0.1, 매니저 ID '212', 입사일 '27/06/20', 퇴사여부 'N'.
