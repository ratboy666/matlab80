#include "matlab.h"
      FLOAT FUNCTION WDOTCI(N,XR,XI,INCX,YR,YI,INCY)
      FLOAT XR(1),XI(1),YR(1),YI(1),S,FLOP
      S = F_0
      IF (N .LE. 0) GO TO 20
      IX = 1
      IY = 1
      IF (INCX.LT.0) IX = (-N+1)*INCX + 1
      IF (INCY.LT.0) IY = (-N+1)*INCY + 1
      DO 10 I = 1, N
         S = S + XR(IX)*YI(IY) - XI(IX)*YR(IY)
         IF (S .NE. F_0) S = FLOP(S)
         IX = IX + INCX
         IY = IY + INCY
   10 CONTINUE
   20 WDOTCI = S
      RETURN
      END


            