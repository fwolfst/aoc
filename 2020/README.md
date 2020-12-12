# AoC 2020

## Notes

So far, all puzzles read their input via `ARGF` (either pipe or enter data via
STDIN  or pass file name(s) as argument).

All done quick and dirty, basically without revisiting.  Don't want to win a
beauty-award here. My goal is to **find the solution while respecting the
(non-mathematical) problem domain**.

### Puzzle 1

Puzzle #1 input at https://adventofcode.com/2020/day/1/input but need
authentication to download.

I do not yet know how mean the puzzles are, so I assume a friendly input
(positive integers).

Quite some time pressure, I go without tests and super-iterative brute-force approach.

### Puzzle 2

I can obviously extend the first puzzles solution.  Messy code, but will work.
If the next puzzle wants an abstraction (*find `n` numbers summing to `m`*), I
will have to rethink.

### Puzzle 3
### Puzzle 4
We keep our course to iteratists heaven. Finally, use XOR-operator (`^`).

### Puzzle 5
When to extract geo-functions?  Have not yet created a single class, but my
first methods :)
It feels hacky as in the 90s, but way more evil than back then.

### Puzzle 6
Would feel good if I refactor a bit first. Did the bare minimum and will not
understand the solution anymore in t+2h.

### Puzzle 7 (day4#1)
Used a `Struct`. Yay!

### Puzzle 8 (day4#2)
Regexp galore.

### Puzzle 9 (day5#1)
Overdoing ranges. Index zero.
### Puzzle 10 (day5#2)

### Puzzle 11
### Puzzle 12
Break out of a single block iteration using `next <value>`.

### Puzzle 13 (day7#1)
I thought I will need some NLP and Graph theory but at the end I really needed
a `uniq`, which took me too many minutes to figure it out.
### Puzzle 14 (day7#2)
I was unhappy with part one anyway, so instead of extending like in all other
part 2s, redo it a bit more. Recursion again.

### Puzzle 15 (day8)
### Puzzle 16 (day8#2)
arg. == != =
map_with_index = each_with_index.map{|v,idx|}

### Puzzle 17 (day9)
Explode the combinations.
### Puzzle 18 (day9#2)

### Puzzle 19 (day10)
### Puzzle 20 (day10#2)
That was yesterday.

### Puzzle 21 (day11)
Raise the solution in a non SRP-SeatMap.
### Puzzle 21 (day11#2)
Nothing to be proud of here. 
Doing deep copies with `Marshal.load(Marshal.dum())` - I like it :)

### Puzzle 23 (day12)
### Puzzle 24 (day12#2)
I am sure there is a better rotation logic in the standard library.

## Recap

