from flask import Flask, render_template, request, make_response, session, redirect, url_for, flash

from DAO import *
from wtf.form.users import *
from wtf.form.places import *
from wtf.form.statuses import *
from wtf.form.events import *
from wtf.form.createdEvents import *
from wtf.form.queues import *
import datetime

app = Flask(__name__)
app.secret_key = 'development key'


@app.route('/')
def hello():
    return render_template('index.html')


@app.route('/auth')
def auth():
    return render_template('auth.html')


@app.route('/auth/logoff')
def logoff():
    # response = make_response("Unlogged in and session with cookie was deleted")
    response = make_response(redirect('/'))
    session.pop('login', None)
    response.set_cookie("loginCookie", '', expires=0)
    return response


@app.route('/auth/login', methods=["GET", "POST"])
def login():
    form = UserLoginForm()

    if request.method == "GET":
        # if not session.has_key('login'):
        if 'login' not in session:
            login = request.cookies.get("loginCookie")
            if login is None:
                # if login is valid .. select ...
                return render_template('authLogin.html', myform=form)
            else:
                session['login'] = login
                return "U R logged in by cookie"
        else:
            return "U R logged in by session"
    if request.method == "POST":
        # form = request.form
        if not form.validate():
            return render_template('authLogin.html', myform=form)
        else:
            user = User()
            user.__enter__()
            var = user.log_in(request.form['login'], request.form['password'])

            if var == '200 OK':
                session['login'] = request.form['login']

                response = make_response("logged in")
                expire_date = datetime.datetime.now()
                expire_date = expire_date + datetime.timedelta(days=90)
                response.set_cookie("loginCookie", value=request.form["login"], expires=expire_date)

                return response
            else:
                flash("Wrong credentials!")
                return redirect(url_for('login'))


@app.route('/auth/registration', methods=["GET", "POST"])
def registration():
    form = UserRegistrationForm()

    if request.method == "GET":
        # if not session.has_key('login'):
        if 'login' not in session:
            login = request.cookies.get("loginCookie")
            if login is None:
                # if login is valid .. select ...
                return render_template('authRegistration.html', regForm=form)
            else:
                session['login'] = login
                return "U R logged in by cookie"
        else:
            return "U R logged in by session"
    if request.method == "POST":
        # form = request.form
        if not form.validate():
            return render_template('authRegistration.html', regForm=form)
        else:
            user = User()
            user.__enter__()
            var = user.register(request.form['login'], request.form['password'], request.form['email'])

            # 1 create response
            if var == "200 OK":
                session['login'] = request.form['login']

                response = make_response("U R registered")
                expire_date = datetime.datetime.now()
                expire_date = expire_date + datetime.timedelta(days=90)
                response.set_cookie("loginCookie", value=request.form["login"], expires=expire_date)

                return response
            else:
                response = make_response(var)
                return response


@app.route('/users')
def users():
    return render_template('users.html')


