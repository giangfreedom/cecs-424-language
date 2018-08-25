def strToarr(HTString):
	"""convert a string into list"""
	L = list(HTString)
	return L
def arrTostr(HTArr):
	"""convert a  list to string"""
	S = ''.join(HTArr)
	return S

def move(HTArr,userchoice):
        """ move 2 char to empty space"""
        if any("-" in s for s in HTArr):
                temp1 = HTArr[userchoice]
                temp2 = HTArr[userchoice+1]
                HTArr[userchoice] = "-"
                HTArr[userchoice+1] = "-"
                for i in range(len(HTArr)):
                        if i == userchoice or i == userchoice+1:
                                continue
                        else:
                             if HTArr[i] in '-':
                                        HTArr[i] = temp1
                                        HTArr[i+1] = temp2
                                        break   
                """
                HTArr[userchoice] = HTArr[len(HTArr)-2]
                HTArr[userchoice+1] = HTArr[len(HTArr)-3]
                HTArr[len(HTArr)-2] = temp1
                HTArr[len(HTArr)-3] = temp2
                temp1 = HTArr[userchoice]
                temp2 = HTArr[userchoice+1]
                for i in range(userchoice+2,len(HTArr)-1):
                        HTArr[userchoice] = HTArr[userchoice+2]
                        userchoice+=1
                HTArr[len(HTArr)-2] = temp1
                HTArr[len(HTArr)-3] = temp2
                """
                L = HTArr
                
        else:
                HTArr.append(HTArr[userchoice])
                HTArr.append(HTArr[userchoice + 1])
                HTArr[userchoice] = "-"
                HTArr[userchoice + 1] = "-"
                """
                temp1 = HTArr[userchoice]
                temp2 = HTArr[userchoice+1]
                for i in range(userchoice+2,len(HTArr)-1):
                        HTArr[userchoice] = HTArr[userchoice+2]
                        userchoice+=1
                HTArr[len(HTArr)-2] = temp1
                HTArr[len(HTArr)-3] = temp2
                """
                L = HTArr                
        
        return L

s1 = "HHHHHTTTTT"
print(s1)
print("you have 5 move use your space to indicate which character you want")
i = 0
""" loop 5 time for 5 move"""
while i < 5:
        i+=1
        print("move number ", i)
        print(s1)
        userinput = input()
        userValue = len(userinput)
        print("you chose letter number ", userValue+1)
        L1 = strToarr(s1)
        if (userValue == len(L1)-1):
                print("you cant pick the end of the string ")
                s1 = arrTostr(L1)
        elif (L1[userValue] == '-' or L1[userValue+1] == '-'):
                print("invalid choice you lose 1 move ")
                s1 = arrTostr(L1)            
        else:
                L1 = move(L1,userValue)
                s1 = arrTostr(L1)
        print(s1)

if (i == 5):
        if(s1 == 'HTHTHTHTHT--' or s1 == 'THTHTHTHTH--'):
                print("you got it!!! ")
        else:
                print("you fail to solve the problem ")
