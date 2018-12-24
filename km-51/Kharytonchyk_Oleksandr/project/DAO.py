import cx_Oracle as cx_Oracle


class User:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1521/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def register(self, login, password, email):
        result = self.__cursor.callfunc("USER_PACKAGE.REGISTER", cx_Oracle.STRING, [login, password, email])
        return result

    def log_in(self, login, password):
        result = self.__cursor.callfunc("USER_PACKAGE.LOG_IN", cx_Oracle.STRING, [login, password])
        return result

    def get_user(self, select_login):
        query = 'select * from table ( USER_PACKAGE.GET_USERS(:LOGIN) )'
        var = self.__cursor.execute(query, LOGIN=select_login)
        return var.fetchall()

    def get_users(self):
        query = 'select * from table (USER_PACKAGE.GET_USERS())'
        var = self.__cursor.execute(query)
        return var.fetchall()

    def update_user(self, oldLogin, newLogin, newPassword, newEmail):
        result = self.__cursor.callfunc("USER_PACKAGE.UPDATE_USER", cx_Oracle.STRING,
                                        [oldLogin, newLogin, newPassword, newEmail])
        return result

    def delete_user(self, login):
        result = self.__cursor.callfunc("USER_PACKAGE.DELETE_USER", cx_Oracle.STRING, [login])
        return result


class Place:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1521/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def create_place(self, newPlaceID, newAddress, newRoomNumber, newSchedule):
        result = self.__cursor.callfunc("PLACE_PACKAGE.CREATE_PLACE", cx_Oracle.STRING,
                                        [newPlaceID, newAddress, newRoomNumber, newSchedule])
        return result

    def get_place(self, p_id):
        query = 'select * from table ( PLACE_PACKAGE.GET_PLACES(:PLACE_ID) )'
        var = self.__cursor.execute(query, PLACE_ID=p_id)
        return var.fetchall()

    def get_places(self):
        query = 'select * from table (PLACE_PACKAGE.GET_PLACES())'
        var = self.__cursor.execute(query)
        return var.fetchall()

    def update_place(self, oldPlaceID, newPlaceID, newAddress, newRoomNumber, newSchedule):
        result = self.__cursor.callfunc("PLACE_PACKAGE.UPDATE_PLACE", cx_Oracle.STRING,
                                        [oldPlaceID, newPlaceID, newAddress, newRoomNumber, newSchedule])
        return result

    def delete_place(self, placeID):
        result = self.__cursor.callfunc("PLACE_PACKAGE.DELETE_PLACE", cx_Oracle.STRING, [placeID])
        return result


