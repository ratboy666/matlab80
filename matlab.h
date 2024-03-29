/* matlab.h
 *
 * Configure MATLAB for REAL or DOUBLE PRECISION and number of elements
 */

#define MAX_LINE 1024
#define BUF_SIZE 256

#define ZERO 0
#define SLASH 44
#define EOL 99
#define DOT 47
#define BLANK 36
#define BSLASH 45
#define LRECL 80
#define SEMI 39
#define EQUAL 46
#define COMMA 48
#define LESS 50
#define GREAT 51
#define NAME 1
#define LPAREN 37
#define RPAREN 38
#define COLON 40
#define DSTAR 54
#define STAR 43
#define QUOTE 49
#define NUM 0
#define PLUS 41
#define MINUS 42

/* #define N_SIZE 5005 50505*/
//#define N_SIZE 15
#define N_SIZE 1105

/*
#define USE_SAVE
*/

#define CHARACTER BYTE

/*
#define USE_DOUBLE
*/

#ifdef USE_DOUBLE

#define FLOAT DOUBLE PRECISION

#define F_0 0.0D0
#define F_0P05 0.05D0
#define F_0P5 0.5D0
#define F_1 1.0D0
#define F_2 2.0D0
#define F_3 3.0D0
#define F_4 4.0D0
#define F_6 6.0D0
#define F_8 8.0D0
#define F_10 10.0D0
#define F_100 100.0D0
#define F_1D9 1.0D9

/* Note that we rely on FORTRAN not taking any spaces as significant
 * (preventing recursive expansion)
 */
#define DABS(X) D ABS(X)
#define IDINT(X) I DINT(X)
#define DBLE(X) D BLE(X)
#define DMOD(X,Y) D MOD(X,Y)
#define DLOG(X) D LOG(X)
#define DSQRT(X) D SQRT(X)
#define DMAX1(X,Y) D MAX1(X,Y)
#define DMIN1(X,Y) D MIN1(X,Y)
#define DLOG10(X) D LOG10(X)
#define DMAX3(X,Y,Z) D MAX1(X,Y,Z)
#define DATAN(X) D ATAN(X)
#define DCOSH(X) 1.0
#define DSINH(X) 1.0
#else

#define FLOAT REAL

#define F_0 0.0E0
#define F_0P05 0.05E0
#define F_0P5 0.5E0
#define F_1 1.0E0
#define F_2 2.0E0
#define F_3 3.0E0
#define F_4 4.0E0
#define F_6 6.0E0
#define F_8 8.0E0
#define F_10 10.0E0
#define F_100 100.0E0
#define F_1D9 1.0E9

#define DABS(X) ABS(X)
#define IDINT(X) INT(X)
#define DBLE(X) SNGL(X)
#define DMOD(X,Y) AMOD(X,Y)
#define DLOG(X) ALOG(X)
#define DSQRT(X) SQRT(X)
#define DMAX1(X,Y) AMAX1(X,Y)
#define DMIN1(X,Y) AMIN1(X,Y)
#define DLOG10(X) ALOG10(X)
#define DMAX3(X,Y,Z) AMAX1(X,Y,Z)
#define DATAN(X) ATAN(X)
#define DCOSH(X) 1.0
#define DSINH(X) 1.0

#endif
                                                                                                
