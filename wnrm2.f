#include "matlab.h"
      FLOAT FUNCTION WNRM2(N,XR,XI,INCX)
#include "funcs.h"
      FLOAT XR(1),XI(1),S
C     NORM2(X)
      S = F_0
      IF (N .LE. 0) GO TO 20
      IX = 1
      DO 10 I = 1, N
         S = PYTHAG(S,XR(IX))
         S = PYTHAG(S,XI(IX))
         IX = IX + INCX
   10 CONTINUE
   20 WNRM2 = S
      RETURN
      END
                                            
