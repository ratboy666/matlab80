#include "matlab.h"
      FLOAT FUNCTION ROUNDM(X)
      FLOAT X,Y,Z,E,H
      DATA H/F_1D9/
#ifdef USE_SAVE
      SAVE H
#endif
      Z = DABS(X)
      Y = Z + F_1
      IF (Y .EQ. Z) GO TO 40
      Y = F_0
      E = H
   10 IF (E .GE. Z) GO TO 20
         E = F_2*E
         GO TO 10
   20 IF (E .LE. H) GO TO 30
         IF (E .LE. Z) Y = Y + E
         IF (E .LE. Z) Z = Z - E
         E = E/F_2
         GO TO 20
   30 Z = IDINT(Z + F_0P5)
      Y = Y + Z
      IF (X .LT. F_0) Y = -Y
      ROUNDM = Y
      RETURN
   40 ROUNDM = X
      RETURN
      END

                                                 