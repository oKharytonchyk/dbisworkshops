from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class PlaceCreateForm(Form):
    new_place_id = StringField("New place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_address = StringField("New address : ",
                              [validators.DataRequired("Required"),
                               validators.regexp('^[^";]{4,60}$', flags=0,
                                                 message='Please enter like this [^";]{4,60}')])
    new_room_number = StringField("New room number : ",
                                  [validators.DataRequired("Required"),
                                   validators.regexp('^\d{3,5}$', flags=0,
                                                     message='Please enter like this d{3,5}')])
    # message=u'Please enter a number from 100 to 99999')])
    new_schedule = StringField("New schedule : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^[0-2][0-9]:[0-2][0-9] [0-2][0-9]:[0-2][0-9]$',
                                                  flags=0,
                                                  message='Please enter like this [0-2][0-9]:[0-2][0-9] [0-2][0-9]:[0-2][0-9]')])
    submit = SubmitField("Create place")


class PlaceReadForm(Form):
    select_place_id = StringField("Select place with id : ",
                                  [validators.regexp('^\d{0,10}$', flags=0,
                                                     message='Please enter like this d{0,10}')])
    submit = SubmitField("Select one or all places")


class PlaceUpdateForm(Form):
    old_place_id = StringField("Old place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_place_id = StringField("New place id : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^\d{1,10}$', flags=0,
                                                  message='Please enter like this d{1,10}')])
    new_address = StringField("New address : ",
                              [validators.DataRequired("Required"),
                               validators.regexp('^[^";]{4,60}$', flags=0,
                                                 message='Please enter like this [^";]{4,60}')])
    new_room_number = StringField("New room number : ",
                                  [validators.DataRequired("Required"),
                                   validators.regexp('^\d{3,5}$', flags=0,
                                                     message='Please enter like this d{3,5}')])
    # message=u'Please enter a number from 100 to 99999')])
    new_schedule = StringField("New schedule : ",
                               [validators.DataRequired("Required"),
                                validators.regexp('^[0-2][0-9]:[0-2][0-9] [0-2][0-9]:[0-2][0-9]$',
                                                  flags=0,
                                                  message='Please enter like this [0-2][0-9]:[0-2][0-9] [0-2][0-9]:[0-2][0-9]')])
    submit = SubmitField("Update place")


class PlaceDeleteForm(Form):
    delete_place_id = StringField("Delete place with id : ", [validators.DataRequired("Required")])

    submit = SubmitField("Delete place")
