-- -----------------------------------------------------
-- Table `WIN_DEVICE`
-- -----------------------------------------------------
CREATE TABLE WIN_DEVICE (
  DEVICE_ID VARCHAR(45) NOT NULL,
  CHANNEL_URI VARCHAR(100) DEFAULT NULL,
  DEVICE_INFO VARCHAR2(4000) DEFAULT NULL,
  IMEI VARCHAR(45) DEFAULT NULL,
  IMSI VARCHAR(45) DEFAULT NULL,
  OS_VERSION VARCHAR(45) DEFAULT NULL,
  DEVICE_MODEL VARCHAR(45) DEFAULT NULL,
  VENDOR VARCHAR(45) DEFAULT NULL,
  LATITUDE VARCHAR(45) DEFAULT NULL,
  LONGITUDE VARCHAR(45) DEFAULT NULL,
  SERIAL VARCHAR(45) DEFAULT NULL,
  MAC_ADDRESS VARCHAR(45) DEFAULT NULL,
  DEVICE_NAME VARCHAR(100) DEFAULT NULL,
  CONSTRAINT PK_WIN_DEVICE PRIMARY KEY (DEVICE_ID)
)
/

-- -----------------------------------------------------
-- Table `WIN_FEATURE`
-- -----------------------------------------------------
CREATE TABLE WIN_FEATURE (
  ID NUMBER(10) NOT NULL,
  CODE VARCHAR(45) NOT NULL,
  NAME VARCHAR(100) NOT NULL,
  DESCRIPTION VARCHAR(200) NULL,
  PRIMARY KEY (ID)
)
/

-- -----------------------------------------------------
-- Table `WINDOWS_ENROLLMENT_TOKEN`
-- -----------------------------------------------------
CREATE TABLE WINDOWS_ENROLLMENT_TOKEN (
  ID NUMBER(10) NOT NULL,
  TENANT_DOMAIN VARCHAR(45) NOT NULL,
  TENANT_ID NUMBER(10) DEFAULT 0,
  ENROLLMENT_TOKEN VARCHAR(100) NULL,
  DEVICE_ID VARCHAR(100) NULL,
  USERNAME VARCHAR(45) NULL,
  OWNERSHIP VARCHAR(45) NULL,
  PRIMARY KEY (ID)
)
/

-- -----------------------------------------------------
-- Sequence `WIN_FEATURE_ID_INC_SEQ`
-- -----------------------------------------------------
CREATE SEQUENCE WIN_FEATURE_ID_INC_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

-- -----------------------------------------------------
-- Trigger `WIN_FEATURE_ID_INC_TRIG`
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER WIN_FEATURE_ID_INC_TRIG
BEFORE INSERT
ON WIN_FEATURE
REFERENCING NEW AS NEW
FOR EACH ROW
  BEGIN
    SELECT WIN_FEATURE_ID_INC_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
  END;
/

-- -----------------------------------------------------
-- Sequence `WIN_ENR_TOKEN_ID_INC_SEQ`
-- -----------------------------------------------------
CREATE SEQUENCE WIN_ENR_TOKEN_ID_INC_SEQ START WITH 1 INCREMENT BY 1 NOCACHE
/

-- -----------------------------------------------------
-- Trigger `WIN_ENR_TOKEN_ID_INC_TRIG`
-- -----------------------------------------------------
CREATE OR REPLACE TRIGGER WIN_ENR_TOKEN_ID_INC_TRIG
BEFORE INSERT
ON WINDOWS_ENROLLMENT_TOKEN
REFERENCING NEW AS NEW
FOR EACH ROW
  BEGIN
    SELECT WIN_ENR_TOKEN_ID_INC_SEQ.NEXTVAL INTO :NEW.ID FROM DUAL;
  END;
/