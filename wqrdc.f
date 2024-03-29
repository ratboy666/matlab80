#include "matlab.h"
      SUBROUTINE WQRDC(XR,XI,LDX,N,P,QRAUXR,QRAUXI,JPVT,WORKR,WORKI,
     *                 JOB)
#include "funcs.h"
      INTEGER LDX,N,P,JOB
      INTEGER JPVT(1)
      FLOAT XR(LDX,1),XI(LDX,1),QRAUXR(1),QRAUXI(1),
     *                 WORKR(1),WORKI(1)
C 
C     WQRDC USES HOUSEHOLDER TRANSFORMATIONS TO COMPUTE THE QR
C     FACTORIZATION OF AN N BY P MATRIX X.  COLUMN PIVOTING
C     BASED ON THE 2-NORMS OF THE REDUCED COLUMNS MAY BE
C     PERFORMED AT THE USERS OPTION.
C 
C     ON ENTRY
C 
C        X       DOUBLE-COMPLEX(LDX,P), WHERE LDX .GE. N.
C                X CONTAINS THE MATRIX WHOSE DECOMPOSITION IS TO BE
C                COMPUTED.
C 
C        LDX     INTEGER.
C                LDX IS THE LEADING DIMENSION OF THE ARRAY X.
C 
C        N       INTEGER.
C                N IS THE NUMBER OF ROWS OF THE MATRIX X.
C 
C        P       INTEGER.
C                P IS THE NUMBER OF COLUMNS OF THE MATRIX X.
C 
C        JPVT    INTEGER(P).
C                JPVT CONTAINS INTEGERS THAT CONTROL THE SELECTION
C                OF THE PIVOT COLUMNS.  THE K-TH COLUMN X(K) OF X
C                IS PLACED IN ONE OF THREE CLASSES ACCORDING TO THE
C                VALUE OF JPVT(K).
C 
C                   IF JPVT(K) .GT. 0, THEN X(K) IS AN INITIAL
C                                      COLUMN.
C 
C                   IF JPVT(K) .EQ. 0, THEN X(K) IS A FREE COLUMN.
C 
C                   IF JPVT(K) .LT. 0, THEN X(K) IS A FINAL COLUMN.
C 
C                BEFORE THE DECOMPOSITION IS COMPUTED, INITIAL COLUMNS
C                ARE MOVED TO THE BEGINNING OF THE ARRAY X AND FINAL
C                COLUMNS TO THE END.  BOTH INITIAL AND FINAL COLUMNS
C                ARE FROZEN IN PLACE DURING THE COMPUTATION AND ONLY
C                FREE COLUMNS ARE MOVED.  AT THE K-TH STAGE OF THE
C                REDUCTION, IF X(K) IS OCCUPIED BY A FREE COLUMN
C                IT IS INTERCHANGED WITH THE FREE COLUMN OF LARGEST
C                REDUCED NORM.  JPVT IS NOT REFERENCED IF
C                JOB .EQ. 0.
C 
C        WORK    DOUBLE-COMPLEX(P).
C                WORK IS A WORK ARRAY.  WORK IS NOT REFERENCED IF
C                JOB .EQ. 0.
C 
C        JOB     INTEGER.
C                JOB IS AN INTEGER THAT INITIATES COLUMN PIVOTING.
C                IF JOB .EQ. 0, NO PIVOTING IS DONE.
C                IF JOB .NE. 0, PIVOTING IS DONE.
C 
C     ON RETURN
C 
C        X       X CONTAINS IN ITS UPPER TRIANGLE THE UPPER
C                TRIANGULAR MATRIX R OF THE QR FACTORIZATION.
C                BELOW ITS DIAGONAL X CONTAINS INFORMATION FROM
C                WHICH THE UNITARY PART OF THE DECOMPOSITION
C                CAN BE RECOVERED.  NOTE THAT IF PIVOTING HAS
C                BEEN REQUESTED, THE DECOMPOSITION IS NOT THAT
C                OF THE ORIGINAL MATRIX X BUT THAT OF X
C                WITH ITS COLUMNS PERMUTED AS DESCRIBED BY JPVT.
C 
C        QRAUX   DOUBLE-COMPLEX(P).
C                QRAUX CONTAINS FURTHER INFORMATION REQUIRED TO RECOVER
C                THE UNITARY PART OF THE DECOMPOSITION.
C 
C        JPVT    JPVT(K) CONTAINS THE INDEX OF THE COLUMN OF THE
C                ORIGINAL MATRIX THAT HAS BEEN INTERCHANGED INTO
C                THE K-TH COLUMN, IF PIVOTING WAS REQUESTED.
C 
C     LINPACK. THIS VERSION DATED 07/03/79 .
C     G.W. STEWART, UNIVERSITY OF MARYLAND, ARGONNE NATIONAL LAB.
C 
C     WQRDC USES THE FOLLOWING FUNCTIONS AND SUBPROGRAMS.
C 
C     BLAS WAXPY,PYTHAG,WDOTCR,WDOTCI,WSCAL,WSWAP,WNRM2
C     /* FORTRAN DABS,DIMAG,DMAX1,MIN0 */
C 
C     INTERNAL VARIABLES
C 
      INTEGER J,JP,L,LP1,LUP,MAXJ,PL,PU
      FLOAT MAXNRM,WNRM2,TT
      FLOAT NRMXLR,NRMXLI,TR,TI
      LOGICAL NEGJ,SWAPJ
