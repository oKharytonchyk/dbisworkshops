CREATE OR REPLACE PACKAGE EVENT_PACKAGE AS

  TYPE T_EVENT IS RECORD (
  event_name VARCHAR2(50)
  );

  TYPE T_EVENT_TABLE IS
    TABLE OF T_EVENT;

  FUNCTION CREATE_EVENT(NEW_E_NAME IN EVENT.EVENT_NAME%TYPE)
    RETURN VARCHAR2;

  FUNCTION GET_EVENTS(E_NAME IN EVENT.EVENT_NAME%TYPE DEFAULT NULL)
    RETURN T_EVENT_TABLE PIPELINED;

  FUNCTION UPDATE_EVENT(OLD_E_NAME IN EVENT.EVENT_NAME%TYPE,
                        NEW_E_NAME IN EVENT.EVENT_NAME%TYPE)
    RETURN VARCHAR2;

  FUNCTION DELETE_EVENT(E_NAME IN EVENT.EVENT_NAME%TYPE)
    RETURN VARCHAR2;
END;


CREATE OR REPLACE PACKAGE BODY EVENT_PACKAGE AS
  FUNCTION CREATE_EVENT(NEW_E_NAME IN EVENT.EVENT_NAME%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO EVENT (EVENT_NAME) VALUES (NEW_E_NAME);
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

  FUNCTION GET_EVENTS(E_NAME IN EVENT.EVENT_NAME%TYPE DEFAULT NULL)
    RETURN T_EVENT_TABLE
  PIPELINED
  IS
    TYPE user_cursor_type IS REF CURSOR;
    event_cursor user_cursor_type;
    cursor_data  T_EVENT;
    query_str    varchar2(1000);
    begin
      query_str := 'select EVENT_NAME
                        from EVENT';
      if E_NAME is not null
      then
        query_str := query_str || ' where trim(EVENT_NAME) = trim(''' || E_NAME || ''') ';
      end if;
      --       query_str := query_str || ' group by user_login';

      OPEN event_cursor FOR query_str;
      LOOP
        FETCH event_cursor into cursor_data;
        exit when (event_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END;

  FUNCTION UPDATE_EVENT(OLD_E_NAME IN EVENT.EVENT_NAME%TYPE,
                        NEW_E_NAME IN EVENT.EVENT_NAME%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      UPDATE EVENT SET EVENT_NAME = NEW_E_NAME WHERE EVENT_NAME = OLD_E_NAME;
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

  FUNCTION DELETE_EVENT(E_NAME IN EVENT.EVENT_NAME%TYPE)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      delete from EVENT where EVENT_NAME = E_NAME;
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

END EVENT_PACKAGE;
/

select *
from table (EVENT_PACKAGE.GET_EVENTS());

select EVENT_PACKAGE.CREATE_EVENT('StandUp')
from dual;

select EVENT_PACKAGE.UPDATE_EVENT('StandUp', 'Course work')
from dual;

select EVENT_PACKAGE.DELETE_EVENT('Course work')
from dual;
