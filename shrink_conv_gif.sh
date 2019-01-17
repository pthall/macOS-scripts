#/bin/bash
DIV=1
sips -s format gif --resampleHeight $(($(sips -g pixelHeight "$(echo $1)" | awk '{print $2}')/${2:-DIV})) $(echo $1) --out $(echo $(echo $1 | sed -E 's/(.*)\.[a-zA-Z0-9]+/\1/')".gif")