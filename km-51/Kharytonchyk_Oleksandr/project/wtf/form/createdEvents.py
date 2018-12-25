from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class CreatedEventCreateForm(Form):
    new_place_id = StringField("New created event with place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_event_name = StringField("New created event with event name : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,50}$', flags=0,
                                                    message='Please enter like this [^";]{4,50}')])
    new_date_creation_event = StringField("New created event with date creation event : ",
                                          [validators.DataRequired("Required"),
                                           validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                             flags=0,
                                                             message='Please enter like this \d{4}-\d{2}-\d{2}')])
    submit = SubmitField("Create created event")


class CreatedEventReadForm(Form):
    select_place_id = StringField("Select created event with place id : ")
    select_event_name = StringField("Select created event with event name : ")
    select_date_creation_event = StringField("Select created event with date creation event : ")
    submit = SubmitField("Select one or all created events")


class CreatedEventUpdateForm(Form):
    old_place_id = StringField("Old created event with place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    old_event_name = StringField("Old created event with event name : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,50}$', flags=0,
                                                    message='Please enter like this [^";]{4,50}')])
    old_date_creation_event = StringField("Old created event with date creation event : ",
                                          [validators.DataRequired("Required"),
                                           validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                             flags=0,
                                                             message='Please enter like this \d{4}-\d{2}-\d{2}')])
    new_place_id = StringField("New created event with place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_event_name = StringField("New created event with event name : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,50}$', flags=0,
                                                    message='Please enter like this [^";]{4,50}')])
    new_date_creation_event = StringField("New created event with date creation event : ",
                                          [validators.DataRequired("Required"),
                                           validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                             flags=0,
                                                             message='Please enter like this \d{4}-\d{2}-\d{2}')])
    submit = SubmitField("Update created event")


class CreatedEventDeleteForm(Form):
    delete_place_id = StringField("Delete created event with place id : ", [validators.DataRequired("Required")])
    delete_event_name = StringField("Delete created event with event name : ", [validators.DataRequired("Required")])
    delete_date_creation_event = StringField("Delete created event with date creation event : ",
                                             [validators.DataRequired("Required")])

    submit = SubmitField("Delete created event")
