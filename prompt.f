#include "matlab.h"
      SUBROUTINE PROMPT(PAUSE)
      INTEGER PAUSE
C
C     ISSUE MATLAB PROMPT WITH OPTIONAL PAUSE
C
      CHARACTER LIN(MAX_LINE)
      INTEGER DDT,ERR,FMT,LCT(4),LPT(6),HIO,RIO,WIO,RTE,WTE
      COMMON /IOP/ DDT,ERR,FMT,LCT,LIN,LPT,HIO,RIO,WIO,RTE,WTE
      WRITE(WTE,10)
      IF (WIO .NE. 0) WRITE(WIO,10)
   10 FORMAT(/1X,'<>')
      IF (PAUSE .EQ. 1) READ(RTE,20) DUMMY
   20 FORMAT(A1)
      RETURN
      END
                                                           