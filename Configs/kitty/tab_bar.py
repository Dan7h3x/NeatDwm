from enum import Enum
from typing import Callable
from kitty.fast_data_types import Screen, add_timer, get_boss, get_options
from kitty.tab_bar import DrawData, TabBarData, ExtraData, TabAccessor, as_rgb
from kitty.utils import color_as_int
import os
import datetime
from pathlib import Path

opts = get_options()

BG = as_rgb(color_as_int(opts.color19))
FG = as_rgb(color_as_int(opts.color7))
COLOR_1 = as_rgb(color_as_int(opts.color3))
COLOR_2 = as_rgb(color_as_int(opts.color5))
COLOR_3 = as_rgb(color_as_int(opts.color4))
COLOR_4 = as_rgb(color_as_int(opts.color4))

REFRESH_TIME = 15
MAX_LENGTH_PATH = 3

folder_icon = " "
time_icon = "󰥔 "
session_icon = " "


class Cell:
    def __init__(
        self,
        icon: str,
        text_fn: Callable[[int, TabBarData], str | None],
        tab: TabBarData = None,
        bg: str = BG,
        fg: str = FG,
        color: int = COLOR_1,
        separator: str = "",
        border: tuple[str, str] = ("", ""),
    ) -> None:

        self.tab: TabBarData = tab
        self.fg: str = fg
        self.bg: str = bg
        self.color: int = color
        self.icon: str = icon
        self.text_fn: Callable[[int, TabBarData], str | None] = text_fn
        self.border: tuple[str, str] = border
        self.separator: str = separator
        self.text_length_overhead = (
            len(self.border[0] + self.border[1] + self.separator + self.icon) + 1
        )

    def draw(self, screen: Screen, max_size: int) -> None:
        text = self.text_fn(max_size - self.text_length_overhead, self.tab)

        if text is None:
            return

        screen.cursor.dim = False
        screen.cursor.bold = False
        screen.cursor.italic = False

        screen.cursor.bg = 0
        screen.cursor.fg = self.color
        screen.draw(self.border[0])

        screen.cursor.bg = self.color
        screen.cursor.fg = self.bg
        screen.cursor.bold = True
        screen.draw(self.icon)
        screen.cursor.bold = False

        if text == "":
            screen.cursor.bg = 0
            screen.cursor.fg = self.color
            screen.draw(self.border[1])
        else:
            screen.cursor.bg = self.bg
            screen.cursor.fg = self.color
            screen.draw(self.separator)

            screen.cursor.fg = self.fg
            screen.draw(f" {text}")

            screen.cursor.fg = self.bg
            screen.cursor.bg = 0
            screen.draw(self.border[1])

    def length(self, max_size: int) -> int:
        text = self.text_fn(max_size - self.text_length_overhead, self.tab)

        if text is None:
            return 0
        elif text == "":
            return len(self.icon + self.border[0] + self.border[1])
        else:
            return len(text) + self.text_length_overhead


def get_wd(max_size: int, tab: TabBarData):
    accessor = TabAccessor(tab.tab_id)

    wd = Path(accessor.active_wd)
    home = Path(os.getenv("HOME"))

    if wd.is_relative_to(home):
        wd = wd.relative_to(home)

        if wd == home:
            wd = Path("~")
        else:
            wd = Path("~") / wd

    parts = list(wd.parts)
    compressed = False
    if len(parts) > MAX_LENGTH_PATH:
        compressed = True
        parts = [parts[0], ".."] + parts[-MAX_LENGTH_PATH:]

    parts_cnt = 1 + compressed
    while parts_cnt != len(parts):
        wd = "/".join(parts[0 : 1 + compressed] + parts[parts_cnt:])
        if len(wd) <= max_size:
            return wd
        parts_cnt += 1

    if len(parts[-1]) <= max_size:
        return parts[-1]

    return None


def get_time(max_size: int, tab: TabBarData) -> str | None:
    if max_size < 5:
        return None
    else:
        return datetime.datetime.now().strftime("%H:%M")


def get_tab(max_size: int, tab: TabBarData) -> str | None:
    accessor = TabAccessor(tab.tab_id)

    if tab.title[0] == "#":
        text = tab.title[1:]
    else:
        text = str(accessor.active_exe)

    if max_size <= len(text):
        return ""
    else:
        return text


