# from flask_wtf import FlaskForm
from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class RegistrationForm(Form):
    """
    <fieldset>
        Label1: <input type="text" name="email"/>
        Label1: <input type="text" name="password"/>

        <input type="submit" name="Sign in"/>
    </fieldset>
    """

    # email = "<input ...>"
    # login = StringField("Login : ", [validators.DataRequired("Required"), validators.Email("Error in email")])
    login = StringField("Login : ", [validators.DataRequired("Required"),
                                     validators.Length(1, 20, "Login should be from 1 to 20 symbols")])
    password = StringField("Password : ", [validators.DataRequired("Required"),
                                           validators.Length(1, 20, "Password should be from 1 to 20 symbols")])
    email = StringField("Email : ", [validators.DataRequired("Required"), validators.Email("Error in email"),
                                     validators.Length(1, 40, "Email should be from 1 to 40 symbols")])

    submit = SubmitField("Sign in")
