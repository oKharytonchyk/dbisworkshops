CREATE OR REPLACE PACKAGE CREATED_EVENT_PACKAGE AS

  TYPE T_CREATED_EVENT IS RECORD (
  place_id NUMBER,
  event_name VARCHAR2(50),
  date_creation_event VARCHAR2(10)
  );

  TYPE T_CREATED_EVENT_TABLE IS
    TABLE OF T_CREATED_EVENT;

  FUNCTION CREATE_CREATED_EVENT(NEW_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                NEW_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                NEW_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type)
    RETURN VARCHAR2;

  FUNCTION GET_CREATED_EVENTS(CE_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type DEFAULT NULL,
                              CE_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type DEFAULT NULL,
                              CE_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type DEFAULT NULL)
    RETURN T_CREATED_EVENT_TABLE PIPELINED;

  FUNCTION UPDATE_CREATED_EVENT(OLD_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                OLD_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                OLD_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type,
                                NEW_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                NEW_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                NEW_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type)
    RETURN VARCHAR2;

  FUNCTION DELETE_CREATED_EVENT(CE_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                CE_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                CE_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type)
    RETURN VARCHAR2;
END;


CREATE OR REPLACE PACKAGE BODY CREATED_EVENT_PACKAGE AS
  FUNCTION CREATE_CREATED_EVENT(NEW_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                NEW_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                NEW_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO CREATEDEVENT (PLACE_ID, EVENT_NAME, DATE_CREATION_EVENT)
      VALUES (NEW_PLACE_ID, NEW_EVENT_NAME, NEW_DATE_CREATION_EVENT);
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

  FUNCTION GET_CREATED_EVENTS(CE_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type DEFAULT NULL,
                              CE_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type DEFAULT NULL,
                              CE_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type DEFAULT NULL)
    RETURN T_CREATED_EVENT_TABLE
  PIPELINED
  IS
    TYPE created_event_cursor_type IS REF CURSOR;
    created_event_cursor created_event_cursor_type;
    cursor_data          T_CREATED_EVENT;
    query_str            varchar2(1000);
    begin
      query_str := 'select PLACE_ID, EVENT_NAME, DATE_CREATION_EVENT
                        from CREATEDEVENT';
      if CE_PLACE_ID is not null
      then
        query_str := query_str || ' where PLACE_ID = trim(''' || CE_PLACE_ID || ''') ';
        if CE_EVENT_NAME is not null
        then
          query_str := query_str || ' AND EVENT_NAME = trim(''' || CE_EVENT_NAME || ''') ';
          if CE_DATE_CREATION_EVENT is not null
          then
            query_str := query_str || ' AND DATE_CREATION_EVENT = trim(''' || CE_DATE_CREATION_EVENT || ''') ';
          end if;
        end if;
      end if;
      --       query_str := query_str || ' group by user_login';

      OPEN created_event_cursor FOR query_str;
      LOOP
        FETCH created_event_cursor into cursor_data;
        exit when (created_event_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END;

  FUNCTION UPDATE_CREATED_EVENT(OLD_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                OLD_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                OLD_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type,
                                NEW_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                NEW_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                NEW_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      UPDATE CREATEDEVENT
      SET PLACE_ID            = NEW_PLACE_ID,
          EVENT_NAME          = NEW_EVENT_NAME,
          DATE_CREATION_EVENT = NEW_DATE_CREATION_EVENT
      WHERE PLACE_ID = OLD_PLACE_ID
        AND EVENT_NAME = OLD_EVENT_NAME
        AND DATE_CREATION_EVENT = OLD_DATE_CREATION_EVENT;
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

  FUNCTION DELETE_CREATED_EVENT(CE_PLACE_ID            IN CREATEDEVENT.PLACE_ID%type,
                                CE_EVENT_NAME          IN CREATEDEVENT.EVENT_NAME%type,
                                CE_DATE_CREATION_EVENT IN CREATEDEVENT.DATE_CREATION_EVENT%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      delete
      from CREATEDEVENT
      WHERE PLACE_ID = CE_PLACE_ID
        AND EVENT_NAME = CE_EVENT_NAME
        AND DATE_CREATION_EVENT = CE_DATE_CREATION_EVENT;
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

END CREATED_EVENT_PACKAGE;
/

select *
from table (CREATED_EVENT_PACKAGE.GET_CREATED_EVENTS());

select CREATED_EVENT_PACKAGE.CREATE_CREATED_EVENT(3, 'Lab work', '2018-12-12')
from dual;

select CREATED_EVENT_PACKAGE.UPDATE_CREATED_EVENT(3, 'Lab work', '2018-12-12', 3, 'Lab work', '2019-11-11')
from dual;

select CREATED_EVENT_PACKAGE.DELETE_CREATED_EVENT(3, 'Lab work', '2019-11-11')
from dual;
