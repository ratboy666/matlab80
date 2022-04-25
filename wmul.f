#include "matlab.h"
      SUBROUTINE WMUL(AR,AI,BR,BI,CR,CI)
      FLOAT AR,AI,BR,BI,CR,CI,T,FLOP
C     C = A*B
      T = AR*BI + AI*BR
      IF (T .NE. F_0) T = FLOP(T)
      CR = FLOP(AR*BR - AI*BI)
      CI = T
      RETURN
      END

      