#Try/Except
# try:
#     x=5+4
# except:
#     print("Failed")
#OOP.
#An object has state and behaviours
#states =properties/ attributes that define an object - color, height,name,etc
#Behaviour = what does the object do-functionalities
#Examples are nlike move(), eat(), etc
#in programming states - properties & behaviours are functions/method
class Fish():
    #constructor of properties
    def __init__(self):
        self.name = "Bob"
        self.age = 4
        self.color = "silver"
        self.weight = 3
    #a function inside a class is called a method
    def swim(self, lake):
        message =  (self.name, "can swim", lake)
        return message
    def jump(self):
        message =  self.name, "can jump"
        return message
        
#call the object/Instantiate
fish = Fish()
print(fish.age)
print(fish.swim("L.Nakuru"))
#prefer
message = fish.swim("L. Nakuru")#argument
print(type(message))
print(message)

bookings = [{
    'x':10,
    'y':15
}, {
    'x':100,
    'y':200
}]

for booking in bookings:
    member = {
        'b':70
    }
    #adsd key
    booking['z'] = member
    print(bookings)