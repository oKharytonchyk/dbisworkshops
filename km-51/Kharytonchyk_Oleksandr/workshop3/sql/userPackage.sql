CREATE OR REPLACE PACKAGE USER_PACKAGE AS

    TYPE T_USER IS RECORD (
   	user_login VARCHAR2(20),
  	user_password VARCHAR2(20),
 	user_email VARCHAR2(40)
    );
    
    TYPE T_USER_TABLE IS 
    	TABLE OF T_USER;
        
    FUNCTION LOG_IN(LOGIN IN SuperUser.user_login%TYPE, 
		    PASSWORD IN SuperUser.user_password%TYPE)
    	RETURN T_USER_TABLE PIPELINED;

  PROCEDURE REGISTER(LOGIN    IN SuperUser.user_login%TYPE,
                     PASSWORD IN SuperUser.user_password %TYPE,
                     EMAIL    IN SuperUser.user_email%TYPE);
END;



CREATE OR REPLACE PACKAGE BODY USER_PACKAGE AS
  FUNCTION LOG_IN(LOGIN IN SuperUser.user_login%TYPE, PASSWORD IN SuperUser.user_password%TYPE)
    RETURN T_USER_TABLE PIPELINED AS
    CURSOR MY_CUR IS
      SELECT *
      FROM SuperUser
      WHERE SuperUser.user_login = LOGIN
        AND SuperUser.user_password = PASSWORD;
    BEGIN
      FOR rec IN MY_CUR
      LOOP
        pipe row (rec);
      end loop;
    END;

  PROCEDURE REGISTER(LOGIN IN SuperUser.user_login%TYPE, PASSWORD IN SuperUser.user_password %TYPE,
                     EMAIL IN SuperUser.user_email%TYPE) AS
    BEGIN
      INSERT INTO SuperUser(user_login, user_password, user_email) VALUES (LOGIN, PASSWORD, EMAIL);
    END;

END;
/

SELECT *
FROM TABLE (USER_PACKAGE.LOG_IN('ledoff.sky', 'qwerty123456'));