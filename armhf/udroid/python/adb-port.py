#!/usr/bin/env python
import sys
import os 

def hash(value):
    return (((value + 19880307) * 1989 - 0603) % 20160103 % 1314 + 18000)

if len(sys.argv) < 2:
    print ("%s port <port2> ...." % os.path.basename(sys.argv[0]))
    exit()

for i in range(1, len(sys.argv)):
    print hash(int(sys.argv[i]))