@app.route('/usersRead', methods=["GET", "POST"])
def usersRead():
    form = UserReadForm()

    if request.method == "GET":
        return render_template('usersRead.html', userForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('usersRead.html', userForm=form)
        else:
            user = User()
            user.__enter__()
            if request.form['select_login'] == "":
                var = user.get_users()
            else:
                var = user.get_user(request.form['select_login'])
            return render_template('usersRead.html', selectedUsers=var, userForm=form)


@app.route('/usersUpdate', methods=["GET", "POST"])
def usersUpdate():
    form = UserUpdateForm()

    if request.method == "GET":
        return render_template('usersUpdate.html', userForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('usersUpdate.html', userForm=form)
        else:
            user = User()
            user.__enter__()
            var = user.update_user(request.form['old_login'], request.form['new_login'],
                                   request.form['new_password'], request.form['new_email'])
            return render_template('usersUpdate.html', updationStatus=var, userForm=form)


@app.route('/usersDelete', methods=["GET", "POST"])
def usersDelete():
    form = UserDeleteForm()

    if request.method == "GET":
        return render_template('usersDelete.html', userForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('usersDelete.html', userForm=form)
        else:
            user = User()
            user.__enter__()
            var = user.delete_user(request.form['delete_user_login'])
            return render_template('usersDelete.html', deletionStatus=var, userForm=form)


@app.route('/places')
def places():
    return render_template('places.html')


@app.route('/placesCreate', methods=["GET", "POST"])
def placesCreate():
    form = PlaceCreateForm()

    if request.method == "GET":
        return render_template('placesCreate.html', placeForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('placesCreate.html', placeForm=form)
        else:
            place = Place()
            place.__enter__()
            var = place.create_place(request.form['new_place_id'], request.form['new_address'],
                                     request.form['new_room_number'], request.form['new_schedule'])
            return render_template('placesCreate.html', creationStatus=var, placeForm=form)


@app.route('/placesRead', methods=["GET", "POST"])
def placesRead():
    form = PlaceReadForm()

    if request.method == "GET":
        return render_template('placesRead.html', placeForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('placesRead.html', placeForm=form)
        else:
            place = Place()
            place.__enter__()
            if request.form['select_place_id'] == "":
                var = place.get_places()
            else:
                var = place.get_place(request.form['select_place_id'])
            return render_template('placesRead.html', selectedPlaces=var, placeForm=form)


@app.route('/placesUpdate', methods=["GET", "POST"])
def placesUpdate():
    form = PlaceUpdateForm()

    if request.method == "GET":
        return render_template('placesUpdate.html', placeForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('placesUpdate.html', placeForm=form)
        else:
            place = Place()
            place.__enter__()
            var = place.update_place(request.form['old_place_id'], request.form['new_place_id'],
                                     request.form['new_address'], request.form['new_room_number'],
                                     request.form['new_schedule'])
            return render_template('placesUpdate.html', updationStatus=var, placeForm=form)


@app.route('/placesDelete', methods=["GET", "POST"])
def placesDelete():
    form = PlaceDeleteForm()

    if request.method == "GET":
        return render_template('placesDelete.html', placeForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('placesDelete.html', placeForm=form)
        else:
            place = Place()
            place.__enter__()
            var = place.delete_place(request.form['delete_place_id'])
            return render_template('placesDelete.html', deletionStatus=var, placeForm=form)


@app.route('/statuses')
def statuses():
    return render_template('statuses.html')


@app.route('/statusesCreate', methods=["GET", "POST"])
def statusesCreate():
    form = StatusCreateForm()

    if request.method == "GET":
        return render_template('statusesCreate.html', statusForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('statusesCreate.html', statusForm=form)
        else:
            status = Status()
            status.__enter__()
            var = status.create_status(request.form['new_status'])
            return render_template('statusesCreate.html', creationStatus=var, statusForm=form)


@app.route('/statusesRead', methods=["GET", "POST"])
def statusesRead():
    form = StatusReadForm()

    if request.method == "GET":
        return render_template('statusesRead.html', statusForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('statusesRead.html', statusForm=form)
        else:
            status = Status()
            status.__enter__()
            if request.form['select_status'] == "":
                var = status.get_statuses()
            else:
                var = status.get_status(request.form['select_status'])
            return render_template('statusesRead.html', selectedStatuses=var, statusForm=form)


@app.route('/statusesUpdate', methods=["GET", "POST"])
def statusesUpdate():
    form = StatusUpdateForm()

    if request.method == "GET":
        return render_template('statusesUpdate.html', statusForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('statusesUpdate.html', statusForm=form)
        else:
            status = Status()
            status.__enter__()
            var = status.update_status(request.form['old_status'], request.form['new_status'])
            return render_template('statusesUpdate.html', updationStatus=var, statusForm=form)


@app.route('/statusesDelete', methods=["GET", "POST"])
def statusesDelete():
    form = StatusDeleteForm()

    if request.method == "GET":
        return render_template('statusesDelete.html', statusForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('statusesDelete.html', statusForm=form)
        else:
            status = Status()
            status.__enter__()
            var = status.delete_status(request.form['delete_status'])
            return render_template('statusesDelete.html', deletionStatus=var, statusForm=form)


@app.route('/events')
def events():
    return render_template('events.html')


@app.route('/eventsCreate', methods=["GET", "POST"])
def eventsCreate():
    form = EventCreateForm()

    if request.method == "GET":
        return render_template('eventsCreate.html', eventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('eventsCreate.html', eventForm=form)
        else:
            event = Event()
            event.__enter__()
            var = event.create_event(request.form['new_event_name'])
            return render_template('eventsCreate.html', creationStatus=var, eventForm=form)


@app.route('/eventsRead', methods=["GET", "POST"])
def eventsRead():
    form = EventReadForm()

    if request.method == "GET":
        return render_template('eventsRead.html', eventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('eventsRead.html', eventForm=form)
        else:
            event = Event()
            event.__enter__()
            if request.form['select_event'] == "":
                var = event.get_events()
            else:
                var = event.get_event(request.form['select_event'])
            return render_template('eventsRead.html', selectedEvents=var, eventForm=form)


@app.route('/eventsUpdate', methods=["GET", "POST"])
def eventsUpdate():
    form = EventUpdateForm()

    if request.method == "GET":
        return render_template('eventsUpdate.html', eventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('eventsUpdate.html', eventForm=form)
        else:
            event = Event()
            event.__enter__()
            var = event.update_event(request.form['old_event_name'], request.form['new_event_name'])
            return render_template('eventsUpdate.html', updationStatus=var, eventForm=form)


@app.route('/eventsDelete', methods=["GET", "POST"])
def eventsDelete():
    form = EventDeleteForm()

    if request.method == "GET":
        return render_template('eventsDelete.html', eventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('eventsDelete.html', eventForm=form)
        else:
            event = Event()
            event.__enter__()
            var = event.delete_event(request.form['delete_event'])
            return render_template('eventsDelete.html', deletionStatus=var, eventForm=form)


@app.route('/createdEvents')
def createdEvents():
    return render_template('createdEvents.html')


@app.route('/createdEventsCreate', methods=["GET", "POST"])
def createdEventsCreate():
    form = CreatedEventCreateForm()

    if request.method == "GET":
        return render_template('createdEventsCreate.html', createdEventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('createdEventsCreate.html', createdEventForm=form)
        else:
            createdEvent = CreatedEvent()
            createdEvent.__enter__()
            var = createdEvent.create_created_event(request.form['new_place_id'], request.form['new_event_name'],
                                                    request.form['new_date_creation_event'])
            return render_template('createdEventsCreate.html', creationStatus=var, createdEventForm=form)


@app.route('/createdEventsRead', methods=["GET", "POST"])
def createdEventsRead():
    form = CreatedEventReadForm()

    if request.method == "GET":
        return render_template('createdEventsRead.html', createdEventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('createdEventsRead.html', createdEventForm=form)
        else:
            createdEvent = CreatedEvent()
            createdEvent.__enter__()
            if request.form['select_place_id'] == "":
                var = createdEvent.get_created_events_0()
            else:
                if request.form['select_event_name'] == "":
                    var = createdEvent.get_created_events_1(request.form['select_place_id'])
                else:
                    if request.form['select_date_creation_event'] == "":
                        var = createdEvent.get_created_events_2(request.form['select_place_id'],
                                                                request.form['select_event_name'])
                    else:
                        var = createdEvent.get_created_events_3(request.form['select_place_id'],
                                                                request.form['select_event_name'],
                                                                request.form['select_date_creation_event'])

            return render_template('createdEventsRead.html', selectedCreatedEvents=var, createdEventForm=form)


@app.route('/createdEventsUpdate', methods=["GET", "POST"])
def createdEventsUpdate():
    form = CreatedEventUpdateForm()

    if request.method == "GET":
        return render_template('createdEventsUpdate.html', createdEventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('createdEventsUpdate.html', createdEventForm=form)
        else:
            createdEvent = CreatedEvent()
            createdEvent.__enter__()
            var = createdEvent.update_created_event(request.form['old_place_id'], request.form['old_event_name'],
                                                    request.form['old_date_creation_event'],
                                                    request.form['new_place_id'],
                                                    request.form['new_event_name'],
                                                    request.form['new_date_creation_event'])
            return render_template('createdEventsUpdate.html', updationStatus=var, createdEventForm=form)


@app.route('/createdEventsDelete', methods=["GET", "POST"])
def createdEventsDelete():
    form = CreatedEventDeleteForm()

    if request.method == "GET":
        return render_template('createdEventsDelete.html', createdEventForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('createdEventsDelete.html', createdEventForm=form)
        else:
            createdEvent = CreatedEvent()
            createdEvent.__enter__()
            var = createdEvent.delete_created_event(request.form['delete_place_id'], request.form['delete_event_name'],
                                                    request.form['delete_date_creation_event'])
            return render_template('createdEventsDelete.html', deletionStatus=var, createdEventForm=form)


@app.route('/queues')
def queues():
    return render_template('queues.html')


@app.route('/queuesCreate', methods=["GET", "POST"])
def queuesCreate():
    form = QueueCreateForm()

    if request.method == "GET":
        return render_template('queuesCreate.html', queueForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('queuesCreate.html', queueForm=form)
        else:
            queue = Queue()
            queue.__enter__()
            var = queue.create_queue(request.form['new_status'], request.form['new_user_login'],
                                     request.form['new_place_id'], request.form['new_event_name'],
                                     request.form['new_date_creation_event'],
                                     request.form['new_date_request_creation'])
            return render_template('queuesCreate.html', creationStatus=var, queueForm=form)


@app.route('/queuesRead', methods=["GET", "POST"])
def queuesRead():
    form = QueueReadForm()

    if request.method == "GET":
        return render_template('queuesRead.html', queueForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('queuesRead.html', queueForm=form)
        else:
            queue = Queue()
            queue.__enter__()
            if request.form['select_status'] == "":
                var = queue.get_queues_0()
            else:
                if request.form['select_user_login'] == "":
                    var = queue.get_queues_1(request.form['select_status'])
                else:
                    if request.form['select_place_id'] == "":
                        var = queue.get_queues_2(request.form['select_status'],
                                                 request.form['select_user_login'])
                    else:
                        if request.form['select_event_name'] == "":
                            var = queue.get_queues_3(request.form['select_status'],
                                                     request.form['select_user_login'],
                                                     request.form['select_place_id'])
                        else:
                            if request.form['select_date_creation_event'] == "":
                                var = queue.get_queues_4(request.form['select_status'],
                                                         request.form['select_user_login'],
                                                         request.form['select_place_id'],
                                                         request.form['select_event_name'])
                            else:
                                if request.form['select_date_request_creation'] == "":
                                    var = queue.get_queues_5(request.form['select_status'],
                                                             request.form['select_user_login'],
                                                             request.form['select_place_id'],
                                                             request.form['select_event_name'],
                                                             request.form['select_date_creation_event'])
                                else:
                                    var = queue.get_queues_6(request.form['select_status'],
                                                             request.form['select_user_login'],
                                                             request.form['select_place_id'],
                                                             request.form['select_event_name'],
                                                             request.form['select_date_creation_event'],
                                                             request.form['select_date_request_creation'])
            return render_template('queuesRead.html', selectedQueues=var, queueForm=form)


@app.route('/queuesUpdate', methods=["GET", "POST"])
def queuesUpdate():
    form = QueueUpdateForm()

    if request.method == "GET":
        return render_template('queuesUpdate.html', queueForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('queuesUpdate.html', queueForm=form)
        else:
            queue = Queue()
            queue.__enter__()
            var = queue.update_queue(request.form['old_status'], request.form['old_user_login'],
                                     request.form['old_place_id'], request.form['old_event_name'],
                                     request.form['old_date_creation_event'],
                                     request.form['old_date_request_creation'],
                                     request.form['new_status'], request.form['new_user_login'],
                                     request.form['new_place_id'], request.form['new_event_name'],
                                     request.form['new_date_creation_event'],
                                     request.form['new_date_request_creation'])
            return render_template('queuesUpdate.html', updationStatus=var, queueForm=form)


@app.route('/queuesDelete', methods=["GET", "POST"])
def queuesDelete():
    form = QueueDeleteForm()

    if request.method == "GET":
        return render_template('queuesDelete.html', queueForm=form)
    if request.method == "POST":
        if not form.validate():
            return render_template('queuesDelete.html', queueForm=form)
        else:
            queue = Queue()
            queue.__enter__()
            var = queue.delete_queue(request.form['delete_status'], request.form['delete_user_login'],
                                     request.form['delete_place_id'], request.form['delete_event_name'],
                                     request.form['delete_date_creation_event'],
                                     request.form['delete_date_request_creation'])
            return render_template('queuesDelete.html', deletionStatus=var, queueForm=form)


app.run(debug=True)
