CREATE OR REPLACE PACKAGE QUEUE_PACKAGE AS
  TYPE T_QUEUE IS RECORD (
  status VARCHAR2(20),
  user_login VARCHAR2(20),
  place_id NUMBER,
  event_name VARCHAR2(50),
  date_creation_event DATE,
  date_request_creation DATE
  );

  TYPE T_QUEUE_TABLE IS TABLE OF T_QUEUE;

  FUNCTION CREATE_QUEUE(NEW_STATUS                IN QUEUE.STATUS%type,
                        NEW_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        NEW_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        NEW_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        NEW_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        NEW_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type)
    RETURN VARCHAR2;

  FUNCTION GET_QUEUES(Q_STATUS                IN QUEUE.STATUS%type default null,
                      Q_USER_LOGIN            IN QUEUE.USER_LOGIN%type default null,
                      Q_PLACE_ID              IN QUEUE.PLACE_ID%type default null,
                      Q_EVENT_NAME            IN QUEUE.EVENT_NAME%type default null,
                      Q_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type default null,
                      Q_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type default null)
    RETURN T_QUEUE_TABLE PIPELINED;

  FUNCTION UPDATE_QUEUE(OLD_STATUS                IN QUEUE.STATUS%type,
                        OLD_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        OLD_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        OLD_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        OLD_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        OLD_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type,
                        NEW_STATUS                IN QUEUE.STATUS%type,
                        NEW_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        NEW_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        NEW_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        NEW_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        NEW_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type)
    RETURN VARCHAR2;

  FUNCTION DELETE_QUEUE(Q_STATUS                IN QUEUE.STATUS%type,
                        Q_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        Q_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        Q_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        Q_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        Q_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type)
    RETURN VARCHAR2;

END;

CREATE OR REPLACE PACKAGE BODY QUEUE_PACKAGE AS
  FUNCTION CREATE_QUEUE(NEW_STATUS                IN QUEUE.STATUS%type,
                        NEW_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        NEW_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        NEW_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        NEW_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        NEW_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO QUEUE (status, user_login, place_id, event_name, date_creation_event, date_request_creation)
      VALUES (NEW_STATUS,
              NEW_USER_LOGIN,
              NEW_PLACE_ID,
              NEW_EVENT_NAME,
              NEW_DATE_CREATION_EVENT,
              NEW_DATE_REQUEST_CREATION);
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

  FUNCTION GET_QUEUES(Q_STATUS                IN QUEUE.STATUS%type default null,
                      Q_USER_LOGIN            IN QUEUE.USER_LOGIN%type default null,
                      Q_PLACE_ID              IN QUEUE.PLACE_ID%type default null,
                      Q_EVENT_NAME            IN QUEUE.EVENT_NAME%type default null,
                      Q_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type default null,
                      Q_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type default null)
    RETURN T_QUEUE_TABLE
  PIPELINED
  IS
    TYPE queue_cursor_type IS REF CURSOR;
    queue_cursor queue_cursor_type;
    cursor_data  T_QUEUE;
    query_str    varchar2(1000);
    begin
      query_str := 'select STATUS, USER_LOGIN, PLACE_ID, EVENT_NAME, DATE_CREATION_EVENT, DATE_REQUEST_CREATION
                        from Queue';
      if Q_STATUS is not null
      then
        query_str := query_str || ' where STATUS = trim(''' || Q_STATUS || ''') ';
        if Q_USER_LOGIN is not null
        then
          query_str := query_str || ' AND USER_LOGIN = trim(''' || Q_USER_LOGIN || ''') ';
          if Q_PLACE_ID is not null
          then
            query_str := query_str || ' AND PLACE_ID = trim(''' || Q_PLACE_ID || ''') ';
            if Q_EVENT_NAME is not null
            then
              query_str := query_str || ' AND EVENT_NAME = trim(''' || Q_EVENT_NAME || ''') ';
              if Q_DATE_CREATION_EVENT is not null
              then
                query_str := query_str || ' AND DATE_CREATION_EVENT = trim(''' || Q_DATE_CREATION_EVENT || ''') ';
                if Q_DATE_REQUEST_CREATION is not null
                then
                  query_str := query_str || ' AND DATE_REQUEST_CREATION = trim(''' || Q_DATE_REQUEST_CREATION || ''') ';
                end if;
              end if;
            end if;
          end if;
        end if;
      end if;
      --       query_str := query_str || ' group by user_login';

      OPEN queue_cursor FOR query_str;
      LOOP
        FETCH queue_cursor into cursor_data;
        exit when (queue_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END;

  FUNCTION UPDATE_QUEUE(OLD_STATUS                IN QUEUE.STATUS%type,
                        OLD_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        OLD_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        OLD_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        OLD_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        OLD_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type,
                        NEW_STATUS                IN QUEUE.STATUS%type,
                        NEW_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        NEW_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        NEW_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        NEW_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        NEW_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      UPDATE QUEUE
      SET STATUS                = NEW_STATUS,
          USER_LOGIN            = NEW_USER_LOGIN,
          PLACE_ID              = NEW_PLACE_ID,
          EVENT_NAME            = NEW_EVENT_NAME,
          DATE_CREATION_EVENT   = NEW_DATE_CREATION_EVENT,
          DATE_REQUEST_CREATION = NEW_DATE_REQUEST_CREATION
      WHERE STATUS = OLD_STATUS
        AND USER_LOGIN = OLD_USER_LOGIN
        AND PLACE_ID = OLD_PLACE_ID
        AND EVENT_NAME = OLD_EVENT_NAME
        AND DATE_CREATION_EVENT = OLD_DATE_CREATION_EVENT
        AND DATE_REQUEST_CREATION = OLD_DATE_REQUEST_CREATION;
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

  FUNCTION DELETE_QUEUE(Q_STATUS                IN QUEUE.STATUS%type,
                        Q_USER_LOGIN            IN QUEUE.USER_LOGIN%type,
                        Q_PLACE_ID              IN QUEUE.PLACE_ID%type,
                        Q_EVENT_NAME            IN QUEUE.EVENT_NAME%type,
                        Q_DATE_CREATION_EVENT   IN QUEUE.DATE_CREATION_EVENT%type,
                        Q_DATE_REQUEST_CREATION IN QUEUE.DATE_REQUEST_CREATION%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      delete
      from QUEUE
      where STATUS = Q_STATUS
        AND USER_LOGIN = Q_USER_LOGIN
        AND PLACE_ID = Q_PLACE_ID
        AND EVENT_NAME = Q_EVENT_NAME
        AND DATE_CREATION_EVENT = Q_DATE_CREATION_EVENT
        AND DATE_REQUEST_CREATION = Q_DATE_REQUEST_CREATION;
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

END QUEUE_PACKAGE;
/
