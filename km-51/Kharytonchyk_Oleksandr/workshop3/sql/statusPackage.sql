CREATE OR REPLACE PACKAGE STATUS_PACKAGE AS

  TYPE T_STATUS IS RECORD (
  status VARCHAR2(20)
  );

  TYPE T_STATUS_TABLE IS
    TABLE OF T_STATUS;

  FUNCTION CREATE_STATUS(NEW_STATUS IN STATUS.STATUS%TYPE)
    RETURN VARCHAR2;

  FUNCTION GET_STATUSES(S_STATUS IN STATUS.STATUS%TYPE DEFAULT NULL)
    RETURN T_STATUS_TABLE PIPELINED;

  FUNCTION UPDATE_STATUS(OLD_STATUS IN STATUS.STATUS%TYPE,
                         NEW_STATUS IN STATUS.STATUS%TYPE)
    RETURN VARCHAR2;

  FUNCTION DELETE_STATUS(S_STATUS IN STATUS.STATUS%TYPE)
    RETURN VARCHAR2;
END;


CREATE OR REPLACE PACKAGE BODY STATUS_PACKAGE AS
  FUNCTION CREATE_STATUS(NEW_STATUS IN STATUS.STATUS%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO STATUS (STATUS) VALUES (NEW_STATUS);
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

  FUNCTION GET_STATUSES(S_STATUS IN STATUS.STATUS%TYPE DEFAULT NULL)
    RETURN T_STATUS_TABLE
  PIPELINED
  IS
    TYPE status_cursor_type IS REF CURSOR;
    status_cursor status_cursor_type;
    cursor_data   T_STATUS;
    query_str     varchar2(1000);
    begin
      query_str := 'select STATUS
                        from STATUS';
      if S_STATUS is not null
      then
        query_str := query_str || ' where trim(STATUS) = trim(''' || S_STATUS || ''') ';
      end if;
      --       query_str := query_str || ' group by user_login';

      OPEN status_cursor FOR query_str;
      LOOP
        FETCH status_cursor into cursor_data;
        exit when (status_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END;

  FUNCTION UPDATE_STATUS(OLD_STATUS IN STATUS.STATUS%TYPE,
                         NEW_STATUS IN STATUS.STATUS%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      UPDATE STATUS SET STATUS = NEW_STATUS WHERE STATUS = OLD_STATUS;
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

  FUNCTION DELETE_STATUS(S_STATUS IN STATUS.STATUS%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      delete from STATUS where STATUS = S_STATUS;
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

END STATUS_PACKAGE;
/

select *
from table (STATUS_PACKAGE.GET_STATUSES());

select STATUS_PACKAGE.CREATE_STATUS('pending')
from dual;

select STATUS_PACKAGE.UPDATE_STATUS('pending', 'on hold')
from dual;

select STATUS_PACKAGE.DELETE_STATUS('on hold')
from dual;
