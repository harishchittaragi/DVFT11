mylist =[1,2,3,4,5,6,7,8,9,0,"Hari","Name"]
print(len(mylist))
#accessing element
print(mylist[0])
print(mylist[10])
print(mylist[8])

#Slicing 
print(mylist[1:5])
print(mylist[:])
print(mylist[1:])
print(mylist[:5])
print(mylist[::])
print(mylist[2:10:2])
print(mylist[::])
print(mylist[:10:])
print(mylist[::3])
print(mylist[1::2])

#Modify
#Updating Elements
mylist[10]=25
print(mylist)

#insert()
mylist.insert(1,15)
print(mylist)

#Add
#append()
mylist.append(50)
print(mylist)

#extend()
mylist.extend([60,70,80])
print(mylist)

#Remove Methods
mylist.remove(25) #removes 25 from list
mylist.pop()      #removes last element
mylist.pop(2)      #removes 2nd index element
#mylist.clear()    # clear all the elements inside list
del mylist[2]


#searching Operations
#index()
print(mylist.index(0))  #gives index

#count()
print(mylist.count(2))  # number of times 2 appears in list

#sorting
#sort() ascending
mylist =[1,2,3,4,5,6,7,8,9,0]
mylist.sort()
print(mylist)

#sort(reverse=True) descending
mylist.sort(reverse=True)
print(mylist)

#sorted()  (does not change original list)
new_list=sorted(mylist)
print(new_list)

#reversing
new_list=[1,3,5,7]
new_list.reverse()
print(new_list)

#copying list
newlist=new_list.copy()
print(newlist)

#Membership check
print(10 in mylist)
print(110 not in mylist)

#looping through list
for item in mylist:
    print(item)

# list concatenation
list1=[1,2,3,4,5]
list2=[6,7,8,9,0]
print(list1+list2)

#Repetition
print([1,2]*3)

#Nested list
nested=[[1,2],[3,4]]
print(nested[1][0])

#list Comprehension
squares=[x**2 for x in range(5)]
print(squares)


