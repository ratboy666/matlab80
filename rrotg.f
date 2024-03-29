#include "matlab.h"
      SUBROUTINE RROTG(DA,DB,C,S)
C 
C     CONSTRUCT GIVENS PLANE ROTATION.
C 
      FLOAT DA,DB,C,S,RHO,PYTHAG,FLOP,R,Z
C 
      RHO = DB
      IF ( DABS(DA) .GT. DABS(DB) ) RHO = DA
      C = F_1
      S = F_0
      Z = F_1
      R = FLOP(DSIGN(PYTHAG(DA,DB),RHO))
      IF (R .NE. F_0) C = FLOP(DA/R)
      IF (R .NE. F_0) S = FLOP(DB/R)
      IF ( DABS(DA) .GT. DABS(DB) ) Z = S
      IF ( DABS(DB) .GE. DABS(DA) .AND. C .NE. F_0 ) Z = FLOP(F_0/C)
      DA = R
      DB = Z
      RETURN
      END

                                                                                               