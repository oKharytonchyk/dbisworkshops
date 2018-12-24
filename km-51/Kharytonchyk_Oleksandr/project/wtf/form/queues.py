# from flask_wtf import FlaskForm
from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class QueueCreateForm(Form):
    new_status = StringField("New queue with status : ",
                             [validators.DataRequired("Required"),
                              validators.regexp('^[^";]{4,20}$', flags=0,
                                                message='Please enter like this [^";]{4,20}')])
    new_user_login = StringField("New queue with user login : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,20}$', flags=0,
                                                    message='Please enter like this [^";]{4,20}')])
    new_place_id = StringField("New queue with place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_event_name = StringField("New queue with event name : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,50}$', flags=0,
                                                    message='Please enter like this [^";]{4,50}')])
    new_date_creation_event = StringField("New queue with date creation event : ",
                                          [validators.DataRequired("Required"),
                                           validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                             flags=0,
                                                             message='Please enter like this \d{4}-\d{2}-\d{2}')])
    new_date_request_creation = StringField("New queue with date request creation : ",
                                            [validators.DataRequired("Required"),
                                             validators.regexp('^\d{4}-\d{2}-\d{2}$', flags=0,
                                                               message='Please enter like this \d{4}-\d{2}-\d{2}')])
    submit = SubmitField("Create queue")


class QueueReadForm(Form):
    select_status = StringField("New queue with status : ")
    select_user_login = StringField("New queue with user login : ")
    select_place_id = StringField("New queue with place id : ")
    select_event_name = StringField("New queue with event name : ")
    select_date_creation_event = StringField("New queue with date creation event : ")
    select_date_request_creation = StringField("New queue with date request creation : ")
    submit = SubmitField("Select one or all queues")


class QueueUpdateForm(Form):
    old_status = StringField("Old queue with status : ",
                             [validators.DataRequired("Required"),
                              validators.regexp('^[^";]{4,20}$', flags=0,
                                                message='Please enter like this [^";]{4,20}')])
    old_user_login = StringField("Old queue with user login : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,20}$', flags=0,
                                                    message='Please enter like this [^";]{4,20}')])
    old_place_id = StringField("Old queue with place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    old_event_name = StringField("Old queue with event name : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,50}$', flags=0,
                                                    message='Please enter like this [^";]{4,50}')])
    old_date_creation_event = StringField("Old queue with date creation event : ",
                                          [validators.DataRequired("Required"),
                                           validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                             flags=0,
                                                             message='Please enter like this \d{4}-\d{2}-\d{2}')])
    old_date_request_creation = StringField("Old queue with date request creation : ",
                                            [validators.DataRequired("Required"),
                                             validators.regexp('^\d{4}-\d{2}-\d{2}$', flags=0,
                                                               message='Please enter like this \d{4}-\d{2}-\d{2}')])
    new_status = StringField("New queue with status : ",
                             [validators.DataRequired("Required"),
                              validators.regexp('^[^";]{4,20}$', flags=0,
                                                message='Please enter like this [^";]{4,20}')])
    new_user_login = StringField("New queue with user login : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,20}$', flags=0,
                                                    message='Please enter like this [^";]{4,20}')])
    new_place_id = StringField("New queue with place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_event_name = StringField("New queue with event name : ",
                                 [validators.DataRequired("Required"),
                                  validators.regexp('^[^";]{4,50}$', flags=0,
                                                    message='Please enter like this [^";]{4,50}')])
    new_date_creation_event = StringField("New queue with date creation event : ",
                                          [validators.DataRequired("Required"),
                                           validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                             flags=0,
                                                             message='Please enter like this \d{4}-\d{2}-\d{2}')])
    new_date_request_creation = StringField("New queue with date request creation : ",
                                            [validators.DataRequired("Required"),
                                             validators.regexp('^\d{4}-\d{2}-\d{2}$', flags=0,
                                                               message='Please enter like this \d{4}-\d{2}-\d{2}')])
    submit = SubmitField("Update queue")


class QueueDeleteForm(Form):
    delete_status = StringField("Delete queue with status : ",
                                [validators.DataRequired("Required"),
                                 validators.regexp('^[^";]{4,20}$', flags=0,
                                                   message='Please enter like this [^";]{4,20}')])
    delete_user_login = StringField("Delete queue with user login : ",
                                    [validators.DataRequired("Required"),
                                     validators.regexp('^[^";]{4,20}$', flags=0,
                                                       message='Please enter like this [^";]{4,20}')])
    delete_place_id = StringField("Delete queue with place id : ",
                                  [validators.DataRequired("Required"),
                                   validators.regexp('^\d{1,10}$', flags=0,
                                                     message='Please enter like this d{1,10}')])
    delete_event_name = StringField("Delete queue with event name : ",
                                    [validators.DataRequired("Required"),
                                     validators.regexp('^[^";]{4,50}$', flags=0,
                                                       message='Please enter like this [^";]{4,50}')])
    delete_date_creation_event = StringField("Delete queue with date creation event : ",
                                             [validators.DataRequired("Required"),
                                              validators.regexp('^\d{4}-\d{2}-\d{2}$',
                                                                flags=0,
                                                                message='Please enter like this \d{4}-\d{2}-\d{2}')])
    delete_date_request_creation = StringField("Delete queue with date request creation : ",
                                               [validators.DataRequired("Required"),
                                                validators.regexp('^\d{4}-\d{2}-\d{2}$', flags=0,
                                                                  message='Please enter like this \d{4}-\d{2}-\d{2}')])
    submit = SubmitField("Delete queue")
