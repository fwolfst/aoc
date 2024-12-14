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

    // This seems to eat not enough :(
    // let mult_off_on = Regex::new(r"don't\(\).*?do\(\)").unwrap();
    // let after = mult_off_on.replace_all(&input, "");

    let tokens = Regex::new(r"(mul\((\d+),(\d+)\)|don't\(\)|do\(\))").unwrap();

    let mut enabled = true;

    let mut r = 0;
    for token in tokens.captures_iter(&input) {
        //dbg!(&token);
        let op = token.get(1).map_or("", |m| m.as_str());
        if op.starts_with("mul") {
            let m1: i32 =  token.get(2).map_or(0, |m| m.as_str().parse().unwrap());
            let m2: i32 =  token.get(3).map_or(0, |m| m.as_str().parse().unwrap());
            if enabled {
                r += m1 * m2;
            }
        }
        else if op.starts_with("do(") {
            enabled = true;
        }
        else if op.starts_with("don") {
            enabled = false;
        }
        else {
            println!("Unknown token");
        }
    }

    println!("two:");
    println!("{:?}", r);
}
