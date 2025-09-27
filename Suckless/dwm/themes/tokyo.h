static char c000000[] = "#bc7ad9"; // placeholder value

static char normfgcolor[] = "#00ffff";
static char normbgcolor[] = "#1a1b26";
static char normbordercolor[] = "#1a1b26";
static char normfloatcolor[] = "#1a1b26";

static char selfgcolor[] = "#101010";
static char selbgcolor[] = "#ededed";
static char selbordercolor[] = "#7aa2f7";
static char selfloatcolor[] = "#7aa2f7";

static char titlenormfgcolor[] = "#bc7ad9";
static char titlenormbgcolor[] = "#1a1b26";
static char titlenormbordercolor[] = "#1a1b26";
static char titlenormfloatcolor[] = "#1a1b26";

static char titleselfgcolor[] = "#9ece6a";
static char titleselbgcolor[] = "#1a1b26";
static char titleselbordercolor[] = "#bc7ada";
static char titleselfloatcolor[] = "#7aa2f7";

static char tagsnormfgcolor[] = "#00ffff";
static char tagsnormbgcolor[] = "#1a1b26";
static char tagsnormbordercolor[] = "#1a1b26";
static char tagsnormfloatcolor[] = "#1a1b26";

static char tagsselfgcolor[] = "#b7d97a";
static char tagsselbgcolor[] = "#1a1b26";
static char tagsselbordercolor[] = "#7dcfff";
static char tagsselfloatcolor[] = "#7dcfff";

static char hidnormfgcolor[] = "#1a1b26";
static char hidselfgcolor[] = "#5c9900";
static char hidnormbgcolor[] = "#f7768e";
static char hidselbgcolor[] = "#7dcfff";

static char urgfgcolor[] = "#f7768e";
static char urgbgcolor[] = "#1a1b26";
static char urgbordercolor[] = "#f7768e";
static char urgfloatcolor[] = "#1a1b26";

#if RENAMED_SCRATCHPADS_PATCH
static char scratchselfgcolor[]          = "#FFF7D4";
static char scratchselbgcolor[]          = "#77547E";
static char scratchselbordercolor[]      = "#894B9F";
static char scratchselfloatcolor[]       = "#894B9F";

static char scratchnormfgcolor[]         = "#FFF7D4";
static char scratchnormbgcolor[]         = "#664C67";
static char scratchnormbordercolor[]     = "#77547E";
static char scratchnormfloatcolor[]      = "#77547E";
#endif // RENAMED_SCRATCHPADS_PATCH

#if BAR_FLEXWINTITLE_PATCH
static char normTTBbgcolor[]             = "#1a1b26";
static char normLTRbgcolor[]             = "#1a1b26";
static char normMONObgcolor[]            = "#1a1b26";
static char normGRIDbgcolor[]            = "#1a1b26";
static char normGRD1bgcolor[]            = "#1a1b26";
static char normGRD2bgcolor[]            = "#1a1b26";
static char normGRDMbgcolor[]            = "#1a1b26";
static char normHGRDbgcolor[]            = "#1a1b26";
static char normDWDLbgcolor[]            = "#1a1b26";
static char normSPRLbgcolor[]            = "#1a1b26";
static char normfloatbgcolor[]           = "#1a1b26";
static char actTTBbgcolor[]              = "#1a1b26";
static char actLTRbgcolor[]              = "#1a1b26";
static char actMONObgcolor[]             = "#1a1b26";
static char actGRIDbgcolor[]             = "#1a1b26";
static char actGRD1bgcolor[]             = "#1a1b26";
static char actGRD2bgcolor[]             = "#1a1b26";
static char actGRDMbgcolor[]             = "#1a1b26";
static char actHGRDbgcolor[]             = "#1a1b26";
static char actDWDLbgcolor[]             = "#1a1b26";
static char actSPRLbgcolor[]             = "#1a1b26";
static char actfloatbgcolor[]            = "#1a1b26";
static char selTTBbgcolor[]              = "#1a1b26";
static char selLTRbgcolor[]              = "#1a1b26";
static char selMONObgcolor[]             = "#1a1b26";
static char selGRIDbgcolor[]             = "#1a1b26";
static char selGRD1bgcolor[]             = "#1a1b26";
static char selGRD2bgcolor[]             = "#1a1b26";
static char selGRDMbgcolor[]             = "#1a1b26";
static char selHGRDbgcolor[]             = "#1a1b26";
static char selDWDLbgcolor[]             = "#1a1b26";
static char selSPRLbgcolor[]             = "#1a1b26";
static char selfloatbgcolor[]            = "#1a1b26";
#endif // BAR_FLEXWINTITLE_PATCH

