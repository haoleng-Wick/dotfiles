/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 2;        /* border pixel of windows */
static const unsigned int gappx     = 4;        /* gap pixel between windows */
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 0;        /* 0 means bottom bar */
static const char *fonts[]          = { "Hack Nerd Font:size=15",
                                        "Microsoft YaHei:size=14:type=Regular:antialias=true:autohint=true" };
static const char dmenufont[]       = "monospace:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#37473f";
static const char col_border[]      = "#ff6600";
static const unsigned int baralpha = 0xd0;
static const unsigned int borderalpha = OPAQUE;
static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_border  },
};
static const unsigned int alphas[][3]      = {
    /*               fg      bg        border*/
    [SchemeNorm] = { OPAQUE, baralpha, borderalpha },
	[SchemeSel]  = { OPAQUE, baralpha, borderalpha },
};

/* tagging */
static const char *tags[] = { "", "", "", "󰓥", "󰓓", "󱗖", "", "󰄄", "" };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
    /* class      instance    title       tags mask     isfloating   monitor    float x,y,w,h     floatborderpx    scratch key */
	{ "steam",    NULL,       NULL,       1 << 4,       0,           -1,        -1,-1,-1,-1,      2,               0  },
	{ "SimpleScreenRecorder", NULL, NULL, 1 << 7,       1,           -1,        800,150,460,700,  2,               0  },
	{ NULL,       NULL,    "scratchpad",  0,            1,           -1,        500,270,-1,-1,    2,              's' },
	{ NULL,       NULL,    "Scratchpad",  0,            1,           -1,        500,270,888,512,  2,              'S' },
	{ NULL,       NULL,     "termusic",   0,            1,           -1,        1388,20,512,320,  2,              'm' },
	{ NULL,       NULL,     "cava",       0,            1,           -1,        1060,20,320,320,  2,              'c' },
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
	/* symbol     arrange function */
    { " ",      tile },    /* first entry is default */
    { " ",      NULL },    /* no layout function means floating behavior */
    { "[M]",    monocle },
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
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "rofi", "-show", "drun", NULL };
static const char *termcmd[]  = { "st", NULL };
static const char *browse[]  = { "firefox-bin", NULL };
static const char *screenshot[]  = { "maim", "-s", "~/$(date +\"%s\").png", NULL }; //maim -s ~/$(date +"%s").png
static const char *neovide[]  = { "neovide", NULL };
static const char *backlight_add[]  = { "xbacklight", "-inc", "2", NULL };
static const char *backlight_sub[]  = { "xbacklight", "-dec", "2", NULL };
static const char *sound_add[]  = { "amixer", "-q", "set", "Master", "2%+", "unmute", NULL };
static const char *sound_sub[]  = { "amixer", "-q", "set", "Master", "2%-", "unmute", NULL };
static const char *sound_toggle[]  = { "amixer", "sset", "Master", "toggle", NULL };
static const char *music_play[]  = { "playerctl", "play", NULL };
static const char *music_pause[] = { "playerctl", "play-pause", NULL };
static const char *music_stop[]  = { "playerctl", "stop", NULL };
static const char *music_prev[]  = { "playerctl", "previous", NULL };
static const char *music_next[]  = { "playerctl", "next", NULL };
static const char *calculator[]  = { "rofi", "-show", "calc", "-modi", "calc", "-no-show-match", "-no-sort", NULL };
static const char *powermenu[]   = { "rofi", "-show", "power", "-modi", "power:~/.config/rofi/scripts/powermenu.sh", NULL };

/*First arg only serves to match against key in rules*/
static const char *scratchpadcmd[] = {"s", "st", "-t", "scratchpad", NULL}; 
static const char *Scratchpadcmd[] = {"S", "kitty", "-T", "Scratchpad", NULL}; 
static const char *termusicmd[]    = {"m", "st", "-t", "termusic", "-e", "termusic", NULL}; 

static const Key keys[] = {
	/* modifier                     key        function        argument */
    /* 自定义程序和脚本快捷键 */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = powermenu } },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_grave,  togglescratch,  {.v = scratchpadcmd } },
	{ Mod1Mask,                     XK_grave,  togglescratch,  {.v = Scratchpadcmd } },
	{ MODKEY,                       XK_m,      togglescratch,  {.v = termusicmd } },
    { MODKEY,                       XK_o,      spawn,          {.v = browse } },
    { MODKEY,                       XK_n,      spawn,          {.v = neovide } },
    { MODKEY|ShiftMask,             XK_equal,  spawn,          {.v = screenshot } },
    /* 音乐播放器控制，系统音量、| 可通过xev获取按键的编码 */
    { 0,                            0x1008ff02,spawn,          {.v = backlight_add } },
    { 0,                            0x1008ff03,spawn,          {.v = backlight_sub } },
    { 0,                            0x1008ff11,spawn,          {.v = sound_sub } },
    { 0,                            0x1008ff12,spawn,          {.v = sound_toggle } },
    { 0,                            0x1008ff13,spawn,          {.v = sound_add } },
    { MODKEY,                       0x1008ff14,spawn,          {.v = music_play } },
    { 0,                            0x1008ff15,spawn,          {.v = music_stop } },
    { 0,                            0x1008ff14,spawn,          {.v = music_pause } },
    { 0,                            0x1008ff16,spawn,          {.v = music_prev} },
    { 0,                            0x1008ff17,spawn,          {.v = music_next } },
    { 0,                            0x1008ff1d,spawn,          {.v = calculator } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_i,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.02} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.02} },
	{ MODKEY,                       XK_BackSpace, zoom,        {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },
	{ MODKEY,                       XK_f,      fullscreen,     {0} },
	{ MODKEY,                       XK_space,  togglefloating, {0} },
	{ MODKEY|ShiftMask,             XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY|ShiftMask,             XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY|ShiftMask,             XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY|ShiftMask,             XK_space,  setlayout,      {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
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
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};

