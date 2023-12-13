import datetime
class Test:
    """
    A parent class representing a general test.
    Attributes:
        test_id (int)
        name (str)
        user_id (int)
        result (bool)
        date (date)
    Methods:
         save_result()
    """
    def __init__(self, test_id, name, user_id, result=None, date=None):
        self.test_id = test_id
        self.name = name
        self.user_id = user_id
        self.result = result
        self.date = date if date else datetime.datetime.now()

    def save_result(self, result):
        self.result = result


class Blood_test(Test):
    """
    A child class representing a blood test.
    Attributes:
        test_id,
        name,
        user_id,
        result,
        date,
        chol,
        stab.glu,
        hdl,
        ratio,
        glyhb,
        age,
        height,
        weight,
        bp.1s,
        bp.1d,
        bp.2s,
        bp.2d,
        waist,
        hip,
        time.ppn,
        model
    Methods: predict_result
    """
    def __init__(self, test_id, name, user_id, chol, stabglu,
                 hdl, ratio, glyhb, age, height, weight, bp1s, bp1d,
                 bp2s, bp2d, waist, hip, timeppn, model):
        super().__init__(test_id, name, user_id)
        self.chol = chol
        self.stabglu = stabglu
        self.hdl = hdl
        self.ratio = ratio
        self.glyhb = glyhb
        self.age = age
        self.height = height
        self.weight = weight
        self.bp1s = bp1s
        self.bp1d = bp1d
        self.bp2s = bp2s
        self.bp2d = bp2d
        self.waist = waist
        self.hip = hip
        self.timeppn = timeppn
        self.model = model

    def predict_result(self):
        # predict result logic
        pass

class BrainMRI(Test):
    """
    A child class representing a Brain MRI test.
    Attributes:
        file_path (str): The file path of the brain MRI image.
        model (Model): The pre-trained model used for diagnosis.
    Methods:
         preprocess_image()
         predict_result()
    """
    def __init__(self, test_id, name, user_id, file_path, model, result=None, date=None):
        super().__init__(test_id, name, user_id, result, date)
        self.file_path = file_path
        self.model = model

    def preprocess_image(self):
        """
        Preprocess the brain MRI image to make it suitable for input into the pre-trained model.
        """
        pass

    def predict_result(self):
        """
        Predict the result of the Brain MRI test based on the input image.
        """
        pass