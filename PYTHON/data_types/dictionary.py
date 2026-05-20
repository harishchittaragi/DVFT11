"""Creating Dictionary"""
#empty dict
d={}
d=dict()
print(d)

#with initial key values pairs
d={"name":"Harish","Age":22,"city": "Bangaluru"}
print(d)

#From list of tuples
d=dict([("a",1),("b",2)])
print(d)

# Using dict comprehension
d={x: x**2 for x in range (5)}
print(d)

""" Accessing Elements """
print("****Access******")
d={"name":"Harish","Age":22,"city": "Bangaluru"}
print(d["name"])  #keyerror if missing
print(d.get("name"))  #None if missing
print(d.get("x","N/A")) # default if missing

""" Adding and updating"""
print("******Adding and Updating*******")
d={"name":"Harish","Age":22,"city": "Bangaluru"}
print(d)
d["email"]="abc@gmail.com"
d["Age"]=30   #update existing key
print(d)
d.update({"age":33,"City":"India"})  #update multiple
print(d)
d.setdefault("score",0)  #add only if key doesn't exist
print(d)

"""Deleting Elements"""
print("****Deleting elments******")
del d["age"]    # remove by key (key error if missing)
print(d.pop("city"))  #Remove and return value
print(d.pop("city",None)) # Remove safely with default
print(d.popitem()) # Remove & return last inserted (key,value)
#print(d.clear())   # Remove all items

""" Checking Membership"""
print("***Checking Membership*****")
print("name" in d)
print("Harish" in d.values())

"""   Iterating  """
print("****Iterating****")
for key in d:
    print(key)
print("******")
for key in d.keys():
    print(key)
print("******")
for val in d.values():
    print(val)
print("******")
for key ,val in d.items():
    print(f"  {key}    {val}")


""" Dictionary Views"""
print("*****Dictionary views****")
print(d.keys())
print(d.values())
print(d.items())

"""Dictionary copying"""
print("****Copying******")
d2=d.copy()
print(d)
print(d2)
import copy
d2=copy.deepcopy(d)  #Deep copy (for nested dicts)
print(d2)   
d2={**d}# shallow copy via unpacking
print(d2)

d2=d #handle assignment
d2.update({"age":2222})
print(d)

"""Merging Dictionaries"""
print("****Merging****")
d1={"name":"hari","age":"23"}
d2={"id":"DVFT1103", "work":"chipedge"}
merged={**d1,**d2}
print(merged)
d1.update(d2)
print(d1)

"""Sorting"""
print("****Sorting****")
# sort By Keys
sorted_d1=dict(sorted(d1.items()))
print(sorted_d1)

#sort by values
sorted_d1= dict(sorted(d1.items(), key=lambda x: x[1]))
print(sorted_d1)

#sort descending
sorted_d1=dict(sorted(d1.items(), key=lambda x:x[1], reverse=True))
print(sorted_d1)

"""Nested Dictionaries"""
print("***Nested Dictionaries****")
user={"Harish": {"age":23, "city": "BGK"},
        "Hari": {"age":18,"city":"Bang"}
        }
print(user)

print(user["Harish"]["age"])
print(user["Hari"]["city"])
user["Hari"]["city"]="sf"
print(user)

""" Dictionary From two lists """
keys=["a","e","i","o","u"]
vals=[1,2,3,4,5]
d5=dict(zip(keys,vals))
print(f"d5   {d5}")
