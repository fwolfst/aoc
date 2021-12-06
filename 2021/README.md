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

## Puzzle Day IV

How to track the "hit" spaces on the board? How to figure out when a row or
column is fully matched?

Instead of tracking that and out of the laziness to look up how `Matrix` works,
I wanted to proceed quickly and added an additional row and column to each
"board"-array-of-arrays. So in the last column and the last row I would store
how many hits have been within this row/column. As numbers are never drawn
twice, I can figure out a winning board by looking at the last column/row.
This makes calculating the score unintuive though: first I have to figure out
which number where hit, second I have to remove the last column and row.

Part 2 did not add very much to the table.

## Puzzle Day V

The fear of searching the algorithms from my Computer Graphic classes of how to
figure out which pixels are hit "how much" by a line was luckily without
reason. Stumbled over the regex-fu.

### Part 2

The diagonals hit me twice: 1) because descending ranges are empty in ruby 2)
because even with diagonals, there are 4 variants of "directions" of lines and I
chose to implement a step-wise-along-the-line-approach.

## Puzzle Day VI

In part 1, do the real simulation (fun!)
because we do not know where the ship is heading.

### Part 2

Guess what: solution from part 1 takes too long on my beloved Dell Latitude
64xx.

And I did not find the direct formula. Thus decided to only work on the distribution
of fish ages (the order does not matter, for knowing how many fish there are
tomorrow you only need to know how many will give birth).

Superhappy to have finally used `Hash#tally`

# The Takeaways/Learned-Agains

Should look at these again before next years puzzling.

* <3 `ARGF` <3
* `Array#count`
* `Array#filter!` (just alias for `#select!`)
* Binary Int as String -> Integer: `String#to_i 2`
* or use `i = Integer(y,2)` and access bits `i[1]`.
* Ruby doesnt have `descending ranges`: `(4..2).to_a == [] ; (2..4).to_a =
  [2,3,4]`
