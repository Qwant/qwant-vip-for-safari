#!/bin/bash

mkdir tmp

echo ""
echo "⤵️  Downloading list converter"
git clone https://github.com/Qwant/SafariConverterLib.git -b qwant-main

echo ""
echo "⤵️  Converting safelist"
mkdir macOS\ \(App\)/Content\ Blockers/Generated/allow
(cd SafariConverterLib && cat ../Scripts/safelist.txt | swift run ConverterTool --safari-version 16 --optimize true --advanced-blocking true --output-file-name QwantSafelist)
mv QwantSafelist.json macOS\ \(App\)/Content\ Blockers/Generated/allow/QwantSafelist.json

echo ""
echo "⤵️  Converting lists"
categories=("ads" "annoyances" "language" "other" "privacy" "security" "social")

for category in ${categories[@]}; do
  	while read -r line; do

  		# Create folder based on the category
	    mkdir macOS\ \(App\)/Content\ Blockers/Generated/${category}

	    # Curl lists
	    name=$(echo $line | cut -d ';' -f 1)
	    state=$(echo $line | cut -d ';' -f 2)
	    url=$(echo $line | cut -d ';' -f 3)

	    if [ "$state" == "off" ]; then
	    	continue
	    fi

	    curl $url > tmp/$name

	    # Replace cursed parts
	    tail -r tmp/$name > tmp/${name}_ # Reverse the file

	    awk '! /^$/ && ! /^\s+$/ && ! /qwant/ && ! /^!/ && ! /^\[/ && !x[$0]++ { sub("\\$all", "$document"); print }' tmp/${name}_ > tmp/${name}__
	    # This command does the following:
	    #
		# 1. `! /^$/ && ! /^\s+$/`: This checks if the line is not empty or not just whitespace. If the line meets this condition, the command proceeds to the next step.
		# 2. `! /qwant/`: This checks if the line does not contain the word "qwant". If the line meets this condition, the command proceeds to the next step.
		# 3. `! /^!/ && ! /^\[/`: This checks if the line does not start with "!" or "[". If the line meets this condition, the command proceeds to the next step.
		# 4. `! x[$0]++`: This checks if the current line has not been seen before. If the line is not a duplicate, the command proceeds to the next step.
		# 5. `{ sub("\\$all", "$document"); print }`: This replaces all occurrences of "$all" with "$document" in the current line, and then prints the modified line.

	    tail -r tmp/${name}__ > tmp/$name # Reverse back to its original order

	    # Convert to Safari style
	    (cd SafariConverterLib && cat ../tmp/${name} | swift run ConverterTool --safari-version 16 --optimize true --advanced-blocking true --output-file-name $name)

	    # Move to the correct folder
	    mv ${name}.json macOS\ \(App\)/Content\ Blockers/Generated/${category}/${name}.json

	done <macOS\ \(App\)/Content\ Blockers/Lists/${category}.txt
done

rm -rf tmp
rm -rf SafariConverterLib