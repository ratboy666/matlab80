#include "matlab.h"
      SUBROUTINE PARSE
      INTEGER ID(4),EXCNT,PTS
      CHARACTER ANS(4),ENND(4),ELSE(4)
      INTEGER P,R
#include "common.h"
      DATA ANS/10,23,28,36/,ENND/14,23,13,36/,ELSE/14,21,28,14/
#ifdef USE_SAVE
      SAVE ANS,ENND,ELSE
#endif
C
   01 R = 0
      IF (ERR .GT. 0) PTZ = 0
      IF (ERR.LE.0 .AND. PT.GT.PTZ) R = RSTK(PT)
      IF (DDT .EQ. 1) WRITE(WTE,100) PT,R,PTZ,ERR
  100 FORMAT(1X,'PARSE ',4I4)
      IF (R.EQ.15) GO TO 93
      IF (R.EQ.16 .OR. R.EQ.17) GO TO 94
      SYM = EOL
      TOP = 0
      IF (RIO .NE. RTE) CALL FILES(-RIO,BUF)
      RIO = RTE
      LCT(3) = 0
      LCT(4) = 2
      LPT(1) = 1
   10 IF (SYM.EQ.EOL .AND. MOD(LCT(4)/2,2).EQ.1) CALL PROMPT(LCT(4)/4)
      IF (SYM .EQ. EOL) CALL GETLIN
      ERR = 0
      PT = PTZ
   15 EXCNT = 0
      IF (DDT .EQ. 1) WRITE(WTE,115) PT,TOP
  115 FORMAT(1X,'STATE ',2I4)
      LHS = 1
      CALL PUTID(ID,ANS)
      CALL GETSYM
      IF (SYM.EQ.COLON .AND. CHAR.EQ.EOL) DDT = 1-DDT
      IF (SYM .EQ. COLON) CALL GETSYM
      IF (SYM.EQ.SEMI .OR. SYM.EQ.COMMA .OR. SYM.EQ.EOL) GO TO 80
      IF (SYM .EQ. NAME) GO TO 20
      IF (SYM .EQ. LESS) GO TO 40
      IF (SYM .EQ. GREAT) GO TO 45
      GO TO 50
C 
C     LHS BEGINS WITH NAME
   20 CAll COMAND(SYN)
      IF (ERR .GT. 0) GO TO 01
      IF (FUN .EQ. 99) GO TO 95
      IF (FIN .EQ. -15) GO TO 80
      IF (FIN .LT. 0) GO TO 91
      IF (FIN .GT. 0) GO TO 70
C     IF NAME IS A FUNCTION, MUST BE RHS
      RHS = 0
      CALL FUNS(SYN)
      IF (FIN .NE. 0) GO TO 50
C     PEEK ONE CHARACTER AHEAD
      IF (CHAR.EQ.SEMI .OR. CHAR.EQ.COMMA .OR. CHAR.EQ.EOL)
     $      CALL PUTID(ID,SYN)
      IF (CHAR .EQ. EQUAL) GO TO 25
      IF (CHAR .EQ. LPAREN) GO TO 30
      GO TO 50
C 
C     LHS IS SIMPLE VARIABLE
   25 CALL PUTID(ID,SYN)
      CALL GETSYM
      CALL GETSYM
      GO TO 50
C 
C     LHS IS NAME(...)
   30 LPT(5) = LPT(4)
      CALL PUTID(ID,SYN)
      CALL GETSYM
   32 CALL GETSYM
      EXCNT = EXCNT+1
      PT = PT+1
      CALL PUTID(IDS(1,PT), ID)
      PSTK(PT) = EXCNT
      RSTK(PT) = 1
C     *CALL* EXPR
      GO TO 92
   35 CALL PUTID(ID,IDS(1,PT))
      EXCNT = PSTK(PT)
      PT = PT-1
      IF (SYM .EQ. COMMA) GO TO 32
      IF (SYM .NE. RPAREN) CALL ERROR(3)
      IF (ERR .GT. 0) GO TO 01
      IF (ERR .GT. 0) RETURN
      IF (SYM .EQ. RPAREN) CALL GETSYM
      IF (SYM .EQ. EQUAL) GO TO 50
