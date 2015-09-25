#!/usr/bin/env python3
import sys
if(len(sys.argv) < 2):
	sys.exit("Usage: fixImages.py File_To_Fix.md")
output = ''
with open(str(sys.argv[1]), 'r') as file:
	try:
		for line in file:
			if('<img' in line):
				line = "![](" + line.split(' ')[1].split('=')[1][1:][0:-1] + ")"
				if(line[len(line)-3:] == '">)'):
					line = line[0:-3] + ')'
			else:
				try:
					if(sys.argv[2] == '--debug' or sys.argv[2] == '-d'):
						print(line)
				except Exception as e:
					if(str(e) != 'list index out of range'):
						print(e)
			output += line
			if(line[len(line)-1]!='\n'):
				output += '\n'
		#file.write(output)
	except Exception as e:
		print('Error!\n%s'%(str(e)))
		#print(sys.argv[1])
		sys.exit()
with open(str(sys.argv[1]), 'w') as file:
	file.seek(0)
	file.write(output)
	file.truncate()
