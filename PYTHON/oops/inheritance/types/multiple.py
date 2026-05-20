""" Multiple type of inheritance (one child class has more than one parent class) """
class parent1():
    def __init__(self):
        print(f"this is parent1 class init function")

    def display(self):
        super().display()
        print(f"this is parent1 class display function")

class parent2():
    def __init__(self):
        print(f"this is parent2 init function")

    def display(self):
        print(f"this is parent2 class display function")

class child (parent1,parent2):
   # pass              #if wrote this empty child class then it will execute parent1 class methods 
                       # as we declared it first in line:lass child (parent1<---, parent2)
    def __init__(self):
        print(f"this is child class init function")

    def display(self):
        super().display()
        print(f"this is child class display function")

c=child()
c.display()
print(child.mro()) # mro= Method Resolution Order;
#[<class '__main__.child'>, <class '__main__.parent1'>, <class '__main__.parent2'>, <class 'object'>]
parent1.display(c) # inside this paranthesis we have to write object name fix while direct calling