class Queue:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1521/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def create_queue(self, NEW_STATUS, NEW_USER_LOGIN, NEW_PLACE_ID, NEW_EVENT_NAME, NEW_DATE_CREATION_EVENT,
                     NEW_DATE_REQUEST_CREATION):
        result = self.__cursor.callfunc("QUEUE_PACKAGE.CREATE_QUEUE", cx_Oracle.STRING,
                                        [NEW_STATUS, NEW_USER_LOGIN, NEW_PLACE_ID, NEW_EVENT_NAME,
                                         NEW_DATE_CREATION_EVENT, NEW_DATE_REQUEST_CREATION])
        return result

    def get_queues_0(self):
        query = 'select * from table (QUEUE_PACKAGE.GET_QUEUES())'
        var = self.__cursor.execute(query)
        return var.fetchall()

    def get_queues_1(self, select_status):
        query = 'select * from table ( QUEUE_PACKAGE.GET_QUEUES(:STATUS) )'
        var = self.__cursor.execute(query, STATUS=select_status)
        return var.fetchall()

    def get_queues_2(self, select_status, select_user_login):
        query = 'select * from table ( QUEUE_PACKAGE.GET_QUEUES(:STATUS, :USER_LOGIN) )'
        var = self.__cursor.execute(query, STATUS=select_status, USER_LOGIN=select_user_login)
        return var.fetchall()

    def get_queues_3(self, select_status, select_user_login, select_place_id):
        query = 'select * from table ( QUEUE_PACKAGE.GET_QUEUES(:STATUS, :USER_LOGIN, :PLACE_ID) )'
        var = self.__cursor.execute(query, STATUS=select_status, USER_LOGIN=select_user_login, PLACE_ID=select_place_id)
        return var.fetchall()

    def get_queues_4(self, select_status, select_user_login, select_place_id, select_event_name):
        query = 'select * from table ( QUEUE_PACKAGE.GET_QUEUES(:STATUS, :USER_LOGIN, :PLACE_ID, :EVENT_NAME) )'
        var = self.__cursor.execute(query, STATUS=select_status, USER_LOGIN=select_user_login, PLACE_ID=select_place_id,
                                    EVENT_NAME=select_event_name)
        return var.fetchall()

    def get_queues_5(self, select_status, select_user_login, select_place_id, select_event_name,
                     select_date_creation_event):
        query = 'select * from table ( QUEUE_PACKAGE.GET_QUEUES(:STATUS, :USER_LOGIN, :PLACE_ID, :EVENT_NAME, :DATE_CREATION_EVENT) )'
        var = self.__cursor.execute(query, STATUS=select_status, USER_LOGIN=select_user_login, PLACE_ID=select_place_id,
                                    EVENT_NAME=select_event_name, DATE_CREATION_EVENT=select_date_creation_event)
        return var.fetchall()

    def get_queues_6(self, select_status, select_user_login, select_place_id, select_event_name,
                     select_date_creation_event, select_date_request_creation):
        query = 'select * from table ( QUEUE_PACKAGE.GET_QUEUES(:STATUS, :USER_LOGIN, :PLACE_ID, :EVENT_NAME, :DATE_CREATION_EVENT, :DATE_REQUEST_CREATION) )'
        var = self.__cursor.execute(query, STATUS=select_status, USER_LOGIN=select_user_login, PLACE_ID=select_place_id,
                                    EVENT_NAME=select_event_name, DATE_CREATION_EVENT=select_date_creation_event,
                                    DATE_REQUEST_CREATION=select_date_request_creation)
        return var.fetchall()

    def update_queue(self, OLD_STATUS, OLD_USER_LOGIN, OLD_PLACE_ID, OLD_EVENT_NAME, OLD_DATE_CREATION_EVENT,
                     OLD_DATE_REQUEST_CREATION, NEW_STATUS, NEW_USER_LOGIN, NEW_PLACE_ID, NEW_EVENT_NAME,
                     NEW_DATE_CREATION_EVENT, NEW_DATE_REQUEST_CREATION):
        result = self.__cursor.callfunc("QUEUE_PACKAGE.UPDATE_QUEUE", cx_Oracle.STRING,
                                        [OLD_STATUS, OLD_USER_LOGIN, OLD_PLACE_ID, OLD_EVENT_NAME,
                                         OLD_DATE_CREATION_EVENT,
                                         OLD_DATE_REQUEST_CREATION, NEW_STATUS, NEW_USER_LOGIN, NEW_PLACE_ID,
                                         NEW_EVENT_NAME, NEW_DATE_CREATION_EVENT, NEW_DATE_REQUEST_CREATION])
        return result

    def delete_queue(self, Q_STATUS, Q_USER_LOGIN, Q_PLACE_ID, Q_EVENT_NAME, Q_DATE_CREATION_EVENT,
                     Q_DATE_REQUEST_CREATION):
        result = self.__cursor.callfunc("QUEUE_PACKAGE.DELETE_QUEUE", cx_Oracle.STRING,
                                        [Q_STATUS, Q_USER_LOGIN, Q_PLACE_ID, Q_EVENT_NAME, Q_DATE_CREATION_EVENT,
                                         Q_DATE_REQUEST_CREATION])
        return result
