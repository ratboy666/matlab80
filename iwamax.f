#include "matlab.h"
      INTEGER FUNCTION IWAMAX(N,XR,XI,INCX)
      FLOAT XR(1),XI(1),S,P
C     INDEX OF NORMINF(X)
      K = 0
      IF (N .LE. 0) GO TO 20
      K = 1
      S = F_0
      IX = 1
      DO 10 I = 1, N
         P = DABS(XR(IX)) + DABS(XI(IX))
         IF (P .GT. S) K = I
         IF (P .GT. S) S = P
         IX = IX + INCX
   10 CONTINUE
   20 IWAMAX = K
      RETURN
      END
                                                                                                