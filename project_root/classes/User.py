class User:
    """
    A class to represent a user in the medicine project.

    Attributes:
        user_id (int): A unique identifier for the user.
        name (str): The name of the user.
        surname (str): The surname of the user.
        login_mail (str): The email address the user uses to log in.
        password (str): The password the user uses to log in.
        city (str): The city where the user lives.
        age (int): The age of the User
        gender (

    Methods:
        sign_up(): This method creates a new user profile.
        log_in(): This method allows the user to log in.
        get_doctors(): This method retrieves a list of doctors in the user's city.
    """

    def __init__(self, user_id, name, surname, login_mail, password, city):
        """
        Constructs a new User object.

        Args:
            user_id (int): A unique identifier for the user.
            name (str): The name of the user.
            surname (str): The surname of the user.
            login_mail (str): The email address the user uses to log in.
            password (str): The password the user uses to log in.
            city (str): The city where the user lives.
        """
        self.user_id = user_id
        self.name = name
        self.surname = surname
        self.login_mail = login_mail
        self.password = password
        self.city = city

    def sign_up(self):
        """
        Creates a new user profile.

        This method will save the user's information to the database.
        """
        # Save the user to the database
        pass

    def log_in(self):
        """
        Allows the user to log in.

        This method will authenticate the user based on their login email and password.

        Returns:
            bool: True if the user was successfully authenticated, False otherwise.
        """
        # Authenticate the user
        pass

    def get_doctors(self):
        """
        Retrieves a list of doctors in the user's city.

        Returns:
            list: A list of Doctor objects.
        """
        # Get the list of doctors from the database
        pass


