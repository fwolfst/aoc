# AoC 2022

## Notes

This year I will not be able to spend as much time on this. So, I do not aim
for somewhat readable code in the problem domain, but want to find the
solution. Besides, I would be happy to increase my writing skills (e.g.
practising by
writing the notes below)

Just for fun, this is the exact same note as last year.

I assume all puzzles will read their input via `ARGF` (either pipe or enter data via
STDIN  or pass file name(s) as argument).

## Puzzle Day I

Nothing particularly tricky here. The input is very small and my machine very beefy, so I chain every method of [Enumerable](https://ruby-doc.org/core-3.1.2/Enumerable.html) and [Array](https://ruby-doc.org/core-3.1.2/Array.html) I know of together.
I was a bit surprised that there is no `reverse_sort` (documentation mentions `sort_by{..}.reverse!`).

## Puzzle Day II

Oh, my. I simple exploded all solutions, in the hope that this is faster than thinking through the math of Rock, Paper, Scissors. Took 25 minutes. Fastest responses on AOC were under 5 minutes. Math wins.

Oh, my 2. The math is fun - index, subtract and use mod 3 (`% 3`). But some of the top 100 solvers did explode and lookup, just like me (but more concise and faster).

### Puzzle Day III

Learned different ways to split a string in half, but did not find that any was more expressive then what I had.

### Puzzle Day IV

Some confusion about `cover?` and `include?`, otherwise I am happy with my
solution.

## Puzzle Day V

Searched something like `[] <<* ary.pop(3)`, but found nothing (`<< [1,2]` will
push the `[1,2]` array, where I want the individual items in the array to be
pushed). So had to resort to `[].push *ary.pop(3)`.

## Puzzle Day VI

Enumerable will stay our best friend, even if `each_slice` should have an option
to behave like `each_cons`. Solutions could be condensed.

## Puzzle Day VII

Initiallize I wanted to play with Ruby 3.1s upcoming `Data` (~immutable Struct)
implementation, but then I saw the time on the clock.

I implemented a Struct instead and was able to stay close to the domain without
crossing the bar of 50 lines of code.

Niceties too look out for in the solutions: The "wtf, then I use `ObjectSpace`"-
moment, and "I do not like chains" at the end.
