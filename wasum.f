#include "matlab.h"
      FLOAT FUNCTION WASUM(N,XR,XI,INCX)
      FLOAT XR(1),XI(1),S,FLOP
C     NORM1(X)
      S = F_0
      IF (N .LE. 0) GO TO 20
      IX = 1
      DO 10 I = 1, N
         S = FLOP(S + DABS(XR(IX)) + DABS(XI(IX)))
         IX = IX + INCX
   10 CONTINUE
   20 WASUM = S
      RETURN
      END
                                                        