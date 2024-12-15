use std::env;
use std::fs;
use regex::Regex;

fn is_xmas() -> bool {
    return false;
}

// "cargo run samples.txt"
fn main() {
    let args: Vec<String> = env::args().collect();
    //dbg!(args);

    let input_file = if args.len() > 1 {
        args[1].clone()
    } else {
        "input".to_string()
    };

    let input = fs::read_to_string(&input_file).unwrap();
    //let values = input.lines.map();
    let values: Vec<Vec<char>> = input.lines().map(|line| line.chars().collect());
    //    -1
    // -1  x  +1
    //    +1
    let directions = [
        [ 1, 0],  // EAST,
        [ 1, 1],  // SOUTH-EASH
        [ 0, 1],  // SOUTH
        [-1, 1],  // SOUTH-WEST
        [-1, 0],  // WEST
        [-1,-1],  // NORTH-WEST
        [ 0,-1],  // NORTH
        [ 1,-1],  // NORTH
    ];

    let xmas = ['X', 'M', 'A', 'S'];
    let mut r = 0;

    // TODO need iter with index
    for x in values {
        for y in x {
            for dir in directions {

                //if in_bounds(x,y, input)
                //is_xmas(input,x,y,dir)
            }
        }
    }

    println!("one:");
    println!("{:?}", r);
    println!("two:");
    println!("{:?}", r);
}
