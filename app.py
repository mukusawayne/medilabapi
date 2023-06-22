from flask import Flask
from flask_jwt_extended import JWTManager
from flask_restful import Api

app = Flask(__name__)

#  Set up JWT
from datetime import timedelta

app.secret_key = "hfjdfhgjkdfhhtgdf865785"
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = timedelta(minutes=1)
app.config["JWT_REFRESH_TOKEN_EXPIRES"] = timedelta(minutes=59)
jwt = JWTManager(app)
# Make the app an api
api = Api(app)

# configure Views/Endpoints here

# Apis for Members Dashboard
from views.views import AddDependant,MemberProfile,MemberSignin
from views.views import MemberSignUp,ViewDependants,Laboratories
from views.views import LabTests, MakeBooking, MyBookings, MakePayment

api.add_resource(MemberSignUp, "/api/member_signup")
api.add_resource(MemberSignin, "/api/member_signin")
api.add_resource(MemberProfile, "/api/member_profile")
api.add_resource(AddDependant, "/api/add_dependant")
api.add_resource(ViewDependants, "/api/view_dependants")
api.add_resource(Laboratories, "/api/laboratories")
api.add_resource(LabTests, "/api/lab_tests")
api.add_resource(MakeBooking, "/api/make_booking")
api.add_resource(MyBookings, "/api/mybookings")
api.add_resource(MakePayment, "/api/make_payment")

# Apis for Admin Dashboard
from views.views_dashboard import LabSignup, LabSignin, LabProfile, AddLabtests,ViewLabTests
from views.views_dashboard import ViewLabBookings,AddNurse,ViewNurses,TaskAllocation

api.add_resource(LabSignup, "/api/lab_signup")
api.add_resource(LabSignin, "/api/lab_signin")
api.add_resource(LabProfile, "/api/lab_profile")
api.add_resource(AddLabtests, "/api/add_tests")
api.add_resource(ViewLabTests, "/api/view_lab_tests")
api.add_resource(ViewLabBookings, "/api/view_bookings")
api.add_resource(AddNurse, "/api/add_nurse")
api.add_resource(ViewNurses, "/api/view_nurses")
api.add_resource(TaskAllocation, "/api/task_allocation")

#Apis for nurse dashboard
from views.view_nurse import NurseSignin,ViewAssignments,ViewInvoiceDetails,ChangePass
api.add_resource(NurseSignin, "/api/nurse_signin")
api.add_resource(ViewAssignments,"/api/view_assignments")
api.add_resource(ViewInvoiceDetails,"/api/view_invoice_details")
api.add_resource(ChangePass,"/api/change_pass")


if __name__ == "__main__":
    app.run(debug=True)
