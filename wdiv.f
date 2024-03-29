#include "matlab.h"
      SUBROUTINE WDIV(AR,AI,BR,BI,CR,CI)
      FLOAT AR,AI,BR,BI,CR,CI
C     C = A/B
      FLOAT S,D,ARS,AIS,BRS,BIS,FLOP
      S = DABS(BR) + DABS(BI)
      IF (S .EQ. F_0) CALL ERROR(27)
      IF (S .EQ. F_0) RETURN
      ARS = AR/S
      AIS = AI/S
      BRS = BR/S
      BIS = BI/S
      D = BRS**2 + BIS**2
      CR = FLOP((ARS*BRS + AIS*BIS)/D)
      CI = (AIS*BRS - ARS*BIS)/D
      IF (CI .NE. 0.0D0) CI = FLOP(CI)
      RETURN
      END

                         