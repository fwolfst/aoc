use lazy_static::lazy_static;

use std::collections::HashMap;
use std::env;
use std::fs;

// From value x and y time to "how many elements"
lazy_static! {
    static ref CACHE :HashMap<(i64, usize),usize> = HashMap::<(i64, usize), usize>::new();
}

fn even_digits(num: i64) -> bool {
    num.to_string().len() % 2 == 0
}

fn strnum_split(num: i64) -> Vec<i64> {
    let string = num.to_string();
    let len = string.len();
    //(string[..len/2].parse().unwrap(), string[len/2..].parse().unwrap())
    vec![string[..len/2].parse().unwrap(), string[len/2..].parse().unwrap()]
}

fn evolve(world: &Vec<i64>) -> Vec<i64> {
    world.iter().flat_map(|n| {
        if n == &0 {
            vec![1]
        } else if even_digits(*n) {
            strnum_split(*n)
        } else {
            vec![n * 2024]
        }

    }).collect()
}

// using cache
fn child_evolution(n: i64, time_left: usize) -> usize{
    if CACHE.contains_key(&(n, time_left)) {
        return *CACHE.get(&(n, time_left)).unwrap();
    }
    for t in time_left..=1 {
        if n == 0 {
            CACHE.insert((0,t),child_evolution(1,t-1));
        } else if even_digits(n) {
            let s = strnum_split(n);
            CACHE.insert((0,t), child_evolution(s[0], t-1) + child_evolution(s[1], t -1));
        } else {
            //vec![n * 2024]
        }
        //CACHE.insert()
    }
    0
}

fn parse(input: &str) -> Vec<i64> {
    input
        .lines()
        .flat_map(|line| line.split_whitespace().map(|w| w.parse().unwrap()))
        .collect()
}

fn solve(input: &str) -> (usize, usize) {
    let mut world = parse(input);

    dbg!(&world);
    let mut r1 = 0;
    let mut _r2 = 0;

    for _i in 1..=25 {
        world = evolve(&world);
    }
    for _i in 1..=75 {
        //sum = child_evolution(&world.each).sum();
    }

    r1 = world.len();

    (r1, _r2)
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
            "125 17"
        };

        assert_eq!(solve(sample), (55312, 0));
    }

    #[test]
    fn even_digits_true() {
        let sample = 1217;

        assert_eq!(even_digits(sample), true);
    }

    #[test]
    fn strnum_split_splits() {
        let sample = 1217;

        assert_eq!(strnum_split(sample), vec![12, 17]);
    }
}
