#!/bin/bash

BASE=$(dirname "$0")
CONFIG_DIR="$HOME/.config/xkb/symbols/"
TYPO_FILE="optima"
TYPO_FIX_EN_FILE="enfix"
TYPO_FIX_RU_FILE="rufix"
XPROFILE="$HOME/.xprofile"
# options can be found in /usr/share/X11/xkb/rules/base.lst
SETLAYOUT="setxkbmap -layout 'us+$TYPO_FILE+$TYPO_FIX_EN_FILE,ru:2+$TYPO_FILE:2+$TYPO_FIX_RU_FILE' -option 'grp:alt_shift_toggle,grp:caps_toggle,lv3:ralt_switch,lv3:win_switch,compose:rctrl,compose:menu' -print | xkbcomp -I\${HOME}/.config/xkb - \$DISPLAY"

while [ -n "$1" ]; do
  case "$1" in
  -u) UPDATE=1 ;;
  --)
    shift
    break
    ;;
  esac
  shift
done

# Create ~/.config/xkb/symbols/ dir
echo -e "\e[32mCreating $CONFIG_DIR dir...\e[0m"
if [ ! -d "$CONFIG_DIR" ]; then
  mkdir -p "$CONFIG_DIR" || {
    echo -e "\e[31mCreating dir error. Abort.\e[0m"
    exit 1
  }
  echo -e "\e[32mDone.\e[0m"
else
  echo -e "\e[33m$CONFIG_DIR already exist.\e[0m"
fi

# Copy typo files to ~/.config/xkb/symbols/
for FILE in $TYPO_FILE $TYPO_FIX_EN_FILE $TYPO_FIX_RU_FILE
do
  echo -e "\e[32mCopying $FILE typo file...\e[0m"
  if [ -f "$BASE/$FILE" ]; then
    cp "$BASE/$FILE" "$CONFIG_DIR" || {
      echo -e "\e[31mCopying file error. Abort.\e[0m"
      exit 1
    }
    echo -e "\e[32mDone.\e[0m"
  else
    echo -e "\e[31m$BASE/$FILE does not exist, nothing to copy. Abort.\e[0m"
    exit 1
  fi
done

# Activate layout
eval "$SETLAYOUT"

# If update - exit
if [ -n "$UPDATE" ] ; then
  exit 1
fi

# Add setxkbmap command to ~/.xprofile
echo -e "\e[32mCreating $XPROFILE file...\e[0m"
if [ ! -f "$XPROFILE" ]; then
  touch "$XPROFILE" || {
    echo -e "\e[31mCreating file error. Abort.\e[0m"
    exit 1
  }
  echo -e "\e[32mDone.\e[0m"
else
  echo -e "\e[33m$XPROFILE already exist.\e[0m"
fi

echo -e "\e[32mAdding setxkbmap command to $XPROFILE...\e[0m"

if ! grep -q "$SETLAYOUT" "$XPROFILE"; then
  echo "$SETLAYOUT" >>"$XPROFILE" || {
    echo -e "\e[31mAdding setxkbmap command error. Abort.\e[0m"
    exit 1
  }
  echo -e "\e[32mDone.\e[0m"
else
  echo -e "\e[33mFile $XPROFILE already contains command setxkbmap.\e[0m"
fi
