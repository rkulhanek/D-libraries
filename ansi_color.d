import std.format, std.stdio;

enum ANSI_Color {
	NONE = 0,
	BLACK = 30,
	RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE,
	BRIGHT_BLACK = 90, BRIGHT_RED, BRIGHT_GREEN, BRIGHT_YELLOW,
	BRIGHT_BLUE, BRIGHT_MAGENTA, BRIGHT_CYAN, BRIGHT_WHITE
}

string ansi_color(string s, ANSI_Color fg, ANSI_Color bg = ANSI_Color.NONE) {
	assert(fg > 0);
	if (bg > 0) {
		return format("\x1b[%d;%dm%s\x1b0m", fg, bg + 10);
	}
	else {
		return format("\x1b[%dm%s\x1b0m", fg);
	}
}

unittest {
	void main() {
		string s = "Hello, world!";
		writef("%s\n%s\n%s\n%s\n",
			ansi_color(s, ANSI_Color.RED),
			ansi_color(s, ANSI_Color.RED, ANSI_Color.BRIGHT_YELLOW),
			ansi_color(s, ANSI_Color.RED, ANSI_Color.BRIGHT_YELLOW),
			ansi_color(s, ANSI_Color.BRIGHT_RED, ANSI_Color.BRIGHT_YELLOW),
		);
	}
}
