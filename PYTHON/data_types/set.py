s={1,2,3,4,5}
print(type(s))

s=set([1,2,3,4,45])
print(s)
#s=set{}   #creating  empty set

print("""adding and removing elements""")

s.add(10)
print(f"s.add(10): {s}")

s.update([20,30,40,50])
print(f"s.update([20,30,40,50]): {s}")

s.remove(30)   #removes 30 if it is not in set it will raise error.
s.discard(200)  #removes 200 if it is exist else it will not raise any error
print(f"s.remove(30):{s}")

s.pop()   # removes last element
print(f"s.pop(): {s}")

s.clear()
print(f"s,clear():{s}")

print("********Math Operations********")
a={1,2,3,4,5,6}
b={5,6,7,8,9}

#union
print(a|b)
print(a.union(b))

#intersection
print(a&b)
print(a.intersection(b))

#difference
print(a-b)
print(a.difference(b))
print(b-a)
print(b.difference(a))

#symmetric_diffrence
print(a^b)
print(a.symmetric_difference(b))

print("****"" In-place(Mutating) Variants ""****")
#a|=b
a.update(b)  
print(a)

#a&=b
a.intersection_update([1,2,3,4,5,6,8,9,0,10,11,12])
print(a)

#a-=b
a.difference_update([1,2,3,4])
print(a)

#a^=b
a.symmetric_difference_update([2,3,4,5,6,7])
print(a)

""" Subset and superset"""
print("*******Subset and superset************")
print({1,2}.issubset({1,2,3,4,5}))
print({1,2,3,4,5.0}. issuperset({1,5.0}))
print({1,2,3} <= {1,3})  #subset
print({1,2,5}>={1,2})    #superset

""" Disjoint """
print("Disjoint Bolck")
print({1,2}.isdisjoint({3,4}))
