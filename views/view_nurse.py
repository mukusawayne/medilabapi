# Import required modules
import pymysql
from flask_restful import *
from flask import *
from functions import *
import pymysql.cursors

# import JWT Packages
from flask_jwt_extended import create_access_token, jwt_required, create_refresh_token

# Nurse signin
class NurseSignin(Resource):
    def post(self):
        json = request.json
        surname = json['surname']
        password = json['password']

        sql = "select * from nurses where surname = %s"
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql, surname)
        count = cursor.rowcount
        if count == 0:
            return jsonify({"message": "User does not exist,contact the admin to sign you up"})
        else:
            nurse = cursor.fetchone()
            hashed_password = nurse["password"]
            # verify
            if hash_verify(password, hashed_password):
                # TODO  JSON Web tokens
                access_token = create_access_token(identity=surname, fresh=True)
                refresh_token = create_refresh_token(surname)

                return jsonify(
                    {
                        "message": nurse,
                        "access_token": access_token,
                        "refresh_token": refresh_token,
                    }
                )
            else:
                return jsonify({"message": "Login Failed"})
 #TODO
 # VIEW ASSIGNMENTS- provide nurse_id  and returns invoice_no,flag       
 # View invoice details-provid invoice no,return trests under that invoice
 # change password   

#This class will fetch Nurse booking allocations
class ViewAssignments(Resource):
    @jwt_required(refresh=True)  # refresh toke
    def post(self):
        json = request.json
        nurse_id = json['nurse_id']
        flag = json['flag']

        #Check if the above invoice is in active
        sql = '''select * from nurse_lab_allocations where
        nurse_id = %s and flag = %s'''
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql,(nurse_id,flag))
        count = cursor.rowcount
        if count == 0:
            message = "No {} Assignments".format(flag)
            return jsonify({'message': message})
        else:
            #It has been found , what is the flag holding
            data = cursor.fetchall()
            return jsonify(data)
        
#view invoice details
class ViewInvoiceDetails(Resource):
    @jwt_required(refresh=True)  # refresh toke
    def post(self):
        json = request.json
        invoice_no = json['invoice_no']

        #Check if the above invoice is in active
        sql = '''select * from bookings where invoice_no = %s'''
        connection = pymysql.connect(host='localhost',
                                     user='root',
                                     password='',
                                     database='medilab')
        cursor = connection.cursor(pymysql.cursors.DictCursor)
        cursor.execute(sql,(invoice_no))
        count = cursor.rowcount
        if count == 0:
            message = " InvoiceNo {} Does not Exist".format(invoice_no)
            return jsonify({'message': message})
        else:
            bookings = cursor.fetchall()
            import json
            jsonStr = json.dumps(bookings, indent=1, sort_keys=True, default=str)
            # then convert json string to json object
            return json.loads(jsonStr)
        
        
    class ChangePass(Resource):
        def post(self):
            json = request.json
            nurse_id = json['nurse_id']
            current_password = json['current_password']
            new_password = json['new_password']
            confirm_password = json['confirm_password ']
            # select using the nurse id, if nurtse does not exist, give a mesage
            # if nurse exists get the hashed password
            # Verify if the current password and hashed password are ok 
            # if  current password ius verified = False,Give a message - current is wrong
            # If verified is true, then confirm that new_password and confirm_password are the same.
            # If they are not the same , Give a message.
            # If they are ssame then, hash new_password and do update Query, Update pasword using nurse_id
            # Give a message password updated
            # Go login with the new password