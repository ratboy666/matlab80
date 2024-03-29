#include "matlab.h"
      SUBROUTINE INITM(INIT)
C
C     INIT = 0 FOR ORDINARY FIRST ENTRY
C          = POSITIVE FOR SUBSEQUENT ENTRIES
C          = NEGATIVE FOR SILENT INITIALIZATION (SEE MATZ)
C
      FLOAT S,T
      CHARACTER EPS(4),FLOPS(4),EYE(4),RAND(4)
      CHARACTER ALPHA(52),ALPHB(52)
#include "common.h"
C
C     CHARACTER SET
C            0       10       20       30       40       50
C
C     0      0        A        K        U   COLON  :  LESS   <
C     1      1        B        L        V   PLUS   +  GREAT  >
C     2      2        C        M        W   MINUS  -
C     3      3        D        N        X   STAR   *
C     4      4        E        O        Y   SLASH  /
C     5      5        F        P        Z   BSLASH \
C     6      6        G        Q  BLANK     EQUAL  =
C     7      7        H        R  LPAREN (  DOT    .
C     8      8        I        S  RPAREN )  COMMA  ,
C     9      9        J        T  SEMI   ;  QUOTE  '
C
      DATA ALPHA /'0','1','2','3','4','5','6','7','8','9',
     $    'A','B','C','D','E','F','G','H','I','J',
     $    'K','L','M','N','O','P','Q','R','S','T',
     $    'U','V','W','X','Y','Z',' ','(',')',';',
     $    ':','+','-','*','/','\','=','.',',','''',
     $    '<','>'/
C
C     ALTERNATE CHARACTER SET
C
      DATA ALPHB /'0','1','2','3','4','5','6','7','8','9',
     $    'a','b','c','d','e','f','g','h','i','j',
     $    'k','l','m','n','o','p','q','r','s','t',
     $    'u','v','w','x','y','z',' ','(',')',';',
     $    '|','+','-','*','/','$','=','.',',','"',
     $    '[',']'/
C
      DATA EPS/14,25,28,36/,FLOPS/15,21,24,25/
      DATA EYE/14,34,14,36/,RAND/27,10,23,13/
C
#ifdef USE_SAVE
      SAVE ALPHA,ALPHB
      SAVE EPS,EYE,FLOPS,RAND
#endif
C
      ICHAR(I) = I
C
      IF (INIT .GT. 0) GO TO 90
C
C     RTE = UNIT NUMBER FOR TERMINAL INPUT
      RTE = 1
      CALL FILES(RTE,BUF)
      RIO = RTE
C
C     WTE = UNIT NUMBER FOR TERMINAL OUTPUT
      WTE = 1
      CALL FILES(WTE,BUF)
C
      WIO = 0
C
      IF (INIT .GE. 0) WRITE(WTE,100)
  100 FORMAT(/,1X,'     < M A T L A B >'
     $       /,1X,'   VERSION OF 05/25/82')
C
C     HIO = UNIT NUMBER FOR HELP FILE
      HIO = 9
      CALL FILES(HIO,BUF)
C
C     RANDOM NUMBER SEED
      RAN(1) = 0
C
C     INITIAL LINE LIMIT
      LCT(2) = 25
C
      ALFL = 52
      CASE = 0
C     CASE = 1 FOR FILE NAMES IN LOWER CASE
      DO 20 I = 1, ALFL
         ALFA(I) = ICHAR(ALPHA(I))
         ALFB(I) = ICHAR(ALPHB(I))
   20 CONTINUE
C
      VSIZE = N_SIZE
      LSIZE = 48
      PSIZE = 32
      BOT = LSIZE-3
      CALL WSET(5,F_0,F_0,STKR(VSIZE-4),STKI(VSIZE-4),1)
      CALL PUTID(IDSTK(1,LSIZE-3),EPS)
      LSTK(LSIZE-3) = VSIZE-4
      MSTK(LSIZE-3) = 1
      NSTK(LSIZE-3) = 1
      S = F_1
   30 S = S/F_2
      T = F_1 + S
      IF (T .GT. F_1) GO TO 30
      STKR(VSIZE-4) = F_2*S
      CALL PUTID(IDSTK(1,LSIZE-2),FLOPS)
      LSTK(LSIZE-2) = VSIZE-3
      MSTK(LSIZE-2) = 1
      NSTK(LSIZE-2) = 2
      CALL PUTID(IDSTK(1,LSIZE-1), EYE)
      LSTK(LSIZE-1) = VSIZE-1
      MSTK(LSIZE-1) = -1
      NSTK(LSIZE-1) = -1
      STKR(VSIZE-1) = F_1
      CALL PUTID(IDSTK(1,LSIZE), RAND)
      LSTK(LSIZE) = VSIZE
      MSTK(LSIZE) = 1
      NSTK(LSIZE) = 1
      FMT = 1
      FLP(1) = 0
      FLP(2) = 0
      DDT = 0
      DDT = 1
      RAN(2) = 0
      PTZ = 0
      PT = PTZ
      ERR = 0
      IF (INIT .LT. 0) RETURN
C
   90 RETURN
      END
              
