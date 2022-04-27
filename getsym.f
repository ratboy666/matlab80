#include "matlab.h"
      SUBROUTINE GETSYM
C     GET A SYMBOL
      FLOAT SYV,S
      INTEGER Z,D,E,SIGN,CHCNT
      INTEGER SS
#include "common.h"
#define Z 35
#define D 13
#define E 14
   10 IF (CHAR .NE. BLANK) GO TO 20
      CALL GETCH
      GO TO 10
   20 LPT(2) = LPT(3)
      LPT(3) = LPT(4)
      IF (CHAR .LE. 9) GO TO 50
      IF (CHAR .LE. Z) GO TO 30
C 
C     SPECIAL CHARACTER
      SS = SYM
      SYM = CHAR
      CALL GETCH
      IF (SYM .NE. DOT) GO TO 90
C 
C     IS DOT PART OF NUMBER OR OPERATOR
      SYV = F_0
      IF (CHAR .LE. 9) GO TO 55
      IF (CHAR.EQ.STAR .OR. CHAR.EQ.SLASH .OR. CHAR.EQ.BSLASH) GO TO 90
      IF (SS.EQ.STAR .OR. SS.EQ.SLASH .OR. SS.EQ.BSLASH) GO TO 90
      GO TO 55
C 
C     NAME
   30 SYM = NAME
      SYN(1) = CHAR
      CHCNT = 1
   40 CALL GETCH
      CHCNT = CHCNT+1
      IF (CHAR .GT. Z) GO TO 45
      IF (CHCNT .LE. 4) SYN(CHCNT) = CHAR
      GO TO 40
   45 IF (CHCNT .GT. 4) GO TO 47
      DO 46 I = CHCNT, 4
   46 SYN(I) = BLANK
   47 CONTINUE
      GO TO 90
C 
C     NUMBER
   50 CALL GETVAL(SYV)
      IF (CHAR .NE. DOT) GO TO 60
      CALL GETCH
   55 CHCNT = LPT(4)
      CALL GETVAL(S)
      CHCNT = LPT(4) - CHCNT
      IF (CHAR .EQ. EOL) CHCNT = CHCNT+1
      SYV = SYV + S/F_10**CHCNT
   60 IF (CHAR.NE.D .AND. CHAR.NE.E) GO TO 70
      CALL GETCH
      SIGN = CHAR
      IF (SIGN.EQ.MINUS .OR. SIGN.EQ.PLUS) CALL GETCH
      CALL GETVAL(S)
      IF (SIGN .NE. MINUS) SYV = SYV*F_10**S
      IF (SIGN .EQ. MINUS) SYV = SYV/F_10**S
   70 STKI(VSIZE) = FLOP(SYV)
      SYM = NUM
C 
   90 IF (CHAR .NE. BLANK) GO TO 99
      CALL GETCH
      GO TO 90
   99 IF (DDT .NE. 1) RETURN
      IF (SYM.GT.NAME .AND. SYM.LT.ALFL) WRITE(WTE,197) ALFA(SYM+1)
      IF (SYM .GE. ALFL) WRITE(WTE,198)
      IF (SYM .EQ. NAME) CALL PRNTID(SYN,1)
      IF (SYM .EQ. NUM) WRITE(WTE,199) SYV
  197 FORMAT(1X,A1)
  198 FORMAT(1X,'EOL')
  199 FORMAT(1X,G8.2)
      RETURN
      END
