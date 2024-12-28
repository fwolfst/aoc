//use regex::Regex;
use regex::Regex;
use std::env;
use std::fs;

fn debug_map(width: i32, height: i32, parts: &Vec<Part>) {
    for y in 0..height {
        for x in 0..width {
            match parts.iter().filter(|p| p.x() == x && p.y() == y).count() {
                0 => print!("."),
                c => print!("{}",c),
            }
        }
        println!();
    }
}

#[derive(Debug)]
struct Vec2 {
    x: i32,
    y: i32,
}

#[derive(Debug)]
struct Part {
    pos: Vec2,
    vel: Vec2,
}

impl Part {
    fn x(&self) -> i32 {
        self.pos.x
    }
    fn y(&self) -> i32 {
        self.pos.y
    }
    fn step(&mut self) {
        self.pos.x += self.vel.x;
        self.pos.y += self.vel.y;
    }
}

fn line_to_part(line: &str) -> Part {
    let number_re = Regex::new(r"p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)").unwrap();
    let caps = number_re.captures(line).unwrap();

    Part {
        pos: Vec2 { x: caps[1].parse().unwrap_or(0), y: caps[2].parse().unwrap_or(0) },
        vel: Vec2 { x: caps[3].parse().unwrap_or(0), y: caps[4].parse().unwrap_or(0) },
    }
}

// p=2,4 v=2,-3
fn parse(input: &str) -> Vec<Part> {
    input
        .lines()
        .map(|line| line_to_part(line))
        .collect::<Vec<Part>>()
}


fn solve(input: &str) -> (usize, usize) {
    let mut parts = parse(input);

    debug_map(11,7,&parts);
    let width = 101;//11;//101;
    let height = 103;//103;

    for second in 0..100 {
        parts.iter_mut().for_each(|p| {
            p.step();
            p.pos.x = p.pos.x.rem_euclid(width);
            p.pos.y = p.pos.y.rem_euclid(height);

            if p.pos.x < 0 || p.pos.y < 0 {
                panic!("PAPANICNIC");
            }
        }
        );
    }

    let q1 = parts.iter().filter(|p| p.x() < (width / 2) && p.y() < (height / 2)).count();
    let q2 = parts.iter().filter(|p| p.x() > (width / 2) && p.y() < (height / 2)).count();
    let q3 = parts.iter().filter(|p| p.x() < (width / 2) && p.y() > (height / 2)).count();
    let q4 = parts.iter().filter(|p| p.x() > (width / 2) && p.y() > (height / 2)).count();
    dbg!(&q1, &q2, &q3, &q4);

    //debug_map(11,7,&parts);
    //dbg!(&parts);

    let r1 = q1 * q2 * q3 * q4;
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

#[cfg(test)]
mod tests {
    use super::*;
    use indoc::indoc;

    #[test]
    fn solves_14_correctly() {
        let sample = indoc! {
            "p=0,4 v=3,-3
             p=6,3 v=-1,-3
             p=10,3 v=-1,2
             p=2,0 v=2,-1
             p=0,0 v=1,3
             p=3,0 v=-2,-2
             p=7,6 v=-1,-3
             p=3,0 v=-1,-2
             p=9,3 v=2,3
             p=7,3 v=-1,2
             p=2,4 v=2,-3
             p=9,5 v=-3,-3"
        };

        assert_eq!(solve(sample), (12, 0));
    }
}
