C STACK2.F
C
C FACTORED FOR OVERLAY
C
#include "matlab.h"
      SUBROUTINE STCK21(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
      IF (DDT .EQ. 1) WRITE(WTE,100) OP
  100 FORMAT(1X,'STACK2',I4)
      L2 = LSTK(TOP)
      M2 = MSTK(TOP)
      N2 = NSTK(TOP)
      TOP = TOP-1
      L = LSTK(TOP)
      M = MSTK(TOP)
      N = NSTK(TOP)
      FUN = 0
      RETURN
      END
C
      SUBROUTINE STCK22(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
      IF (N .NE. M2) CALL ERROR(10)
      IF (ERR .GT. 0) RETURN
      MN = M*N2
      LL = L + MN
      ERR = LL+M*N+M2*N2 - LSTK(BOT)
      IF (ERR .GT. 0) CALL ERROR(17)
      IF (ERR .GT. 0) RETURN
      CALL WCOPY(M*N+M2*N2,STKR(L),STKI(L),-1,STKR(LL),STKI(LL),-1)
      DO 08 J = 1, N2
      DO 08 I = 1, M
        K1 = L + MN + (I-1)
        K2 = L2 + MN + (J-1)*M2
        K = L + (I-1) + (J-1)*M
        STKR(K) = WDOTUR(N,STKR(K1),STKI(K1),M,STKR(K2),STKI(K2),1)
        STKI(K) = WDOTUI(N,STKR(K1),STKI(K1),M,STKR(K2),STKI(K2),1)
   08 CONTINUE
      NSTK(TOP) = N2
      RETURN
      END
C
      SUBROUTINE STCK23(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
      SR = STKR(L)
      SI = STKI(L)
      MSTK(TOP) = M2
      NSTK(TOP) = N2
      MN = M2*N2
      DO 27 I = 1, MN
         LL = L+I-1
         CALL WDIV(STKR(LL+1),STKI(LL+1),SR,SI,STKR(LL),STKI(LL))
         IF (ERR .GT. 0) RETURN
   27 CONTINUE
      RETURN
      END
C
      SUBROUTINE STCK24(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
      SR = STKR(L2)
      SI = STKI(L2)
      MN = M*N
      DO 22 I = 1, MN
         LL = L+I-1
         CALL WDIV(STKR(LL),STKI(LL),SR,SI,STKR(LL),STKI(LL))
         IF (ERR .GT. 0) RETURN
   22 CONTINUE
      RETURN
      END
C 
      SUBROUTINE STCK25(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
      MN = MSTK(TOP)*NSTK(TOP)
      CALL WSCAL(MN,SR,SI,STKR(L1),STKI(L1),1)
      IF (L1.NE.L)
     $   CALL WCOPY(MN,STKR(L1),STKI(L1),1,STKR(L),STKI(L),1)
      RETURN
      END
C
      SUBROUTINE STCK26(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
C     POWER
   30 IF (M2*N2 .NE. 1) CALL ERROR(30)
      IF (ERR .GT. 0) RETURN
      IF (M .NE. N) CALL ERROR(20)
      IF (ERR .GT. 0) RETURN
      NEXP = IDINT(STKR(L2))
      IF (STKR(L2) .NE. DBLE(NEXP)) GO TO 39
      IF (STKI(L2) .NE. 0.0D0) GO TO 39
      IF (NEXP .LT. 2) GO TO 39
      MN = M*N
      ERR = L2+MN+N - LSTK(BOT)
      IF (ERR .GT. 0) CALL ERROR(17)
      IF (ERR .GT. 0) RETURN
      CALL WCOPY(MN,STKR(L),STKI(L),1,STKR(L2),STKI(L2),1)
      L3 = L2+MN
      DO 36 KEXP = 2, NEXP
        DO 35 J = 1, N
          LS = L+(J-1)*N
          CALL WCOPY(N,STKR(LS),STKI(LS),1,STKR(L3),STKI(L3),1)
          DO 34 I = 1, N
            LS = L2+I-1
            LL = L+I-1+(J-1)*N
            STKR(LL) = WDOTUR(N,STKR(LS),STKI(LS),N,STKR(L3),STKI(L3),1)
            STKI(LL) = WDOTUI(N,STKR(LS),STKI(LS),N,STKR(L3),STKI(L3),1)
   34     CONTINUE
   35   CONTINUE
   36 CONTINUE
      RETURN
C 
C     NONINTEGER OR NONPOSITIVE POWER, USE EIGENVECTORS
   39 FUN = 2
      FIN = 0
      RETURN
C 
      END
C 
      SUBROUTINE STCK27(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
   60 E2 = STKR(L2)
      ST = F_1
      N = 0
      IF (RHS .LT. 3) GO TO 61
      ST = STKR(L)
      TOP = TOP-1
      L = LSTK(TOP)
      IF (ST .EQ. F_0) GO TO 63
   61 E1 = STKR(L)
C     CHECK FOR CLAUSE
      IF (RSTK(PT) .EQ. 3) GO TO 64
      ERR = L + MAX0(3,IDINT((E2-E1)/ST)) - LSTK(BOT)
      IF (ERR .GT. 0) CALL ERROR(17)
      IF (ERR .GT. 0) RETURN
   62 IF (ST .GT. F_0 .AND. STKR(L) .GT. E2) GO TO 63
      IF (ST .LT. F_0 .AND. STKR(L) .LT. E2) GO TO 63
        N = N+1
        L = L+1
        STKR(L) = E1 + DBLE(N)*ST
        STKI(L) = F_0
        GO TO 62
   63 NSTK(TOP) = N
      MSTK(TOP) = 1
      IF (N .EQ. 0) MSTK(TOP) = 0
      RETURN
C     FOR CLAUSE
   64 STKR(L) = E1
      STKR(L+1) = ST
      STKR(L+2) = E2
      MSTK(TOP) = -3
      NSTK(TOP) = -1
      RETURN
      END
C
      SUBROUTINE STCK28(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
   70 OP = OP - DOT
      IF (M.NE.M2 .OR. N.NE.N2) CALL ERROR(10)
      IF (ERR .GT. 0) RETURN
      MN = M*N
      DO 72 I = 1, MN
         J = L+I-1
         K = L2+I-1
         IF (OP .EQ. STAR)
     $      CALL WMUL(STKR(J),STKI(J),STKR(K),STKI(K),STKR(J),STKI(J))
         IF (OP .EQ. SLASH)
     $      CALL WDIV(STKR(J),STKI(J),STKR(K),STKI(K),STKR(J),STKI(J))
         IF (OP .EQ. BSLASH)
     $      CALL WDIV(STKR(K),STKI(K),STKR(J),STKI(J),STKR(J),STKI(J))
         IF (ERR .GT. 0) RETURN
   72 CONTINUE
      RETURN
      END
C 
C 
      SUBROUTINE STACK2(OP)
      INTEGER OP
      FLOAT SR,SI,E1,ST,E2
#include "common.h"
C 
C     BINARY AND TERNARY OPERATIONS
C 
      COMMON /STCK2C/SR,SI,E1,ST,E2,L2,M2,N2,L,M,N,MN,LL,K,K1,K2,
     * I,J
      CALL STCK21(OP)
      IF (OP .EQ. PLUS) GO TO 01
      IF (OP .EQ. MINUS) GO TO 03
      IF (OP .EQ. STAR) GO TO 05
      IF (OP .EQ. DSTAR) GO TO 30
      IF (OP .EQ. SLASH) GO TO 20
      IF (OP .EQ. BSLASH) GO TO 25
      IF (OP .EQ. COLON) GO TO 60
      IF (OP .GT. 2*DOT) GO TO 80
      IF (OP .GT. DOT) GO TO 70
C 
C     ADDITION
   01 IF (M .LT. 0) GO TO 50
      IF (M2 .LT. 0) GO TO 52
      IF (M .NE. M2) CALL ERROR(8)
      IF (ERR .GT. 0) RETURN
      IF (N .NE. N2) CALL ERROR(8)
      IF (ERR .GT. 0) RETURN
      CALL WAXPY(M*N,F_1,F_0,STKR(L2),STKI(L2),1,
     $            STKR(L),STKI(L),1)
      RETURN
C 
C     SUBTRACTION
   03 IF (M .LT. 0) GO TO 54
      IF (M2 .LT. 0) GO TO 56
      IF (M .NE. M2) CALL ERROR(9)
      IF (ERR .GT. 0) RETURN
      IF (N .NE. N2) CALL ERROR(9)
      IF (ERR .GT. 0) RETURN
      CALL WAXPY(M*N,-F_1,F_0,STKR(L2),STKI(L2),1,
     $            STKR(L),STKI(L),1)
      RETURN
C 
C     MULTIPLICATION
   05 IF (M2*M2*N2 .EQ. 1) GO TO 10
      IF (M*N .EQ. 1) GO TO 11
      IF (M2*N2 .EQ. 1) GO TO 10
      CALL STCK22(OP)
      RETURN
C 
C     MULTIPLICATION BY SCALAR
   10 SR = STKR(L2)
      SI = STKI(L2)
      L1 = L
      GO TO 13
   11 SR = STKR(L)
      SI = STKI(L)
      L1 = L+1
      MSTK(TOP) = M2
      NSTK(TOP) = N2
   13 CALL STCK25(OP)
      MN = MSTK(TOP)*NSTK(TOP)
      CALL WSCAL(MN,SR,SI,STKR(L1),STKI(L1),1)
      IF (L1.NE.L)
     $   CALL WCOPY(MN,STKR(L1),STKI(L1),1,STKR(L),STKI(L),1)
      RETURN
C 
C     RIGHT DIVISION
   20 IF (M2*N2 .EQ. 1) GO TO 21
      IF (M2 .EQ. N2) FUN = 1
      IF (M2 .NE. N2) FUN = 4
      FIN = -1
      RHS = 2
      RETURN
   21 CALL STCK24(OP)
      SR = STKR(L2)
      SI = STKI(L2)
      MN = M*N
      DO 22 I = 1, MN
         LL = L+I-1
         CALL WDIV(STKR(LL),STKI(LL),SR,SI,STKR(LL),STKI(LL))
         IF (ERR .GT. 0) RETURN
   22 CONTINUE
      RETURN
C 
C     LEFT DIVISION
   25 IF (M*N .EQ. 1) GO TO 26
      IF (M .EQ. N) FUN = 1
      IF (M .NE. N) FUN = 4
      FIN = -2
      RHS = 2
      RETURN
   26 CALL STCK23(OP)
      RETURN
C 
C     POWER
   30 CALL STCK26(OP)
      RETURN
C 
C     ADD OR SUBTRACT SCALAR
   50 IF (M2 .NE. N2) CALL ERROR(8)
      IF (ERR .GT. 0) RETURN
      M = M2
      N = N2
      MSTK(TOP) = M
      NSTK(TOP) = N
      SR = STKR(L)
      SI = STKI(L)
      CALL WCOPY(M*N,STKR(L+1),STKI(L+1),1,STKR(L),STKI(L),1)
      GO TO 58
   52 IF (M .NE. N) CALL ERROR(8)
      IF (ERR .GT. 0) RETURN
      SR = STKR(L2)
      SI = STKI(L2)
      GO TO 58
   54 IF (M2 .NE. N2) CALL ERROR(9)
      IF (ERR .GT. 0) RETURN
      M = M2
      N = N2
      MSTK(TOP) = M
      NSTK(TOP) = N
      SR = STKR(L)
      SI = STKI(L)
      CALL WCOPY(M*N,STKR(L+1),STKI(L+1),1,STKR(L),STKI(L),1)
      CALL WRSCAL(M*N,-1.0D0,STKR(L),STKI(L),1)
      GO TO 58
   56 IF (M .NE. N) CALL ERROR(9)
      IF (ERR .GT. 0) RETURN
      SR = -STKR(L2)
      SI = -STKI(L2)
      GO TO 58
   58 DO 59 I = 1, N
         LL = L + (I-1)*(N+1)
         STKR(LL) = FLOP(STKR(LL)+SR)
         STKI(LL) = FLOP(STKI(LL)+SI)
   59 CONTINUE
C 
      RETURN
C
C     COLON
   60 CALL STCK27(OP)
      RETURN
C 
C     ELEMENTWISE OPERATIONS
   70 CALL STCK28(OP)
      RETURN
C 
C     KRONECKER
   80 FIN = OP - 2*DOT - STAR + 11
      FUN = 6
      TOP = TOP + 1
      RHS = 2
      RETURN
      END
                                                                                                 
