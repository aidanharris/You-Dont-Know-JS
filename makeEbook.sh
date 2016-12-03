#!/bin/bash
set -e
if [ -z "$1" ]
then
  echo "Usage: "
  echo "  $0 parent directory of ebooks to build e.g:"
  echo '  '"$0 " '"'"$PWD"'"'
  exit 1
fi
printf '\n'
for d in "$1"/*/
do
	if [[ $(basename "$d") != "epubs" ]]
	then
		if [[ $(basename "$d") != "kickstarter-survey-site" ]]
		then
			CWD=""
			for f in "$1/$(basename "$d")"/*
			do
				if [[ "$(basename "$f")" != "README.md" ]]
				then
					if [[ "$CWD" == "" ]]
					then
						CWD=""$(dirname "$f")""
					fi
				fi
			done
			echo ""Processing "$CWD"...""
			if [ -f "$CWD"/cover.jpg ]
			then
				EPUBARTWORK=""--epub-cover-image=\'"$CWD"/cover.jpg\'""
			else
				echo "Cover is missing!"
				echo "We tried to find: "
				echo \'"$CWD"/cover.jpg\'
				EPUBARTWORK=""
			fi
			CMD=$(echo ""cd \'$(dirname "$CWD")/$(basename "$CWD")\' \&\& pandoc -S -o \'$(dirname "$CWD")/epubs/$(basename "$CWD").epub\' \'"$CWD"/title.txt\' "$EPUBARTWORK" \'"$CWD"\'/*.md"")
			bash -c "$CMD"
			if [ -f "$(dirname "$CWD")/epubs/$(basename "$CWD").epub" ]
			then
				echo ""Markdown exported to \'$(dirname "$CWD")/epubs/$(basename "$CWD").epub\'""
				printf '\n'
			fi
		fi
  fi
done
