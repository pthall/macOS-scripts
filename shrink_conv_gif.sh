#/bin/bash
sips -s format gif --resampleHeight $(($(sips -g pixelHeight "${1}" | grep pixelHeight | awk '{print $2}')/${2})) "${1}" --out "${1%.*}.gif"
