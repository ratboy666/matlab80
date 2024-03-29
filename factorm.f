#include "matlab.h"
      SUBROUTINE FACTOR
      INTEGER R,ID(4),EXCNT
#include "common.h"
      IF (DDT .EQ. 1) WRITE(WTE,100) PT,RSTK(PT),SYM
  100 FORMAT(1X,'FACTOR',3I4)
      R = RSTK(PT)
      GO TO (99,99,99,99,99,99,99,01,01,25,45,65,99,99,99,55,75,32,37),R
   01 IF (SYM.EQ.NUM .OR. SYM.EQ.QUOTE .OR.  SYM.EQ.LESS) GO TO 10
      IF (SYM .EQ. GREAT) GO TO 30
      EXCNT = 0
      IF (SYM .EQ. NAME) GO TO 40
      ID(1) = BLANK
      IF (SYM .EQ. LPAREN) GO TO 42
      CALL ERROR(2)
      IF (ERR .GT. 0) RETURN
C 
C     PUT SOMETHING ON THE STACK
   10 L = 1
      IF (TOP .GT. 0) L = LSTK(TOP) + MSTK(TOP)*NSTK(TOP)
      IF (TOP+1 .GE. BOT) CALL ERROR(18)
      IF (ERR .GT. 0) RETURN
      TOP = TOP+1
      LSTK(TOP) = L
      IF (SYM .EQ. QUOTE) GO TO 15
      IF (SYM .EQ. LESS) GO TO 20
C 
C     SINGLE NUMBER, GETSYM STORED IT IN STKI
      MSTK(TOP) = 1
      NSTK(TOP) = 1
      STKR(L) = STKI(VSIZE)
      STKI(L) = F_0
      CALL GETSYM
      GO TO 60
C 
C     STRING
   15 N = 0
      LPT(4) = LPT(3)
      CALL GETCH
   16 IF (CHAR .EQ. QUOTE) GO TO 18
   17 LN = L+N
      IF (CHAR .EQ. EOL) CALL ERROR(31)
      IF (ERR .GT. 0) RETURN
      STKR(LN) = DBLE(CHAR)
      STKI(LN) = F_0
      N = N+1
      CALL GETCH
      GO TO 16
   18 CALL GETCH
      IF (CHAR .EQ. QUOTE) GO TO 17
      IF (N .LE. 0) CALL ERROR(31)
      IF (ERR .GT. 0) RETURN
      MSTK(TOP) = 1
      NSTK(TOP) = N
      CALL GETSYM
      GO TO 60
C 
C     EXPLICIT MATRIX
   20 MSTK(TOP) = 0
      NSTK(TOP) = 0
   21 TOP = TOP + 1
      LSTK(TOP) = LSTK(TOP-1) + MSTK(TOP-1)*NSTK(TOP-1)
      MSTK(TOP) = 0
      NSTK(TOP) = 0
      CALL GETSYM
   22 IF (SYM.EQ.SEMI .OR. SYM.EQ.GREAT .OR. SYM.EQ.EOL) GO TO 27
      IF (SYM .EQ. COMMA) CALL GETSYM
      PT = PT+1
      RSTK(PT) = 10
C     *CALL* EXPR
      RETURN
   25 PT = PT-1
      TOP = TOP - 1
      IF (MSTK(TOP) .EQ. 0) MSTK(TOP) = MSTK(TOP+1)
      IF (MSTK(TOP) .NE. MSTK(TOP+1)) CALL ERROR(5)
      IF (ERR .GT. 0) RETURN
      NSTK(TOP) = NSTK(TOP) + NSTK(TOP+1)
      GO TO 22
   27 IF (SYM.EQ.SEMI .AND. CHAR.EQ.EOL) CALL GETSYM
      CALL STACK1(QUOTE)
      IF (ERR .GT. 0) RETURN
      TOP = TOP - 1
      IF (MSTK(TOP) .EQ. 0) MSTK(TOP) = MSTK(TOP+1)
      IF (MSTK(TOP).NE.MSTK(TOP+1) .AND. MSTK(TOP+1).GT.0) CALL ERROR(6)
      IF (ERR .GT. 0) RETURN
      NSTK(TOP) = NSTK(TOP) + NSTK(TOP+1)
      IF (SYM .EQ. EOL) CALL GETLIN
      IF (SYM .NE. GREAT) GO TO 21
      CALL STACK1(QUOTE)
      IF (ERR .GT. 0) RETURN
      CALL GETSYM
      GO TO 60
C 
C     MACRO STRING
   30 CALL GETSYM
      IF (SYM.EQ.LESS .AND. CHAR.EQ.EOL) CALL ERROR(28)
      IF (ERR .GT. 0) RETURN
      PT = PT+1
      RSTK(PT) = 18
