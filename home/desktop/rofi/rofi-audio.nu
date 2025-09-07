#! /usr/bin/env nu

def main [direction: string] {
  let ctx = match ($direction | str downcase ) {
    input  => {
      prompt: "Audio Input: ",
      options: (list-inputs),
      cmd: set-default-source,
    }
    output => {
      prompt: "Audio Output: ",
      options: (list-outputs),
      cmd: set-default-sink,
    }
    _ => {
      print $"Unknown direction '($direction)'. Choose one of: [ INPUT, OUTPUT ]"
      exit 1
    }
  }

  alias choose = rofi -dmenu -i -p $ctx.prompt

  let chosen_description = $ctx.options
    | get description
    | to text
    | choose
    | str trim

  if $chosen_description != "" {
    let chosen_name = $ctx.options
      | where description == $chosen_description
      | get name
      | first

    echo $"Setting default sink to: ($chosen_name)"
    pactl $ctx.cmd $chosen_name
  } else {
    echo "No selection made."
  }
}

def list-outputs [] {
  pactl -f json list sinks
    | from json
    | select name description
}

def list-inputs [] {
  pactl -f json list sources
    | from json
    | select name description
    | filter  { |source|
      not ($source.name | str ends-with ".monitor")
    }
}
