CREATE OR REPLACE PACKAGE PLACE_PACKAGE AS
  TYPE T_PLACE IS RECORD (
  place_id NUMBER,
  address VARCHAR2(60),
  room_number NUMBER,
  schedule VARCHAR2(11)
  );

  TYPE T_PLACE_TABLE IS TABLE OF T_PLACE;

  FUNCTION CREATE_PLACE(NEW_PLACE_ID    IN Place.place_id%type,
                            NEW_ADDRESS     IN Place.ADDRESS%type,
                            NEW_ROOM_NUMBER IN Place.ROOM_NUMBER%type,
                            NEW_SCHEULE     IN Place.SCHEDULE%type)
    RETURN VARCHAR2;

  FUNCTION GET_PLACES(P_ID IN Place.place_id%type default null)
    RETURN T_PLACE_TABLE PIPELINED;

  FUNCTION UPDATE_PLACE(OLD_P_ID        IN Place.place_id%type,
                        NEW_P_ID        IN Place.place_id%type,
                        NEW_ADDRESS     IN Place.ADDRESS%type,
                        NEW_ROOM_NUMBER IN Place.ROOM_NUMBER%type,
                        NEW_SCHEULE     IN Place.SCHEDULE%type)
    RETURN VARCHAR2;

  FUNCTION DELETE_PLACE(P_ID IN Place.place_id%type)
    RETURN VARCHAR2;
END;

CREATE OR REPLACE PACKAGE BODY PLACE_PACKAGE AS
  FUNCTION CREATE_PLACE(NEW_PLACE_ID    IN Place.PLACE_ID%type,
                            NEW_ADDRESS     IN Place.ADDRESS%type,
                            NEW_ROOM_NUMBER IN Place.ROOM_NUMBER%type,
                            NEW_SCHEULE     IN Place.SCHEDULE%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      INSERT INTO PLACE (PLACE_ID, ADDRESS, ROOM_NUMBER, SCHEDULE)
      VALUES (NEW_PLACE_ID, NEW_ADDRESS, NEW_ROOM_NUMBER, NEW_SCHEULE);
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

  FUNCTION GET_PLACES(P_ID IN Place.place_id%type default null)
    RETURN T_PLACE_TABLE
  PIPELINED
  IS
    TYPE place_cursor_type IS REF CURSOR;
    place_cursor place_cursor_type;
    cursor_data  T_PLACE;
    query_str    varchar2(1000);
    begin
      query_str := 'select place_id, address, room_number, schedule
                        from Place';
      if P_ID is not null
      then
        query_str := query_str || ' where trim(place_id) = trim(''' || P_ID || ''') ';
      end if;
      --       query_str := query_str || ' group by user_login';

      OPEN place_cursor FOR query_str;
      LOOP
        FETCH place_cursor into cursor_data;
        exit when (place_cursor%NOTFOUND);
        PIPE ROW (cursor_data);
      END LOOP;
    END;

  FUNCTION UPDATE_PLACE(OLD_P_ID        IN Place.place_id%type,
                        NEW_P_ID        IN Place.place_id%type,
                        NEW_ADDRESS     IN Place.ADDRESS%type,
                        NEW_ROOM_NUMBER IN Place.ROOM_NUMBER%type,
                        NEW_SCHEULE     IN Place.SCHEDULE%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      UPDATE PLACE
      SET place_id    = NEW_P_ID,
          ADDRESS     = NEW_ADDRESS,
          ROOM_NUMBER = NEW_ROOM_NUMBER,
          SCHEDULE    = NEW_SCHEULE
      WHERE place_id = OLD_P_ID;
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

  FUNCTION DELETE_PLACE(P_ID IN Place.place_id%type)
    RETURN VARCHAR2 AS PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
      delete from PLACE where PLACE_ID = P_ID;
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


END PLACE_PACKAGE;
/

select *
from table (PLACE_PACKAGE.GET_PLACES());

select PLACE_PACKAGE.CREATE_PLACE(100, 'Khreshatyk 1b', 110, '08:00 20:00')
from dual;
            
select *
from table (PLACE_PACKAGE.GET_PLACES(100));

select PLACE_PACKAGE.UPDATE_PLACE(100, 100, 'Peremohy square 37a', 111, '10:00 16:00')
from dual;

select PLACE_PACKAGE.DELETE_PLACE(100)
from dual;

