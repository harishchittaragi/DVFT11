class parent1():
    def __init__(self):
        print(f"this is parent1 class init function")

    def display(self):
        print(f"This is parent1 class display function")

class parent2():
    def __init__(self):
        print(f"this is parent2 class init function")

    def display(self):
        print(f"This is parent2 class display function")


class child(parent2,parent1):
    def __init__(self):
        print(f"this is child class init function")

    def display(self):
        print(f"This is child class display function")

class grand_child(child):
    def __init__(self):
        super().__init__()
        print(f"this is grandchild class init function")

    def display(self):
        print(f"This is grandchild class display function")

gc=grand_child()
gc.display()
print(grand_child.mro())
#[<class '__main__.grand_child'>, <class '__main__.child'>, <class '__main__.parent2'>, <class '__main__.parent1'>, <class 'object'>]

