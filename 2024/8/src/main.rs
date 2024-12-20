use std::collections::HashMap;
use std::env;
use std::fs;

/// LEARN "documentation tests"
/// `rustdoc --test src/main.rs`
/// # Examples
/// ```rust
/// let r = 1;
/// assert_eq!(r, 3); // (will fail)
/// ```
fn solve(input: &str) -> i32 {
    for (y, line) in input.lines().enumerate() {
        for (x, chr) in line.chars().enumerate() {
            if chr != '.' {

            }
        }
    }

    let mut antinodes : Vec<Vec<Vec<char>>>;
    let mut frequency_emitter_locations : HashMap<char, Vec<(i32,i32)>>;
    1
}

// "cargo run sample"
fn main() {
    let args: Vec<String> = env::args().collect();

    let input_file = if args.len() > 1 {
        args[1].clone()
    } else {
        "input".to_string()
    };

    let input = fs::read_to_string(input_file).unwrap();

    println!("One: {}", solve(&input));

    let r: usize = 0;
    println!("two:");
    println!("{:?}", r);
}

// LEARN put your tests here
#[cfg(test)]
mod tests {
    use super::*;
    use indoc::indoc;

    #[test]
    fn it_works() {
        let sample = indoc! {
            "............
            ........0...
            .....0......
            .......0....
            ....0.......
            ......A.....
            ............
            ............
            ........A...
            .........A..
            ............
            ............"
        };

        assert_eq!(solve(sample), 4);
    }
}
