static char normfgcolor[] = "#2c5f4a";
static char normbgcolor[] = "#f0f7f4";
static char normbordercolor[] = "#d1ebe0";
static char normfloatcolor[] = "#d1ebe0";

static char selfgcolor[] = "#ffffff";
static char selbgcolor[] = "#3b8b6b";
static char selbordercolor[] = "#2c6b51";
static char selfloatcolor[] = "#2c6b51";

static char titlenormfgcolor[] = "#5a9e87";
static char titlenormbgcolor[] = "#d1ebe0";
static char titlenormbordercolor[] = "#d1ebe0";
static char titlenormfloatcolor[] = "#d1ebe0";

static char titleselfgcolor[] = "#c4a77d";
static char titleselbgcolor[] = "#f0f7f4";
static char titleselbordercolor[] = "#3b8b6b";
static char titleselfloatcolor[] = "#3b8b6b";

static char tagsnormfgcolor[] = "#4b7b68";
static char tagsnormbgcolor[] = "#e0f0e8";
static char tagsnormbordercolor[] = "#d1ebe0";
static char tagsnormfloatcolor[] = "#d1ebe0";

static char tagsselfgcolor[] = "#d6b484";
static char tagsselbgcolor[] = "#e0f0e8";
static char tagsselbordercolor[] = "#3b8b6b";
static char tagsselfloatcolor[] = "#3b8b6b";

static char hidnormfgcolor[] = "#5a9e87";
static char hidselfgcolor[] = "#3b8b6b";
static char hidnormbgcolor[] = "#e0f0e8";
static char hidselbgcolor[] = "#d1ebe0";

static char urgfgcolor[] = "#2c6b51";
static char urgbgcolor[] = "#f0f7f4";
static char urgbordercolor[] = "#2c6b51";
static char urgfloatcolor[] = "#f0f7f4";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[] = "#ffffff";
static char scratchselbgcolor[] = "#3b8b6b";
static char scratchselbordercolor[] = "#2c6b51";
static char scratchselfloatcolor[] = "#2c6b51";

static char scratchnormfgcolor[] = "#2c5f4a";
static char scratchnormbgcolor[] = "#d1ebe0";
static char scratchnormbordercolor[] = "#5a9e87";
static char scratchnormfloatcolor[] = "#5a9e87";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[] = "#d1ebe0";
static char normLTRbgcolor[] = "#d1ebe0";
static char normMONObgcolor[] = "#d1ebe0";
static char normGRIDbgcolor[] = "#d1ebe0";
static char normGRD1bgcolor[] = "#d1ebe0";
static char normGRD2bgcolor[] = "#d1ebe0";
static char normGRDMbgcolor[] = "#d1ebe0";
static char normHGRDbgcolor[] = "#d1ebe0";
static char normDWDLbgcolor[] = "#d1ebe0";
static char normSPRLbgcolor[] = "#d1ebe0";
static char normfloatbgcolor[] = "#d1ebe0";
static char actTTBbgcolor[] = "#e0f0e8";
static char actLTRbgcolor[] = "#e0f0e8";
static char actMONObgcolor[] = "#e0f0e8";
static char actGRIDbgcolor[] = "#e0f0e8";
static char actGRD1bgcolor[] = "#e0f0e8";
static char actGRD2bgcolor[] = "#e0f0e8";
static char actGRDMbgcolor[] = "#e0f0e8";
static char actHGRDbgcolor[] = "#e0f0e8";
static char actDWDLbgcolor[] = "#e0f0e8";
static char actSPRLbgcolor[] = "#e0f0e8";
static char actfloatbgcolor[] = "#e0f0e8";
static char selTTBbgcolor[] = "#3b8b6b";
static char selLTRbgcolor[] = "#3b8b6b";
static char selMONObgcolor[] = "#3b8b6b";
static char selGRIDbgcolor[] = "#3b8b6b";
static char selGRD1bgcolor[] = "#3b8b6b";
static char selGRD2bgcolor[] = "#3b8b6b";
static char selGRDMbgcolor[] = "#3b8b6b";
static char selHGRDbgcolor[] = "#3b8b6b";
static char selDWDLbgcolor[] = "#3b8b6b";
static char selSPRLbgcolor[] = "#3b8b6b";
static char selfloatbgcolor[] = "#3b8b6b";
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
