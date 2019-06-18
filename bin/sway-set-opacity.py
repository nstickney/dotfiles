#!/usr/bin/env python
'''
Set focused windows and unfocused windows to different opacities in i3/sway
'''

__version__ = '0.2.0'

# This script requires i3ipc-python (installed from AUR or pip).

from argparse import ArgumentParser
from i3ipc import Connection


def main(args):
    '''Connect to IPC, set transparencies, and set up listener'''
    ipc = Connection()
    for window in ipc.get_tree():
        if args.all or window.focused:
            window.command('opacity ' + args.opacity)


if __name__ == '__main__':
    parser = ArgumentParser(description='Set opacity of current window(s)')

    parser.add_argument('opacity',
                        action='store',
                        default='1.0',
                        help='desired opacity between 0 and 1',
                        metavar='[0..1]',
                        nargs='?')

    parser.add_argument('-a',
                        '--all',
                        action='store_true',
                        dest='all',
                        help='set opacity for all windows')

    parser.add_argument(
        '--version',
        action='version',
        version='%(prog)s (version {version})'.format(version=__version__))

    args = parser.parse_args()
    main(args)