C     LHS IS REALLY RHS, FORGET SCAN JUST DONE
      TOP = TOP - EXCNT
      LPT(4) = LPT(5)
      CHAR = LPAREN
      SYM = NAME
      CALL PUTID(SYN,ID)
      CALL PUTID(ID,ANS)
      EXCNT = 0
      GO TO 50
C 
C     MULTIPLE LHS
   40 LPT(5) = LPT(4)
      PTS = PT
      CALL GETSYM
   41 IF (SYM .NE. NAME) GO TO 43
      CALL PUTID(ID,SYN)
      CALL GETSYM
      IF (SYM .EQ. GREAT) GO TO 42
      IF (SYM .EQ. COMMA) CALL GETSYM
      PT = PT+1
      LHS = LHS+1
      PSTK(PT) = 0
      CALL PUTID(IDS(1,PT),ID)
      GO TO 41
   42 CALL GETSYM
      IF (SYM .EQ. EQUAL) GO TO 50
   43 LPT(4) = LPT(5)
      PT = PTS
      LHS = 1
      SYM = LESS
      CHAR = LPT(4)-1
      CHAR = LIN(CHAR)
      CALL PUTID(ID,ANS)
      GO TO 50
C 
C     MACRO STRING
   45 CALL GETSYM
      IF (DDT .EQ. 1) WRITE(WTE,145) PT,TOP
  145 FORMAT(1X,'MACRO ',2I4)
      IF (SYM.EQ.LESS .AND. CHAR.EQ.EOL) CALL ERROR(28)
      IF (ERR .GT. 0) GO TO 01
      PT = PT+1
      RSTK(PT) = 20
C     *CALL* EXPR
      GO TO 92
   46 PT = PT-1
      IF (SYM.NE.LESS .AND. SYM.NE.EOL) CALL ERROR(37)
      IF (ERR .GT. 0) GO TO 01
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
      DO 48 J = 1, N
         LS = L + J-1
         LIN(K) = IDINT(STKR(LS))
         IF (LIN(K).LT.0 .OR. LIN(K).GE.ALFL) CALL ERROR(37)
         IF (ERR .GT. 0) RETURN
         IF (K.LT. MAX_LINE) K = K+1
         IF (K.EQ. MAX_LINE) WRITE(WTE,47) K
   47    FORMAT(1X,'INPUT BUFFER LIMIT IS ',I4,' CHARACTERS.')
   48 CONTINUE
      TOP = TOP-1
      LIN(K) = EOL
      LPT(6) = K
      LPT(4) = LPT(1)
      LPT(3) = 0
      LPT(2) = 0
      LCT(1) = 0
      CHAR = BLANK
      PT = PT+1
      PSTK(PT) = LPT(1)
      RSTK(PT) = 21
C     *CALL* PARSE
      GO TO 15
   49 PT = PT-1
      IF (DDT .EQ. 1) WRITE(WTE,149) PT,TOP
  149 FORMAT(1X,'MACEND',2I4)
      K = LPT(1) - 4
      LPT(1) = LIN(K+1)
      LPT(4) = LIN(K+2)
      LPT(6) = LIN(K+3)
      CHAR = BLANK
      CALL GETSYM
      GO TO 80
C 
C     LHS FINISHED, START RHS
   50 IF (SYM .EQ. EQUAL) CALL GETSYM
      PT = PT+1
      CALL PUTID(IDS(1,PT),ID)
      PSTK(PT) = EXCNT
      RSTK(PT) = 2
