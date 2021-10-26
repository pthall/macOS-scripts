#/bin/bash
# $1: source file
# $2: video dimension multiplier
# $3: frames per second
#ffmpeg -i "${1}" -vf "fps=10,scale=1511:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 "${1%.*}.gif"
ffprobe -v error -show_entries stream=width "${1}" -of csv=p=0
#ffmpeg -i "${1}" -vf "fps=${3},scale=$(echo "(${2} * $(ffprobe -v error -show_entries stream=width "${1}" -of csv=p=0)) / 1" | bc ):-1"
ffmpeg -i "${1}" -vf "fps=${3},scale=trunc(${2}*iw/2)*2:-2" "${1%.*}.mp4"

