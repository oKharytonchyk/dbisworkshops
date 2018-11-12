from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)


user_dictionary = {
    "user_login": "ledoff.sky",
    "user_password": "qwerty123456",
    "user_email": "ledoff.sky@ukr.net"
}

notification_dictionary = {
    "notification_status": "You are 10th"
}

event_dictionary = {
    "event_name": "Concert"
}

place_dictionary = {
    "place_id": "1",
    "address": "Bykova 11",
    "room_number": "101",
    "schedule": "10:00 19:00"
}

created_event_dictionary = {
    "place_id": "1",
    "event_name": "Concert",
    "date_creation_event": "2018-12-12"
}

queue_dictionary = {
    "notification_status": "You are next",
    "user_login": "Slidan",
    "place_id": "1",
    "event_name": "Concert",
    "date_creation_event": "2018-12-12",
    "date_request_creation": "2019-01-04",
    "wishlist_status": "approved"
}

available_dictionary = dict.fromkeys(['user', 'notification', 'event', 'place', 'created_event', 'queue'], "dict_name")


@app.route('/api/<action>', methods=['GET'])
def apiGet(action):
    if action == "user":
        return render_template("user.html", user=user_dictionary)
    elif action == "notification":
        return render_template("notification.html", notification=notification_dictionary)
    elif action == "event":
        return render_template("event.html", event=event_dictionary)
    elif action == "place":
        return render_template("place.html", place=place_dictionary)
    elif action == "created_event":
        return render_template("created_event.html", created_event=created_event_dictionary)
    elif action == "queue":
        return render_template("queue.html", queue=queue_dictionary)
    elif action == "all":
        return render_template("all.html", user=user_dictionary, notification=notification_dictionary,
                               event=event_dictionary, place=place_dictionary, created_event=created_event_dictionary,
                               queue=queue_dictionary)
    else:
        return render_template("404.html", action_value=action, available=available_dictionary)


@app.route('/api', methods=['POST'])
def apiPost():
    if request.form["action"] == "user_update":
        user_dictionary["user_login"] = request.form["user_login"]
        user_dictionary["user_password"] = request.form["user_password"]
        user_dictionary["user_email"] = request.form["user_email"]

        return redirect(url_for('apiGet', action="all"))

    elif request.form["action"] == "notification_update":
        notification_dictionary["notification_status"] = request.form["notification_status"]

        return redirect(url_for('apiGet', action="all"))

    elif request.form["action"] == "event_update":
        event_dictionary["event_name"] = request.form["event_name"]

        return redirect(url_for('apiGet', action="all"))

    elif request.form["action"] == "place_update":
        place_dictionary["place_id"] = request.form["place_id"]
        place_dictionary["address"] = request.form["address"]
        place_dictionary["room_number"] = request.form["room_number"]
        place_dictionary["schedule"] = request.form["schedule"]

        return redirect(url_for('apiGet', action="all"))

    elif request.form["action"] == "created_event_update":
        created_event_dictionary["place_id"] = request.form["place_id"]
        created_event_dictionary["event_name"] = request.form["event_name"]
        created_event_dictionary["date_creation_event"] = request.form["date_creation_event"]

        return redirect(url_for('apiGet', action="all"))

    elif request.form["action"] == "queue_update":
        queue_dictionary["notification_status"] = request.form["notification_status"]
        queue_dictionary["user_login"] = request.form["user_login"]
        queue_dictionary["place_id"] = request.form["place_id"]
        queue_dictionary["event_name"] = request.form["event_name"]
        queue_dictionary["date_creation_event"] = request.form["date_creation_event"]
        queue_dictionary["date_request_creation"] = request.form["date_request_creation"]
        queue_dictionary["wishlist_status"] = request.form["wishlist_status"]

        return redirect(url_for('apiGet', action="all"))


if __name__ == '__main__':
    app.run(debug=True, port=8085)
