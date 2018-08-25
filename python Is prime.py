"""first we check if the input is > than 3 or not if it is then
   % it against the number from 2 to itself - 1. If the remainder == 0
   then it is not a prime number return False. Else we run through the whole
   list and found none divisble we will skip the rest condition and return true
   it is a prime number.

   for number less than 3 we will check is it == 2 or 3 if it is then it is prime
   else it is less than 1 and at this point all number are not prime."""
def is_prime(value):
    if value > 3:
        for i in range (2,value):
            if((value%i) == 0):
                return False
    elif value == 2 or value == 3:
        return True
    else:
        return False

    return True

def get_prime(value):
    primelist = []
    for i in range(value,2000000):
        if is_prime(i):
            print(i)
            primelist.append(i)

    return primelist

def sum_prime(l):
    return sum(l)
        
userinput = int(input("enter your starting number: "))    
l = get_prime(userinput)

print ("prime sum is " , sum_prime(l))
