#include "matlab.h"
      SUBROUTINE GETVAL(S)
      FLOAT S
C     FORM NUMERICAL VALUE
#include "common.h"
      S = F_0
   10 IF (CHAR .GT. 9) RETURN
      S = F_10*S + CHAR
      CALL GETCH
      GO TO 10
      END
