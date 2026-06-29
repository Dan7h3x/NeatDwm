import os
import json
from pathlib import Path

c = c
config = config
config.load_autoconfig(False)


def userscript(script_name: str):
    return os.path.join(os.path.join(config.configdir, "userscripts"), script_name)


def load_pywal_colors_json():
    """Load colors from Pywal's JSON cache file"""
    wal_json = Path.home() / ".cache" / "wal" / "colors.json"

    if wal_json.exists():
        with open(wal_json, "r") as f:
            data = json.load(f)
            return data.get("special", {}), data.get("colors", {})
    return {}, {}


# Load colors
special, colors = load_pywal_colors_json()

# Access colors
background = special.get("background", "#1e1e2e")
foreground = special.get("foreground", "#cdd6f4")
cursor = special.get("cursor", "#9aca9a")
color0 = colors.get("color0", "#313244")
color1 = colors.get("color1", "#f38ba8")
color2 = colors.get("color2", "#a6e3a1")
color3 = colors.get("color3", "#f9e2af")
color4 = colors.get("color4", "#89b4fa")
color5 = colors.get("color5", "#cba6f7")
color6 = colors.get("color6", "#94e2d5")
color7 = colors.get("color7", "#f5e0dc")  # or color15
color8 = colors.get("color8", "#45475a")
color9 = colors.get("color9", "#fab387")
color10 = colors.get("color10", "#74c7ec")
color11 = colors.get("color11", "#f5c2e7")
color12 = colors.get("color12", "#89dceb")
color13 = colors.get("color13", "#89dceb")
color14 = colors.get("color14", "#89dceb")
color15 = colors.get("color15", "#89dceb")

################
#    Themes    #
################


# Font #
c.fonts.default_family = ["Maple Mono"]
c.fonts.default_size = "11pt"


# Setting themes #

# c.colors.completion.category.bg = foreground
# c.colors.completion.category.fg = background
# c.colors.completion.category.border.bottom = color4
# c.colors.completion.category.border.top = color4
# c.colors.completion.even.bg = background
# c.colors.completion.odd.bg = background
# c.colors.completion.fg = [foreground, color4, color2]
# c.colors.completion.item.selected.bg = foreground
# c.colors.completion.item.selected.border.bottom = color1
# c.colors.completion.item.selected.border.top = color1
# c.colors.completion.item.selected.fg = background
# c.colors.completion.item.selected.match.fg = color4
# c.colors.completion.match.fg = color1
# c.colors.completion.scrollbar.bg = foreground
# c.colors.completion.scrollbar.fg = background
# c.colors.contextmenu.disabled.bg = background
# c.colors.contextmenu.disabled.fg = foreground
# c.colors.contextmenu.menu.bg = background
# c.colors.contextmenu.menu.fg = color6
# c.colors.contextmenu.selected.bg = foreground
# c.colors.contextmenu.selected.fg = background
# c.colors.downloads.bar.bg = foreground
# c.colors.downloads.error.bg = "#ea7a7a"
# c.colors.downloads.error.fg = background
# c.colors.downloads.start.bg = color4
# c.colors.downloads.start.fg = foreground
# c.colors.downloads.stop.bg = background
# c.colors.downloads.stop.fg = color7
# c.colors.hints.bg = background
# c.colors.hints.fg = color4
# c.colors.hints.match.fg = cursor
# c.colors.keyhint.bg = background
# c.colors.keyhint.fg = color5
# c.colors.keyhint.suffix.fg = cursor
# c.colors.messages.error.bg = color1
# c.colors.messages.error.border = color4
# c.colors.messages.error.fg = background
# c.colors.messages.info.bg = color9
# c.colors.messages.info.border = color4
# c.colors.messages.info.fg = background
# c.colors.messages.warning.bg = color10
# c.colors.messages.warning.border = color4
# c.colors.messages.warning.fg = background
# c.colors.prompts.bg = background
# c.colors.prompts.border = cursor
# c.colors.prompts.fg = cursor
# c.colors.prompts.selected.bg = foreground
# c.colors.prompts.selected.fg = background
# c.colors.statusbar.caret.bg = background
# c.colors.statusbar.caret.fg = color11
# c.colors.statusbar.caret.selection.bg = background
# c.colors.statusbar.caret.selection.fg = cursor
# c.colors.statusbar.command.bg = background
# c.colors.statusbar.command.fg = "#ba3cba"
# c.colors.statusbar.normal.bg = background
# c.colors.statusbar.normal.fg = foreground
# c.colors.statusbar.progress.bg = background
# c.colors.statusbar.url.fg = color4
# c.colors.statusbar.url.hover.fg = background
# c.colors.statusbar.url.success.http.fg = color14
# c.colors.statusbar.url.success.https.fg = color14
# c.colors.statusbar.url.warn.fg = color13
# c.colors.tabs.bar.bg = background
# # c.colors.tabs.odd.bg = color4
# c.colors.tabs.even.bg = color4
# c.colors.tabs.odd.fg = color4
# c.colors.tabs.even.fg = background
# c.colors.tabs.selected.even.bg = color4
# c.colors.tabs.selected.even.fg = background
# c.colors.tabs.selected.odd.bg = c.colors.tabs.selected.even.fg
# c.colors.tabs.selected.odd.fg = c.colors.tabs.selected.even.bg
c.colors.tooltip.bg = background
c.colors.tooltip.fg = color4
c.colors.webpage.bg = background
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.policy.images = "never"
config.set("colors.webpage.darkmode.enabled", False, "file://*")

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

################
# Searchengines#
################
c.url.start_pages = "https://github.com/"

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
    "g": "https://google.com/search?q={}",
    "aw": "https://wiki.archlinux.org/?search={}",
    "gh": "https://github.com/search?q={}&type=code",
    "ghr": "https://github.com/search?q={}&type=repository",
    "yt": "https://youtube.com/results?search_query={}",
    "in": "https://invidious.nerdvpn.de/search?q={}",
    "re": "https://www.reddit.com/search/?q={}",
    "so": "https://stackoverflow.com/search?q={}",
    "sg": "https://sourcegraph.com/search?q=context:global+{}&patternType=standard&sm=1",
    "wk": "https://en.wikipedia.org/wiki/Special:Search/{}",
    "mt": "https://www.magnetdl.com/search/?m=1&q={}",
    "pp": "https://www.perplexity.ai/search?q={}",
    "dd": "https://devdocs.io#q={}",
    "dp": "https://devdocs.io#q=python {}",
    "dl": "https://devdocs.io#q=lua {}",
    "dr": "https://devdocs.io#q=rust {}",
}

################
#   Settings   #
################
c.auto_save.session = True
c.content.javascript.clipboard = "access-paste"
c.content.javascript.enabled = True
c.content.notifications.presenter = "auto"
c.content.pdfjs = False
c.downloads.position = "bottom"
c.downloads.remove_finished = 10000
c.editor.command = [
    os.environ["TERMINAL"] or "st",
    "-c",
    "'floating'",
    "-e",
    "nvim",
    "-f",
    "{file}",
    "-c",
    "normal {line}G{column0}l",
]
c.tabs.indicator.width = 0
c.tabs.width = "7%"
c.tabs.padding = {"top": 5, "bottom": 5, "left": 5, "right": 5}
c.tabs.position = "top"
c.tabs.show = "multiple"
c.tabs.title.alignment = "center"
c.tabs.title.elide = "middle"
c.window.hide_decoration = True
c.window.title_format = "{perc}{current_title}"

config.set("content.webgl", False, "*")
config.set("content.canvas_reading", False)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)

c.hints.selectors["code"] = [
    ":not(pre) > code",
    "pre",
]
################
#   Keymaps    #
################
css_dark = os.path.expanduser("~/.config/qutebrowser/solarized_dark.css")
css_light = os.path.expanduser("~/.config/qutebrowser/solarized_light.css")
css_wall = os.path.expanduser("~/.cache/wal/qute.css")

config.bind(",m", f'config-cycle content.user_stylesheets {css_dark} ""')
config.bind(",l", f'config-cycle content.user_stylesheets {css_light} ""')
config.bind(",.", f'config-cycle content.user_stylesheets {css_wall} ""')
config.bind(
    ",n",
    "config-cycle colors.webpage.darkmode.enabled true false",
)
config.bind("<Ctrl-1>", "tab-focus 1")
config.bind("<Ctrl-2>", "tab-focus 2")
config.bind("<Ctrl-3>", "tab-focus 3")
config.bind("<Ctrl-4>", "tab-focus 4")
config.bind("<Ctrl-5>", "tab-focus 5")
config.bind("<Ctrl-6>", "tab-focus 6")
config.bind("<Ctrl-7>", "tab-focus 7")
config.bind("<Ctrl-8>", "tab-focus 8")
config.bind("<Ctrl-9>", "tab-focus -1")
# config.bind("<Ctrl-m>", "tab-mute")
config.bind("<Ctrl+e>", "edit-text", "insert")
config.bind("<Ctrl+e>", "cmd-edit", "command")
config.bind("<Ctrl+i>", "mode-enter normal ;; hint inputs", "insert")
config.bind("j", "scroll-page 0 0.3", "normal")
config.bind("k", "scroll-page 0 -0.3", "normal")
config.bind("<Ctrl+h>", "fake-key <left>", "insert")
config.bind("<Ctrl+j>", "fake-key <down>", "insert")
config.bind("<Ctrl+k>", "fake-key <up>", "insert")
config.bind("<Ctrl+l>", "fake-key <right>", "insert")
config.bind("<Enter>", "fake-key -g <enter>;; later 0.3s mode-leave", "insert")
config.bind("<Ctrl+h>", "rl-unix-filename-rubout", "prompt")
config.bind("<Ctrl+j>", "prompt-item-focus next", "prompt")
config.bind("<Ctrl+k>", "prompt-item-focus prev", "prompt")
config.bind("<Ctrl+g>", "fake-key -g /", "prompt")
config.bind(";c", "hint code userscript code_select")
config.bind("O", "cmd-set-text -s :open -t")
config.bind("sd", f"spawn --userscript {userscript('open_download')}")
config.bind("<Ctrl-o>", f"spawn --userscript {userscript('qutedmenu')} tab")
config.bind(";a", f"spawn --userscript {userscript('readability')}")
config.bind(";B", f"spawn --userscript {userscript('getbib')}")
config.bind("<Ctrl-m>", "hint links spawn mpv {hint-url}")
# config.bind("'", "mode-enter jump_mark")
# config.bind("+", "zoom-in")
# config.bind("-", "zoom-out")
# config.bind(".", "cmd-repeat-last")
# config.bind("/", "cmd-set-text /")
# config.bind(":", "cmd-set-text :")
# config.bind(";I", "hint images tab")
# config.bind(";O", "hint links fill :open -t -r {hint-url}")
# config.bind(";R", "hint --rapid links window")
# config.bind(";Y", "hint links yank-primary")
# config.bind(";b", "hint all tab-bg")
# config.bind(";d", "hint links download")
# config.bind(";f", "hint all tab-fg")
# config.bind(";h", "hint all hover")
# config.bind(";i", "hint images")
# config.bind(";o", "hint links fill :open {hint-url}")
# config.bind(";r", "hint --rapid links tab-bg")
# config.bind(";t", "hint inputs")
# config.bind(";y", "hint links yank")
# config.bind("<Ctrl-A>", "navigate increment")
# config.bind("<Ctrl-Alt-p>", "print")
# config.bind("<Ctrl-B>", "scroll-page 0 -1")
# config.bind("<Ctrl-D>", "scroll-page 0 0.5")
# config.bind("<Ctrl-F5>", "reload -f")
# config.bind("<Ctrl-F>", "scroll-page 0 1")
# config.bind("<Ctrl-N>", "open -w")
# config.bind("<Ctrl-PgDown>", "tab-next")
# config.bind("<Ctrl-PgUp>", "tab-prev")
# config.bind("<Ctrl-Q>", "quit")
# config.bind("<Ctrl-Return>", "selection-follow -t")
# config.bind("<Ctrl-Shift-N>", "open -p")
# config.bind("<Ctrl-Shift-T>", "undo")
# config.bind("<Ctrl-Shift-Tab>", "nop")
# config.bind("<Ctrl-Shift-W>", "close")
# config.bind("<Ctrl-T>", "open -t")
# config.bind("<Ctrl-Tab>", "tab-focus last")
# config.bind("<Ctrl-U>", "scroll-page 0 -0.5")
# config.bind("<Ctrl-V>", "mode-enter passthrough")
# config.bind("<Ctrl-W>", "tab-close")
# config.bind("<Ctrl-X>", "navigate decrement")
# config.bind("<Ctrl-^>", "tab-focus last")
# config.bind("<Ctrl-h>", "home")
# config.bind("<Ctrl-p>", "tab-pin")
# config.bind("<Ctrl-s>", "stop")
# config.bind("<Escape>", "clear-keychain ;; search ;; fullscreen --leave")
# config.bind("<F11>", "fullscreen")
# config.bind("<F5>", "reload")
# config.bind("<Return>", "selection-follow")
# config.bind("<back>", "back")
# config.bind("<forward>", "forward")
# config.bind("=", "zoom")
# config.bind("?", "cmd-set-text ?")
# config.bind("@", "macro-run")
# config.bind("B", "cmd-set-text -s :quickmark-load -t")
# config.bind("D", "tab-close -o")
# config.bind("F", "hint all tab")
# config.bind("G", "scroll-to-perc")
# config.bind("H", "back")
# config.bind("J", "tab-next")
# config.bind("K", "tab-prev")
# config.bind("L", "forward")
# config.bind("M", "bookmark-add")
# config.bind("N", "search-prev")
# config.bind("PP", "open -t -- {primary}")
# config.bind("Pp", "open -t -- {clipboard}")
# config.bind("R", "reload -f")
# config.bind("Sb", "bookmark-list --jump")
# config.bind("Sh", "history")
# config.bind("Sq", "bookmark-list")
# config.bind("Ss", "set")
# config.bind("T", "cmd-set-text -sr :tab-focus")
# config.bind("U", "undo -w")
# config.bind("V", "mode-enter caret ;; selection-toggle --line")
# config.bind("ZQ", "quit")
# config.bind("ZZ", "quit --save")
# config.bind("[[", "navigate prev")
# config.bind("]]", "navigate next")
# config.bind("`", "mode-enter set_mark")
# config.bind("ad", "download-cancel")
# config.bind("b", "cmd-set-text -s :quickmark-load")
# config.bind("cd", "download-clear")
# config.bind("co", "tab-only")
# config.bind("d", "tab-close")
# config.bind("f", "hint")
# config.bind("g$", "tab-focus -1")
# config.bind("g0", "tab-focus 1")
# config.bind("gB", "cmd-set-text -s :bookmark-load -t")
# config.bind("gC", "tab-clone")
# config.bind("gD", "tab-give")
# config.bind("gJ", "tab-move +")
# config.bind("gK", "tab-move -")
# config.bind("gO", "cmd-set-text :open -t -r {url:pretty}")
# config.bind("gU", "navigate up -t")
# config.bind("g^", "tab-focus 1")
# config.bind("ga", "open -t")
# config.bind("gb", "cmd-set-text -s :bookmark-load")
# config.bind("gd", "download")
# config.bind("gf", "view-source")
# config.bind("gg", "scroll-to-perc 0")
# config.bind("gi", "hint inputs --first")
# config.bind("gm", "tab-move")
# config.bind("go", "cmd-set-text :open {url:pretty}")
# config.bind("gt", "cmd-set-text -s :tab-select")
# config.bind("gu", "navigate up")
# config.bind("h", "scroll left")
# config.bind("i", "mode-enter insert")
# config.bind("j", "scroll down")
# config.bind("k", "scroll up")
# config.bind("l", "scroll right")
# config.bind("m", "quickmark-save")
# config.bind("n", "search-next")
# config.bind("o", "cmd-set-text -s :open")
# config.bind("pP", "open -- {primary}")
# config.bind("pp", "open -- {clipboard}")
# config.bind("q", "macro-record")
# config.bind("r", "reload")
# config.bind("sf", "save")
# config.bind("sk", "cmd-set-text -s :bind")
# config.bind("sl", "cmd-set-text -s :set -t")
# config.bind("ss", "cmd-set-text -s :set")
# config.bind(
#     "tCH",
#     "config-cycle -p -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
# )
# config.bind(
#     "tCh",
#     "config-cycle -p -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
# )
# config.bind(
#     "tCu",
#     "config-cycle -p -u {url} content.cookies.accept all no-3rdparty never ;; reload",
# )
# config.bind("tIH", "config-cycle -p -u *://*.{url:host}/* content.images ;; reload")
# config.bind("tIh", "config-cycle -p -u *://{url:host}/* content.images ;; reload")
# config.bind("tIu", "config-cycle -p -u {url} content.images ;; reload")
# config.bind("tPH", "config-cycle -p -u *://*.{url:host}/* content.plugins ;; reload")
# config.bind("tPh", "config-cycle -p -u *://{url:host}/* content.plugins ;; reload")
# config.bind("tPu", "config-cycle -p -u {url} content.plugins ;; reload")
# config.bind(
#     "tSH", "config-cycle -p -u *://*.{url:host}/* content.javascript.enabled ;; reload"
# )
# config.bind(
#     "tSh", "config-cycle -p -u *://{url:host}/* content.javascript.enabled ;; reload"
# )
# config.bind("tSu", "config-cycle -p -u {url} content.javascript.enabled ;; reload")
# config.bind(
#     "tcH",
#     "config-cycle -p -t -u *://*.{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
# )
# config.bind(
#     "tch",
#     "config-cycle -p -t -u *://{url:host}/* content.cookies.accept all no-3rdparty never ;; reload",
# )
# config.bind(
#     "tcu",
#     "config-cycle -p -t -u {url} content.cookies.accept all no-3rdparty never ;; reload",
# )
# config.bind("th", "back -t")
# config.bind("tiH", "config-cycle -p -t -u *://*.{url:host}/* content.images ;; reload")
# config.bind("tih", "config-cycle -p -t -u *://{url:host}/* content.images ;; reload")
# config.bind("tiu", "config-cycle -p -t -u {url} content.images ;; reload")
# config.bind("tl", "forward -t")
# config.bind("tpH", "config-cycle -p -t -u *://*.{url:host}/* content.plugins ;; reload")
# config.bind("tph", "config-cycle -p -t -u *://{url:host}/* content.plugins ;; reload")
# config.bind("tpu", "config-cycle -p -t -u {url} content.plugins ;; reload")
# config.bind(
#     "tsH",
#     "config-cycle -p -t -u *://*.{url:host}/* content.javascript.enabled ;; reload",
# )
# config.bind(
#     "tsh", "config-cycle -p -t -u *://{url:host}/* content.javascript.enabled ;; reload"
# )
# config.bind("tsu", "config-cycle -p -t -u {url} content.javascript.enabled ;; reload")
# config.bind("u", "undo")
# config.bind("v", "mode-enter caret")
# config.bind("wB", "cmd-set-text -s :bookmark-load -w")
# config.bind("wIf", "devtools-focus")
# config.bind("wIh", "devtools left")
# config.bind("wIj", "devtools bottom")
# config.bind("wIk", "devtools top")
# config.bind("wIl", "devtools right")
# config.bind("wIw", "devtools window")
# config.bind("wO", "cmd-set-text :open -w {url:pretty}")
# config.bind("wP", "open -w -- {primary}")
# config.bind("wb", "cmd-set-text -s :quickmark-load -w")
# config.bind("wf", "hint all window")
# config.bind("wh", "back -w")
# config.bind("wi", "devtools")
# config.bind("wl", "forward -w")
# config.bind("wo", "cmd-set-text -s :open -w")
# config.bind("wp", "open -w -- {clipboard}")
# config.bind("xO", "cmd-set-text :open -b -r {url:pretty}")
# config.bind("xo", "cmd-set-text -s :open -b")
# config.bind("yD", "yank domain -s")
# config.bind("yM", "yank inline [{title}]({url:yank}) -s")
# config.bind("yP", "yank pretty-url -s")
# config.bind("yT", "yank title -s")
# config.bind("yY", "yank -s")
# config.bind("yd", "yank domain")
# config.bind("ym", "yank inline [{title}]({url:yank})")
# config.bind("yp", "yank pretty-url")
# config.bind("yt", "yank title")
# config.bind("yy", "yank")
# config.bind("{{", "navigate prev -t")
# config.bind("}}", "navigate next -t")
# config.bind("$", "move-to-end-of-line", mode="caret")
# config.bind("0", "move-to-start-of-line", mode="caret")
# config.bind("<Ctrl-Space>", "selection-drop", mode="caret")
# config.bind("<Escape>", "mode-leave", mode="caret")
# config.bind("<Return>", "yank selection", mode="caret")
# config.bind("<Space>", "selection-toggle", mode="caret")
# config.bind("G", "move-to-end-of-document", mode="caret")
# config.bind("H", "scroll left", mode="caret")
# config.bind("J", "scroll down", mode="caret")
# config.bind("K", "scroll up", mode="caret")
# config.bind("L", "scroll right", mode="caret")
# config.bind("V", "selection-toggle --line", mode="caret")
# config.bind("Y", "yank selection -s", mode="caret")
# config.bind("[", "move-to-start-of-prev-block", mode="caret")
# config.bind("]", "move-to-start-of-next-block", mode="caret")
# config.bind("b", "move-to-prev-word", mode="caret")
# config.bind("c", "mode-enter normal", mode="caret")
# config.bind("e", "move-to-end-of-word", mode="caret")
# config.bind("gg", "move-to-start-of-document", mode="caret")
# config.bind("h", "move-to-prev-char", mode="caret")
# config.bind("j", "move-to-next-line", mode="caret")
# config.bind("k", "move-to-prev-line", mode="caret")
# config.bind("l", "move-to-next-char", mode="caret")
# config.bind("o", "selection-reverse", mode="caret")
# config.bind("v", "selection-toggle", mode="caret")
# config.bind("w", "move-to-next-word", mode="caret")
# config.bind("y", "yank selection", mode="caret")
# config.bind("{", "move-to-end-of-prev-block", mode="caret")
# config.bind("}", "move-to-end-of-next-block", mode="caret")
# config.bind("<Alt-B>", "rl-backward-word", mode="command")
# config.bind("<Alt-Backspace>", "rl-backward-kill-word", mode="command")
# config.bind("<Alt-D>", "rl-kill-word", mode="command")
# config.bind("<Alt-F>", "rl-forward-word", mode="command")
# config.bind("<Ctrl-?>", "rl-delete-char", mode="command")
# config.bind("<Ctrl-A>", "rl-beginning-of-line", mode="command")
# config.bind("<Ctrl-B>", "rl-backward-char", mode="command")
# config.bind("<Ctrl-C>", "completion-item-yank", mode="command")
# config.bind("<Ctrl-D>", "completion-item-del", mode="command")
# config.bind("<Ctrl-E>", "rl-end-of-line", mode="command")
# config.bind("<Ctrl-F>", "rl-forward-char", mode="command")
# config.bind("<Ctrl-H>", "rl-backward-delete-char", mode="command")
# config.bind("<Ctrl-K>", "rl-kill-line", mode="command")
# config.bind("<Ctrl-N>", "command-history-next", mode="command")
# config.bind("<Ctrl-P>", "command-history-prev", mode="command")
# config.bind("<Ctrl-Return>", "command-accept --rapid", mode="command")
# config.bind("<Ctrl-Shift-C>", "completion-item-yank --sel", mode="command")
# config.bind("<Ctrl-Shift-Tab>", "completion-item-focus prev-category", mode="command")
# config.bind("<Ctrl-Shift-W>", "rl-filename-rubout", mode="command")
# config.bind("<Ctrl-Tab>", "completion-item-focus next-category", mode="command")
# config.bind("<Ctrl-U>", "rl-unix-line-discard", mode="command")
# config.bind("<Ctrl-W>", 'rl-rubout " "', mode="command")
# config.bind("<Ctrl-Y>", "rl-yank", mode="command")
# config.bind("<Down>", "completion-item-focus --history next", mode="command")
# config.bind("<Escape>", "mode-leave", mode="command")
# config.bind("<PgDown>", "completion-item-focus next-page", mode="command")
# config.bind("<PgUp>", "completion-item-focus prev-page", mode="command")
# config.bind("<Return>", "command-accept", mode="command")
# config.bind("<Shift-Delete>", "completion-item-del", mode="command")
# config.bind("<Shift-Tab>", "completion-item-focus prev", mode="command")
# config.bind("<Tab>", "completion-item-focus next", mode="command")
# config.bind("<Up>", "completion-item-focus --history prev", mode="command")
# config.bind("<Ctrl-B>", "hint all tab-bg", mode="hint")
# config.bind("<Ctrl-F>", "hint links", mode="hint")
# config.bind("<Ctrl-R>", "hint --rapid links tab-bg", mode="hint")
# config.bind("<Escape>", "mode-leave", mode="hint")
# config.bind("<Return>", "hint-follow", mode="hint")
# config.bind("<Ctrl-E>", "edit-text", mode="insert")
# config.bind("<Escape>", "mode-leave", mode="insert")
# config.bind("<Shift-Escape>", "fake-key <Escape>", mode="insert")
# config.bind("<Shift-Ins>", "insert-text -- {primary}", mode="insert")
# config.bind("<Shift-Escape>", "mode-leave", mode="passthrough")
# config.bind("<Alt-B>", "rl-backward-word", mode="prompt")
# config.bind("<Alt-Backspace>", "rl-backward-kill-word", mode="prompt")
# config.bind("<Alt-D>", "rl-kill-word", mode="prompt")
# config.bind("<Alt-E>", "prompt-fileselect-external", mode="prompt")
# config.bind("<Alt-F>", "rl-forward-word", mode="prompt")
# config.bind("<Alt-Shift-Y>", "prompt-yank --sel", mode="prompt")
# config.bind("<Alt-Y>", "prompt-yank", mode="prompt")
# config.bind("<Ctrl-?>", "rl-delete-char", mode="prompt")
# config.bind("<Ctrl-A>", "rl-beginning-of-line", mode="prompt")
# config.bind("<Ctrl-B>", "rl-backward-char", mode="prompt")
# config.bind("<Ctrl-E>", "rl-end-of-line", mode="prompt")
# config.bind("<Ctrl-F>", "rl-forward-char", mode="prompt")
# config.bind("<Ctrl-H>", "rl-backward-delete-char", mode="prompt")
# config.bind("<Ctrl-K>", "rl-kill-line", mode="prompt")
# config.bind("<Ctrl-P>", "prompt-open-download --pdfjs", mode="prompt")
# config.bind("<Ctrl-Shift-W>", "rl-filename-rubout", mode="prompt")
# config.bind("<Ctrl-U>", "rl-unix-line-discard", mode="prompt")
# config.bind("<Ctrl-W>", 'rl-rubout " "', mode="prompt")
# config.bind("<Ctrl-X>", "prompt-open-download", mode="prompt")
# config.bind("<Ctrl-Y>", "rl-yank", mode="prompt")
# config.bind("<Down>", "prompt-item-focus next", mode="prompt")
# config.bind("<Escape>", "mode-leave", mode="prompt")
# config.bind("<Return>", "prompt-accept", mode="prompt")
# config.bind("<Shift-Tab>", "prompt-item-focus prev", mode="prompt")
# config.bind("<Tab>", "prompt-item-focus next", mode="prompt")
# config.bind("<Up>", "prompt-item-focus prev", mode="prompt")
# config.bind("<Escape>", "mode-leave", mode="register")
# config.bind("<Alt-Shift-Y>", "prompt-yank --sel", mode="yesno")
# config.bind("<Alt-Y>", "prompt-yank", mode="yesno")
# config.bind("<Escape>", "mode-leave", mode="yesno")
# config.bind("<Return>", "prompt-accept", mode="yesno")
# config.bind("N", "prompt-accept --save no", mode="yesno")
# config.bind("Y", "prompt-accept --save yes", mode="yesno")
# config.bind("n", "prompt-accept no", mode="yesno")
# config.bind("y", "prompt-accept yes", mode="yesno")
