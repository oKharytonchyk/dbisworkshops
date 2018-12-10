from flask import Flask, render_template, request, make_response, session, redirect, url_for

from DAO import *
from wtf.form.login import LoginForm
from wtf.form.registration import RegistrationForm
import datetime

app = Flask(__name__)
app.secret_key = 'development key'


@app.route('/')
def hello():
    return render_template('Hello.html')


@app.route('/login', methods=["GET", "POST"])
def login():
    form = LoginForm()

    if request.method == "GET":
        # if not session.has_key('login'):
        if 'login' not in session:
            login = request.cookies.get("loginCookie")
            if login is None:
                # if login is valid .. select ...
                return render_template('login.html', myform=form)
            else:
                session['login'] = login
                return "U R logged in by cookie"
        else:
            return "U R logged in by session"
    if request.method == "POST":
        # form = request.form
        if not form.validate():
            return render_template('login.html', myform=form)
        else:
            user = User()
            user.__enter__()
            var = user.sign_in(request.form['login'], request.form['password'])

            if var == 1:
                # 1 create response
                session['login'] = request.form['login']

                response = make_response("logged in")
                expire_date = datetime.datetime.now()
                expire_date = expire_date + datetime.timedelta(days=90)
                response.set_cookie("loginCookie", value=request.form["login"], expires=expire_date)

                return response
            else:
                return redirect(url_for('registration'))


@app.route('/logoff')
def logoff():
    # response = make_response("Unlogged in and session with cookie was deleted")
    # response = make_response(render_template('Hello.html'))
    response = make_response(redirect('/'))
    session.pop('login', None)
    response.set_cookie("loginCookie", '', expires=0)
    return response


@app.route('/registration', methods=["GET", "POST"])
def registration():
    form = RegistrationForm()

    if request.method == "GET":
        # if not session.has_key('login'):
        if 'login' not in session:
            login = request.cookies.get("loginCookie")
            if login is None:
                # if login is valid .. select ...
                return render_template('registration.html', regForm=form)
            else:
                return "U R logged in by cookie"
        else:
            return "U R logged in by session"
    if request.method == "POST":
        # form = request.form
        if not form.validate():
            return render_template('registration.html', regForm=form)
        else:
            # 1 create response
            session['login'] = request.form['login']

            response = make_response("U R registered")
            expire_date = datetime.datetime.now()
            expire_date = expire_date + datetime.timedelta(days=90)
            response.set_cookie("loginCookie", value=request.form["login"], expires=expire_date)

            return response


app.run(debug=True)
