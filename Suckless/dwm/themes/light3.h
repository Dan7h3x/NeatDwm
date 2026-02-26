static char normfgcolor[] = "#6b4f3c";
static char normbgcolor[] = "#fff9e6";
static char normbordercolor[] = "#ffedc9";
static char normfloatcolor[] = "#ffedc9";

static char selfgcolor[] = "#4a3b2c";
static char selbgcolor[] = "#f7d794";
static char selbordercolor[] = "#e3b15a";
static char selfloatcolor[] = "#e3b15a";

static char titlenormfgcolor[] = "#b38b5c";
static char titlenormbgcolor[] = "#ffedc9";
static char titlenormbordercolor[] = "#ffedc9";
static char titlenormfloatcolor[] = "#ffedc9";

static char titleselfgcolor[] = "#c49b6b";
static char titleselbgcolor[] = "#fff9e6";
static char titleselbordercolor[] = "#f7d794";
static char titleselfloatcolor[] = "#f7d794";

static char tagsnormfgcolor[] = "#8f7354";
static char tagsnormbgcolor[] = "#fff2d7";
static char tagsnormbordercolor[] = "#ffedc9";
static char tagsnormfloatcolor[] = "#ffedc9";

static char tagsselfgcolor[] = "#d4a656";
static char tagsselbgcolor[] = "#fff2d7";
static char tagsselbordercolor[] = "#f7d794";
static char tagsselfloatcolor[] = "#f7d794";

static char hidnormfgcolor[] = "#b38b5c";
static char hidselfgcolor[] = "#f7d794";
static char hidnormbgcolor[] = "#fff2d7";
static char hidselbgcolor[] = "#ffedc9";

static char urgfgcolor[] = "#e3b15a";
static char urgbgcolor[] = "#fff9e6";
static char urgbordercolor[] = "#e3b15a";
static char urgfloatcolor[] = "#fff9e6";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[] = "#4a3b2c";
static char scratchselbgcolor[] = "#f7d794";
static char scratchselbordercolor[] = "#e3b15a";
static char scratchselfloatcolor[] = "#e3b15a";

static char scratchnormfgcolor[] = "#6b4f3c";
static char scratchnormbgcolor[] = "#ffedc9";
static char scratchnormbordercolor[] = "#b38b5c";
static char scratchnormfloatcolor[] = "#b38b5c";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[] = "#ffedc9";
static char normLTRbgcolor[] = "#ffedc9";
static char normMONObgcolor[] = "#ffedc9";
static char normGRIDbgcolor[] = "#ffedc9";
static char normGRD1bgcolor[] = "#ffedc9";
static char normGRD2bgcolor[] = "#ffedc9";
static char normGRDMbgcolor[] = "#ffedc9";
static char normHGRDbgcolor[] = "#ffedc9";
static char normDWDLbgcolor[] = "#ffedc9";
static char normSPRLbgcolor[] = "#ffedc9";
static char normfloatbgcolor[] = "#ffedc9";
static char actTTBbgcolor[] = "#fff2d7";
static char actLTRbgcolor[] = "#fff2d7";
static char actMONObgcolor[] = "#fff2d7";
static char actGRIDbgcolor[] = "#fff2d7";
static char actGRD1bgcolor[] = "#fff2d7";
static char actGRD2bgcolor[] = "#fff2d7";
static char actGRDMbgcolor[] = "#fff2d7";
static char actHGRDbgcolor[] = "#fff2d7";
static char actDWDLbgcolor[] = "#fff2d7";
static char actSPRLbgcolor[] = "#fff2d7";
static char actfloatbgcolor[] = "#fff2d7";
static char selTTBbgcolor[] = "#f7d794";
static char selLTRbgcolor[] = "#f7d794";
static char selMONObgcolor[] = "#f7d794";
static char selGRIDbgcolor[] = "#f7d794";
static char selGRD1bgcolor[] = "#f7d794";
static char selGRD2bgcolor[] = "#f7d794";
static char selGRDMbgcolor[] = "#f7d794";
static char selHGRDbgcolor[] = "#f7d794";
static char selDWDLbgcolor[] = "#f7d794";
static char selSPRLbgcolor[] = "#f7d794";
static char selfloatbgcolor[] = "#f7d794";
#endif // BAR_FLEXWINTITLE_PATCH

#if BAR_ALPHA_PATCH
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3] = {
    [SchemeNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeSel] = {OPAQUE, baralpha, borderalpha},
    [SchemeTitleNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeTitleSel] = {OPAQUE, baralpha, borderalpha},
    [SchemeTagsNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeTagsSel] = {OPAQUE, baralpha, borderalpha},
    [SchemeHidNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeHidSel] = {OPAQUE, baralpha, borderalpha},
    [SchemeUrg] = {OPAQUE, baralpha, borderalpha},
#if RENAMED_SCRATCHPADS_PATCH
    [SchemeScratchSel] = {OPAQUE, baralpha, borderalpha},
    [SchemeScratchNorm] = {OPAQUE, baralpha, borderalpha},
#endif // RENAMED_SCRATCHPADS_PATCH
#if BAR_FLEXWINTITLE_PATCH
    [SchemeFlexActTTB] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActLTR] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActMONO] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActGRID] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActGRD1] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActGRD2] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActGRDM] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActHGRD] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActDWDL] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActSPRL] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexActFloat] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaTTB] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaLTR] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaMONO] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaGRID] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaGRD1] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaGRD2] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaGRDM] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaHGRD] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaDWDL] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaSPRL] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexInaFloat] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelTTB] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelLTR] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelMONO] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelGRID] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelGRD1] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelGRD2] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelGRDM] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelHGRD] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelDWDL] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelSPRL] = {OPAQUE, baralpha, borderalpha},
    [SchemeFlexSelFloat] = {OPAQUE, baralpha, borderalpha},
#endif // BAR_FLEXWINTITLE_PATCH
};
#endif // BAR_ALPHA_PATCH
