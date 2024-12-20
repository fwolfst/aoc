# AOC 2024

Not a great year. Lets see how much we can do about it.
Challenge is not to use Copilot (not as integrated tool, but the webapp) and not to be too ashamed - its public!

## Learnings

* Puzzle Day 8: Testing
  1. `rustodoc --test src/main.rs` executes the tests within documentation (`/// `).
    That is why often the documentation code samples often have `assert_eq!(....)`s.
    Would it be nice to have this in Ruby, but maybe without
    explicit asserts, but against after-comment content, like
    `'A'.downcase # 'a'`?
    The documentation says these will be executed with `cargo test`. On my setup, they aren't.
  2. Post-matter unit tests are trivial, use `#[test]` directive.
    These are included in `cargo test` runs.
  3. Rust does not have a squiggly unindenting heredoc, like Ruby has.
    But someone wrote a macro for it, called `indoc`.