C     *CALL* EXPR
      RETURN
   32 PT = PT-1
      IF (SYM.NE.LESS .AND. SYM.NE.EOL) CALL ERROR(37)
      IF (ERR .GT. 0) RETURN
      IF (SYM .EQ. LESS) CALL GETSYM
      K = LPT(6)
      LIN(K+1) = LPT(1)
      LIN(K+2) = LPT(2)
      LIN(K+3) = LPT(6)
      LPT(1) = K + 4
C     TRANSFER STACK TO INPUT LINE
      K = LPT(1)
      L = LSTK(TOP)
      N = MSTK(TOP)*NSTK(TOP)
      DO 34 J = 1, N
         LS = L + J-1
         LIN(K) = IDINT(STKR(LS))
         IF (LIN(K).LT.0 .OR. LIN(K).GE.ALFL) CALL ERROR(37)
         IF (ERR .GT. 0) RETURN
         IF (K.LT. MAX_LINE) K = K+1
         IF (K.EQ. MAX_LINE) WRITE(WTE,33) K
   33    FORMAT(1X,'INPUT BUFFER LIMIT IS ',I4,' CHARACTERS.')
   34 CONTINUE
      TOP = TOP-1
      LIN(K) = EOL
      LPT(6) = K
      LPT(4) = LPT(1)
      LPT(3) = 0
      LPT(2) = 0
      LCT(1) = 0
      CHAR = BLANK
      CALL GETSYM
      PT = PT+1
      RSTK(PT) = 19
C     *CALL* EXPR
      RETURN
   37 PT = PT-1
      K = LPT(1) - 4
      LPT(1) = LIN(K+1)
      LPT(4) = LIN(K+2)
      LPT(6) = LIN(K+3)
      CHAR = BLANK
      CALL GETSYM
      GO TO 60
C 
C     FUNCTION OR MATRIX ELEMENT
   40 CALL PUTID(ID,SYN)
      CALL GETSYM
      IF (SYM .EQ. LPAREN) GO TO 42
      RHS = 0
      CALL FUNS(ID)
      IF (FIN .NE. 0) CALL ERROR(25)
      IF (ERR .GT. 0) RETURN
      CALL STACKG(ID)
      IF (ERR .GT. 0) RETURN
      IF (FIN .EQ. 7) GO TO 50
      IF (FIN .EQ. 0) CALL PUTID(IDS(1,PT+1),ID)
      IF (FIN .EQ. 0) CALL ERROR(4)
      IF (ERR .GT. 0) RETURN
      GO TO 60
C 
   42 CALL GETSYM
      EXCNT = EXCNT+1
      PT = PT+1
      PSTK(PT) = EXCNT
      CALL PUTID(IDS(1,PT),ID)
      RSTK(PT) = 11
C     *CALL* EXPR
      RETURN
   45 CALL PUTID(ID,IDS(1,PT))
      EXCNT = PSTK(PT)
      PT = PT-1
      IF (SYM .EQ. COMMA) GO TO 42
      IF (SYM .NE. RPAREN) CALL ERROR(3)
      IF (ERR .GT. 0) RETURN
      IF (SYM .EQ. RPAREN) CALL GETSYM
      IF (ID(1) .EQ. BLANK) GO TO 60
      RHS = EXCNT
      CALL STACKG(ID)
      IF (ERR .GT. 0) RETURN
      IF (FIN .EQ. 0) CALL FUNS(ID)
      IF (FIN .EQ. 0) CALL ERROR(4)
      IF (ERR .GT. 0) RETURN
C 
C     EVALUATE MATRIX FUNCTION
   50 PT = PT+1
      RSTK(PT) = 16
C     *CALL* MATFN
      RETURN
   55 PT = PT-1
      GO TO 60
C 
C     CHECK FOR QUOTE (TRANSPOSE) AND ** (POWER)
   60 IF (SYM .NE. QUOTE) GO TO 62
         I = LPT(3) - 2
         IF (LIN(I) .EQ. BLANK) GO TO 90
         CALL STACK1(QUOTE)
         IF (ERR .GT. 0) RETURN
         CALL GETSYM
   62 IF (SYM.NE.STAR .OR. CHAR.NE.STAR) GO TO 90
      CALL GETSYM
      CALL GETSYM
      PT = PT+1
      RSTK(PT) = 12
C     *CALL* FACTORM
      GO TO 01
   65 PT = PT-1
      CALL STACK2(DSTAR)
      IF (ERR .GT. 0) RETURN
      IF (FUN .NE. 2) GO TO 90
C     MATRIX POWER, USE EIGENVECTORS
      PT = PT+1
      RSTK(PT) = 17
C     *CALL* MATFN
      RETURN
   75 PT = PT-1
   90 RETURN
   99 CALL ERROR(22)
      IF (ERR .GT. 0) RETURN
      RETURN
      END

                                                                              
