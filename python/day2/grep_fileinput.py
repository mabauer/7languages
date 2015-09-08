#!/usr/bin/env python

# A simple grep using fileinput

# Use python 3 compatible syntax or print
from __future__ import print_function

import sys
import fileinput
import re

# Search for 'expr' in 'files', if no files are provided, stdin is used instead
# Note that this will stop on the first non-readable file!
def grep(expr, files): 
    try:
        for line in fileinput.input(files, mode='rU'):
            line = line.rstrip('\n')
            if re.search(expr, line):
                if fileinput.isstdin():
                    file_name = 'stdin'
                else:
                    file_name = fileinput.filename()
                print('{}: {}'.format(file_name, line))
    except IOError:
        print('Error opening file \'{}\'.'.format(fileinput.filename()), file=sys.stderr)

    
# Very simple command line parsing: sys.argv[0] == script name, sys.argv[1:] == arguments
if len(sys.argv) < 2:
    # No arguments: print usage message
    script = os.path.basename(sys.argv[0])
    print('Usage: {} expr file...'.format(script), file=sys.stderr) 
else:
    expr =  sys.argv[1]
    grep(expr, sys.argv[2:])
