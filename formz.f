#include "matlab.h"
      SUBROUTINE FORMZ(LUNIT,X,Y)
      FLOAT X,Y
C
C     SYSTEM DEPENDENT ROUTINE TO PRINT WITH Z FORMAT
C
      IF (Y .NE. F_0) WRITE(LUNIT,10) X,Y
      IF (Y .EQ. F_0) WRITE(LUNIT,10) X
   10 FORMAT(2G18.10)
      RETURN
      END
                                                                                                                     