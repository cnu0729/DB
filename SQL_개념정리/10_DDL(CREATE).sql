/*
DDL (DATA DEFINITION LANGUAGE) : 데이터 정의 언어

OBJECT  CREATE  ALTER   DROP
객체     만들고 수정하고 삭제하는 언어
--------------------------------------------------------------------------------
오라클에서 객체 : 테이블(TABLE) 뷰(VIEW) 시퀀스(SEQUENCE)
                 인텍스(INDEX) 패키지(PACKAGE) 트리거(TRIGGER)
                 프로시져(PROCEDURE) 함수(FUNCTION)
                 동의어(SYNONYM) 사용자(USER)
--------------------------------------------------------------------------------

CREATE
- 테이블이나 인덱스, 뷰 등 다양한 데이터 베이스 객체를 생성하는 구문
-- 테이블로 생성된 객체는 DROP 구문을 통해 제거할 수 있음

1. 테이블 생성하기
 - 테이블이란?
 -- 행(ROW)와 열(COLUMN)으로 구성되는 가장 기본적인 데이터베이스 객체
 --- 데이터베이스 내에서 모든 데이터는 테이블을 통해 저장
 
 --- [ 표현식 ]
 CREATE TABLE 테이블명 (
            컬럼명 자료형(크기),
            컬럼명 자료형(크기),
            ...);
            
 ----- [ 자료형 ]
            NUMBER : 숫자형 (정수, 실수)
            
            CHAR(크기) : 고정길이 문자형 (2000BYTE)
            VARCHAR2(크기) : 가변길이 문자형 (4000BYTE) VARCHAR1의 업그레이드 버전
            
            ABC 문자열을 CHAR VARCHAR2 저장하면 어떻게 되는가?
            CHAR(10) 컬럼 : CHAR는 10을 모두 소진
            VARCHAR(10) 컬럼 : VARCHAR2 3만큼만 소진 나머지 7은 반환
            
            DATE : 날짜 타입
            BLOB : 대용량 사진 / 동영상 / 파일 데이터 저장 (4GB)
            CLOB : 대용량 문자 데이터 (4GB)
    
    UTF-8
    영어, 숫자, 특수문자 == 1BYTE
    나머지(한글 등)      == 3BYTE
*/

-- USER_MEMBER 테이블 생성
--- 필요한 컬럼 : 아이디 비밀번호 이름 주민번호 가입일 

-- 아이디    : USER_ID / 자료형 VARCHAR2(20)
-- 비밀번호  : USER_PW / 자료형 VARCHAR2(20)
-- 이름      : USER_NAME / 자료형 VARCHAR2(16) -- 한글 5글자 까지 OK
-- 주민번호  : USER_SSN / CHAR(14)  -- 14글자 고정
-- 가입일    : ENROLL_DATE / 자료형 DATE - DEFAULT SYSDATE -> 현재 시간 기본값

CREATE TABLE USER_MEMBER(
USER_ID VARCHAR2(20),
USER_PW VARCHAR2(20),
USER_NAME VARCHAR2(16),
USER_SSN CHAR(14),
ENROLL_DATE DATE DEFAULT SYSDATE
);

-- DEFAULT (=기본값) 컬럼의 기본값 지정 (필수 아님)
--> default 기본값을 지정하고 insert 나 update 문을 작성해줄 때
----> 지정한 기본값이 들어감

-- 테이블 잘 만들어졌는지 확인
SELECT * FROM USER_MEMBER;

-- 2. 컬럼에 주석으로 컬럼에 대한 설명 추가
-- [표현식]
-- COMMENT ON COLUMN 테이블명.컬럼명 IS '주석내용';

COMMENT ON COLUMN "USER_MEMBER".USER_ID IS '회원아이디';

-- 제약 조건 
-- unique primary key foreign key check

/*
제약조건 (CONSTRAINTS)
사용자가 원하는 조건의 데이터만 유지하기 위해 특정컬럼에 설정하는 제약

데이터 무결성 보장을 목적으로 함
+ 입력 데이터에 문제가 없는지 자동으로 검사하는 목적
데이터 수정 / 삭제 가능 여부 검사 등을 목적으로 함
--> 제약 조건을 위배하는 DML 구문은 수행할 수 없음

제약 조건 종류
PRIMARY KEY, NOT NULL, UNIQUE, CHECK, FOREIGN KEY

-- 제약 조건 확인
-- USER_CONSTRAINTS : 사용자가 작성한 제약 조건을 확인하는 딕셔너리 뷰

OWNER              : 유저 아이디
CONSTRAINT_NAME    : 제약 조건 이름
CONSTRAINT_TYPE    : 제약 조건 유형
                     C : CHECK
                     P : PRIMARY KEY
                     U : UNIQUE
                     R : FOREIGN KEY
                     V : VIEW
                     O : 읽기 전용 뷰
TABLE_NAME         : 제약 조건이 적용된 테이블 이름
*/

