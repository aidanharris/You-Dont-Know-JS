#!/usr/bin/env python3
import sys
if(len(sys.argv) < 2):
	sys.exit("Usage: makeMetadata.py ebook_title path_to_write_metadata")
output = ''
output += '---\n'
output += 'title: ' + sys.argv[1].split('/')[len(sys.argv[1].split('/'))-1].title() + '\n'
output += 'author: ' + 'Kyle Simpson' + '\n'
output += 'rights: ' + 'Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License' + '\n'
output += 'language: ' + 'en-US' + '\n'
output += '...'
try:
	if(sys.argv[3] == '--debug' or sys.argv[3] == '-d'):
		print(output)
except Exception as e:
	pass
with open(sys.argv[2] + '/title.txt', 'w') as metadata:
	try:
		metadata.write(output)
	except Exception as e:
		print(str(e))
