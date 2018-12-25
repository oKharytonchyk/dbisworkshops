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


class Event:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1521/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def create_event(self, NEW_E_NAME):
        result = self.__cursor.callfunc("EVENT_PACKAGE.CREATE_EVENT", cx_Oracle.STRING, [NEW_E_NAME])
        return result

    def get_event(self, E_NAME):
        query = 'select * from table ( EVENT_PACKAGE.GET_EVENTS(:EVENT_NAME) )'
        var = self.__cursor.execute(query, EVENT_NAME=E_NAME)
        return var.fetchall()

    def get_events(self):
        query = 'select * from table (EVENT_PACKAGE.GET_EVENTS())'
        var = self.__cursor.execute(query)
        return var.fetchall()

    def update_event(self, OLD_E_NAME, NEW_E_NAME):
        result = self.__cursor.callfunc("EVENT_PACKAGE.UPDATE_EVENT", cx_Oracle.STRING, [OLD_E_NAME, NEW_E_NAME])
        return result

    def delete_event(self, E_NAME):
        result = self.__cursor.callfunc("EVENT_PACKAGE.DELETE_EVENT", cx_Oracle.STRING, [E_NAME])
        return result


class Status:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1521/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def create_status(self, NEW_STATUS):
        result = self.__cursor.callfunc("STATUS_PACKAGE.CREATE_STATUS", cx_Oracle.STRING, [NEW_STATUS])
        return result

    def get_status(self, S_STATUS):
        query = 'select * from table ( STATUS_PACKAGE.GET_STATUSES(:STATUS) )'
        var = self.__cursor.execute(query, STATUS=S_STATUS)
        return var.fetchall()

    def get_statuses(self):
        query = 'select * from table (STATUS_PACKAGE.GET_STATUSES())'
        var = self.__cursor.execute(query)
        return var.fetchall()

    def update_status(self, OLD_STATUS, NEW_STATUS):
        result = self.__cursor.callfunc("STATUS_PACKAGE.UPDATE_STATUS", cx_Oracle.STRING, [OLD_STATUS, NEW_STATUS])
        return result

    def delete_status(self, S_STATUS):
        result = self.__cursor.callfunc("STATUS_PACKAGE.DELETE_STATUS", cx_Oracle.STRING, [S_STATUS])
        return result


class CreatedEvent:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1521/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def create_created_event(self, NEW_PLACE_ID, NEW_EVENT_NAME, NEW_DATE_CREATION_EVENT):
        result = self.__cursor.callfunc("CREATED_EVENT_PACKAGE.CREATE_CREATED_EVENT", cx_Oracle.STRING,
                                        [NEW_PLACE_ID, NEW_EVENT_NAME, NEW_DATE_CREATION_EVENT])
        return result

    def get_created_events_0(self):
        query = 'select * from table (CREATED_EVENT_PACKAGE.GET_CREATED_EVENTS())'
        var = self.__cursor.execute(query)
        return var.fetchall()

    def get_created_events_1(self, select_status):
        query = 'select * from table ( CREATED_EVENT_PACKAGE.GET_CREATED_EVENTS(:STATUS) )'
        var = self.__cursor.execute(query, STATUS=select_status)
        return var.fetchall()

    def get_created_events_2(self, select_status, select_user_login):
        query = 'select * from table ( CREATED_EVENT_PACKAGE.GET_CREATED_EVENTS(:STATUS, :USER_LOGIN) )'
        var = self.__cursor.execute(query, STATUS=select_status, USER_LOGIN=select_user_login)
        return var.fetchall()

    def get_created_events_3(self, select_place_id, select_event_name, select_date_creation_event):
        query = 'select * from table ( CREATED_EVENT_PACKAGE.GET_CREATED_EVENTS(:PLACE_ID, :EVENT_NAME, :DATE_CREATION_EVENT) )'
        var = self.__cursor.execute(query, PLACE_ID=select_place_id, EVENT_NAME=select_event_name,
                                    DATE_CREATION_EVENT=select_date_creation_event)
        return var.fetchall()

    def update_created_event(self, OLD_PLACE_ID, OLD_EVENT_NAME, OLD_DATE_CREATION_EVENT, NEW_PLACE_ID, NEW_EVENT_NAME,
                             NEW_DATE_CREATION_EVENT):
        result = self.__cursor.callfunc("CREATED_EVENT_PACKAGE.UPDATE_CREATED_EVENT", cx_Oracle.STRING,
                                        [OLD_PLACE_ID, OLD_EVENT_NAME, OLD_DATE_CREATION_EVENT, NEW_PLACE_ID,
                                         NEW_EVENT_NAME, NEW_DATE_CREATION_EVENT])
        return result

    def delete_created_event(self, CE_PLACE_ID, CE_EVENT_NAME, CE_DATE_CREATION_EVENT):
        result = self.__cursor.callfunc("CREATED_EVENT_PACKAGE.DELETE_CREATED_EVENT", cx_Oracle.STRING,
                                        [CE_PLACE_ID, CE_EVENT_NAME, CE_DATE_CREATION_EVENT])
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