#if BAR_ALPHA_PATCH
static const unsigned int baralpha = 10;
static const unsigned int borderalpha = OPAQUE;
static const unsigned int alphas[][3] = {
	/*                       fg      bg        border     */
	[SchemeNorm]         = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]          = { OPAQUE, baralpha, borderalpha },
	[SchemeTitleNorm]    = { OPAQUE, baralpha, borderalpha },
	[SchemeTitleSel]     = { OPAQUE, baralpha, borderalpha },
	[SchemeTagsNorm]     = { OPAQUE, baralpha, borderalpha },
	[SchemeTagsSel]      = { OPAQUE, baralpha, borderalpha },
	[SchemeHidNorm]      = { OPAQUE, baralpha, borderalpha },
	[SchemeHidSel]       = { OPAQUE, baralpha, borderalpha },
	[SchemeUrg]          = { OPAQUE, baralpha, borderalpha },
	#if RENAMED_SCRATCHPADS_PATCH
	[SchemeScratchSel]  = { OPAQUE, baralpha, borderalpha },
	[SchemeScratchNorm] = { OPAQUE, baralpha, borderalpha },
	#endif // RENAMED_SCRATCHPADS_PATCH
	#if BAR_FLEXWINTITLE_PATCH
	[SchemeFlexActTTB]   = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActLTR]   = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActMONO]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActGRID]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActGRD1]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActGRD2]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActGRDM]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActHGRD]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActDWDL]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActSPRL]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexActFloat] = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaTTB]   = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaLTR]   = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaMONO]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaGRID]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaGRD1]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaGRD2]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaGRDM]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaHGRD]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaDWDL]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaSPRL]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexInaFloat] = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelTTB]   = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelLTR]   = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelMONO]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelGRID]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelGRD1]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelGRD2]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelGRDM]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelHGRD]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelDWDL]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelSPRL]  = { OPAQUE, baralpha, borderalpha },
	[SchemeFlexSelFloat] = { OPAQUE, baralpha, borderalpha },
	#endif // BAR_FLEXWINTITLE_PATCH
};
#endif // BAR_ALPHA_PATCH

// static char *statuscolors[][ColCount] = {
// 	/*                       fg                bg                border
// float */ 	[SchemeNorm]         = { "#f7768e",        normbgcolor,
// normbordercolor,      normfloatcolor }, 	[SchemeSel]          = {
// "#e0af68", normbordercolor,		selbordercolor,       selfloatcolor },
// 	[SchemeTitleNorm]    = { "#7dcfff",        normbgcolor,
// titlenormbordercolor, titlenormfloatcolor }, 	[SchemeTitleSel]     = {
// "#a9b1d6",        normbordercolor,		titleselbordercolor,
// titleselfloatcolor }, 	[SchemeTagsNorm]     = { "#ebcb8d", normbgcolor,
// tagsnormbordercolor,  tagsnormfloatcolor }, 	[SchemeTagsSel]      = {
// "#bb9af7",        normbordercolor,		tagsselbordercolor,
// tagsselfloatcolor }, 	[SchemeHidNorm]      = { "#c0caf5", normbgcolor,
// c000000,              c000000 }, 	[SchemeHidSel]       = { "#9ece6a",
// normbordercolor,		c000000,              c000000 }, 	[SchemeUrg]
// = { "#7aa2f7",        normbgcolor,			urgbordercolor,
// urgfloatcolor },
// };
