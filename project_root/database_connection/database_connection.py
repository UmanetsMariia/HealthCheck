import psycopg2

def connect_to_database():
    db_params = {
        'host': 'localhost',
        'port': '5432',
        'dbname': 'HealthCheck',
        'user': 'postgres',
        'password': 's19861986'
    }

    try:
        connection = psycopg2.connect(**db_params)
        print("Connected to the database.")
        return connection
    except psycopg2.Error as e:
        print("Unable to connect to the database. Error:", e)
        return None

def close_connection(connection):
    if connection:
        connection.close()
        print("Connection closed.")

def register_user(email, password, first_name, last_name, dob, city):
    connection = connect_to_database()
    if not connection:
        return False

    try:
        with connection.cursor() as cursor:
            # Example: Insert a new user into the 'users' table
            cursor.execute("""
                INSERT INTO users (email, password, first_name, last_name, dob, city)
                VALUES (%s, %s, %s, %s, %s, %s);
            """, (email, password, first_name, last_name, dob, city))

        connection.commit()
        return True
    except psycopg2.Error as e:
        print("Error registering user:", e)
        return False
    finally:
        close_connection(connection)


def authenticate_user(email, password):
    connection = connect_to_database()
    if not connection:
        return False

    try:
        with connection.cursor() as cursor:
            # Check if the user exists in the 'users' table
            cursor.execute("SELECT * FROM users WHERE email = %s AND password = %s;", (email, password))
            return cursor.fetchone() is not None
    except psycopg2.Error as e:
        print("Error authenticating user:", e)
        return False
    finally:
        close_connection(connection)

def get_dob(user_id):
    """
    Retrieves the date of birth for a given user from the database.

    Parameters:
    user_id (int): The ID of the user whose date of birth is to be retrieved.

    Returns:
    str: The date of birth of the user in 'YYYY-MM-DD' format, or None if not found.
    """
    connection = connect_to_database()
    if not connection:
        return None

    try:
        with connection.cursor() as cursor:
            cursor.execute("SELECT dob FROM users WHERE id = %s;", (user_id,))
            result = cursor.fetchone()
            return result[0] if result else None
    except psycopg2.Error as e:
        print(f"Error retrieving date of birth: {e}")
        return None
    finally:
        close_connection(connection)