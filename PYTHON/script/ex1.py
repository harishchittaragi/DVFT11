f= open("/home/dvft1103/dvft11/PYTHON/openfiles/ex1.py","w")
f.write("Hello\n")
f.write("Harish\n")
f.close()
f1=open("/home/dvft1103/dvft11/PYTHON/openfiles/ex1.py","r")
print(f1.read())

with open("logic","w") as f2:

    f2.writelines(["Hello Python world\n",
              "\nThis is Harish\t from Bangalore\n"])
    f2.close()

with open("logic","r") as f3:
    print(f3.read())
    f3.close()

""" Hello
    Harish

    Hello Python world
    This is Harish	 from Bangalore

    """
    
