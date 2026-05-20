""" Empty class creation """
class student():
    pass  #write pass always for empty class
print(type(student))

"""Class with Handle"""
class student():
    def display(self):
        print(f"This id Display method")
    print(f"This is of class type")
st=student()    # Object creation for class
st.display()    # using st handle calling function display()

""" Class with __init__"""
class done():
    def __init__(self):
        print(f"This is init method")
    def display1(self):
        print(f"This is Display1 method")
d=done()
d.display1()

""" class with variables  """
class var():
    def __init__(self):
        print(f"__init__")
    def display2(self, name ,age):
        print(f"this is display2 {name} {age}")
v=var()
v.display2("Hari",23)

""" Global and Local variable """
class student():
    a=10                  # Global variables a and b
    b=a+1
    def __init__(self):
        self.c=20         # local variable c for init method only
        self.d=self.c+1   #local variable d for init method only
        print(f"c:{self.c}  d:{self.d}")
    def display(self):
        self.e=30          # local variable e for display method only
        self.f=self.e+1    # local variable f for display method only 
        print(f"a:{self.a}  b:{self.b}")#we can call global variable with self key inside any methods
        print(f"c:{self.c}  d:{self.d}")#we can call other method variables here with self keyword
        print(f"e:{self.e}  f:{self.f}")
    print(f"a:{a}  b:{b}")# global variable calling directly without self keyword
st=student()
print(f"c:{st.c}  d:{st.d}")#here we access local variables usign object  
st.display()
print(f"e:{st.e}  f:{st.f}")
