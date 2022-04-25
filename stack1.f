#include "matlab.h"
      SUBROUTINE STACK1(OP)
      INTEGER OP
C 
C     UNARY OPERATIONS
C
#include "common.h" 
      IF (DDT .EQ. 1) WRITE(WTE,100) OP
  100 FORMAT(1X,'STACK1',I4)
      L = LSTK(TOP)
      M = MSTK(TOP)
      N = NSTK(TOP)
      MN = M*N
      IF (MN .EQ. 0) GO TO 99
      IF (OP .EQ. QUOTE) GO TO 30
C 
C     UNARY MINUS
      CALL WRSCAL(MN,-1.0D0,STKR(L),STKI(L),1)
      GO TO 99
C 
C     TRANSPOSE
   30 LL = L + MN
      ERR = LL+MN - LSTK(BOT)
      IF (ERR .GT. 0) CALL ERROR(17)
      IF (ERR .GT. 0) RETURN
      CALL WCOPY(MN,STKR(L),STKI(L),1,STKR(LL),STKI(LL),1)
      M = NSTK(TOP)
      N = MSTK(TOP)
      MSTK(TOP) = M
      NSTK(TOP) = N
      DO 50 I = 1, M
      DO 50 J = 1, N
        LS = L+MN+(J-1)+(I-1)*N
        LL = L+(I-1)+(J-1)*M
        STKR(LL) = STKR(LS)
        STKI(LL) = -STKI(LS)
   50 CONTINUE
      GO TO 99
   99 RETURN
      END
