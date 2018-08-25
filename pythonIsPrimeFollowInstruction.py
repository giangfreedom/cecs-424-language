"""first we check if the input is > than 3 or not if it is then
   % it against the number from 2 to itself - 1. If the remainder == 0
   then it is not a prime number return False. Else we run through the whole
   list and found none divisble we will skip the rest condition and return true
   it is a prime number.

   for number less than 3 we will check is it == 2 or 3 if it is then it is prime
   else it is less than 1 and at this point all number are not prime."""
def is_prime(value):
    """ if the value is >3 and it is odd number
        and it is not divisible by 2,3,5,7,11
        then check for all number from 12 to half of
        value +1 because value can't divisible by number that
        is greater than half of itself"""
    if value > 3 and (value%2 != 0) and (value%3 != 0) and (value%5 != 0) and (value%7 != 0) and (value%11 != 0):
        for i in range (2,((value//2)+1)):
            if((value%i) == 0):
                return False       
    elif value == 2 or value == 3 or value == 5 or value == 7 or value == 11:
        return True
    else:
        return False

    return True

def get_primes(value):
    primelist = []
    for i in range(value,value+10):
        if is_prime(i):
            print(i)
            primelist.append(i)

    return primelist

"""
    if user input 2mil at start a message will be show and
    the program terminate
    otherwise an infinite while loop start
    the loop call get_primes to obtain a list of 10
    primes numbers from starting number of user
    if the primes number exceed 2 million the loop
    will terminate and return the sum
"""
def sum_primes(startNumber):
    condition = True
    sumprime = 0
    mylist = []
    if startNumber >= 2000000:
        print ("you can't start with 2000000 ")
        return          
    while(condition):
        mylist = get_primes(startNumber)
        for j in range(0,len(mylist)):
            if mylist[j] >= 2000:
                condition = False
                break
            sumprime = sumprime + mylist[j]
        startNumber = startNumber+10

    return sumprime
        



     
userinput = int(input("enter your starting number: "))    
total = sum_primes(userinput)

print ("prime sum is " , total)

