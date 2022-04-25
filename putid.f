#include "matlab.h"
      SUBROUTINE PUTID(X,Y)
C     STORE A NAME
      CHARACTER X(4),Y(4)
      BYTE I
      DO 10 I=1, 4
   10   X(I) = Y(I)
      RETURN
      END
