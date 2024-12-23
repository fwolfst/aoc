// Template for AOC solutions
// I knew this would happen.
use std::env;
use std::fs;

fn parse(input: &str) -> Vec<Vec<u32>> {
    input
        .lines()
        .map(|line| line.chars().map(|c| c as u32 - '0' as u32).collect())
        .collect()
}

fn solve(input: &str) -> (usize, usize) {
    let _world = parse(input);

    let mut r1 = 0;
    let mut r2 = 0;

    (r1, r2)
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let input_file = if args.len() > 2 {
        args[2].clone()
    } else {
        "input".to_string()
    };

    let input = fs::read_to_string(input_file).unwrap();

    let solutions = solve(&input);

    println!("One: {}", solutions.0);
    println!("Two: {}", solutions.1);
}

// LEARN put your tests here
#[cfg(test)]
mod tests {
    use super::*;
    use indoc::indoc;

    #[test]
    fn solves_correctly() {
        let sample = indoc! {
            "1 2 3
             6 5 4"
        };

        assert_eq!(solve(sample), (0, 0));
    }
}
