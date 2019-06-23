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

from i3ipc import Connection


def main():
    ''' Main entry point of the script '''
    sway = Connection()
    displays = sway.get_outputs()
    for display in displays:
        if display.active:
            print(display.name)


if __name__ == '__main__':
    ''' Executed when the script is run directly '''
    main()
