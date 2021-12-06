#!/usr/bin/env jq -sRf
def from_radix($base; $table):
  ( reverse
  | map($table[.])
  | reduce .[] as $c ([1,0];
      ( (.[0] * $base) as $b
      | [$b, .[1] + (.[0] * $c)]
      )
    )
  | .[1]
  );
def from_bin: from_radix(2; [0,1]);

def count_by(f):
  group_by(f) | map([(.[0] | f), length]);

def part1:
  ( transpose
  | map(count_by(.) | if .[0][1] > . [1][1] then 0 else 1 end)
  | from_radix(2; [0, 1]) as $gamma
  | from_radix(2; [1, 0]) as $epsilon
  | $gamma * $epsilon
  );

def part2:
  def search($t):
    ( {r: ., i: 0}
    | until(
        .r | length == 1;
        ( . as $s
        | ( .r
          | count_by(.[$s.i])
          | if .[0][1] > .[1][1] then $t[0] else $t[1] end
          ) as $keep
        | .r |= map(select(.[$s.i] == $keep))
        | .i |= .+1
        )
      )
    );
  ( (search([0,1]).r[0] | from_bin) as $oxygen
  | (search([1,0]).r[0] | from_bin) as $co2
  | $oxygen * $co2
  );

( split("\n")
| map(explode | map(.-48))
| part1
, part2
)