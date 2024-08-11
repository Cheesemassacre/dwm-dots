/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 5;        /* gaps between windows */
static const unsigned int snap      = 1;       /* snap pixel */
static const int swallowfloating    = 0;        /* 1 means swallow floating windows by default */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const char *fonts[]          = { "SourceCodePro:pixelsize=14:antialias=true:autohint=true:style=SemiBold" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#00040a"; /* podloga bara */
static const char col_gray2[]       = "#1f1d2e"; /* neaktivni prozor */
static const char col_gray3[]       = "#dcd7ba"; /* neaktivni tag */
static const char col_gray4[]       = "#dcd7ba"; /* naslov i aktivni tag tekst */
static const char col_cyan[]        = "#00040a"; /* aktivni naslov i tag */
static const char col_tag[]         = "#957fb8";
static const char col_border[]      = "#dcd7ba";
static const unsigned int baralpha = 0xe6;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_border  },
	[SchemeTagsSel]  = { col_tag, col_cyan,  col_cyan  },
};
static const unsigned int alphas[][3]      = {
    /*               fg      bg        border*/
    [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
    [SchemeSel]  = { OPAQUE, baralpha, borderalpha },
    [SchemeTagsSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "TTY", "WWW", "FMG", "MUS", "SOC", "VIM", "WS7", "WS8", "WS9" };

static const char *const autostart[] = {
	/* "st", NULL, */
	"bash", "-c", "~/.dwmstart.sh", NULL,
	NULL /* terminate */
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class                  instance    title       tags mask     isfloating   isterminal  noswallow  monitor */
	{ "Gimp",                 NULL,       NULL,       0,            1,           0,          0,         -1 },
	{ "Firefox",              NULL,       NULL,       0,            0,           0,          0,         -1 },
	{ "imv",                 NULL,       NULL,        0,            1,           0,          0,         -1 },
	{ "mpv",                  NULL,       NULL,       0,            1,           0,          0,         -1 },
	{ "Qalculate-gtk",        NULL,       NULL,       0,            1,           0,          0,         -1 },
	{ "Pavucontrol",          NULL,       NULL,       0,            1,           0,          0,         -1 },
	{ "alacritty",            NULL,       NULL,       0,            0,           1,          0,         -1 },
	{ "kitty",                NULL,       NULL,       0,            0,           1,          0,         -1 },
	{ "ranger",               NULL,       NULL,       0,            1,           0,          0,         -1 },
	{ NULL,                   NULL,   "Event Tester", 0,            0,           0,          1,         -1 }, /* xev */
	{ "st-256color",          NULL,       NULL,       0,            1,           1,          0,         -1 },
	{ "vesktop",		  NULL,       NULL,       1 << 4,       0,           0,          0,         -1 },
};

/* layout(s) */
static const float mfact     = 0.52; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "[D]",      deck },
	{ "TTT",      bstack },
	{ "===",      bstackhoriz },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL}; 
static const char *termcmd[]  = { "kitty", NULL };
/* static const char *clipcmd[]  = { "rofi", "-modi", "clipboard:greenclip", "print", "-show", "clipboard", NULL }; */
static const char *termcmd2[] = { "kitty", NULL };
static const char *browsercmd[] = {"firefox-nightly", NULL};
static const char *keepassxccmd[] = {"spotify", NULL};
static const char *emacscmd[] = {"vesktop", NULL};
static const char *rangercmd[] = {"kitty", "-e", "ranger", NULL};

Autostarttag autostarttaglist[] = {
	{.cmd = termcmd2, .tags = 1 << 0 },
	{.cmd = browsercmd, .tags = 1 << 1 },
	{.cmd = keepassxccmd, .tags = 1 << 3 },
	{.cmd = emacscmd, .tags = 1 << 4 },
	{.cmd = rangercmd, .tags = 1 << 2 },
	{.cmd = NULL, .tags = 0 },
};
#include "movestack.c"
static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_d,      spawn,          {.v = dmenucmd } }, 
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	/* { MODKEY,                       XK_p,      spawn,          {.v = clipcmd } }, */ 
	{ MODKEY|ShiftMask,             XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY|ShiftMask,             XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_g,      zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_r,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_s,      togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,			XK_c,      focusmaster,    {0} },
	{ MODKEY,                       XK_u,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY,                       XK_o,      setlayout,      {.v = &layouts[5]} },
        { MODKEY,                       XK_x,      movecenter,     {0} },
        { MODKEY|ShiftMask,             XK_j,      movestack,      {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      movestack,      {.i = -1 } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY,                       XK_minus, scratchpad_show, {0} },
	{ MODKEY|ShiftMask,             XK_minus, scratchpad_hide, {0} },
	{ MODKEY,                       XK_equal,scratchpad_remove,{0} },
	


};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	/* placemouse options, choose which feels more natural:
	 *    0 - tiled position is relative to mouse cursor
	 *    1 - tiled postiion is relative to window center
	 *    2 - mouse pointer warps to window center
	 *
	 * The moveorplace uses movemouse or placemouse depending on the floating state
	 * of the selected client. Set up individual keybindings for the two if you want
	 * to control these separately (i.e. to retain the feature to move a tiled window
	 * into a floating position).
	 */
	{ ClkClientWin,         MODKEY,         Button1,        moveorplace,    {.i = 1} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

