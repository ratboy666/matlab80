#include "matlab.h"
      SUBROUTINE PRNTID(ID,ARGCNT)
C     PRINT VARIABLE NAMES
      CHARACTER ID(4,1)
      INTEGER ARGCNT
#include "common.h"
      J1 = 1
   10 J2 = MIN0(J1+7,IABS(ARGCNT))
      L = 0
      DO 15 J = J1,J2
      DO 15 I = 1, 4
      K = ID(I,J)+1
      L = L+1
      BUF(L) = ALFA(K)
   15 CONTINUE
      IF (ARGCNT .EQ. -1) L=L+1
      I = EQUAL + 1
      IF (ARGCNT .EQ. -1) BUF(L) = ALFA(I)
      WRITE(WTE,20) (BUF(I),I=1,L)
      IF (WIO .NE. 0) WRITE(WIO,20) (BUF(I),I=1,L)
   20 FORMAT(1X,8(4A1,2H  ))
      J1 = J1+8
      IF (J1 .LE. IABS(ARGCNT)) GO TO 10
      RETURN
      END

                             
