# Import required modules
import pymysql
from flask_restful import *
from flask import *
from functions import *
import pymysql.cursors

# import JWT Packages
from flask_jwt_extended import create_access_token, jwt_required, create_refresh_token

# Member sign_up
class MemberSignUp(Resource):
    def post(self):
        # Connect to Mysql
        json = request.json
        surname = json["surname"]
        others = json["others"]
        gender = json["gender"]
        email = json["email"]
        phone = json["phone"]
        dob = json["dob"]
        password = json["password"]
        location_id = json["location_id"]

        # Validate Password
        response = passwordValidity(password)
        if response == True:
            if check_phone(phone):
                connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
                cursor = connection.cursor()
                # Insert Data
                sql = '''insert into members (surname, others, gender, email, phone, dob, password,
                    location_id)values(%s,%s,%s,%s,%s,%s,%s,%s)'''
                # Provide data
                data = (
                    surname,
                    others,
                    gender,
                    encrypt(email),
                    encrypt(phone),
                    dob,
                    hash_password(password),
                    location_id,
                )
                try:
                    cursor.execute(sql, data)
                    connection.commit()
                    # send SMS/Email
                    code = gen_random(6)
                    send_sms(
                        phone,
                        """Thank you for Joining MediLab.Your Secret No is: {}.Do not share""".format(
                            code
                        ),
                    )
                    return jsonify({"message": "Successfuly Registered"})
                except:
                    connection.rollback()
                    return jsonify({"message": "Failed.Try Again"})

            else:
                return jsonify({"message": "Invalid Phone +254"})
        else:
            return jsonify({"message": response})


class MemberSignin(Resource):
    def post(self):
        # Connect to Mysql
        json = request.json
        surname = json["surname"]
        password = json["password"]

        # The user enters plain text email
        sql = "select * from members where surname = %s"
        # data = encrypt((email))

        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql, surname)
        count = cursor.rowcount
        if count == 0:
            return jsonify({"message": "User does not exist"})
        else:
            # user exists
            member = cursor.fetchone()
            hashed_password = member["password"]  # This password is hashed
            # Jane provided a plain password
            if hash_verify(password, hashed_password):
                # TODO  JSON Web tokens
                access_token = create_access_token(identity=surname,
                                                   fresh=True)
                refresh_token = create_refresh_token(surname)

                return jsonify({"message": member,
                                'access_token':access_token,
                                'refresh_token':refresh_token})
            
            else:
                return jsonify({"message": "Login Failed"})


# Token,Member profile,Add dependant
# Member profile
class MemberProfile(Resource):
    @jwt_required(refresh=True)#refresh token
    def post(self):
        json = request.json
        member_id = json["member_id"]
        sql = "select * from members where member_id = %s"
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql, member_id)
        count = cursor.rowcount
        if count == 0:
            return jsonify({"message": "Member does not exist"})
        else:
            member = cursor.fetchone()
            return jsonify({"message": member})


# Add dependant
class AddDependant(Resource):
    @jwt_required(refresh=True)#refresh token
    def post(self):
        # Connect to Mysql
        json = request.json
        member_id = json["member_id"]
        surname = json["surname"]
        others = json["others"]
        dob = json["dob"]

        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor()
        # Insert Data
        sql = """ Insert into dependants (member_id, surname, others, dob)values(%s,%s,%s,%s)"""
        # Provide Data
        data = (member_id, surname, others, dob)
        try:
            cursor.execute(sql, data)
            connection.commit()
            return jsonify({"message": "Dependant Added"})
        except:
            connection.rollback
            return jsonify({"message": "Failed. Try Again"})


# ViewDependants
class ViewDependants(Resource):
    @jwt_required(refresh=True)#refresh token
    def post(self):
        json = request.json
        member_id = json["member_id"]
        sql = "select * from dependants where member_id = %s"
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql, member_id)
        count = cursor.rowcount
        if count == 0:
            return jsonify({"message": "You have no Dependants"})
        else:
            dependants = cursor.fetchall()
            return jsonify({"message":dependants})
        # {} - Means Object in JSON, comes with key - value
        # [] - Means a JSON array
        # [{}, {} ]
# JWT TOKEN-pip3 install flask_jwt_extended
class Laboratories(Resource):
    def get(self):
        sql = "select * from laboratories"
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql)
        count = cursor.rowcount
        if count == 0:
            return jsonify({'message': 'No Laboratories listed'})
        else:
            laboratories = cursor.fetchall()
            return jsonify(laboratories)
        
#lab tests
class LabTests(Resource):
    def post(self):
        json = request.json
        lab_id = json['lab_id']
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        sql = "select * from lab_tests where lab_id = %s"
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql, lab_id)
        count = cursor.rowcount
        if count == 0:
            return jsonify({'message': 'No Lab test found'})
        else:
            try:
                lab_tests = cursor.fetchall()
                return jsonify(lab_tests)
            except:jsonify({'message':'Error'})
#Bookings      
class MakeBooking(Resource):
    @jwt_required(refresh=True)#refresh token
    def post(self):
        # Connect to MySQL
        json = request.json
        member_id = json['member_id']
        booked_for = json['booked_for']
        dependant_id = json['dependant_id']
        test_id = json['test_id']
        appointment_date = json['appointment_date']
        appointment_time = json['appointment_time']
        where_taken = json['where_taken']
        latitude = json['latitude']
        longitude = json['longitude']
        lab_id = json['lab_id']
        invoice_no = json['invoice_no']
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor()
        # Insert Data
        sql = ''' Insert into bookings(member_id,booked_for, dependant_id,test_id, appointment_date,
         appointment_time, where_taken, latitude,longitude, lab_id, invoice_no )
          values(%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) '''
        # Provide Data
        data = (member_id,booked_for, dependant_id,test_id, appointment_date,
         appointment_time, where_taken, latitude,longitude, lab_id, invoice_no)
        try:
            cursor.execute(sql, data)
            connection.commit()
            # Select from members to find phone 
            sql = '''select * from members where member_id = %s'''
            cursor = connection.cursor(pymysql.cursors.DictCursor)
            cursor.execute(sql, member_id)
            member = cursor.fetchone()
            #get phone number(phone)
            phone = member['phone']
            # Send SMS to above phone number . NB: decrypt phone number!
            send_sms(decrypt(phone),'Booking on {} at {} ,Invoice {}'
                     .format(appointment_date, appointment_time, invoice_no))
            return jsonify({'message': 'Booking received'})
        except:
            connection.rollback()
            return jsonify({'message': 'Booking failed. Try Again'})
 #My Bookings       
class MyBookings(Resource):
    def get(self):
        json = request.json
        member_id = json['member_id']
        sql = "select * from bookings where member_id = %s"
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql, member_id)
        count =cursor.rowcount
        if count == 0:
            return jsonify({'message': 'You have no booking'})
        else:
            bookings = cursor.fetchall()
            #return  str(bookings)
            import json
            jsonStr = json.dumps(bookings, indent=1, sort_keys=True,
            default=str)
            #then convert json string to json object
            return json.loads(jsonStr)


#Make payments
class MakePayment(Resource):
    @jwt_required(fresh=True)#fresh token
    def post(self):
        json = request.json
        phone = json['phone']
        amount = json['amount']
        invoice_no = json['invoice_no']
        #Access Mpesa Functions locatated in functions.py
        mpesa_payment(amount, phone, invoice_no)
        return jsonify({'message': 'Sent - Complete Payment on Your Phone.'})
#logout
#SQL
#classes
#if else