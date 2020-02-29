#!/usr/bin/env python
""" Convert bytes to Python string """

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, you can obtain one at http://mozilla.org/MPL/2.0/.

__author__ = "Stick"
__credits__ = ["https://www.python-boilerplate.com/"]
__email__ = "stick@stma.is"
__license__ = "Mozilla PL"
__version__ = "0.1.0"

from sys import argv, stdin


def hexify(data):
    return "".join(["\\x" + hex(c)[2:] for c in data])


if __name__ == "__main__":
    """ Read from given filename, or stdin if no arguments """
    if len(argv) > 1:
        with open(argv[1], "rb") as sf:
            data = sf.read()
    else:
        data = stdin.buffer.read()

    print(hexify(data))
