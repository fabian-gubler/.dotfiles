/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 4;        /* border pixel of windows */
static const unsigned int gappx     = 10;        /* gaps between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const unsigned int systraypinning = 0;   /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systrayonleft = 0;   	/* 0: systray in the right corner, >0: systray on left of status text */
static const unsigned int systrayspacing = 10;   /* systray spacing */
static const int systraypinningfailfirst = 1;   /* 1: if pinning fails, display systray on the first monitor, False: display systray on the last monitor*/
static int showsystray				= 1;     /* 0 means no systray */
static const int showbar            = 1;     /* 0 means no bar */
static const int topbar             = 1;     /* 0 means bottom bar */
static const char *fonts[]          = { "SFMono:size=12" };
static const char dmenufont[]       = "SFMono:size=12";
static char normbgcolor[]           = "#252A34";
static char normbordercolor[]       = "#444444";
static char normfgcolor[]           = "#bbbbbb";
static char selfgcolor[]            = "#d8dee9";
static char selbordercolor[]        = "#5e81ac";
static char selbgcolor[]            = "#434c5e";
static char *colors[][3] = {

	/*               fg           bg           border   */
	[SchemeNorm] = { normfgcolor, normbgcolor, normbordercolor },
	[SchemeSel]  = { selfgcolor,  selbgcolor,  selbordercolor  },
	[SchemeStatus]  = { normfgcolor, normbgcolor,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { selfgcolor, selbgcolor,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
    [SchemeTagsNorm]  = { normfgcolor, normbgcolor,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
    [SchemeInfoSel]  = { selfgcolor, normbgcolor,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
    [SchemeInfoNorm]  = { normfgcolor, normbgcolor,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}
};

/* tagging */
static const char *tags[] = { "1", "2", "3", "4", "5", "6", "7", "8", "9" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class				instance    title       tags mask   isfloating   monitor    float x,y,w,h       floatborderpx*/
	{ "sioyek",				NULL,       NULL,       1 << 5,		0,           -1,        50,50,500,500,      0 },
	{ "trayer",				NULL,       NULL,       ~0,			0,			 -1,		50,50,500,500,      0 },
	{ "Chromium-browser",	NULL,       NULL,       1 << 4,		0,           -1,        50,50,500,500,      0 },
	{ "firefox",			NULL,       NULL,       1 << 3,		0,           -1,        50,50,500,500,      0 },
	{ "Com.github.johnfactotum.Foliate",NULL, NULL, 1 << 2,		0,           -1,        50,50,500,500,      0 },
	{ "mpv",				NULL,       NULL,       1 << 2,		0,           -1,        50,50,500,500,      0 },
	{ "qutebrowser",		NULL,       NULL,       1 << 1,		0,           -1,        50,50,500,500,      0 },
	{ "kitty",				NULL,       NULL,       0,			0,           -1,        50,50,500,500,      0 },

	/* class				instance    title       tags mask   isfloating   monitor    float x,y,w,h       floatborderpx*/
	{ "Firefox",			NULL,       "Save As",  0,			0,           -1,        50,50,500,500,      0 },
	{ "Rofi",				NULL,	   	NULL,	  	0,			1,           -1,        50,50,1000,1000,    0 },
	{ "Blueberry.py",		NULL,	   	NULL,	  	0,			1,           -1,        50,50,1000,1000,    0 },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 0;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><=",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,				KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = {"dmenu_run -i", NULL };
static const char *termcmd[] = { "kitty", NULL };

#include "movestack.c"

static Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,						XK_p,      spawn,          SHCMD("dmenu_run -i")},
	{ MODKEY,						XK_w,      spawn,          SHCMD("qutebrowser")},
	{ MODKEY,                       XK_y,      spawn,          SHCMD("clipmenu")},
	{ MODKEY,                       XK_g,      spawn,          SHCMD("sioyek")},
	{ MODKEY,                       XK_v,      spawn,          SHCMD("spotify --force-device-scale-factor=1.5")},
	{ MODKEY,                       XK_k,      spawn,          SHCMD("$HOME/.dotfiles/scripts/dmenu/logout")},
	{ MODKEY|ShiftMask,             XK_k,      spawn,          SHCMD("$HOME/.dotfiles/scripts/dmenu/layout")},
	{ MODKEY,                       XK_b,      spawn,          SHCMD("rofi-bluetooth")},
	{ MODKEY|ControlMask,           XK_y,      spawn,          SHCMD("autorandr --load laptop")},
	{ MODKEY|ShiftMask|ControlMask, XK_y,      spawn,          SHCMD("autorandr --load monitor")},
	{ ShiftMask,					XK_Return, spawn,          SHCMD("dunstctl close-all")},

	/* modifier                     key        function        argument */
	{ MODKEY,						XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_s,      togglebar,      {0} },
    { MODKEY,						XK_a,      togglesystray,  {0} },
	{ MODKEY,                       XK_n,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_e,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_m,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_i,      setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask,           XK_n,      movestack,      {.i = +1 } },
	{ MODKEY|ControlMask,           XK_e,      movestack,      {.i = -1 } },
	{ MODKEY,                       XK_Tab,	   zoom,           {0} },
	{ MODKEY|ShiftMask,             XK_Tab,	   view,           {0} },
	{ MODKEY,						XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_h,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY,						XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_F5,     xrdb,           {.v = NULL } },
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
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
	{ ClkStatusText,        0,              Button3,        spawn,          SHCMD("xkill")},
	{ ClkStatusText,		0,				Button1,		togglesystray,	{0} },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

