""" Encapsulation 
    - three methods of encapsulation
      => public
      => private(__)
      => protected(_)"""

class parent():
    def __init__(self,name):
        self._name=name
        print(f"[parent] class {self._name}")
    def __display(self,num1):
        self.a=num1
        print(f"[parent] class {self.a}")
    def access(self):
        self.__display()

class child(parent):
    def __init__(self,name):
        super().__init__(name)
        print(f"[child] class {self._name}")
    def display(self,num1):
        super().display(num1)
        print(f"[child] class {self.a}")

c=child("Harish")
print(c._name)
c.display(5)
