CREATE OR REPLACE PACKAGE USER_PACKAGE AS

  TYPE T_USER IS RECORD (
  user_login VARCHAR2(20),
  user_password VARCHAR2(20),
  user_email VARCHAR2(40)
  );

  TYPE T_USER_TABLE IS
    TABLE OF T_USER;

  FUNCTION LOG_IN(LOGIN    IN SuperUser.user_login%TYPE,
                  PASSWORD IN SuperUser.user_password%TYPE)
    RETURN NUMBER;

  PROCEDURE REGISTER(STATUS   OUT VARCHAR2,
                     LOGIN    IN  SuperUser.user_login%TYPE,
                     PASSWORD IN  SuperUser.user_password%TYPE,
                     EMAIL    IN  SuperUser.user_email%TYPE);
END;


CREATE OR REPLACE PACKAGE BODY USER_PACKAGE AS
  FUNCTION LOG_IN(LOGIN IN SuperUser.user_login%TYPE, PASSWORD IN SuperUser.user_password%TYPE)
    RETURN NUMBER AS
    res NUMBER(1);
    begin
      SELECT count(*)
          INTO res FROM SuperUser WHERE user_login = LOGIN
                                    AND user_password = PASSWORD;
      RETURN (res);
    END;

  PROCEDURE REGISTER(STATUS   OUT VARCHAR2,
                     LOGIN    IN  SuperUser.user_login%TYPE,
                     PASSWORD IN  SuperUser.user_password%TYPE,
                     EMAIL    IN  SuperUser.user_email%TYPE) AS
    BEGIN
      INSERT INTO SuperUser (user_login, user_password, user_email) VALUES (LOGIN, PASSWORD, EMAIL);

      COMMIT;
      STATUS := '200 OK';
      exception
      WHEN DUP_VAL_ON_INDEX
      THEN
        STATUS := '500 Already inserted';
      WHEN OTHERS
      THEN
        STATUS := SQLERRM;
    END;


END USER_PACKAGE;
/

select USER_PACKAGE.LOG_IN('ledoff.sky', 'qwerty123456')
from dual;
