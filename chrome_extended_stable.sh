#!/bin/bash
# $1: action - restore-plugins; disable-plugins

set -x

KEYSTONE_PLIST="/Library/Managed Preferences/com.google.Keystone.plist"

[[ "$EUID" == 0 ]] || { echo "need to run as root"; exit 1; }

[[ -e "${KEYSTONE_PLIST}" ]] && { echo "${KEYSTONE_PLIST} already exists"; exit 1; }

cat << EOF > "${KEYSTONE_PLIST}"
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
    <dict>
      <key>updatePolicies</key>
      <dict>
       <key>global</key>
       <dict>
        <key>UpdateDefault</key>
        <integer>0</integer>
       </dict>
      <key>com.google.Chrome</key>
       <dict>
        <key>TargetChannel</key>
        <string>extended</string>
        <key>RollbackToTargetVersion</key>
        <true/>
       </dict>
      </dict>
    </dict>
</plist>
EOF

chflags schg "${KEYSTONE_PLIST}"

