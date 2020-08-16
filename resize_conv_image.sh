#/bin/bash
# $1: source file
# $2: image dimension multiplier
# $3: format of resized image
new_height=$(echo "(${2} * $(sips -g pixelHeight "${1}" | grep pixelHeight | awk '{print $2}')) / 1" | bc)
echo "new height $new_height"
sips -s format ${3} --resampleHeight "$new_height" "${1}" --out "${1%.*}_resize.${3}"
