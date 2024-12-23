//use std::collections::HashMap;
use std::env;
use itertools::Itertools;
use std::fs;

// x,y
static DIRECTIONS: [(i32, i32); 4] = [(1, 0), (0, 1), (-1, 0), (0, -1)];

// value can be derived from world
fn uphills(x: usize, y: usize, world: &Vec<Vec<u32>>) -> Vec<(usize, usize)> {
    let value = world[y][x];

    let width_range = 0..world[0].len();
    let height_range = 0..world.len();

    let ups : Vec<(i32,i32)>= DIRECTIONS.iter().filter(|d| {
        let look = (x as i32 + d.0, y as i32 + d.1);
        width_range.contains(&(look.0 as usize)) && height_range.contains(&(look.1 as usize)) && world[look.1 as usize][look.0 as usize] == value +1
    }).map(|d| (x as i32 + d.0 , y as i32 + d.1) ).collect();

    ups.iter().map(|n| (n.0 as usize, n.1 as usize)).collect()
}

fn multi_uphills(starting_poss: &Vec<(usize, usize)>, world: &Vec<Vec<u32>>) -> Vec<(usize, usize)> {
    starting_poss.iter().flat_map(|p| uphills(p.0 as usize, p.1 as usize, world)).collect()
}

// return position of reachable nines, multiple times if multiple paths found
fn count_trails(x: usize, y: usize, world: &Vec<Vec<u32>>) -> Vec<(usize,usize)> {
    // Pathfinder: collect positions for one step up
    let mut trails = uphills(x,y,world);
    while !trails.is_empty() && world[trails[0].1][trails[0].0] != 9 {
        trails = multi_uphills(&trails, world);
    }

    // LEARN: either sort().dedup(), or use itertools .unique()
    trails
}

fn parse(input: &str) -> Vec<Vec<u32>> {
    input
        .lines()
        .map(|line| line.chars().map(|c| c as u32 - '0' as u32).collect())
        .collect()
}

fn solve(input: &str) -> (usize, usize) {
    let world = parse(input);

    let mut r1 = 0;
    let mut r2 = 0;
    // Determine starting positions
    for (y, row) in world.iter().enumerate() {
        for (x, col) in row.iter().enumerate() {
            if *col == 0 {
                // How many nines can I reach from here?
                let trails = count_trails(x, y, &world);
                r1 += trails.iter().unique().count();
                r2 += trails.iter().count();
            }
        }
    }

    (r1, r2)
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

        assert_eq!(solve(sample), (36, 81));
    }

    #[test]
    fn uphills_returns_correctly() {
        let sample = indoc! {
            "89012
             78121
             10456"
        };

        assert_eq!(uphills(3, 0, &parse(sample)), vec![(4, 0), (3, 1)]);
    }

    #[test]
    fn multi_uphill_returns_correctly() {
        let sample = indoc! {
            "89012
             78121
             10456"
        };

        let starting_poss = vec![(3_usize, 0_usize),(0_usize, 2_usize)];

        assert_eq!(multi_uphills(&starting_poss, &parse(sample)), vec![(4, 0), (3, 1)]);
    }

    #[test]
    fn count_trails_works() {
        let sample = indoc! {
            "89012
             98543
             87654"
        };

        assert_eq!(count_trails(2, 0, &parse(sample)).iter().unique().count(), 2);
    }
}
