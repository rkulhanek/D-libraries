import std.format;

enum ANSI_Color {
	NONE = 0,
	BLACK = 30,
	RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE,
	BRIGHT_BLACK = 90, BRIGHT_RED, BRIGHT_GREEN, BRIGHT_YELLOW,
	BRIGHT_BLUE, BRIGHT_MAGENTA, BRIGHT_CYAN, BRIGHT_WHITE
}

string text_color(string s, ANSI_Color fg, ANSI_Color bg = ANSI_Color.NONE) {
	assert(fg > 0);
	if (bg > 0) {
		return format("\x1b[%d;%dm%s\x1b[0m", fg, bg + 10, s);
	}
	else {
		return format("\x1b[%dm%s\x1b[0m", fg, s);
	}
}

/+
import std.stdio;
void main() {
	string s = "Hello, world!";
	writef("%s\n%s\n%s\n%s\n",
		ansi_color(s, ANSI_Color.BLUE),
		ansi_color(s, ANSI_Color.BLUE, ANSI_Color.YELLOW),
		ansi_color(s, ANSI_Color.BLUE, ANSI_Color.BRIGHT_YELLOW),
		ansi_color(s, ANSI_Color.BRIGHT_BLUE, ANSI_Color.BLUE),
	);
}
+/

