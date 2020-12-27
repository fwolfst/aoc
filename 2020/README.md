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
### Puzzle 22 (day11#2)
Nothing to be proud of here. 
Doing deep copies with `Marshal.load(Marshal.dum())` - I like it :)

### Puzzle 23 (day12)
### Puzzle 24 (day12#2)
I am sure there is a better rotation logic in the standard library.

### Puzzle 25 (day13)
Pretty sure my approach will collapse for part two.
### Puzzle 26 (day13#2)
It doesnt. Curious if I hit max integer size though. Still didnt solve.
Diphotonic functions. Fun, but need more time to sink into the issue. One way
might be to calculate a non integer solution and scale it up.
After trying brute-force with narrowing down the solution space and scribbling
formulas down to papers, this is the first time during AOC where I extracted
some plain utility functions in another file to do some experiments.

### Puzzle 27 (day14)
Binary stuff. This time learn about printf %b and String.to_i/Integer.to_s
Looked at input too late. Mask definitions can appear multiple times.
### Puzzle 28 (day14#2)

### Puzzle 29 (day15)
### Puzzle 30 (day15#2)
Whooo. Thats just a tiny change. Just for fun I tried a rather stupid
optimization. The real optmization would have been to drop the list of said
words alltogether, I guess. And I am not even sure that my optimization
optimizes anything :)

### Puzzle 31 (day17)
Conways space of live. Small enough. But going with hash instead of modeling
coordinate space (or single set of coordinates). Will the rules change at day2?
or world size increase?
### Puzzle 33 (day17#2)
Okay, kinda both. Relatively trivial extension regarding the code.

### Puzzle 35 (day18)
Implementing a calculator. Somehow I did this different in university.
### Puzzle 36 (day18#2)
How not to implement a calculator.

### Puzzle 37 (day19)
Computer Linguistics was so fun at university. Automata and regular expressions
kick ass. Coffee and passion would help find a clean solution.
Did a complete rewrite before code was working.
### Puzzle 38 (day19#2)
Solution scaled well enough, no need to add modifications to the code.

### Puzzle 41 (day21)
### Puzzle 42 (day21#2)
Same code.

### Puzzle 45 (day23)
Was searching Enumerable#cycle and found it too late.
### Puzzle 46 (day23#2)
Pretending to implement a linked-list-ring.

## Recap

As to expect after a couple of days, the code quality sank considerably. Its
becoming an endurance test now.
Problem 26 required a beefy machine, patience or some other skills. Mathematics
might help a lot and I was a good mathematician once but lack a bit of training.

