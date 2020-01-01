#!/usr/bin/env python
''' Create a new executable python script '''

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.

__author__ = 'Stick'
__credits__ = ['https://www.python-boilerplate.com/']
__email__ = 'stick@stma.is'
__license__ = 'Mozilla PL'
__version__ = '0.2.0'

from argparse import ArgumentParser
from os import chmod
from stat import S_IRUSR, S_IWUSR, S_IXUSR


def main(args):
    ''' Main entry point of the script '''
    if args.filename[-3:] != '.py':
        args.filename += '.py'
    with open(args.filename, 'w') as f:
        with open(__file__, 'r') as s:
            f.write(s.read())
    chmod(args.filename, S_IRUSR | S_IWUSR | S_IXUSR)


if __name__ == '__main__':
    ''' Executed when the script is run directly '''
    parser = ArgumentParser()

    # Required positional argument
    parser.add_argument('filename', help='filename of new script')

    # Optional argument flag which defaults to False
    # parser.add_argument('-f', '--flag', action='store_true', default=False)

    # Optional argument which requires a parameter (eg. -d test)
    # parser.add_argument('-n', '--name', action='store', dest='name')

    # Optional verbosity counter (eg. -v, -vv, -vvv, etc.)
    # parser.add_argument(
    #     '-v',
    #     '--verbose',
    #     action='count',
    #     default=0,
    #     help='output verbosity (-v, -vv, etc)')

    # Specify output of '--version'
    parser.add_argument(
        '--version',
        action='version',
        version='%(prog)s (version {version})'.format(version=__version__))

    args = parser.parse_args()
    main(args)
