#include "matlab.h"
      SUBROUTINE GETLIN
C     GET A NEW LINE
      CHARACTER RETU(4)
#include "common.h"
      DATA RETU/27,14,29,30/
#ifdef USE_SAVE
      SAVE RETU
#endif
C
      ICHAR(I) = I
C
   10 L = LPT(1)
   11 DO 12 J = 1, LRECL
         I = BLANK + 1
         BUF(J) = ALFA(I)
   12 CONTINUE
      DO 97 I=1,LRECL
   97   BUF(I)=' '
      READ(RIO,101,END=50,ERR=15) (BUF(J),J=1,LRECL)
CDC.. IF (EOF(RIO).NE.0) GO TO 50
  101 FORMAT(80A1)
C     DO 13 J = 1,LRECL
C        BUF(J) = ICHAR(CBUF(J))
C  13 CONTINUE
      N = LRECL+1
   15 N = N-1
      I = BLANK + 1
      IF (BUF(N) .EQ. ALFA(I)) GO TO 15
      IF (MOD(LCT(4),2) .EQ. 1) WRITE(WTE,102) (BUF(J),J=1,N)
      IF (WIO .NE. 0) WRITE(WIO,102) (BUF(J),J=1,N)
  102 FORMAT(1X,80A1)
C
      DO 40 J = 1, N
         DO 20 K = 1, ALFL
           IF (BUF(J).EQ.ALFA(K) .OR. BUF(J).EQ.ALFB(K)) GO TO 30
   20    CONTINUE
         K = EOL+1
         CALL XCHAR(BUF(J),K)
         IF (K .GT. EOL) GO TO 10
         IF (K .EQ. EOL) GO TO 45
         IF (K .EQ. -1) L = L-1
         IF (K .LE. 0) GO TO 40
C
   30    K = K-1
         IF (K.EQ.SLASH .AND. BUF(J+1).EQ.BUF(J)) GO TO 45
         IF (K.EQ.DOT .AND. BUF(J+1).EQ.BUF(J)) GO TO 11
         IF (K.EQ.BSLASH .AND. N.EQ.1) GO TO 60
         LIN(L) = K
         IF (L.LT. MAX_LINE) L = L+1
         IF (L.EQ. MAX_LINE) WRITE(WTE,33) L
   33    FORMAT(1X,'INPUT BUFFER LIMIT IS ',I4,' CHARACTERS.')
   40 CONTINUE
   45 LIN(L) = EOL
      LPT(6) = L
      LPT(4) = LPT(1)
      LPT(3) = 0
      LPT(2) = 0
      LCT(1) = 0
      CALL GETCH
      RETURN
C
   50 IF (RIO .EQ. RTE) GO TO 52
      CALL PUTID(LIN(L),RETU)
      L = L + 4
      GO TO 45
   52 CALL FILES(-RTE,BUF)
      LIN(L) = EOL
      RETURN
C
   60 N = LPT(6) - LPT(1)
      DO 61 I = 1, N
         J = L+I-1
         K = LIN(J)
         BUF(I) = ALFA(K+1)
         IF (CASE.EQ.1 .AND. K.LT.36) BUF(I) = ALFB(K+1)
   61 CONTINUE
      CALL EDIT(BUF,N)
      N = N + 1
      GO TO 15
      END
     
