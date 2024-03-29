#include "matlab.h"
      FLOAT FUNCTION PYTHAG(A,B)
      FLOAT A,B
      CHARACTER LIN(MAX_LINE)
      INTEGER DDT,ERR,FMT,LCT(4),LPT(6),HIO,RIO,WIO,RTE,WTE
      FLOAT P,Q,R,S,T
      COMMON /IOP/ DDT,ERR,FMT,LCT,LIN,LPT,HIO,RIO,WIO,RTE,WTE
      P = DMAX1(DABS(A),DABS(B))
      Q = DMIN1(DABS(A),DABS(B))
      IF (Q .EQ. F_0) GO TO 20
      IF (DDT .EQ. 25) WRITE(WTE,1)
      IF (DDT .EQ. 25) WRITE(WTE,2) P,Q
    1 FORMAT(1X,'PYTHAG',1P2D23.15)
    2 FORMAT(1X,1P2D23.15)
   10 R = (Q/P)**2
      T = F_4 + R
      IF (T .EQ. F_4) GO TO 20
      S = R/T
      P = P + F_2*P*S
      Q = Q*S
      IF (DDT .EQ. 25) WRITE(WTE,2) P,Q
      GO TO 10
   20 PYTHAG = P
      RETURN
      END

                                               