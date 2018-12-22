CREATE OR REPLACE PACKAGE USER_PACKAGE AS

  TYPE T_USER IS RECORD (
  user_login VARCHAR2(20)
  --   user_password VARCHAR2(20),
  --   user_email VARCHAR2(40)
  );

  TYPE T_USER_TABLE IS
    TABLE OF T_USER;

  FUNCTION LOG_IN(LOGIN    IN SuperUser.user_login%TYPE,
                  PASSWORD IN SuperUser.user_password%TYPE)
    RETURN NUMBER;

  FUNCTION REGISTER(LOGIN    IN SuperUser.user_login%TYPE,
                    PASSWORD IN SuperUser.user_password%TYPE,
                    EMAIL    IN SuperUser.user_email%TYPE)
    RETURN VARCHAR2;

  FUNCTION GET_USERS(LOGIN IN SuperUser.user_login%TYPE DEFAULT NULL)
    RETURN T_USER_TABLE PIPELINED;

  --   FUNCTION UPDATE_USERS(LOGIN    IN SuperUser.user_login%TYPE,
  --                         PASSWORD IN SuperUser.user_password%TYPE,
  --                         EMAIL    IN SuperUser.user_email%TYPE)
  --     RETURN VARCHAR2;
  --
  --   FUNCTION DELETE_USERS(LOGIN    IN SuperUser.user_login%TYPE,
  --                         PASSWORD IN SuperUser.user_password%TYPE,
  --                         EMAIL    IN SuperUser.user_email%TYPE)
  --     RETURN VARCHAR2;
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

  FUNCTION REGISTER(LOGIN    IN SuperUser.user_login%TYPE,
                    PASSWORD IN SuperUser.user_password%TYPE,
                    EMAIL    IN SuperUser.user_email%TYPE)
    RETURN VARCHAR2 AS
    STATUS VARCHAR2(50);
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

  FUNCTION GET_USERS(LOGIN IN SuperUser.user_login%TYPE DEFAULT NULL)
    RETURN T_USER_TABLE
  PIPELINED
  IS
    TYPE user_cursor_type IS REF CURSOR;
    user_cursor user_cursor_type;
    cursor_data T_USER;
    query_str   varchar2(1000);
    begin
      query_str := 'select user_login
                        from SUPERUSER';
      if LOGIN is not null
      then
        query_str := query_str || ' where trim(user_login) = trim(''' || LOGIN || ''') ';
      end if;
      query_str := query_str || ' group by user_login';

      OPEN user_cursor FOR query_str;
      LOOP
        FETCH user_cursor into cursor_data;
        exit when (user_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END GET_USERS;

END USER_PACKAGE;
/

select *
from table (USER_PACKAGE.GET_USERS());
