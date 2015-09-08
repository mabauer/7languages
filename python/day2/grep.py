#!/usr/bin/env python

# A simple grep

# Use python 3 compatible syntax or print
from __future__ import print_function

import sys
import os
import re

# Search for 'expr' in 'file', if no file is provided, stdin is used instead
def grep(expr, file=''):
    try:
        if not file or file == '':
            file = 'stdin'
            f = sys.stdin
        else: 
            f = open(file, "rU")
        for line in f:
            line = line.rstrip('\n')
            if re.search(expr, line):
                print('{}: {}'.format(file, line))
        f.close()
    except IOError:
        print('Error opening file \'{}\'.'.format(file), file=sys.stderr) 
        return       

# Very simple command line parsing: sys.argv[0] == script name, sys.argv[1:] == arguments
if len(sys.argv) < 2:
    # No arguments: print usage message
    script = os.path.basename(sys.argv[0])
    print('Usage: {} expr file...'.format(script), file=sys.stderr) 
else:
    expr =  sys.argv[1]
    print('search expression: {}'.format(expr))
    if len(sys.argv) == 2:
        grep(expr)
    else: 
        for file in sys.argv[2:]:
            grep(expr, file)
