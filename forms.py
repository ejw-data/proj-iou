from flask_wtf import FlaskForm
from wtforms import (
    StringField,
    SubmitField,
    PasswordField,
    ValidationError,
    BooleanField,
    SelectField,
)
from wtforms.validators import DataRequired, InputRequired, EqualTo, Length


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


