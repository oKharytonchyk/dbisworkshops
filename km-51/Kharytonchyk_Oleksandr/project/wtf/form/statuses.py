from flask_wtf import Form
from wtforms import StringField, SubmitField, validators


class StatusCreateForm(Form):
    new_status = StringField("New status : ", [validators.DataRequired("Required"),
                                               validators.regexp('^[^";]{1,20}$', flags=0,
                                                                 message='Please enter like this [^";]{1,20}')])
    submit = SubmitField("Create status")


class StatusReadForm(Form):
    select_status = StringField("Select status : ")
    submit = SubmitField("Select one or all statuses")


class StatusUpdateForm(Form):
    old_status = StringField("Old status : ", [validators.DataRequired("Required"),
                                               validators.regexp('^[^";]{1,20}$', flags=0,
                                                                 message='Please enter like this [^";]{1,20}')])
    new_status = StringField("New status : ", [validators.DataRequired("Required"),
                                               validators.regexp('^[^";]{1,20}$', flags=0,
                                                                 message='Please enter like this [^";]{1,20}')])
    submit = SubmitField("Update status")


class StatusDeleteForm(Form):
    delete_status = StringField("Delete status : ", [validators.DataRequired("Required")])

    submit = SubmitField("Delete status")
