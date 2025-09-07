#! /usr/bin/env nu

const prompt = "BT: "
alias bt = bluetoothctl
alias choose = rofi -dmenu -i -p $prompt

def main [] {
  let devices = list-bt-devices
  let sel_alias = $devices
    | each { |dev|
        let state_indicator = if $dev.connected { 'x' } else ' '
        $"[($state_indicator)] ($dev.alias)"
      }
    | to text
    | choose
    | str replace -r '^\[.\] ' ''
    | str trim

  if ($sel_alias | is-empty) {
    print "nothing selected"
    exit 0
  }

  let sel = $devices | where { |dev| $dev.alias == $sel_alias } | first

  if ($sel.connected) {
    bt disconnect $sel.id
  } else {
    bt connect $sel.id
  }
}

def list-bt-devices [] {
  bt devices
  | parse '{type} {id} {name}'
  | each { |dev| device-info $dev.id }
  | sort-by -r connected
}

def device-info [dev_id: string] {
  bt info $dev_id
    | lines
    | skip 1
    | parse '{key}: {val}'
    | each { |kvs|
        let key = $kvs.key | str trim | str snake-case
        let val = match $kvs.val {
          yes => true
          no => false
          _ => ($kvs.val | str trim)
        }
        [ $key $val ]
      }
    | into record
    | insert id $dev_id
}
