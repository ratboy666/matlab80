#include "matlab.h"
      SUBROUTINE COMAND(ID)
      INTEGER ID(4)
      CHARACTER CBUF(256)
      INTEGER CMD(4,17),CH,H(4)
#include "common.h"
#define CMDL 17
#define A 10
#define D 13
#define E 14
#define Z 35
C
C       CLEAR ELSE  END   EXIT
C       FOR   HELP  IF    LONG
C       RETUR SEMI
C       SHORT WHAT  WHILE
C       WHO   WHY   LALA  FOO
C
      DATA CMD/
     $  12,21,14,10, 14,21,28,14, 14,23,13,36, 14,33,18,29,
     $  15,24,27,36, 17,14,21,25, 18,15,36,36, 21,24,23,16,
     $  27,14,29,30, 28,14,22,18,
     $  28,17,24,27, 32,17,10,29, 32,17,18,21,
     $  32,17,24,36, 32,17,34,36, 21,10,21,10, 15,30,12,20/
C
      ICHAR(I) = I
C
  101 FORMAT(80A1)
  102 FORMAT(1X,80A1)
C
      IF (DDT .EQ. 1) WRITE(WTE,100)
  100 FORMAT(1X,'COMAND')
      FUN = 0
      DO 10 K = 1, CMDL
C
C MICROSOFT FORTRAN ERROR WILL NOT COMPILE THE FOLLOWING LINE CORRECTLY
C
C     IF (EQID(CMD(1,K), ID)) GO TO 20
C
      IF (EQID(CMD(1,K), ID(1))) GO TO 20
   10 CONTINUE
      FIN = 0
      RETURN
C
   20 IF (CHAR.EQ. COMMA .OR. CHAR.EQ. SEMI .OR. CHAR.EQ. EOL) GO TO 22
      IF (CHAR.LE. Z .OR. K.EQ.6) GO TO 22
      CALL ERROR(16)
      RETURN
C
   22 FIN = 1
      GO TO (25,36,38,40,30,80,34,52,44,55,50,65,32,60,70,46,48),K
C
C     CLEAR
   25 IF (CHAR.GE. A .AND. CHAR.LE. Z) GO TO 26
      BOT = LSIZE-3
      GO TO 98
   26 CALL GETSYM
      TOP = TOP+1
      MSTK(TOP) = 0
      NSTK(TOP) = 0
      RHS = 0
      CALL STACKP(SYN)
      IF (ERR .GT. 0) RETURN
      FIN = 1
      GO TO 98
C
C     FOR, WHILE, IF, ELSE, END
   30 FIN = -11
      GO TO 99
   32 FIN = -12
      GO TO 99
   34 FIN = -13
      GO TO 99
   36 FIN = -14
      GO TO 99
   38 FIN = -15
      GO TO 99
C
C     EXIT
   40 IF (PT .GT. PTZ) FIN = -16
      IF (PT .GT. PTZ) GO TO 98
      K = IDINT(STKR(VSIZE-2))
      WRITE(WTE,140) K
      IF (WIO .NE. 0) WRITE(WIO,140) K
C MICROSOFT F80 DOESN'T LIKE /1X OR //
  140 FORMAT(/1X,'TOTAL FLOPS ',I9/,/1X,'ADIOS'/)
      FUN = 99
      GO TO 98
C
C     RETURN
   44 K = LPT(1) - 7
      IF (K .LE. 0) FUN = 99
      IF (K .LE. 0) GO TO 98
      CALL FILES(-RIO,BUF)
      LPT(1) = LIN(K+1)
      LPT(4) = LIN(K+2)
      LPT(6) = LIN(K+3)
      PTZ = LIN(K+4)
      RIO = LIN(K+5)
      LCT(4) = LIN(K+6)
      CHAR = BLANK
      SYM = COMMA
      GO TO 99
C
C     LALA
   46 WRITE(WTE,146)
  146 FORMAT(1X,'QUIT SINGING AND GET BACK TO WORK.')
      GO TO 98
C
C     FOO
   48 WRITE(WTE,148)
  148 FORMAT(1X,'YOUR PLACE OR MINE')
      GO TO 98
C
C     SHORT, LONG
   50 FMT = 1
      GO TO 54
   52 FMT = 2
   54 IF (CHAR.EQ.E .OR. CHAR.EQ.D) FMT = FMT+2
      IF (CHAR .EQ. Z) FMT = 5
      IF (CHAR.EQ.E .OR. CHAR.EQ.D .OR. CHAR.EQ.Z) CALL GETSYM
      GO TO 98
C
C     SEMI
   55 LCT(3) = 1 - LCT(3)
      GO TO 98
C
C     WHO
   60 WRITE(WTE,160)
      IF (WIO .NE. 0) WRITE(WIO,160)
  160 FORMAT(1X,'YOUR CURRENT VARIABLES ARE...')
      CALL PRNTID(IDSTK(1,BOT),LSIZE-BOT+1)
      L = VSIZE-LSTK(BOT)+1
      WRITE(WTE,161) L,VSIZE
      IF (WIO .NE. 0) WRITE(WIO,161) L,VSIZE
  161 FORMAT(1X,'USING ',I7,' OUT OF ',I7,' ELEMENTS.')