def get_session(max_size: int, tab: TabBarData) -> str | None:
    text = tab.session_name
    if text == "":
        text = "none"
    if len(text) <= max_size:
        return text
    elif max_size >= 3:
        return text[:3]
    else:
        return None


def get_tab_cell(tab: TabBarData) -> Cell:
    color = COLOR_2 if tab.is_active else COLOR_1
    return Cell(str(tab.tab_id), get_tab, tab, color=color)


def redraw_tab_bar(_):
    tm = get_boss().active_tab_manager
    if tm is not None:
        tm.mark_tab_bar_dirty()


timer_id = None

center: list[Cell] = []
active_index = 1


class CenterStrategy(Enum):
    EXPAND_ALL = 0
    EXPAND_ACTIVE = 1
    NO_EXPAND = 2
    SHOW_ACTIVE = 3
    SHOW_ACTIVE_NO_EXPAND = 4


def center_strategy(screen: Screen) -> tuple[CenterStrategy, int]:
    n_cells = len(center)

    length = n_cells - 1 + sum(map(lambda x: x.length(screen.columns), center))
    if length < screen.columns:
        return CenterStrategy.EXPAND_ALL, length

    length = n_cells - 1
    for index, cell in enumerate(center):
        if index == active_index:
            length += cell.length(screen.columns)
        else:
            length += cell.length(0)
    if length < screen.columns:
        return CenterStrategy.EXPAND_ACTIVE, length

    length = n_cells - 1 + sum(map(lambda x: x.length(0), center))
    if length < screen.columns:
        return CenterStrategy.NO_EXPAND, length

    length = center[active_index].length(screen.columns)
    if length < screen.columns:
        return CenterStrategy.SHOW_ACTIVE, length

    return CenterStrategy.SHOW_ACTIVE_NO_EXPAND, center[active_index].length(0)


def draw_center(screen: Screen, strategy: CenterStrategy):

    match strategy:
        case CenterStrategy.EXPAND_ALL:
            for idx, cell in enumerate(center):
                if idx != 0:
                    screen.draw(" ")
                cell.draw(screen, screen.columns)

        case CenterStrategy.EXPAND_ACTIVE:
            for idx, cell in enumerate(center):
                if idx != 0:
                    screen.draw(" ")
                cell.draw(screen, screen.columns * (idx == active_index))
        case CenterStrategy.NO_EXPAND:
            for idx, cell in enumerate(center):
                if idx != 0:
                    screen.draw(" ")
                cell.draw(screen, 0)
        case CenterStrategy.SHOW_ACTIVE:
            center[active_index].draw(screen, screen.columns)
        case CenterStrategy.SHOW_ACTIVE_NO_EXPAND:
            center[active_index].draw(screen, 0)


def draw_left(screen: Screen, max_length: int):
    cell = Cell(folder_icon, get_wd, center[active_index].tab, color=COLOR_4)
    cell.draw(screen, max_length)


def draw_right(screen: Screen):
    max_size = screen.columns - screen.cursor.x
    time_cell = Cell(time_icon, get_time, color=COLOR_3)
    session_cell = Cell(
        session_icon, get_session, center[active_index].tab, color=COLOR_3
    )

    total_length = time_cell.length(max_size)
    session_length = session_cell.length(max_size - total_length - 1)

    if session_length != 0:
        total_length += 1 + session_length

    offset_length = max_size - total_length
    screen.draw(" " * offset_length)

    if session_length != 0:
        session_cell.draw(screen, session_length)
        screen.draw(" ")

    time_cell.draw(screen, max_size)


def draw_tab(
    draw_data: DrawData,
    screen: Screen,
    tab: TabBarData,
    before: int,
    max_title_length: int,
    index: int,
    is_last: bool,
    extra_data: ExtraData,
) -> int:
    global center
    global timer_id
    global active_index

    if timer_id is None:
        timer_id = add_timer(redraw_tab_bar, REFRESH_TIME, True)
    if tab.is_active:
        active_index = index - 1

    center.append(get_tab_cell(tab))

    # Draw everything on the last tab
    if is_last:
        strategy, length = center_strategy(screen)

        center_start_position = (screen.columns - length) // 2
        draw_left(screen, center_start_position - 1)

        screen.cursor.x = center_start_position
        draw_center(screen, strategy)
        screen.draw(" ")

        draw_right(screen)
        center = []
    return screen.cursor.x
