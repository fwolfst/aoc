use std::fs;
use regex::Regex;

fn main() {
    let input = fs::read_to_string("input").unwrap();
    
    let re = Regex::new(r"mul\((\d+),(\d+)\)").unwrap();

    let mut r = 0;
    for (_, [mul_one, mul_two]) in re.captures_iter(&input).map(|c| c.extract()) {
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
