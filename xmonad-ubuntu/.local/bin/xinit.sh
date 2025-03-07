sleep 1

tries=5
while ! nitrogen --restore && ((--tries)); do
  echo "nitrogen --restore failed..."
  sleep 1
done

xcompmgr -c &

# keyboard layout, compose key combinations, etc:
# https://dry.sailingissues.com/us-international-keyboard-layout.html
# TODO setxkbmap -option esperanto:qwerty -option compose:menu
