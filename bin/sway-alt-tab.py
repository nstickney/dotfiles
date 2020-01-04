#!/usr/bin/env python
''' Switch between all available windows in Sway '''

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.

__author__ = 'Stick'
__credits__ = ['https://gist.github.com/SidharthArya']
__email__ = 'stick@stma.is'
__license__ = 'Mozilla PL'
__version__ = '0.1.0'

from argparse import ArgumentParser
from i3ipc import Connection


def makeList(tree, workspace):
    ''' Generates a flat list of windows from a sway/i3 tree '''
    result = []
    for i in range(len(tree.nodes)):
        if tree.nodes[i].name is None:
            result.extend(makeList(tree.nodes[i], workspace))
        else:
            result.append((tree.nodes[i].id,
                           tree.nodes[i].focused,
                           workspace))
    return result


def main(args):
    ''' Main entry point of the script '''
    # Connect to sway and get the current container tree
    sway = Connection()
    tree = sway.get_tree()

    # Make a list of all windows, noting the focused window and workspace
    windows = []
    focus = None
    focus_workspace = None
    for output in tree.nodes:
        for workspace in output.nodes:
            if focus is None:
                focus = workspace.find_focused()
                if focus is not None:
                    focus = (focus.id, True, workspace.name)
                    focus_workspace = workspace.name
            windows.extend(makeList(workspace, workspace.name))

    # Set sane default if no window is currently focused
    if focus is None:
        focus = windows[0]
        focus_workspace = focus[2]

    # Limit the windows to the current workspace, unless --all is set
    possible = windows
    if not args.all:
        possible = []
        for window in windows:
            if window[2] == focus_workspace:
                possible.append(window)

    focus = possible.index(focus)

    # Focus the next window, or the previous window if --reverse is set
    new_focus = possible[(focus + 1) % len(possible)][0]
    if args.reverse:
        new_focus = possible[(focus - 1) % len(possible)][0]
    sway.command(f'[con_id={new_focus}] focus')


if __name__ == '__main__':
    ''' Executed when the script is run directly '''
    parser = ArgumentParser()

    # Optional argument to cycle through windows on all workspaces
    parser.add_argument('-a', '--all', dest='all',
                        action='store_true', default=False)

    # Optional argument to cycle through windows in reverse order
    parser.add_argument('-r', '--reverse', dest='reverse',
                        action='store_true', default=False)

    # Specify output of '--version'
    parser.add_argument(
            '--version',
            action='version',
            version='%(prog)s (version {version})'.format(version=__version__))

    main(parser.parse_args())
