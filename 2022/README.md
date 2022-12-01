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
