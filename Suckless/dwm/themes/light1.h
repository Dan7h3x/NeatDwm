static char normfgcolor[] = "#5d3a4e";
static char normbgcolor[] = "#fff0f2";
static char normbordercolor[] = "#ffd9e2";
static char normfloatcolor[] = "#ffd9e2";

static char selfgcolor[] = "#ffffff";
static char selbgcolor[] = "#e46b7a";
static char selbordercolor[] = "#c73f5c";
static char selfloatcolor[] = "#c73f5c";

static char titlenormfgcolor[] = "#b35c7a";
static char titlenormbgcolor[] = "#ffd9e2";
static char titlenormbordercolor[] = "#ffd9e2";
static char titlenormfloatcolor[] = "#ffd9e2";

static char titleselfgcolor[] = "#f9a38f";
static char titleselbgcolor[] = "#fff0f2";
static char titleselbordercolor[] = "#e46b7a";
static char titleselfloatcolor[] = "#e46b7a";

static char tagsnormfgcolor[] = "#9d6b84";
static char tagsnormbgcolor[] = "#ffe5ea";
static char tagsnormbordercolor[] = "#ffd9e2";
static char tagsnormfloatcolor[] = "#ffd9e2";

static char tagsselfgcolor[] = "#f9b5a1";
static char tagsselbgcolor[] = "#ffe5ea";
static char tagsselbordercolor[] = "#e46b7a";
static char tagsselfloatcolor[] = "#e46b7a";

static char hidnormfgcolor[] = "#b35c7a";
static char hidselfgcolor[] = "#e46b7a";
static char hidnormbgcolor[] = "#ffe5ea";
static char hidselbgcolor[] = "#ffd9e2";

static char urgfgcolor[] = "#c73f5c";
static char urgbgcolor[] = "#fff0f2";
static char urgbordercolor[] = "#c73f5c";
static char urgfloatcolor[] = "#fff0f2";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[] = "#ffffff";
static char scratchselbgcolor[] = "#e46b7a";
static char scratchselbordercolor[] = "#c73f5c";
static char scratchselfloatcolor[] = "#c73f5c";

static char scratchnormfgcolor[] = "#5d3a4e";
static char scratchnormbgcolor[] = "#ffd9e2";
static char scratchnormbordercolor[] = "#b35c7a";
static char scratchnormfloatcolor[] = "#b35c7a";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[] = "#ffd9e2";
static char normLTRbgcolor[] = "#ffd9e2";
static char normMONObgcolor[] = "#ffd9e2";
static char normGRIDbgcolor[] = "#ffd9e2";
static char normGRD1bgcolor[] = "#ffd9e2";
static char normGRD2bgcolor[] = "#ffd9e2";
static char normGRDMbgcolor[] = "#ffd9e2";
static char normHGRDbgcolor[] = "#ffd9e2";
static char normDWDLbgcolor[] = "#ffd9e2";
static char normSPRLbgcolor[] = "#ffd9e2";
static char normfloatbgcolor[] = "#ffd9e2";
static char actTTBbgcolor[] = "#ffe5ea";
static char actLTRbgcolor[] = "#ffe5ea";
static char actMONObgcolor[] = "#ffe5ea";
static char actGRIDbgcolor[] = "#ffe5ea";
static char actGRD1bgcolor[] = "#ffe5ea";
static char actGRD2bgcolor[] = "#ffe5ea";
static char actGRDMbgcolor[] = "#ffe5ea";
static char actHGRDbgcolor[] = "#ffe5ea";
static char actDWDLbgcolor[] = "#ffe5ea";
static char actSPRLbgcolor[] = "#ffe5ea";
static char actfloatbgcolor[] = "#ffe5ea";
static char selTTBbgcolor[] = "#e46b7a";
static char selLTRbgcolor[] = "#e46b7a";
static char selMONObgcolor[] = "#e46b7a";
static char selGRIDbgcolor[] = "#e46b7a";
static char selGRD1bgcolor[] = "#e46b7a";
static char selGRD2bgcolor[] = "#e46b7a";
static char selGRDMbgcolor[] = "#e46b7a";
static char selHGRDbgcolor[] = "#e46b7a";
static char selDWDLbgcolor[] = "#e46b7a";
static char selSPRLbgcolor[] = "#e46b7a";
static char selfloatbgcolor[] = "#e46b7a";
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
