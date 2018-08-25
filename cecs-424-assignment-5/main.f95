       PROGRAM SORTNSEARCH
       REAL t, X(20), A
       A = 0


       WRITE(*,*) 'PLEASE ENTER THE LIST OF 20 NUMBER'
       READ(*,*) (X(I), I = 1,20)

 25    WRITE(*,*) 'PLEASE ENTER THE NUMBER YOU WANT TO SEARCH'
       READ(*,*) t

       DO 15, I = 1, 20
          IF (X(I) .EQ. t) THEN
             GO TO 500
          END IF

 15    CONTINUE

       GO TO 1000

 500   WRITE(*,*) 'WE FOUND target'
          GO TO 1500

 1000  WRITE(*,*) 'target is not in list please enter another target'
          GO TO 25

 1500  WRITE(*,*) 'PROGRAM END HERE'
       END program
