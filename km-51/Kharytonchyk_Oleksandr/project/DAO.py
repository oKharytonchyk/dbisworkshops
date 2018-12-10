import cx_Oracle as cx_Oracle


class Place:
    def __enter__(self):
        self.__db = cx_Oracle.connect("ledoff", "Password1", "orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def get_place(self, p_id):
        query = 'select * from table ( PLACE_PACKAGE.GET_PLACE(:PLACE_ID) )'
        var = self.__cursor.execute(query, PLACE_ID=p_id)
        return var.fetchall()

    def get_places(self):
        query = 'select * from table (PLACE_PACKAGE.GET_PLACES())'
        var = self.__cursor.execute(query)
        return var.fetchall()


class User:
    def __enter__(self):
        self.__db = cx_Oracle.connect('ledoff', 'Password1', "localhost:1522/orcl")
        self.__cursor = self.__db.cursor()
        return self

    def __exit__(self, exc_type, exc_val, exc_tb):
        self.__cursor.close()
        self.__db.close()

    def sign_in(self, login, password):
        result = self.__cursor.callfunc("USER_PACKAGE.LOG_IN", [login, password])
        return result

    def register(self, login, password, email):
        result = self.__cursor.callfunc("USER_PACKAGE.LOG_IN", [login, password, email])
        return result


# temp = User()
# temp.__enter__()
# print(temp.sign_in("ledoff.sky", "qwerty123456"))
