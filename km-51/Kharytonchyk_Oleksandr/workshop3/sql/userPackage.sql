CREATE OR REPLACE PACKAGE USER_PACKAGE AS

  TYPE T_USER IS RECORD (
  user_login VARCHAR2(20),
  --   user_password VARCHAR2(20),
  user_email VARCHAR2(40)
  );

  TYPE T_USER_TABLE IS
    TABLE OF T_USER;

  FUNCTION LOG_IN(LOGIN    IN SuperUser.user_login%TYPE,
                  PASSWORD IN SuperUser.user_password%TYPE)
    RETURN VARCHAR2;

  FUNCTION REGISTER(LOGIN    IN SuperUser.user_login%TYPE,
                    PASSWORD IN SuperUser.user_password%TYPE,
                    EMAIL    IN SuperUser.user_email%TYPE)
    RETURN VARCHAR2;

  FUNCTION GET_USERS(LOGIN IN SuperUser.user_login%TYPE DEFAULT NULL)
    RETURN T_USER_TABLE PIPELINED;

  FUNCTION UPDATE_USER(OLD_LOGIN    IN SuperUser.user_login%TYPE,
                       NEW_LOGIN    IN SuperUser.user_login%TYPE,
                       NEW_PASSWORD IN SuperUser.USER_PASSWORD%TYPE,
                       NEW_EMAIL    IN SuperUser.USER_EMAIL%TYPE)
    RETURN VARCHAR2;

  FUNCTION DELETE_USER(LOGIN IN SuperUser.user_login%TYPE)
    RETURN VARCHAR2;
END;


CREATE OR REPLACE PACKAGE BODY USER_PACKAGE AS
  FUNCTION LOG_IN(LOGIN IN SuperUser.user_login%TYPE, PASSWORD IN SuperUser.user_password%TYPE)
    RETURN VARCHAR2
  IS
    quantity NUMBER(10);
    begin
      SELECT count(*)
          INTO quantity FROM SuperUser WHERE user_login = LOGIN
                                         AND user_password = PASSWORD;
      if quantity = 1
      then return '200 OK';
      else return '-200 NE OK';
      end if;
    END;

  FUNCTION REGISTER(LOGIN    IN SuperUser.user_login%TYPE,
                    PASSWORD IN SuperUser.user_password%TYPE,
                    EMAIL    IN SuperUser.user_email%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO SuperUser (user_login, user_password, user_email) VALUES (LOGIN, PASSWORD, EMAIL);
      COMMIT;
      RETURN '200 OK';
      exception
      WHEN DUP_VAL_ON_INDEX
      THEN
        RETURN '500 Already inserted';
      WHEN OTHERS
      THEN
        RETURN SQLERRM;
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
      query_str := 'select user_login, user_email
                        from SUPERUSER';
      if LOGIN is not null
      then
        query_str := query_str || ' where trim(user_login) = trim(''' || LOGIN || ''') ';
      end if;
      --       query_str := query_str || ' group by user_login';

      OPEN user_cursor FOR query_str;
      LOOP
        FETCH user_cursor into cursor_data;
        exit when (user_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END;

  FUNCTION UPDATE_USER(OLD_LOGIN    IN SuperUser.user_login%TYPE,
                       NEW_LOGIN    IN SuperUser.user_login%TYPE,
                       NEW_PASSWORD IN SuperUser.USER_PASSWORD%TYPE,
                       NEW_EMAIL    IN SuperUser.USER_EMAIL%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      UPDATE SUPERUSER
      SET USER_LOGIN    = NEW_LOGIN,
          USER_PASSWORD = NEW_PASSWORD,
          USER_EMAIL    = NEW_EMAIL
      WHERE USER_LOGIN = OLD_LOGIN;
      COMMIT;
      return '200 OK';
      exception
      WHEN DUP_VAL_ON_INDEX
      THEN
        return '500 Already inserted';
      WHEN OTHERS
      THEN
        return SQLERRM;
    END;

  FUNCTION DELETE_USER(LOGIN IN SuperUser.user_login%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      delete from SuperUser where USER_LOGIN = LOGIN;
      COMMIT;
      return '200 OK';
      exception
      WHEN DUP_VAL_ON_INDEX
      THEN
        return '500 Already inserted';
      WHEN OTHERS
      THEN
        return SQLERRM;
    END;

END USER_PACKAGE;
/

select *
from table (USER_PACKAGE.GET_USERS());

select USER_PACKAGE.LOG_IN('ledoff.sky', 'qwerty123456')
from dual;

select USER_PACKAGE.REGISTER('ledoff.sky1', 'Password123456', 'Email@mailc.pmc')
from dual;

select USER_PACKAGE.UPDATE_USER('ledoff.sky1', 'newLedoff.sky', 'newPassword123456', 'newEmail@mailc.pmc')
from dual;

select USER_PACKAGE.DELETE_USER('newLedoff.sky')
from dual;
