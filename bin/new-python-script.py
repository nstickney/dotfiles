#!/usr/bin/env python
'''Create a new executable python script'''

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.

__author__ = 'Stick'
__license__ = 'Mozilla PL'

from os import chmod
from stat import S_IRUSR, S_IWUSR, S_IXUSR
from sys import argv, stderr


def main(filename):
    '''Main entry point of the script'''
    if filename[-3:] != '.py':
        filename += '.py'
    with open(filename, 'w') as f:
        with open(__file__, 'r') as s:
            f.write(s.read())
    chmod(filename, S_IRUSR | S_IWUSR | S_IXUSR)


def usage():
    '''Print the script's usage message'''
    message = 'Usage: [python[3]] ' + argv[0] + ' <filename>\n'
    stderr.write(message)
    exit(1)


if __name__ == '__main__':
    if len(argv) != 2 or '-h' in argv or '--help' in argv:
        usage()
    main(argv[1])
