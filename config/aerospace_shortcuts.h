// Shortcuts for my Aerospace window manager config

#define AE_MEH(KEY) LC(LA(LG(KEY)))
#define AE_HYP(KEY) LS(LC(LA(LG(KEY))))

#define AE_LEFT  AE_MEH(_Y)
#define AE_DOWN  AE_MEH(_H)
#define AE_UP    AE_MEH(_A)
#define AE_RIGHT AE_MEH(_E)

#define AE_FULL  AE_MEH(_F)    // Fullscreen
#define AE_SMLR  AE_MEH(MINUS) // Resize smaller
#define AE_BIGR  AE_MEH(EQUAL) // Resize bigger
#define AE_BLNC  AE_HYP(MINUS) // Balance sizes
#define AE_THRD  AE_HYP(BSLH)  // Two-thirds screen size

#define AE_ACRD  AE_MEH(COMMA) // Accordion layout
#define AE_TILE  AE_MEH(FSLH)  // Tile layout
#define AE_SRVC  AE_MEH(_I)    // Service mode

// Workspaces
#define AE_WS1   AE_MEH(N1)
#define AE_WS2   AE_MEH(N2)
#define AE_WS3   AE_MEH(N3)
#define AE_WS4   AE_MEH(N4)
#define AE_WS_BF AE_MEH(TAB)   // Workspace back-and-forth
