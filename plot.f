#include "matlab.h"
      SUBROUTINE PLOT(LUNIT,X,Y,N,P,K,BUF)
      FLOAT X(N),Y(N),P(1)
      INTEGER BUF(79)
C
C     PLOT X VS. Y ON LUNIT
C     IF K IS NONZERO, THEN P(1),...,P(K) ARE EXTRA PARAMETERS
C     BUF IS WORK SPACE
C
      DOUBLE PRECISION XMIN,YMIN,XMAX,YMAX,DY,DX,Y1,Y0
      CHARACTER ASTC,BLANKC,H,W
      INTEGER AST,BLANKI
#define H 20
#define W 79
C
      ICHAR(I) = I
C
      ASTC='*'
      BLANKC=' '
      AST=ICHAR(ASTC)
      BLANKI=ICHAR(BLANKC)
C
C     H = HEIGHT, W = WIDTH
C
      IF (K .GT. 0) WRITE(LUNIT,01) (P(I), I=1,K)
   01 FORMAT('EXTRA PARAMETERS',10F5.1)
      XMIN = X(1)
      XMAX = X(1)
      YMIN = Y(1)
      YMAX = Y(1)
      DO 10 I = 1, N
         XMIN = DMIN1(XMIN,X(I))
         XMAX = DMAX1(XMAX,X(I))
         YMIN = DMIN1(YMIN,Y(I))
         YMAX = DMAX1(YMAX,Y(I))
   10 CONTINUE
      DX = XMAX - XMIN
      IF (DX .EQ. F_0) DX = F_1
      DY = YMAX - YMIN
      WRITE(LUNIT,35)
      DO 40 L = 1, H
         DO 20 J = 1, W
            BUF(J) = BLANK
   20    CONTINUE
         Y1 = YMIN + (H-L+1)*DY/H
         Y0 = YMIN + (H-L)*DY/H
         JMAX = 1
         DO 30 I = 1, N
            IF (Y(I) .GT. Y1) GO TO 30
            IF (L.NE.H .AND. Y(I).LE.Y0) GO TO 30
            J = 1 + (W-1)*(X(I) - XMIN)/DX
            BUF(J) = AST
            JMAX = MAX0(JMAX,J)
   30    CONTINUE
         WRITE(LUNIT,35) (BUF(J),J=1,JMAX)
   35    FORMAT(79A1)
   40 CONTINUE
      RETURN
      END

                               