C 
      FLOAT ZDUMR,ZDUMI
      FLOAT CABS1
      CABS1(ZDUMR,ZDUMI) = DABS(ZDUMR) + DABS(ZDUMI)
C 
      PL = 1
      PU = 0
      IF (JOB .EQ. 0) GO TO 60
C 
C        PIVOTING HAS BEEN REQUESTED.  REARRANGE THE COLUMNS
C        ACCORDING TO JPVT.
C 
         DO 20 J = 1, P
            SWAPJ = JPVT(J) .GT. 0
            NEGJ = JPVT(J) .LT. 0
            JPVT(J) = J
            IF (NEGJ) JPVT(J) = -J
            IF (.NOT.SWAPJ) GO TO 10
               IF (J .NE. PL)
     *            CALL WSWAP(N,XR(1,PL),XI(1,PL),1,XR(1,J),XI(1,J),1)
               JPVT(J) = JPVT(PL)
               JPVT(PL) = J
               PL = PL + 1
   10       CONTINUE
   20    CONTINUE
         PU = P
         DO 50 JJ = 1, P
            J = P - JJ + 1
            IF (JPVT(J) .GE. 0) GO TO 40
               JPVT(J) = -JPVT(J)
               IF (J .EQ. PU) GO TO 30
                  CALL WSWAP(N,XR(1,PU),XI(1,PU),1,XR(1,J),XI(1,J),1)
                  JP = JPVT(PU)
                  JPVT(PU) = JPVT(J)
                  JPVT(J) = JP
   30          CONTINUE
               PU = PU - 1
   40       CONTINUE
   50    CONTINUE
   60 CONTINUE
C 
C     COMPUTE THE NORMS OF THE FREE COLUMNS.
C 
      IF (PU .LT. PL) GO TO 80
      DO 70 J = PL, PU
         QRAUXR(J) = WNRM2(N,XR(1,J),XI(1,J),1)
         QRAUXI(J) = F_0
         WORKR(J) = QRAUXR(J)
         WORKI(J) = QRAUXI(J)
   70 CONTINUE
   80 CONTINUE
C 
C     PERFORM THE HOUSEHOLDER REDUCTION OF X.
C 
      LUP = MIN0(N,P)
      DO 210 L = 1, LUP
         IF (L .LT. PL .OR. L .GE. PU) GO TO 120
