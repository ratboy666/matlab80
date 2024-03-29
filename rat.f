#include "matlab.h"
      SUBROUTINE RAT(X,LEN,MAXD,A,B,D)
      INTEGER LEN,MAXD
      FLOAT X,A,B,D(LEN)
C 
C     A/B = CONTINUED FRACTION APPROXIMATION TO X
C           USING  LEN  TERMS EACH LESS THAN MAXD
C 
      CHARACTER LIN(MAX_LINE)
      INTEGER DDT,ERR,FMT,LCT(4),LPT(6),HIO,RIO,WIO,RTE,WTE
      FLOAT S,T,Z,ROUNDM
      COMMON /IOP/ DDT,ERR,FMT,LCT,LIN,LPT,HIO,RIO,WIO,RTE,WTE
      Z = X
      DO 10 I = 1, LEN
         K = I
         D(K) = ROUNDM(Z)
         Z = Z - D(K)
         IF (DABS(Z)*DBLE(MAXD) .LE. F_1) GO TO 20
         Z = F_1/Z
   10 CONTINUE
   20 T = D(K)
      S = F_1
      IF (K .LT. 2) GO TO 40
      DO 30 IB = 2, K
         I = K+1-IB
         Z = T
         T = D(I)*T + S
         S = Z
   30 CONTINUE
   40 IF (S .LT. F_0) T = -T
      IF (S .LT. F_0) S = -S
      IF (DDT .EQ. 27) WRITE(WTE,50) X,T,S,(D(I),I=1,K)
   50 FORMAT(/1X,1PD23.15,0PF8.0,' /',F8.0,4X,6F5.0/(1X,45X,6F5.0))
      A = T
      B = S
      RETURN
      END

            