C
C       PRINT OUT THE MATRICES AVAILIABLE IN TOTAL2
C
C      CALL MATTOTDIR
      GO TO 98
C
C     WHAT
   65 WRITE(WTE,165)
  165 FORMAT(1X,'THE FUNCTIONS AND COMMANDS ARE...')
      H(1) = 0
      CALL FUNS(H)
      CALL PRNTID(CMD,CMDL-2)
      GO TO 98
C
C     WHY
   70 K = IDINT(9.0D0*URAND(RAN(1))+1.0D0)
      GO TO (71,72,73,74,75,76,77,78,79),K
   71 WRITE(WTE,171)
  171 FORMAT(1X,'WHAT?')
      GO TO 98
   72 WRITE(WTE,172)
  172 FORMAT(1X,'R.T.F.M.')
      GO TO 98
   73 WRITE(WTE,173)
  173 FORMAT(1X,'HOW DO YOU EXPECT ME TO KNOW?')
      GO TO 98
   74 WRITE(WTE,174)
  174 FORMAT(1X,'PETE MADE ME DO IT.')
      GO TO 98
   75 WRITE(WTE,175)
  175 FORMAT(1X,'INSUFFICIENT DATA TO ANSWER.')
      GO TO 98
   76 WRITE(WTE,176)
  176 FORMAT(1X,'IT FEELS GOOD.')
      GO TO 98
   77 WRITE(WTE,177)
  177 FORMAT(1X,'WHY NOT?')
      GO TO 98
   78 WRITE(WTE,178)
  178 FORMAT(1X,'/--ERROR'/1X,'STUPID QUESTION.')
      GO TO 98
   79 WRITE(WTE,179)
  179 FORMAT(1X,'SYSTEM ERROR, RETRY')
      GO TO 98
C
C     HELP
   80 IF (CHAR .NE. EOL) GO TO 81
      WRITE(WTE,180)
      IF (WIO .NE. 0) WRITE(WIO,180)
  180 FORMAT(1X,'TYPE HELP FOLLOWED BY ...'
     $  /1X,'INTRO   (TO GET STARTED)'
     $  /1X,'NEWS    (RECENT REVISIONS)')
      H(1) = 0
      CALL FUNS(H)
      CALL PRNTID(CMD,CMDL-2)
      J = BLANK+2
      WRITE(WTE,181)
      IF (WIO .NE. 0) WRITE(WIO,181)
  181 FORMAT(1X,'ANS   EDIT  FILE  FUN   MACRO')
      WRITE(WTE,182) (ALFA(I),I=J,ALFL)
      IF (WIO .NE. 0) WRITE(WIO,182) (ALFA(I),I=J,ALFL)
  182 FORMAT(1X,17(A1,1X)/)
      GO TO 98
C
   81 CALL GETSYM
      IF (SYM .EQ. NAME) GO TO 82
      IF (SYM .EQ. 0) SYM = DOT
      I = SYM + 1
      H(1) = ALFA(I)
      I = BLANK + 1
      H(2) = ALFA(I)
      H(3) = ALFA(I)
      H(4) = ALFA(I)
      GO TO 84
   82 DO 83 I = 1, 4
        CH = SYN(I)
        H(I) = ALFA(CH+1)
   83 CONTINUE
   84 READ(HIO,101,END=89) (CBUF(I),I=1,LRECL)
      DO 1112 I = 1,LRECL
         BUF(I) = ICHAR(CBUF(I))
 1112 CONTINUE
CDC.. IF (EOF(HIO).NE.0) GO TO 89
      DO 85 I = 1, 4
        IF (H(I) .NE. BUF(I)) GO TO 84
   85 CONTINUE
      WRITE(WTE,102)
      IF (WIO .NE. 0) WRITE(WIO,102)
   86 K = LRECL + 1
   87 K = K - 1
      I = BLANK + 1
      IF (BUF(K) .EQ. ALFA(I)) GO TO 87
      WRITE(WTE,102) (CBUF(I),I=1,K)
      IF (WIO .NE. 0) WRITE(WIO,102) (CBUF(I),I=1,K)
      READ(HIO,101) (CBUF(I),I=1,LRECL)
      DO 88 I = 1, LRECL
         BUF(I) = ICHAR(CBUF(I))
   88 CONTINUE
      I = BLANK + 1
      IF (BUF(1) .EQ. ALFA(I)) GO TO 86
      CALL FILES(-HIO,BUF)
      GO TO 98
C
   89 WRITE(WTE,189) (H(I),I=1,4)
  189 FORMAT(1X,'SORRY, NO HELP ON ',4A1)
      CALL FILES(-HIO,BUF)
      GO TO 98
C
   98 CALL GETSYM
   99 RETURN
      END
                        
