#include "matlab.h"
      SUBROUTINE EXPR
      INTEGER OP,R,SIGN
      CHARACTER EYE(4)
#include "common.h"
      DATA EYE/14,34,14,36/
#ifdef USE_SAVE
      SAVE EYE
#endif
      IF (DDT .EQ. 1) WRITE(WTE,100) PT,RSTK(PT)
  100 FORMAT(1X,'EXPR  ',2I4)
      R = RSTK(PT)
      GO TO (01,01,01,01,01,05,25,99,99,01,01,99,99,99,99,99,99,01,01,
     $       01),R
   01 IF (SYM .EQ. COLON) CALL PUTID(SYN,EYE)
      IF (SYM .EQ. COLON) SYM = NAME
      KOUNT = 1
   02 SIGN = PLUS
      IF (SYM .EQ. MINUS) SIGN = MINUS
      IF (SYM.EQ.PLUS .OR. SYM.EQ.MINUS) CALL GETSYM
      PT = PT+1
      IF (PT .GT. PSIZE-1) CALL ERROR(26)
      IF (ERR .GT. 0) RETURN
      PSTK(PT) = SIGN + 256*KOUNT
      RSTK(PT) = 6
C     *CALL* TERM
      RETURN
   05 SIGN = MOD(PSTK(PT),256)
      KOUNT = PSTK(PT)/256
      PT = PT-1
      IF (SIGN .EQ. MINUS) CALL STACK1(MINUS)
      IF (ERR .GT. 0) RETURN
   10 IF (SYM.EQ.PLUS .OR. SYM.EQ.MINUS) GO TO 20
      GO TO 50
   20 IF (RSTK(PT) .NE. 10) GO TO 21
C     BLANK IS DELIMITER INSIDE ANGLE BRACKETS
      LS = LPT(3) - 2
      IF (LIN(LS) .EQ. BLANK) GO TO 50
   21 OP = SYM
      CALL GETSYM
      PT = PT+1
      PSTK(PT) = OP + 256*KOUNT
      RSTK(PT) = 7
C     *CALL* TERM
      RETURN
   25 OP = MOD(PSTK(PT),256)
      KOUNT = PSTK(PT)/256
      PT = PT-1
      CALL STACK2(OP)
      IF (ERR .GT. 0) RETURN
      GO TO 10
   50 IF (SYM .NE. COLON) GO TO 60
      CALL GETSYM
      KOUNT = KOUNT+1
      GO TO 02
   60 IF (KOUNT .GT. 3) CALL ERROR(33)
      IF (ERR .GT. 0) RETURN
      RHS = KOUNT
      IF (KOUNT .GT. 1) CALL STACK2(COLON)
      IF (ERR .GT. 0) RETURN
      RETURN
   99 CALL ERROR(22)
      IF (ERR .GT. 0) RETURN
      RETURN
      END

                                                                                 
