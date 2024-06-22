from flask_wtf import FlaskForm
from wtforms import (
    StringField,
    SubmitField,
    PasswordField,
    ValidationError,
    BooleanField,
    SelectField,
    FloatField
)
from wtforms.validators import DataRequired, InputRequired, EqualTo, Length

from models import (
    Users,
    # Records
)


# Create Form Class
class LoginForm(FlaskForm):
    """
    Login Form fields
    """

    username = StringField("Input your Username", validators=[DataRequired()])
    password = PasswordField("Input your Password", validators=[DataRequired()])
    submit = SubmitField("Submit")


class RegisterForm(FlaskForm):
    """
    Registration Form fields
    """

    username = StringField("Input your Username", validators=[DataRequired()])
    password = PasswordField("Input your Password", validators=[DataRequired(), EqualTo('password2', message="Passwords must match")])
    password2 = PasswordField("Retype your Password", validators=[DataRequired()])
    submit = SubmitField("Submit")


class CreateUserForm(FlaskForm):
    """
    User Form fields
    """

    first_name = StringField("Input your First Name", validators=[DataRequired()])
    last_name = StringField("Input your Last Name", validators=[DataRequired()])
    email = StringField("Input your Email", validators=[DataRequired()])
    submit = SubmitField("Submit")


def userform_instance(form_request=None):
    """
    Create to dynamically populate title, role inputs to selector elements
    """
    user_form = CreateUserForm(form_request)

    return user_form


class CreateRecordForm(FlaskForm):
    """
    Add transaction fields
    """

    owee_name = SelectField("I owe:", validators=[DataRequired()])
    business_name = StringField("Business Name", validators=[DataRequired()])
    amount = FloatField("Amount:")
    description = StringField("Description", validators=[DataRequired()])
    notes = StringField("Notes", validators=[DataRequired()])
    submit = SubmitField("Submit")


def recordform_instance(form_request=None):
    """
    Create to dynamically populate user inputs to selector elements
    """
    record_form = CreateRecordForm(form_request)

    name_results = (
        Users.query.with_entities(
            Users.user_id, Users.first_name, Users.last_name, Users.email
        )
        .distinct(Users.first_name, Users.last_name)
        .order_by(Users.last_name.asc())
        .all()
    )

    names_list = [(i.user_id, f"{i.first_name} {i.last_name} - ({i.email})") for i in name_results]

    record_form.owee_name.choices = names_list
    return record_form
