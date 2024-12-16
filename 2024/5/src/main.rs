use std::env;
use std::fs;
use std::collections::HashMap;

// This looks suspicous, but I followed the compiler error
// messages.
fn not_empty_line(line: &&str) -> bool {
    line != &""
}

// Check correct order
fn middlenum_if_good(nums: &Vec<i32>, rules: &HashMap<i32,Vec<i32>>) -> i32 {
    for (idx, needle) in nums.iter().enumerate() {
        if idx == 0 { continue }

        if rules.get(needle).is_some() {
            let successors = &rules[needle];
            if nums.iter().take(idx).any(|n| successors.iter().any(|s| s == n)) {
                // rule broken
                return 0;
            }
        }
    }
    println!("line has good order {:?}", nums);
    nums[nums.len() / 2]
}

fn numbers_between_commata(line: &str) -> Vec<i32> {
    return line
      .split(',')
      .map(|n| n.parse().unwrap())
      .collect();
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

    let mut rules : HashMap::<i32,Vec<i32>> = HashMap::new();
    let mut dataset_separator_lineno : usize = 0;

    // rules = 
    //   input
    //     .lines
    //     .non_empty
    //     .map (first i32, second i32) # or regex matches
    //     .to_hash ...
    for line in input
        .lines()
        .take_while(not_empty_line) {
        let nums : Vec::<i32> = line.split('|').map(|s| s.parse::<i32>().ok()).flatten().collect();
        rules.entry(nums[0])
            .or_insert_with(Vec::new)
            .push(nums[1]);
        //rules.insert(nums[0], nums[1]);
        dataset_separator_lineno += 1;
    }

    let middlenums : i32 = input
        .lines()
        .skip(dataset_separator_lineno + 1)
        .map(|n| middlenum_if_good(&numbers_between_commata(n), &rules))
        .collect::<Vec<i32>>()
        //.flatten()
        .iter().sum();


    // updates.where (rules fine -> middle num) middlenumber sum
    println!("one:");
    println!("{:?}", middlenums);

    let mut r = 0;
    println!("two:");
    println!("{:?}", r);
}
