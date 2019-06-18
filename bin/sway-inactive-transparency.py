#!/usr/bin/env python
'''
Set focused windows and unfocused windows to different opacities in i3/sway
'''

# This script requires i3ipc-python package (install it from a system package
# manager or pip). It takes up to two positional parameters: the first is used
# as the opacity value for focused windows (default 1.0) and the second as the
# opacity value for unfocused windows (default 0.8 * the focused value). Note
# that both opacity values are bounded [0..1].

from i3ipc import Connection
from sys import argv

if argv[0][:2] == 'py':
    argv = argv[1:]

fg_opacity = '1.0'
if len(argv) > 1 and 0 <= float(argv[1]) <= 1:
    fg_opacity = argv[1]

bg_opacity = str(0.8 * float(fg_opacity))
if len(argv) > 2 and 0 <= float(argv[2]) <= 1:
    bg_opacity = argv[2]

ipc = Connection()
prev_focused = None

for window in ipc.get_tree():
    if window.focused:
        prev_focused = window
        window.command('opacity ' + fg_opacity)
    else:
        window.command('opacity ' + bg_opacity)


def on_window_focus(ipc, focused):
    global prev_focused

    # https://github.com/swaywm/sway/issues/2859
    if focused.container.id != prev_focused.id:
        focused.container.command('opacity ' + fg_opacity)
        prev_focused.command('opacity ' + bg_opacity)
        prev_focused = focused.container


ipc.on("window::focus", on_window_focus)
ipc.main()
