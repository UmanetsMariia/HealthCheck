from flask import Flask, render_template, request, redirect, url_for
from database_connection.database_connection import authenticate_user, connect_to_database, register_user, get_neuro,get_endocrinologists
import joblib
from PIL import Image
import pandas as pd
import numpy as np
from flask import session
from datetime import datetime

app = Flask(__name__)
app.static_folder = 'static'
db_connection = connect_to_database()

xgboost = joblib.load('models/xgb_model.joblib')
cnn = joblib.load('models/CNN_model.joblib')

@app.route('/')
def home():
    return render_template('login.html')

@app.route('/login')
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        authenticate_user(email, password)
        if authenticate_user(email, password):
            return redirect(url_for('main'))
        else:
            return "Login failed. Invalid credentials."
    return render_template('login.html')


@app.route('/registration', methods=['GET', 'POST'])
def registration():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        first_name = request.form['first_name']
        last_name = request.form['last_name']
        dob = request.form['dob']
        city = request.form['city']
        if register_user(email, password, first_name, last_name, dob, city):
            return redirect(url_for('login'))
        else:
            return "Registration failed. Please try again."
    return render_template('registration.html')


@app.route('/main')
def main():
    return render_template('main.html')


@app.route('/logout')
def logout():
    session.pop('user_id', None)
    return redirect(url_for('home'))


@app.route('/test_selection')
def test_selection():
    return render_template('test_selection.html')


@app.route('/diabetes', methods=['GET', 'POST'])
def diabetes():
    message = ''
    if request.method == 'POST':
        cholesterol = int(request.form['cholesterol'])
        stabglu = int(request.form['stabglu'])
        hdl= int(request.form['hdl'])
        ratio = float(request.form['ratio'])
        age = int(request.form['age'])
        bp1s = int(request.form['bp1s'])
        bp1d = int(request.form['bp1d'])
        hip = int(request.form['hip'])
        timeppn = int(request.form['timeppn'])
        gender = request.form['gender']
        frame = request.form['frame']
        height = float(request.form['height'])
        weight = float(request.form['weight'])
        gender_encoded = 1 if gender.lower() == 'female' else 0
        bmi = weight / height ** 2
        frame_large, frame_medium, frame_small = 0, 0, 0
        if frame == 'large':
            frame_large = 1
        elif frame == 'medium':
            frame_medium = 1
        elif frame == 'small':
             frame_small = 1
        data_for_model = [cholesterol, stabglu, hdl, ratio, age, bp1s, bp1d, hip, timeppn,
                          gender_encoded,frame_large, frame_medium, frame_small, bmi ]  # Adjust as per your model's requirements
        probabilities = xgboost.predict_proba([data_for_model])[0]
        probability_of_diabetes = probabilities[1] * 100
        is_diabetes = int(probability_of_diabetes >= 45)
        if is_diabetes == 1:
            message = f"Seems like you might have diabetes. Probability: {probability_of_diabetes:.0f}%. Please check up with your doctor."
            endocrinologists = get_endocrinologists()
            return render_template('diabetes.html', message=message, endocrinologists=endocrinologists)
        elif is_diabetes == 0:
            message = "Seems like you don't have diabetes."
    return render_template('diabetes.html', message=message)


def preprocess_image(uploaded_file):
    with Image.open(uploaded_file) as img:
        img = img.resize((244, 224))
        img = img.convert('RGB')
        img_array = np.array(img)
        img_array = np.expand_dims(img_array, axis=0)
        return img_array


def predict_mri_image(file):
    processed_image = preprocess_image(file)
    prediction = cnn.predict(processed_image)
    predicted_class = np.argmax(prediction, axis=1)
    class_names = ['glioma', 'meningioma', 'notumor', 'pituitary']
    predicted_class_name = class_names[predicted_class[0]]
    return predicted_class_name

@app.route('/brain_mri', methods=['GET', 'POST'])
def brain_mri():
    if request.method == 'POST':
        file = request.files['mri_image']
        prediction = predict_mri_image(file)
        if prediction == 'notumor':
            message = "Seems like you don't have any troubles with your brain MRI."
        else:
            neuros = get_neuro()
            message = f"Seems like you might have {prediction}. Please check up with your doctor."
            return render_template('brain_mri.html', message=message, neuros=neuros)
        return render_template('brain_mri.html', message=message)
    return render_template('brain_mri.html')

def calculate_age(dob):
    birth_date = datetime.strptime(dob, "%Y-%m-%d")  # Adjust format as per your database
    today = datetime.today()
    return today.year - birth_date.year - ((today.month, today.day) < (birth_date.month, birth_date.day))



if __name__ == '__main__':
    app.run(port=8000, debug=True)
