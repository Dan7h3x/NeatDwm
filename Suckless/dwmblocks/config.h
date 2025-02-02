//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	/* {"⌨", "sb-kbselect", 0, 30}, */
	// {"", "cat /tmp/recordingicon 2>/dev/null",	0,	9},
	// {"",	"sb-tasks",	10,	26},
	 // {"",	"sb-music",	0,	3},
	// {"",	"sb-pacpackages",	0,	8},
	// {"",	"sb-news",		0,	6},
	// /* {"",	"sb-price xmr-btc \"Monero to Bitcoin\" 🔒 25",	9000,	25}, */
	// /* {"",	"sb-price xmr Monero 🔒 24",			9000,	24}, */
	// /* {"",	"sb-price eth Ethereum 🍸 23",			9000,	23}, */
	// /* {"",	"sb-price btc Bitcoin 💰 21",			9000,	21}, */
	// {"",	"sb-torrent",	20,	7},
	// /* {"",	"sb-memory",	10,	14}, */
	 // {"",	"sb-cpu",		10,	18},
	// /* {"",	"sb-moonphase",	18000,	17}, */
	// {"",	"sb-doppler",	0,	13},
	// {"",	"sb-forecast",	18000,	5},
	// {"",	"sb-mailbox",	180,	12},
	// {"",	"sb-nettraf",	1,	16},
	// {"",	"sb-battery",	5,	3},
	// {"",	"sb-clock",	60,	1},
	// {"",	"sb-internet",	5,	4},
	// /* {"",	"sb-iplocate", 0,	27}, */
	// {"",	"sb-help-icon",	0,	15},
  {"", "wallpaperblock",0,11},
  {"",	"volumeblock",	1,	7},
  // {"",  "brightnessblock",1,6},
  {"",	"redshiftblock",	1,	8},
  {"",	"wifiblock",	1,	4},
  {"",	"cpublock",	1,	18},
  {"",	"memoryblock",	1,	15},
  {"",	"storageblock",	1,	16},
  {"",	"musicblock",	1,	3},
  {"",	"clockblock",	1,	1},
  // {"",  "batteryblock",2,5},
};

//Sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char *delim = " ";

// Have dwmblocks automatically recompile and run when you edit this file in
// vim with the following line in your vimrc/init.vim:

// autocmd BufWritePost ~/.local/src/dwmblocks/config.h !cd ~/.local/src/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }
