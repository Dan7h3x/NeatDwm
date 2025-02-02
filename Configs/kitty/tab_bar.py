import subprocess
from datetime import datetime, timezone

from kitty.boss import get_boss
from kitty.fast_data_types import Screen, add_timer
from kitty.rgb import Color
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title
from kitty.utils import color_as_int

# Constants
ICON = "  "
RIGHT_MARGIN = 1
REFRESH_TIME = 5  # Refresh every 5 seconds

# Colors
icon_fg = as_rgb(color_as_int(Color(255, 250, 205)))
icon_bg = as_rgb(color_as_int(Color(47, 61, 68)))
bat_text_color = as_rgb(0x999F93)
clock_color = as_rgb(0x7FBBB3)
utc_color = as_rgb(color_as_int(Color(113, 115, 116)))
dnd_color = as_rgb(0x465258)
sep_color = as_rgb(0x999F93)

# Battery Icons and Colors
UNPLUGGED_ICONS = {
    10: "", 20: "", 30: "", 40: "", 50: "",
    60: "", 70: "", 80: "", 90: "", 100: "",
}
PLUGGED_ICONS = {1: ""}
UNPLUGGED_COLORS = {15: as_rgb(0xFF0000), 16: as_rgb(0x00FF00)}
PLUGGED_COLORS = {15: as_rgb(0x00FF00), 100: as_rgb(0xA7C080)}

timer_id = None


def _get_battery_status():
    try:
        status = subprocess.run("~/.dotfiles/bin/btry -s", shell=True, capture_output=True, text=True).stdout.strip()
        percent = int(subprocess.run("~/.dotfiles/bin/btry -p", shell=True, capture_output=True, text=True).stdout.strip())
    except Exception:
        status, percent = "Unknown", 0

    if status == "Discharging":
        icon = UNPLUGGED_ICONS[min(UNPLUGGED_ICONS.keys(), key=lambda x: abs(x - percent))]
        color = UNPLUGGED_COLORS[min(UNPLUGGED_COLORS.keys(), key=lambda x: abs(x - percent))]
    else:
        icon = PLUGGED_ICONS[min(PLUGGED_ICONS.keys(), key=lambda x: abs(x - percent))]
        color = PLUGGED_COLORS[min(PLUGGED_COLORS.keys(), key=lambda x: abs(x - percent))]

    return [(color, icon), (bat_text_color, f" {percent}%")]


def _get_dnd_status():
    try:
        result = subprocess.run("~/.dotfiles/bin/dnd -k", shell=True, capture_output=True, text=True)
        return result.stdout.strip() if result.stdout else ""
    except subprocess.CalledProcessError:
        return ""


def _draw_icon(screen: Screen, index: int) -> int:
    if index != 1:
        return 0
    fg, bg = screen.cursor.fg, screen.cursor.bg
    screen.cursor.fg = icon_fg
    screen.cursor.bg = icon_bg
    screen.draw(ICON)
    screen.cursor.fg, screen.cursor.bg = fg, bg
    screen.cursor.x = len(ICON)
    return screen.cursor.x


def _draw_left_status(draw_data: DrawData, screen: Screen, tab: TabBarData, before: int, max_title_length: int, index: int, is_last: bool, extra_data: ExtraData) -> int:
    if draw_data.leading_spaces:
        screen.draw(" " * draw_data.leading_spaces)

    draw_title(draw_data, screen, tab, index)
    trailing_spaces = min(max_title_length - 1, draw_data.trailing_spaces)
    max_title_length -= trailing_spaces
    extra = screen.cursor.x - before - max_title_length
    if extra > 0:
        screen.cursor.x -= extra + 1
        screen.draw("...")
    if trailing_spaces:
        screen.draw(" " * trailing_spaces)
    end = screen.cursor.x
    screen.cursor.bold = screen.cursor.italic = False
    screen.cursor.fg = 0
    if not is_last:
        screen.cursor.bg = as_rgb(color_as_int(draw_data.inactive_bg))
        screen.draw(draw_data.sep)
    screen.cursor.bg = 0
    return end


def _draw_right_status(screen: Screen, is_last: bool) -> int:
    if not is_last:
        return 0

    global timer_id
    if timer_id is None:
        timer_id = add_timer(_redraw_tab_bar, REFRESH_TIME, True)

    clock = datetime.now().strftime("%H:%M")
    utc = datetime.now(timezone.utc).strftime(" (UTC %H:%M)")
    dnd = _get_dnd_status()
    battery_cells = _get_battery_status()

    cells = []
    if dnd:
        cells.append((dnd_color, dnd))
        cells.append((sep_color, " ⋮ "))
    cells.extend(battery_cells)
    cells.append((sep_color, " ⋮ "))
    cells.append((clock_color, clock))
    cells.append((utc_color, utc))

    right_status_length = RIGHT_MARGIN + sum(len(str(cell[1])) for cell in cells)
    draw_spaces = screen.columns - screen.cursor.x - right_status_length

    if draw_spaces > 0:
        screen.draw(" " * draw_spaces)

    for color, status in cells:
        screen.cursor.fg = color
        screen.draw(status)
    screen.cursor.bg = 0

    return screen.cursor.x


def _redraw_tab_bar():
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


def draw_tab(draw_data: DrawData, screen: Screen, tab: TabBarData, before: int, max_title_length: int, index: int, is_last: bool, extra_data: ExtraData) -> int:
    _draw_icon(screen, index)
    _draw_left_status(draw_data, screen, tab, before, max_title_length, index, is_last, extra_data)
    _draw_right_status(screen, is_last)
    return screen.cursor.x