DESC USER_CONSTRAINTS;
-- 단축키 모두 지우기 CTRL SHIFR D

SELECT * FROM USER_CONSTRAINTS;

-- 1. NOT NULL
-- 해당 컬럼에 반드시 값이 존재해야하는 경우 사용
-- 삽입 / 수정시 NULL 값을 허용하지 않도록 컬럼 레벨에서 제한

-- NOT NULL을 지정한 테이블 생성
CREATE TABLE USER_TEST_TABLE (
    USER_NO NUMBER(10,0) NOT NULL, -- 컬럼 레벨 제약 조건 설정
    USER_ID VARCHAR2(30),
    USER_PWD VARCHAR2(30),
    USER_NAME VARCHAR2(20),
    GENDER VARCHAR2(10),
    PHONE VARCHAR2(30),
    EMAIL VARCHAR2(50)
    );

-- INSERT 모두 작성
INSERT INTO USER_TEST_TABLE
VALUES(1, '사용자1', 'PW1', '홍길동', '남', '010-1111-2222', 'hong@hong.co.kr');

-- INSERT 모두 작성
INSERT INTO USER_TEST_TABLE
VALUES(null, '사용자1', 'PW1', '홍길동', '남', '010-1111-2222', 'hong@hong.co.kr');
/*
SQL 오류: ORA-01400: cannot insert NULL into
NULL값을 넣을 수 없음

USER_NO NUMBER (10,0) NOT NULL
NULL 값을 넣을 수 없다 설정 했기 때문에 빈 값 NULL을 넣을 수 없는 것
*/

-- 2. UNIQUE 제약 조건
-- 컬럼에 입력 값에 대해서 중복을 제한하는 제약 조건
-- 컬럼 레벨에서 설정 가능, 테이블 레벨에서 설정 가능
-- 단, UNIQUE 제약 조건이 설정된 컬럼에 NULL 값은 중복 삽입 가능

-- UNIQUE 제약 조건이 들어간 조건 테이블 생성
CREATE TABLE UNIQUE_TABLE(
    USER_NO NUMBER(10,0),
    
    --USER_ID VARCHAR2(20) UNIQUE -- 컬럼 레벨 제약 조건 (이름X)
    -- (방법1)
    USER_ID VARCHAR2(20) CONSTRAINT USER_ID_U UNIQUE, -- CONSTRAINT 제약조건명 제약조건종료
                                                      -- 컬럼 레벨 제약 조건 (이름O)
                                                      
    -- (방법2)
    USER_NAME VARCHAR2(30), -- 테이블 레벨로 UNIQUE 제약 조건 설정
    
    -- 테이블 레벨 --
    -- UNIQUE(USER_NAME) -- 컬럼 레벨 제약 조건 (이름X)
    CONSTRAINT USER_NAME_U UNIQUE(USER_NAME)
);

-- KH_CAFE 테이블 만들기
-- CAFE_ID NUMBER 10 기본키 (PRIMARY KEY)
-- CAFE_NAME VARCHAR2 (100) 널 값 못들어가게 설정
-- CAFE_PHONE VARCHAR2 (20) 핸드폰 번호 카페 중복 X (방법1)
-- CAFE_ADDRESS VARCHAR2 (100) 주소 카페 중복 X (방법2)
CREATE TABLE KH_CAFE(
    CAFE_ID NUMBER(10,0) PRIMARY KEY,
    CAFE_NAME VARCHAR2(100) NOT NULL,
    CAFE_PHONE VARCHAR2(20) CONSTRAINT C_P_U UNIQUE,
    CAFE_ADDRESS VARCHAR2(100),
    CONSTRAINT C_A_U UNIQUE(CAFE_ADDRESS)
);
/*
ORA-00955: name is already used by an existing object
존재하기 떄문에 중복X
*/

INSERT INTO KH_CAFE
VALUES(1, '맥아커피', '02-1111-1111', '서울시 강남구 광남동 2길');

/*
ALTER 를 사용하여 컬럼 크기 수정 가능
ALTER 테이블명 MODIFTY (수정할 컬럼명 수정할 크기);

ALTER TABLE KH_CAFE MODIFT (CAFE_PHONE VARCHAR2(20);
*/

COMMIT;


