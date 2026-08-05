//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
  {"", "wallpaperblock",3,11},
  {"",	"volumeblock",	1,	7},
  // {"",  "brightnessblock",1,6},
  {"",	"redshiftblock",	1,	8},
  // {"",	"wifiblock",	1,	4},
  {"",	"cpublock",	1,	18},
  {"",	"memoryblock",	1,	15},
  {"",	"storageblock",	1,	16},
  {"",	"musicblock",	2,	3},
  {"",	"clockblock",	1,	1},
  // {"",  "batteryblock",2,5},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = "|";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
