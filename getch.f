#include "matlab.h"
      SUBROUTINE GETCH
C     GET NEXT CHARACTER
#include "common.h"
      L = LPT(4)
      CHAR = LIN(L)
      IF (CHAR .NE. EOL) LPT(4) = L + 1
      RETURN
      END
