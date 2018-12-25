from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class EventCreateForm(Form):
    new_event_name = StringField("New event name: ", [validators.DataRequired("Required"),
                                                      validators.regexp('^[^";]{4,50}$', flags=0,
                                                                        message='Please enter like this [^";]{4,50}')])
    submit = SubmitField("Create event")


class EventReadForm(Form):
    select_event = StringField("Select event : ")
    submit = SubmitField("Select one or all events")


class EventUpdateForm(Form):
    old_event_name = StringField("Old event name : ", [validators.DataRequired("Required"),
                                                       validators.regexp('^[^";]{4,50}$', flags=0,
                                                                         message='Please enter like this [^";]{4,50}')])
    new_event_name = StringField("New event name : ", [validators.DataRequired("Required"),
                                                       validators.regexp('^[^";]{1,20}$', flags=0,
                                                                         message='Please enter like this [^";]{4,50}')])
    submit = SubmitField("Update event")


class EventDeleteForm(Form):
    delete_event = StringField("Delete event : ", [validators.DataRequired("Required")])

    submit = SubmitField("Delete status")
