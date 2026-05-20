t=(1,2,3,4,5)
empty=()
nested=(1,(2,3,4,5,6),7,8,9)
tup=tuple([1,2,3,4,"Harish"])
print(f"{t} {empty} {nested} {tup}")

""" accessing elments """
print("****entered to accessing elements****")
t=(10,20,30,40,50,60)
print(t[0])
print(t[-1])
print(t[1:3])
print(t[::-2])

""" Common Operations"""
print("*******operations*******")
a=(1,2,3,4)
b=(5,6,7,8,9)

print(a+b)
print(a*2)
print(2 in a)
print(2 in a and 3 in b)
print(len(a))
print(len(b))
print(min(a))
print(max(b))
print(sum(a))
print(sum(b))

""" Unpacking"""
print("******unpacking****")
x,y,z=(7,8,9)
print(f"{x}   {y}   {z}")
first, *rest=(1,2,3,4)
print(f"{first}    {rest}")
*init,last=(1,2,3,4)
print(f"{init}    {last}")

a,b=b,a
print(f"{a}     {b}")

""" Tple Methods"""
print("*****Tuple methods******")
t=(1,2,3,4,2,2,2,3,3,4,4,5)
print(t.count(2))
print(t.index(3))

#""" Named Tuples"""
#print("***named tuple****")
#Point=namedtuple('Point',['x','y'])
#p=Point(3,4)
#print(p.x)
#print(p.y)
#print(p[0])

