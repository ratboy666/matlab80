#include "matlab.h"
      SUBROUTINE USER(A,M,N,S,T)
      FLOAT A(M,N),S,T
C
      INTEGER A3(9)
      DATA A3 /-149,537,-27,-50,180,-9,-154,546,-25/
      IF (A(1,1) .NE. F_3) RETURN
      DO 10 I = 1, 9
         A(I,1) = DBLE(A3(I))
   10 CONTINUE
      M = 3
      N = 3
      RETURN
      END

                                                                     