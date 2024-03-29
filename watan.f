#include "matlab.h"
      SUBROUTINE WATAN(XR,XI,YR,YI)
C     Y = ATAN(X) = (I/2)*LOG((I+X)/(I-X))
      FLOAT XR,XI,YR,YI,TR,TI
      IF (XI .NE. F_0) GO TO 10
         YR = DATAN2(XR,F_1)
         YI = F_0
         RETURN
   10 IF (XR.NE. F_0 .OR. DABS(XI).NE. F_1) GO TO 20
         CALL ERROR(32)
         RETURN
   20 CALL WDIV(XR,F_1+XI,-XR,F_1-XI,TR,TI)
      CALL WLOG(TR,TI,TR,TI)
      YR = -TI/F_2
      YI = TR/F_2
      RETURN
      END

                                          