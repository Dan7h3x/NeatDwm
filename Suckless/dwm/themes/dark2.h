static char normfgcolor[] = "#9bbf8f";
static char normbgcolor[] = "#1a2f1f";
static char normbordercolor[] = "#234028";
static char normfloatcolor[] = "#234028";

static char selfgcolor[] = "#f2e9c0";
static char selbgcolor[] = "#3b6e4a";
static char selbordercolor[] = "#4c9a5a";
static char selfloatcolor[] = "#4c9a5a";

static char titlenormfgcolor[] = "#7dab73";
static char titlenormbgcolor[] = "#234028";
static char titlenormbordercolor[] = "#234028";
static char titlenormfloatcolor[] = "#234028";

static char titleselfgcolor[] = "#e6b450";
static char titleselbgcolor[] = "#1a2f1f";
static char titleselbordercolor[] = "#3b6e4a";
static char titleselfloatcolor[] = "#3b6e4a";

static char tagsnormfgcolor[] = "#8bb582";
static char tagsnormbgcolor[] = "#1f3825";
static char tagsnormbordercolor[] = "#234028";
static char tagsnormfloatcolor[] = "#234028";

static char tagsselfgcolor[] = "#f0c45a";
static char tagsselbgcolor[] = "#1f3825";
static char tagsselbordercolor[] = "#3b6e4a";
static char tagsselfloatcolor[] = "#3b6e4a";

static char hidnormfgcolor[] = "#7dab73";
static char hidselfgcolor[] = "#3b6e4a";
static char hidnormbgcolor[] = "#1f3825";
static char hidselbgcolor[] = "#234028";

static char urgfgcolor[] = "#4c9a5a";
static char urgbgcolor[] = "#1a2f1f";
static char urgbordercolor[] = "#4c9a5a";
static char urgfloatcolor[] = "#1a2f1f";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[] = "#f2e9c0";
static char scratchselbgcolor[] = "#3b6e4a";
static char scratchselbordercolor[] = "#4c9a5a";
static char scratchselfloatcolor[] = "#4c9a5a";

static char scratchnormfgcolor[] = "#9bbf8f";
static char scratchnormbgcolor[] = "#234028";
static char scratchnormbordercolor[] = "#7dab73";
static char scratchnormfloatcolor[] = "#7dab73";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[] = "#234028";
static char normLTRbgcolor[] = "#234028";
static char normMONObgcolor[] = "#234028";
static char normGRIDbgcolor[] = "#234028";
static char normGRD1bgcolor[] = "#234028";
static char normGRD2bgcolor[] = "#234028";
static char normGRDMbgcolor[] = "#234028";
static char normHGRDbgcolor[] = "#234028";
static char normDWDLbgcolor[] = "#234028";
static char normSPRLbgcolor[] = "#234028";
static char normfloatbgcolor[] = "#234028";
static char actTTBbgcolor[] = "#1f3825";
static char actLTRbgcolor[] = "#1f3825";
static char actMONObgcolor[] = "#1f3825";
static char actGRIDbgcolor[] = "#1f3825";
static char actGRD1bgcolor[] = "#1f3825";
static char actGRD2bgcolor[] = "#1f3825";
static char actGRDMbgcolor[] = "#1f3825";
static char actHGRDbgcolor[] = "#1f3825";
static char actDWDLbgcolor[] = "#1f3825";
static char actSPRLbgcolor[] = "#1f3825";
static char actfloatbgcolor[] = "#1f3825";
static char selTTBbgcolor[] = "#3b6e4a";
static char selLTRbgcolor[] = "#3b6e4a";
static char selMONObgcolor[] = "#3b6e4a";
static char selGRIDbgcolor[] = "#3b6e4a";
static char selGRD1bgcolor[] = "#3b6e4a";
static char selGRD2bgcolor[] = "#3b6e4a";
static char selGRDMbgcolor[] = "#3b6e4a";
static char selHGRDbgcolor[] = "#3b6e4a";
static char selDWDLbgcolor[] = "#3b6e4a";
static char selSPRLbgcolor[] = "#3b6e4a";
static char selfloatbgcolor[] = "#3b6e4a";
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
