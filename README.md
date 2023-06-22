# MediLab API
This is an APi Build in python Flask framework and MySQL database,

## The API has 3 parts.

1. The API allows the client to register a member, sign in, profile, add dependants, make booking, make payments e.t.c

2. Other APIS include sign in, sign up, add laboratory, add lab tests , add nurses, allocate nurses

3. Nurse APIS  allows nurse to login and access the allocated tasks , change password

### How to install
step 1: Download xampp from https://www.apachefriends.org/

step 2; create and import medilab.sql.

step3: create a flask app and install theese packages
'''
pip3 install flask
pip3 install pymysql
pip3 install bcrypt
pip3 install africastalking
pip3 install fpdf
pip3 install fask_restful
pip3 install flask-jwt-extended

'''

step 4:Create a folder named views and place the view_nurses.py,views.py and views_dashboard.py inside

In the roots folder create a functions.py
In the root folder again create app.py and configure your endpoints

Run your app

Useful links

https://flask.palletsprojects.com/en/1.1.x/
https://github.com/africastalking/AfricasTalking