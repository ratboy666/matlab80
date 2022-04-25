#include "matlab.h"
      SUBROUTINE WSQRT(XR,XI,YR,YI)
#include "funcs.h"
      FLOAT XR,XI,YR,YI,S,TR,TI
C     Y = SQRT(X) WITH YR .GE. 0.0 AND SIGN(YI) .EQ. SIGN(XI)
C 
      TR = XR
      TI = XI
      S = DSQRT(F_0P5*(PYTHAG(TR,TI) + DABS(TR)))
      IF (TR .GE. F_0) YR = FLOP(S)
      IF (TI .LT. F_0) S = -S
      IF (TR .LE. F_0) YI = FLOP(S)
      IF (TR .LT. F_0) YR = FLOP(F_0P5*(TI/YI))
      IF (TR .GT. F_0) YI = FLOP(F_0P5*(TI/YR))
      RETURN
      END
