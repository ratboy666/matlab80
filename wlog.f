#include "matlab.h"
      SUBROUTINE WLOG(XR,XI,YR,YI)
      FLOAT XR,XI,YR,YI,T,R,PYTHAG
C     Y = LOG(X)
      R = PYTHAG(XR,XI)
      IF (R .EQ. F_0) CALL ERROR(32)
      IF (R .EQ. F_0) RETURN
      T = DATAN2(XI,XR)
      IF (XI.EQ. F_0 .AND. XR.LT. F_0) T = DABS(T)
      YR = DLOG(R)
      YI = T
      RETURN
      END

                                         