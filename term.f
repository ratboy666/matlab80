#include "matlab.h"
      SUBROUTINE TERM
      INTEGER R,OP
#include "common.h"
      IF (DDT .EQ. 1) WRITE(WTE,100) PT,RSTK(PT)
  100 FORMAT(1X,'TERM  ',2I4)
      R = RSTK(PT)
      GO TO (99,99,99,99,99,01,01,05,25,99,99,99,99,99,35,99,99,99,99),R
   01 PT = PT+1
      RSTK(PT) = 8
C     *CALL* FACTORM
      RETURN
   05 PT = PT-1
   10 OP = 0
      IF (SYM .EQ. DOT) OP = DOT
      IF (SYM .EQ. DOT) CALL GETSYM
      IF (SYM.EQ.STAR .OR. SYM.EQ.SLASH .OR. SYM.EQ.BSLASH) GO TO 20
      RETURN
   20 OP = OP + SYM
      CALL GETSYM
      IF (SYM .EQ. DOT) OP = OP + SYM
      IF (SYM .EQ. DOT) CALL GETSYM
      PT = PT+1
      PSTK(PT) = OP
      RSTK(PT) = 9
C     *CALL* FACTORM
      RETURN
   25 OP = PSTK(PT)
      PT = PT-1
      CALL STACK2(OP)
      IF (ERR .GT. 0) RETURN
C     SOME BINARY OPS DONE IN MATFNS
      IF (FUN .EQ. 0) GO TO 10
      PT = PT+1
      RSTK(PT) = 15
C     *CALL* MATFN
      RETURN
   35 PT = PT-1
      GO TO 10
   99 CALL ERROR(22)
      IF (ERR .GT. 0) RETURN
      RETURN
      END

            
