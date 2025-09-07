#! /usr/bin/env nu

def main [con_type: string] {
  let prompt = match $con_type {
    wifi => "Wi-Fi: "
    vpn => "VPN: "
    _ => {
      print $"unknown connection type '($con_type)'"
      exit 1
    }
  }

  let connections = list-connections $con_type
  let sel_name = select-connection-name $connections $prompt

  if ($sel_name | is-empty) {
    print "nothing selected"
    exit 0
  }

  let sel = $connections
    | where { |con| $con.name == $sel_name }
    | first

  if ($sel.active) {
    nmcli con down $sel.uuid
  } else {
    nmcli con up $sel.uuid
  }
}

def list-connections [con_type: string] {
  nmcli con show
    | lines
    | skip 1 # remove table header
    | split column -r '\s{2,}'
    | drop column 1
    | rename name uuid type device
    | filter { |c| $c.type == $con_type }
    | each { |con|
        let active = nmcli -g GENERAL.STATE con show $con.name | str starts-with 'activ'
        $con | insert active $active
      }
    | flatten
}

def select-connection-name [connections: list, prompt: string] {
  alias choose = rofi -dmenu -i -p $prompt
  $connections
    | each { |con|
        let state_indicator = if $con.active { 'x' } else ' '
        $"[($state_indicator)] ($con.name)"
      }
    | to text
    | choose
    | str replace -r '^\[.\] ' ''
    | str trim
}
