def greet():
    print("Hello, Harish")
greet()

#Function with return type
def add(a,b):
    sum=a+b
    return sum
result=add(2,3)
print(result)
#print(f"sum:{add(2,3)}")

""" Types Of arguments In Python """
# positional Arguments
def student(name,age):
    print(f"Positional arguments {name,age}")
student("Harish",23)

# Keyword Arguments
def student(name,age):
    print(f"Keyword Arguments {name,age}")
student(age=22,name="harish")

# Default Arguments
def student(age,name="harish"): # always gave default parameters at the end
    print(f"Default type args {name,age}")
student(23)

#Variable Length Arguments (*args)
def total(*numbers):
    sum=0
    for i in numbers:
        sum+=i
    print(f" *args type {sum}")
total(1,2,3,4,5)

#Keyword variable length (**kwargs)
def details(**data):
    for key, value in data.items():
        print(f" **data {key,value}")
details(name="Harish",age=22,branch="ECE")
   
#order of args must be
#Positional -> default -> *args ->**kwargs

