#!/usr/bin/env jq -sRf
( reduce (capture("(?<cmd>\\w+) (?<n>\\d+)"; "g") | .n |= tonumber) as {$cmd, $n} (
    {x: 0, y: 0, aim: 0};
    if $cmd == "down" then .aim += $n
    elif $cmd == "up" then .aim -= $n
    elif $cmd == "forward" then .x += $n | .y += $n * .aim
    else .
    end
  )
| .x * .y
)
