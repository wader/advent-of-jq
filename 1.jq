#!/usr/bin/env jq -sf
( . as $depths
| [ range($depths | length-2) as $i
  | $depths[$i:$i+3]
  | add
  ]
| . as $sums
| [ range($sums | length-1) as $i
  | $sums[$i+1]-$sums[$i]
  ]
| map(select(. > 0))
| length
)
