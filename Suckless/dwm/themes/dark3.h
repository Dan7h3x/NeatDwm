static char normfgcolor[] = "#c0e0ff";
static char normbgcolor[] = "#0d0f1a";
static char normbordercolor[] = "#1a1f2e";
static char normfloatcolor[] = "#1a1f2e";

static char selfgcolor[] = "#ffffff";
static char selbgcolor[] = "#ff4d80";
static char selbordercolor[] = "#ff77a9";
static char selfloatcolor[] = "#ff77a9";

static char titlenormfgcolor[] = "#a0c0ff";
static char titlenormbgcolor[] = "#1a1f2e";
static char titlenormbordercolor[] = "#1a1f2e";
static char titlenormfloatcolor[] = "#1a1f2e";

static char titleselfgcolor[] = "#9effd9";
static char titleselbgcolor[] = "#0d0f1a";
static char titleselbordercolor[] = "#ff4d80";
static char titleselfloatcolor[] = "#ff4d80";

static char tagsnormfgcolor[] = "#8aa9ff";
static char tagsnormbgcolor[] = "#141827";
static char tagsnormbordercolor[] = "#1a1f2e";
static char tagsnormfloatcolor[] = "#1a1f2e";

static char tagsselfgcolor[] = "#6efff0";
static char tagsselbgcolor[] = "#141827";
static char tagsselbordercolor[] = "#ff4d80";
static char tagsselfloatcolor[] = "#ff4d80";

static char hidnormfgcolor[] = "#a0c0ff";
static char hidselfgcolor[] = "#ff4d80";
static char hidnormbgcolor[] = "#141827";
static char hidselbgcolor[] = "#1a1f2e";

static char urgfgcolor[] = "#ff77a9";
static char urgbgcolor[] = "#0d0f1a";
static char urgbordercolor[] = "#ff77a9";
static char urgfloatcolor[] = "#0d0f1a";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[] = "#ffffff";
static char scratchselbgcolor[] = "#ff4d80";
static char scratchselbordercolor[] = "#ff77a9";
static char scratchselfloatcolor[] = "#ff77a9";

static char scratchnormfgcolor[] = "#c0e0ff";
static char scratchnormbgcolor[] = "#1a1f2e";
static char scratchnormbordercolor[] = "#a0c0ff";
static char scratchnormfloatcolor[] = "#a0c0ff";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[] = "#1a1f2e";
static char normLTRbgcolor[] = "#1a1f2e";
static char normMONObgcolor[] = "#1a1f2e";
static char normGRIDbgcolor[] = "#1a1f2e";
static char normGRD1bgcolor[] = "#1a1f2e";
static char normGRD2bgcolor[] = "#1a1f2e";
static char normGRDMbgcolor[] = "#1a1f2e";
static char normHGRDbgcolor[] = "#1a1f2e";
static char normDWDLbgcolor[] = "#1a1f2e";
static char normSPRLbgcolor[] = "#1a1f2e";
static char normfloatbgcolor[] = "#1a1f2e";
static char actTTBbgcolor[] = "#141827";
static char actLTRbgcolor[] = "#141827";
static char actMONObgcolor[] = "#141827";
static char actGRIDbgcolor[] = "#141827";
static char actGRD1bgcolor[] = "#141827";
static char actGRD2bgcolor[] = "#141827";
static char actGRDMbgcolor[] = "#141827";
static char actHGRDbgcolor[] = "#141827";
static char actDWDLbgcolor[] = "#141827";
static char actSPRLbgcolor[] = "#141827";
static char actfloatbgcolor[] = "#141827";
static char selTTBbgcolor[] = "#ff4d80";
static char selLTRbgcolor[] = "#ff4d80";
static char selMONObgcolor[] = "#ff4d80";
static char selGRIDbgcolor[] = "#ff4d80";
static char selGRD1bgcolor[] = "#ff4d80";
static char selGRD2bgcolor[] = "#ff4d80";
static char selGRDMbgcolor[] = "#ff4d80";
static char selHGRDbgcolor[] = "#ff4d80";
static char selDWDLbgcolor[] = "#ff4d80";
static char selSPRLbgcolor[] = "#ff4d80";
static char selfloatbgcolor[] = "#ff4d80";
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
