#!/usr/bin/env python
'''
Set focused windows and unfocused windows to different opacities in i3/sway
'''

__version__ = '0.2.0'

# This script requires i3ipc-python (installed from AUR or pip).

from argparse import ArgumentParser
from i3ipc import Connection


def set_opacities(ipc, focused, unfocused):
    for window in ipc.get_tree():
        if window.focused:
            window.command('opacity ' + focused)
        else:
            window.command('opacity ' + unfocused)


def main(args):
    '''Connect to IPC, set transparencies, and set up listener'''
    ipc = Connection()

    set_opacities(ipc, args.focused, args.unfocused)
    ipc.on('window::focus',
           lambda ipc, _: set_opacities(ipc, args.focused, args.unfocused))
    ipc.main()


if __name__ == '__main__':
    parser = ArgumentParser(description='Set window opacity based on focus')

    parser.add_argument('-f',
                        '--focused',
                        action='store',
                        dest='focused',
                        default='1.0',
                        help='opacity for focused window',
                        metavar='[0..1]')

    parser.add_argument('-u',
                        '--unfocused',
                        action='store',
                        dest='unfocused',
                        default='0.93',
                        help='opacity for unfocused windows',
                        metavar='[0..1]')

    parser.add_argument(
        '--version',
        action='version',
        version='%(prog)s (version {version})'.format(version=__version__))

    args = parser.parse_args()
    main(args)
