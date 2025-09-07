#! /usr/bin

const prompt = 'Passwords: '
const cb_clean_session = 'clipboard-cleanup'

def copy-paste (val) {
  wl-copy ($val | to text)
  wtype -s 50 -M ctrl -k v -m ctrl
}

def clear-clipboard () {
  tmux new -d -s $cb_clean_session '
    sleep 10
    wl-copy --clear
    notify-send "Clipboard has been cleared"
    exit
  '
}

def reset-clipboard () {
  if $cb_clean_session in (tmux ls -F '#S') {
    tmux kill-session -t $cb_clean_session
    wl-copy --clear
  }
}

if ($env.WAYLAND_DISPLAY | is-empty) {
  print "You don't seem to be running on Wayland. Make sure '\$WAYLAND_DISPLAY' is set properly."
  exit 1
}

reset-clipboard # Prevent previous clipboard-cleanup from messing up the current run

let pws = gopass ls -f
let sel = $pws | tofi --prompt-text $prompt --output='DP-3'

if ($sel | is-empty) {
  print "selection is empty"
  exit 0
}

let content = gopass show $sel | lines | filter { |line| $line | is-not-empty }
let entries = $content
  | where $it =~ '^\s*\w+:'
  | each { |line|
        $line
        | parse '{key}:{val}'
        | each { |x| $x | str trim }
      }
  | flatten
let pw = { key: password, val: ($content | first) }
let fields = $pw | append $entries

let field_keys = $fields | get key
let sel = [ autotype ] | append $field_keys | to text | tofi --prompt-text $prompt

match $sel {
  autotype => {
    let user = $fields | where ($it.key | str downcase) in [ user username login ] | first
    ($user.val | to text) | wtype -
    wtype -k 'Tab'
    ($pw.val | to text) | wtype -
    wl-copy ($pw | to text)
  },
  _ => {
    let field = $fields | where $it.key == $sel | get val
    copy-paste $field
    clear-clipboard
  }
}
