# MediLab API
This is an APi Build in python Flask framework and MySql database,

### The API has 3 parts.

1. The API allows the client to register a memmber, sign in, profile, add dependants, make booking, make payments e.t.c

2. Other APIS include sign i,sign up laboratory, add lab tests , add nurses, allocate nurses

3. Nurse APIS  allows nurse to login and access the allocated tasks , change password

### How to install
step 1: Download xampp from https://www.apachefriends.org/
step 2; create and import medilab.sql.
step3: create a flask app and install theese packages


pip install flask
pip install pymysql
pip install bcrypt
pip install africastalking
pip install fpdf

step4: Python set up

create a folder named views and place the view_nurses.py,views.py and views_dashboard.py inside

in the roots folder create a functions.py
in the root folder again create app.py and configure your endpoints

Run your app

Useful links
https://flask.palletsprojects.com/en/1.1.x/
https://github.com/africastalking/AfricasTalking