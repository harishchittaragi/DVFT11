#Numeric Data Types
  #integer (int)
a=10 
  #Float(float)
b=10.5
  #Complex(complex)
c=3+2j

#String Type
d="string"

#Boolean Type
e=True 
# e= False

#None Type
f=None

#Sequence Types
 #List(list)
my_list=[1,2,3,"hello"]

 #Tuple(tuple)
my_tuple=(1,2,3,"harish")

 #Range(range)
r= range(10)

#set Type
my_set={1,2,3,3}

#Mapping  Type
 #Dictionary(dict)
student={ "name":"Harish",
           "age":22}


print(type(a))              #<class 'int'>
print(type(b))              #<class 'float'>
print(type(c))              #<class 'complex'>
print(type(d))              #<class 'str'>
print(type(e))              #<class 'bool'>
print(type(f))              #<class 'NoneType'>
print(type(my_list))        #<class 'list'> 
print(type(my_tuple))       #<class 'tuple'> 
print(type(r))              #<class 'range'> 
print(type(my_set))         #<class 'set'> 
print(type(student))        #<class 'dict'> 

print (f"{a} {b} {c} {d} {e} {f} {my_list} {my_tuple} {r} {my_set} {student}")
# answer  10 10.5 (3+2j) string True None [1, 2, 3, 'hello'] (1, 2, 3) range(0, 10) {1, 2, 3} {'name': 'Harish', 'age': 22}

print("a:{}  " "b:{}  " "c:{}  ".format(a,b,c)) # a:10  b:10.5  c:(3+2j)  

