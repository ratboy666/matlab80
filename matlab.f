#include "matlab.h"
      SUBROUTINE MATLAB(INIT)
C
C     INIT = 0 FOR ORDINARY FIRST ENTRY
C          = POSITIVE FOR SUBSEQUENT ENTRIES
C          = NEGATIVE FOR SILENT INITIALIZATION (SEE MATZ)
C
#include "common.h"
      CALL INITM(INIT)
      IF (INIT .LT. 0) RETURN
C
   90 CALL PARSE
      IF (FUN .EQ. 1) CALL MATFN1
      IF (FUN .EQ. 2) CALL MATFN2
      IF (FUN .EQ. 3) CALL MATFN3
      IF (FUN .EQ. 4) CALL MATFN4
      IF (FUN .EQ. 5) CALL MATFN5
      IF (FUN .EQ. 6) CALL MATFN6
      IF (FUN .EQ. 21) CALL MATFN1
      IF (FUN .NE. 99) GO TO 90
      RETURN
      END
                                       
