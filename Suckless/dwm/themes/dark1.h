static char normfgcolor[] = "#b8c1ec";
static char normbgcolor[] = "#232946";
static char normbordercolor[] = "#2a2f4b";
static char normfloatcolor[] = "#2a2f4b";

static char selfgcolor[] = "#fffffe";
static char selbgcolor[] = "#6246ea";
static char selbordercolor[] = "#7f5af0";
static char selfloatcolor[] = "#7f5af0";

static char titlenormfgcolor[] = "#9a8cd9";
static char titlenormbgcolor[] = "#2a2f4b";
static char titlenormbordercolor[] = "#2a2f4b";
static char titlenormfloatcolor[] = "#2a2f4b";

static char titleselfgcolor[] = "#f9c096";
static char titleselbgcolor[] = "#232946";
static char titleselbordercolor[] = "#6246ea";
static char titleselfloatcolor[] = "#6246ea";

static char tagsnormfgcolor[] = "#a7b0e0";
static char tagsnormbgcolor[] = "#2b2f4a";
static char tagsnormbordercolor[] = "#2a2f4b";
static char tagsnormfloatcolor[] = "#2a2f4b";

static char tagsselfgcolor[] = "#ffb86b";
static char tagsselbgcolor[] = "#2b2f4a";
static char tagsselbordercolor[] = "#6246ea";
static char tagsselfloatcolor[] = "#6246ea";

static char hidnormfgcolor[] = "#9a8cd9";
static char hidselfgcolor[] = "#6246ea";
static char hidnormbgcolor[] = "#2b2f4a";
static char hidselbgcolor[] = "#2a2f4b";

static char urgfgcolor[] = "#7f5af0";
static char urgbgcolor[] = "#232946";
static char urgbordercolor[] = "#7f5af0";
static char urgfloatcolor[] = "#232946";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[] = "#fffffe";
static char scratchselbgcolor[] = "#6246ea";
static char scratchselbordercolor[] = "#7f5af0";
static char scratchselfloatcolor[] = "#7f5af0";

static char scratchnormfgcolor[] = "#b8c1ec";
static char scratchnormbgcolor[] = "#2a2f4b";
static char scratchnormbordercolor[] = "#9a8cd9";
static char scratchnormfloatcolor[] = "#9a8cd9";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[] = "#2a2f4b";
static char normLTRbgcolor[] = "#2a2f4b";
static char normMONObgcolor[] = "#2a2f4b";
static char normGRIDbgcolor[] = "#2a2f4b";
static char normGRD1bgcolor[] = "#2a2f4b";
static char normGRD2bgcolor[] = "#2a2f4b";
static char normGRDMbgcolor[] = "#2a2f4b";
static char normHGRDbgcolor[] = "#2a2f4b";
static char normDWDLbgcolor[] = "#2a2f4b";
static char normSPRLbgcolor[] = "#2a2f4b";
static char normfloatbgcolor[] = "#2a2f4b";
static char actTTBbgcolor[] = "#2b2f4a";
static char actLTRbgcolor[] = "#2b2f4a";
static char actMONObgcolor[] = "#2b2f4a";
static char actGRIDbgcolor[] = "#2b2f4a";
static char actGRD1bgcolor[] = "#2b2f4a";
static char actGRD2bgcolor[] = "#2b2f4a";
static char actGRDMbgcolor[] = "#2b2f4a";
static char actHGRDbgcolor[] = "#2b2f4a";
static char actDWDLbgcolor[] = "#2b2f4a";
static char actSPRLbgcolor[] = "#2b2f4a";
static char actfloatbgcolor[] = "#2b2f4a";
static char selTTBbgcolor[] = "#6246ea";
static char selLTRbgcolor[] = "#6246ea";
static char selMONObgcolor[] = "#6246ea";
static char selGRIDbgcolor[] = "#6246ea";
static char selGRD1bgcolor[] = "#6246ea";
static char selGRD2bgcolor[] = "#6246ea";
static char selGRDMbgcolor[] = "#6246ea";
static char selHGRDbgcolor[] = "#6246ea";
static char selDWDLbgcolor[] = "#6246ea";
static char selSPRLbgcolor[] = "#6246ea";
static char selfloatbgcolor[] = "#6246ea";
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