C 
C           LOCATE THE COLUMN OF LARGEST NORM AND BRING IT
C           INTO THE PIVOT POSITION.
C 
            MAXNRM = F_0
            MAXJ = L
            DO 100 J = L, PU
               IF (QRAUXR(J) .LE. MAXNRM) GO TO 90
                  MAXNRM = QRAUXR(J)
                  MAXJ = J
   90          CONTINUE
  100       CONTINUE
            IF (MAXJ .EQ. L) GO TO 110
               CALL WSWAP(N,XR(1,L),XI(1,L),1,XR(1,MAXJ),XI(1,MAXJ),1)
               QRAUXR(MAXJ) = QRAUXR(L)
               QRAUXI(MAXJ) = QRAUXI(L)
               WORKR(MAXJ) = WORKR(L)
               WORKI(MAXJ) = WORKI(L)
               JP = JPVT(MAXJ)
               JPVT(MAXJ) = JPVT(L)
               JPVT(L) = JP
  110       CONTINUE
  120    CONTINUE
         QRAUXR(L) = F_0
         QRAUXI(L) = F_0
         IF (L .EQ. N) GO TO 200
C 
C           COMPUTE THE HOUSEHOLDER TRANSFORMATION FOR COLUMN L.
C 
            NRMXLR = WNRM2(N-L+1,XR(L,L),XI(L,L),1)
            NRMXLI = F_0
            IF (CABS1(NRMXLR,NRMXLI) .EQ. 0.0D0) GO TO 190
               IF (CABS1(XR(L,L),XI(L,L)) .EQ. 0.0D0) GO TO 130
                 CALL WSIGN(NRMXLR,NRMXLI,XR(L,L),XI(L,L),NRMXLR,NRMXLI)
  130          CONTINUE
               CALL WDIV(F_1,F_0,NRMXLR,NRMXLI,TR,TI)
               CALL WSCAL(N-L+1,TR,TI,XR(L,L),XI(L,L),1)
               XR(L,L) = FLOP(F_1 + XR(L,L))
C 
C              APPLY THE TRANSFORMATION TO THE REMAINING COLUMNS,
C              UPDATING THE NORMS.
C 
               LP1 = L + 1
               IF (P .LT. LP1) GO TO 180
               DO 170 J = LP1, P
                  TR = -WDOTCR(N-L+1,XR(L,L),XI(L,L),1,XR(L,J),
     *                         XI(L,J),1)
                  TI = -WDOTCI(N-L+1,XR(L,L),XI(L,L),1,XR(L,J),
     *                         XI(L,J),1)
                  CALL WDIV(TR,TI,XR(L,L),XI(L,L),TR,TI)
                  CALL WAXPY(N-L+1,TR,TI,XR(L,L),XI(L,L),1,XR(L,J),
     *                       XI(L,J),1)
                  IF (J .LT. PL .OR. J .GT. PU) GO TO 160
                  IF (CABS1(QRAUXR(J),QRAUXI(J)) .EQ. F_0)
     *               GO TO 160
                     TT = F_1 - (PYTHAG(XR(L,J),XI(L,J))/QRAUXR(J))**2
                     TT = DMAX1(TT,0.0D0)
                     TR = FLOP(TT)
                     TT = FLOP(F_1+F0P05*TT*(QRAUXR(J)/WORKR(J))**2)
                     IF (TT .EQ. F_1) GO TO 140
                        QRAUXR(J) = QRAUXR(J)*DSQRT(TR)
                        QRAUXI(J) = QRAUXI(J)*DSQRT(TR)
                     GO TO 150
  140                CONTINUE
                        QRAUXR(J) = WNRM2(N-L,XR(L+1,J),XI(L+1,J),1)
                        QRAUXI(J) = F_0
                        WORKR(J) = QRAUXR(J)
                        WORKI(J) = QRAUXI(J)
  150                CONTINUE
  160             CONTINUE
  170          CONTINUE
  180          CONTINUE
C 
C              SAVE THE TRANSFORMATION.
C 
               QRAUXR(L) = XR(L,L)
               QRAUXI(L) = XI(L,L)
               XR(L,L) = -NRMXLR
               XI(L,L) = -NRMXLI
  190       CONTINUE
  200    CONTINUE
  210 CONTINUE
      RETURN
      END

                                         
