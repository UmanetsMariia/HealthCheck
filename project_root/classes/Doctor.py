import tensorflow as tf
class Doctor:
    """
    Represents a doctor.

    Attributes:
        doctor_id (int): The unique identifier of the doctor.
        name (str): The first name of the doctor.
        surname (str): The last name of the doctor.
        specialization (str): The specialization of the doctor.
    """

    def __init__(self, doctor_id, name, surname, specialization):
        self.doctor_id = doctor_id
        self.name = name
        self.surname = surname
        self.specialization = specialization


class Clinic:
    """
    Represents a clinic.

    Attributes:
        clinic_id (int): The unique identifier of the clinic.
        clinic_name (str): The name of the clinic.
        doctors (list): A list of doctors who work at the clinic.
    """

    def __init__(self, clinic_id, clinic_name):
        self.clinic_id = clinic_id
        self.clinic_name = clinic_name
        self.doctors = []

    def add_doctor(self, doctor):
        """
        Adds a doctor to the list of doctors who work at the clinic.

        Parameters:
            doctor (Doctor): The doctor to add.
        """
        self.doctors.append(doctor)

    def get_doctor_by_id(self, doctor_id):
        """
        Returns the doctor with the specified doctor_id from the list of doctors who work at the clinic.

        Parameters:
            doctor_id (int): The unique identifier of the doctor.

        Returns:
            Doctor: The doctor with the specified doctor_id, or None if no such doctor exists.
        """
        for doctor in self.doctors:
            if doctor.doctor_id == doctor_id:
                return doctor
        return None