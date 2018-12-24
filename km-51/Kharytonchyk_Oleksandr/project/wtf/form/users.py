# from flask_wtf import FlaskForm
from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class UserRegistrationForm(Form):
    login = StringField("Login : ", [validators.DataRequired("Required"),
                                     validators.regexp('^[^";]{4,20}$', flags=0,
                                                       message='Please enter like this [^";]{4,20}')])
    password = StringField("Password : ", [validators.DataRequired("Required"),
                                           validators.regexp('^[^";]{4,20}$', flags=0,
                                                             message='Please enter like this [^";]{4,20}')])
    email = StringField("Email : ")
    submit = SubmitField("Register user")


class UserLoginForm(Form):
    login = StringField("Login : ", [validators.DataRequired("Required")])
    password = StringField("Password : ", [validators.DataRequired("Required")])
    submit = SubmitField("Log in")


class UserReadForm(Form):
    select_login = StringField("Login : ")
    submit = SubmitField("Select one or all users")


class UserUpdateForm(Form):
    old_login = StringField("Old login : ", [validators.DataRequired("Required"),
                                             validators.regexp('^[^";]{4,20}$', flags=0,
                                                               message='Please enter like this [^";]{4,20}')])
    new_login = StringField("New login : ", [validators.DataRequired("Required"),
                                             validators.regexp('^[^";]{4,20}$', flags=0,
                                                               message='Please enter like this [^";]{4,20}')])
    new_password = StringField("New password : ", [validators.DataRequired("Required"),
                                                   validators.regexp('^[^";]{4,20}$', flags=0,
                                                                     message='Please enter like this [^";]{4,20}')])
    new_email = StringField("New email : ")
    submit = SubmitField("Update user")


class UserDeleteForm(Form):
    delete_user_login = StringField("Delete user with login : ", [validators.DataRequired("Required")])
    submit = SubmitField("Delete user")
