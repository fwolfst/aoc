use std::env;
use std::fs;
use regex::Regex;

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
    
    let contained_numbers = Regex::new(r"mul\((\d+),(\d+)\)").unwrap();

    println!("Reading from {:?}", input_file);

    let mut r = 0;
    for (_, [mul_one, mul_two]) in contained_numbers.captures_iter(&input).map(|c| c.extract()) {
        //println!("{:?} {:?}", mul_one, mul_two);
        let m1: i32 = mul_one.parse().unwrap();
        let m2: i32 = mul_two.parse().unwrap();
        r += m1 * m2;
    }
    println!("one:");
    println!("{:?}", r);


    //println!("two:");
    //println!("{:?}", cnt);
}
