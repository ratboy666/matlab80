#include "matlab.h"
      SUBROUTINE RREF(AR,AI,LDA,M,N,EPS)
      FLOAT AR(LDA,1),AI(LDA,1),EPS,TOL,TR,TI,WASUM
      TOL = F_0
      DO 10 J = 1, N
         TOL = DMAX1(TOL,WASUM(M,AR(1,J),AI(1,J),1))
   10 CONTINUE
      TOL = EPS*DBLE(2*MAX0(M,N))*TOL
      K = 1
      L = 1
   20 IF (K.GT.M .OR. L.GT.N) RETURN
      I = IWAMAX(M-K+1,AR(K,L),AI(K,L),1) + K-1
      IF (DABS(AR(I,L))+DABS(AI(I,L)) .GT. TOL) GO TO 30
         CALL WSET(M-K+1,F_0,F_0,AR(K,L),AI(K,L),1)
         L = L+1
         GO TO 20
   30 CALL WSWAP(N-L+1,AR(I,L),AI(I,L),LDA,AR(K,L),AI(K,L),LDA)
      CALL WDIV(F_1,F_0,AR(K,L),AI(K,L),TR,TI)
      CALL WSCAL(N-L+1,TR,TI,AR(K,L),AI(K,L),LDA)
      AR(K,L) = F_1
      AI(K,L) = F_0
      DO 40 I = 1, M
         TR = -AR(I,L)
         TI = -AI(I,L)
         IF (I .NE. K) CALL WAXPY(N-L+1,TR,TI,
     $                 AR(K,L),AI(K,L),LDA,AR(I,L),AI(I,L),LDA)
   40 CONTINUE
      K = K+1
      L = L+1
      GO TO 20
      END

                                  