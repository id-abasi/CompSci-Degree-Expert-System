#!/usr/bin/python

import re

def get_credits(pdftxt, course):
    pdftxt.seek(0)
    credits = 0
    for line in pdftxt:
        if re.search(course, line.rstrip()):
              credits = line.rstrip().split()[-1]
    return credits

with open("hss.txt") as in_file, open('sql.txt', 'w') as out_file, open('201314.txt', "r") as pdftxt:
    num_processed = False
    for line in in_file:
        if line.startswith("--"):
            prefix = line.rstrip()[2:]
            out_file.write(line)
        else:
            if not num_processed:
                num = line.rstrip()
                num_processed = True
            else:
                name = line.rstrip()
                
                search_term = "%s %s -" % (prefix, num)
                credits = get_credits(pdftxt, search_term)
                if credits != 0:
                    stmt = "INSERT INTO Courses VALUES('%s %s', '%s', %s);\n" % (prefix, num, name, credits)
                    out_file.write(stmt)
                num_processed = False
                print('.',end="",flush=True)
print()

            