C     *CALL* EXPR
      GO TO 92
   55 IF (SYM.EQ.SEMI .OR. SYM.EQ.COMMA .OR. SYM.EQ.EOL) GO TO 60
      IF (SYM.EQ.NAME .AND. EQID(SYN,ELSE)) GO TO 60
      IF (SYM.EQ.NAME .AND. EQID(SYN,ENND)) GO TO 60
      CALL ERROR(40)
      IF (ERR .GT. 0) GO TO 01
C 
C     STORE RESULTS
   60 RHS = PSTK(PT)
      CALL STACKP(IDS(1,PT))
      IF (ERR .GT. 0) GO TO 01
      PT = PT-1
      LHS = LHS-1
      IF (LHS .GT. 0) GO TO 60
      GO TO 70
C 
C     UPDATE AND POSSIBLY PRINT OPERATION COUNTS
   70 K = FLP(1)
      IF (K .NE. 0) STKR(VSIZE-3) = DBLE(K)
      STKR(VSIZE-2) = STKR(VSIZE-2) + DBLE(K)
      FLP(1) = 0
      IF (.NOT.(CHAR.EQ.COMMA .OR. (SYM.EQ.COMMA .AND. CHAR.EQ.EOL)))
     $       GO TO 80
      CALL GETSYM
      I5 = 10**5
      LUNIT = WTE
   71 IF (K .EQ. 0) WRITE(LUNIT,171)
  171 FORMAT(/1X,'   NO FLOPS')
      IF (K .EQ. 1) WRITE(LUNIT,172)
  172 FORMAT(/1X,'    1 FLOP')
      IF (1.LT.K .AND. K.LT.100000) WRITE(LUNIT,173) K
  173 FORMAT(/1X,I5,' FLOPS')
      IF (100000 .LE. K) WRITE(LUNIT,174) K
  174 FORMAT(/1X,I9,' FLOPS')
      IF (LUNIT.EQ.WIO .OR. WIO.EQ.0) GO TO 80
      LUNIT = WIO
      GO TO 71
C 
C     FINISH STATEMENT
   80 FIN = 0
      P = 0
      R = 0
      IF (PT .GT. 0) P = PSTK(PT)
      IF (PT .GT. 0) R = RSTK(PT)
      IF (DDT .EQ. 1) WRITE(WTE,180) PT,PTZ,P,R,LPT(1)
  180 FORMAT(1X,'FINISH',5I4)
      IF (SYM.EQ.COMMA .OR. SYM.EQ.SEMI) GO TO 15
      IF (R.EQ.21 .AND. P.EQ.LPT(1)) GO TO 49
      IF (PT .GT. PTZ) GO TO 91
      GO TO 10
C 
C     SIMULATE RECURSION
   91 CALL CLAUSE
      IF (ERR .GT. 0) GO TO 01
      IF (PT .LE. PTZ) GO TO 15
      R = RSTK(PT)
      IF (R .EQ. 21) GO TO 49
      GO TO (99,99,92,92,92,99,99,99,99,99,99,99,15,15,99,99,99,99,99),R
C 
   92 CALL EXPR
      IF (ERR .GT. 0) GO TO 01
      R = RSTK(PT)
      GO TO (35,55,91,91,91,93,93,99,99,94,94,99,99,99,99,99,99,94,94,
     $       46),R
C 
   93 CALL TERM
      IF (ERR .GT. 0) GO TO 01
      R = RSTK(PT)
      GO TO (99,99,99,99,99,92,92,94,94,99,99,99,99,99,95,99,99,99,99),R
C 
C  94 CALL FACTORM
   94 CALL FACTOR
      IF (ERR .GT. 0) GO TO 01
      R = RSTK(PT)
      GO TO (99,99,99,99,99,99,99,93,93,92,92,94,99,99,99,95,95,92,92),R
C 
C     CALL MATFNS BY RETURNING TO MATLAB
   95 IF (FIN.GT.0 .AND. MSTK(TOP).LT.0) CALL ERROR(14)
      IF (ERR .GT. 0) GO TO 01
      RETURN
C 
   99 CALL ERROR(22)
      GO TO 01
      END

