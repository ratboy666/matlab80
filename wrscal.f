#include "matlab.h"
      SUBROUTINE WRSCAL(N,S,XR,XI,INCX)
#include "funcs.h"
      FLOAT S,XR(1),XI(1)
      IF (N .LE. 0) RETURN
      IX = 1
      DO 10 I = 1, N
         XR(IX) = FLOP(S*XR(IX))
         IF (XI(IX) .NE. 0.0D0) XI(IX) = FLOP(S*XI(IX))
         IX = IX + INCX
   10 CONTINUE
      RETURN
      END
