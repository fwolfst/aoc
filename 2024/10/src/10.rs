//use std::collections::HashMap;
use std::env;
//use itertools::Itertools;
use std::fs;

// x,y
static DIRECTIONS : [(i32,i32);4]= [
    ( 1, 0),
    ( 0, 1),
    (-1, 0),
    ( 0,-1)
];

fn debug_mem() {
    println!();
}

fn uphills(x: usize, y: usize, value: u32, world: &Vec<Vec<u32>>) -> Vec<(usize, usize)> {
    let mut list = Vec::<(usize,usize)>::new();
    list
}

fn count_trails(x: usize, y: usize, world: &Vec<Vec<u32>>) -> i32 {
    // return position of reachable nines?
    // Pathfinder
    // collect positions one up
    0
}

fn parse(input: &str) -> Vec<Vec<u32>> {
    input.lines().map(|line| {
        line.chars().map(|c| {
            c as u32 - '0' as u32
        }).collect()
    }).collect()
}
    
fn solve(input: &str) -> (i64, i64) {
    let world = parse(input);

    // Determine starting positions
    for (y, row) in world.iter().enumerate() {
        for (x, col) in row.iter().enumerate() {
            if *col == 0 {
                // register in map
                dbg!((&x,&y));
                count_trails(x, y, &world);
            }
        }
    }

    (0,0)
}

// "cargo run sample"
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
            "89010123
             78121874
             87430965
             96549874
             45678903
             32019012
             01329801
             10456732"
        };

        assert_eq!(solve(sample), (1928, 2858));
    }

    #[test]
    fn uphills_returns_correctly() {
        let sample = indoc! {
            "89012
             78121
             10456"
        };

        assert_eq!(uphills(3,0,1,&parse(sample)),
            vec![(4,0), (3,1)]);
    }
}
