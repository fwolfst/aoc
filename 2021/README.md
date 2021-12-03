# AoC 2021

## Notes

This year I will not be able to spend as much time on this. So, I do not aim
for somewhat readable code in the problem domain, but want to find the
solution. Besides, I would be happy to increase my writing skills (e.g.
practising by
writing the notes below)

I assume all puzzles will read their input via `ARGF` (either pipe or enter data via
STDIN  or pass file name(s) as argument).

I try to add use a `-d` (debug) flag to the programs.

## Puzzle Day I

Like last year, I already know that I will wonder whether automating the data
download is worth the time and fun.

### Part 2

Solved each puzzle with `each_cons(n)`.
Biggest problem was to put the `-d` flag for debug output in the right place
and fighting with OSX terminal and MBP/OSX keyboard. I guess they didnt print
the most interesting special characters on the keyboard due to visual design
consinderations. Of course, "€" and "$" has to be there, though.

## Puzzle Day II

`Struct` to the rescue! I can actually still model the problem domain without
thinking about algorithms or math.

At the end I did turn to meta-stuff, adding a generator for the 13 lines of
boilerplace code per day.

## Puzzle Day III

That was pretty horrible. Important lost knowledge to reactivate:
  * Read whole puzzle before starting to implement anything
  * Hash with default Proc
  * Convert `to_i` early.
  * Use `Array#count` when counting in Arrays

### Part 2

I wanted to use lambdas for filtering but that was too clever for this time of
the day. What you would probably refactor first is to use the second filter as an
inverse of the first and extract the consecutive filtering.
With that, boil it down from 70 loc to 45 loc (including the boiling plate).


# The Takeaways/Learned-Agains

Should look at these again before next years puzzling.

* <3 `ARGF` <3
* `Array#count`
* `Array#filter!` (just alias for `#select!`)
* Binary Int as String -> Integer: `String#to_i 2`
