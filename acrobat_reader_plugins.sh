#!/bin/bash
# $1: action - restore-plugins; disable-plugins
DISABLE_DIRS=( Accessibility.acroplugin Comments.acroplugin MakeAccessible.acroplugin Multimedia.acroplugin SendMail.acroplugin )
export PLUGINS_DIR="/Applications/Adobe Acrobat Reader 2020.app/Contents/Plugins"
export DISABLED_PLUGINS_DIR="/Applications/Adobe Acrobat Reader 2020.app/Contents/Disabled Plugins"

set -x

case "$1" in
  disable-plugins)
    [[ ! -e "$DISABLED_PLUGINS_DIR" ]] && sudo mkdir "$DISABLED_PLUGINS_DIR"

    # must delete any dirs already in DISABLED_PLUGINS_DIR before moving PLUGINS_DIR dirs
    for dir in "${DISABLE_DIRS[@]}" ; do
      [[ -d "$DISABLED_PLUGINS_DIR/$dir" ]] && [[ -d "$PLUGINS_DIR/$dir" ]] && rm -rf "$DISABLED_PLUGINS_DIR/$dir"
      [[ -d "$PLUGINS_DIR/$dir" ]] && sudo mv "$PLUGINS_DIR/$dir" "$DISABLED_PLUGINS_DIR/"
    done
    ;;

  restore-plugins)
    # move disabled plugins not already in the plugins dir;
    # remove disabled plugins also in the plugins dir
    find -d "$DISABLED_PLUGINS_DIR" -depth 1 -exec sh -c \
      'if [[ ! -e "$PLUGINS_DIR/$(basename "{}")" ]]; then \
        sudo mv "{}" "$PLUGINS_DIR/"; \
      else
        sudo rm -rf "{}"; \
      fi' \;
    ;;
esac

