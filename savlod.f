#include "matlab.h"
      SUBROUTINE SAVLOD(LUNIT,ID,M,N,IMG,JOB,XREAL,XIMAG)
      CHARACTER IDC(4)
      INTEGER LUNIT,ID(4),M,N,IMG,JOB,TEMP
      FLOAT XREAL(1),XIMAG(1)
      CHARACTER CHAR
      CHAR(I) = I
      ICHAR(I) = I
C
C     IMPLEMENT SAVE AND LOAD
C     LUNIT = LOGICAL UNIT NUMBER
C     ID = NAME, FORMAT 4I1
C     IDC = NAME, FORMAT 4A1
C     M, N = DIMENSIONS
C     IMG = NONZERO IF XIMAG IS NONZERO
C     JOB = 0     FOR SAVE
C         = SPACE AVAILABLE FOR LOAD
C     XREAL, XIMAG = REAL AND OPTIONAL IMAGINARY PARTS
C
C     SYSTEM DEPENDENT FORMATS
  101 FORMAT(4A1,3I4)
  102 FORMAT(G20.8)
C
      IF (JOB .GT. 0) GO TO 20
C
C     SAVE
C
C     CONVERT ID TO CHARACTER STRING
C
      DO 5 I = 1, 4
        TEMP = ID(I)
        IDC(I) = CHAR(TEMP)
    5 CONTINUE
C
   10 WRITE(LUNIT,101) IDC,M,N,IMG
      DO 15 J = 1, N
         K = (J-1)*M+1
         L = J*M
         WRITE(LUNIT,102) (XREAL(I),I=K,L)
         IF (IMG .NE. 0) WRITE(LUNIT,102) (XIMAG(I),I=K,L)
   15 CONTINUE
      RETURN
C
C     LOAD
   20 READ(LUNIT,101,END=30) IDC,M,N,IMG
C
C     CONVERT IDC TO INTEGER STRING
C
      DO 21 I = 1, 4
         ID(I) = ICHAR(IDC(I))
   21 CONTINUE
      IF (M*N .GT. JOB) GO TO 30
      DO 25 J = 1, N
         K = (J-1)*M+1
         L = J*M
         READ(LUNIT,102,END=30) (XREAL(I),I=K,L)
         IF (IMG .NE. 0) READ(LUNIT,102,END=30) (XIMAG(I),I=K,L)
   25 CONTINUE
      RETURN
C
C     END OF FILE
   30 M = 0
      N = 0
      RETURN
      END

                                                                                                                        