""" Multilevel Inheritance  (each child classes were extended from its parent class only) 
    - without super() keyword most priority for last exntended class methods 
    - with super(). keyword we can access its previous extended class methods """

class parent():
    def __init__(self):
        print(f"This is parent class init function")

    def display(self,name):
        self.name=name
        print(f"This is parent class display function with name :{self.name}")

class child(parent):
    def __init__(self):
        super().__init__()
        #grand_child.display(self) #here we can access its next extended class also using class name
        print(f"This is child class init function")

    def display(self,name,number1):
        self.number1=number1
        super().display(name)
        print(f"This is child class display function with number {self.number1}")

class grand_child(child):
    def __init__(self):
        super().__init__()
        #parent.display(self)  #here we can access parent class display method aslo using class name
        print(f"This is grand_child class init function")

    def display(self,name,number1,number2):
        self.number2=number2
        super().display(name,number1)
        print(f"This is grand_child class display function with {number2}")

#object creating  for last extended class i.e grand_child class
gc=grand_child()   #here without calling display() method it will execute only init functions

gc.display("Harish",23,3333333)
print(gc.name) #variable accessing from parent class
print(gc.number1)# variable accessing from child class
print(gc.number2)# variable accessing from grand child

parent.display(gc,"Hari") #This is direct accessing method of parent class



