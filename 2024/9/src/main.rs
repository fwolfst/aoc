//use std::collections::HashMap;
use std::env;
//use itertools::Itertools;
use std::fs;

static FREE :i32 = -1;

fn debug_mem(mem: &Vec<i32>) {
    for n in mem {
        if n < &0 {
            print!(".");
            
        } else {
            print!("{}", n);
        }
    }
    println!();
}

fn checksum(mem: Vec<i32>) -> i64 {
    let mut cursor: usize = 0;
    let mut checksum : i64 = 0;
    while cursor < mem.len() && mem[cursor] != FREE {
        checksum += (mem[cursor] * cursor as i32) as i64;
        cursor += 1;
    }

    checksum
}

fn defrag1(mem: &mut Vec<i32>) {
    let mut begin = 0;
    let mut end = mem.len() - 1;
    while end - 1 > begin {
        let id = mem[end];
        while mem[begin] != FREE {
            begin += 1;
        }
        mem[begin] = id;
        mem[end] = FREE;
        end -= 1;
    }

}

fn solve(input: &str) -> (i64, i64) {
    // LEARN shared constants?
    const FREE : i32 = -1;

    let size : u32 = input.trim().chars().map(|c| c as u32 - '0' as u32).sum();

    // This doesnt need to be a Vec, could be a slice
    let mut mem = vec![FREE; size.try_into().unwrap()];

    let mut free_it = false;
    let mut id = 0;
    let mut mem_cursor = 0;

    let nums = input.trim().chars().map(|c| c as u32 - '0' as u32);

    // Populate memory
    for (_i, num) in nums.enumerate() {
        if free_it {
            for _ in 0..num { mem_cursor += 1; }
        } else {
            for _ in 0..num {
                mem[mem_cursor] = id;
                mem_cursor += 1;
            }
            id += 1;
        }
        free_it = !free_it; // flip flop
    }

    //debug_mem(&mem);
    println!("defrag");

    // condense/"defrag"
    defrag1(&mut mem);

    //debug_mem(&mem);
    println!("scoring");

    // score
    let checksum = checksum(mem);

    println!("{}", size);
    (checksum,0)
}

// "cargo run sample"
fn main() {
    let args: Vec<String> = env::args().collect();

    let input_file = if args.len() > 1 {
        args[1].clone()
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

    #[test]
    fn it_works() {
        let sample = "2333133121414131402\n";

        assert_eq!(solve(sample), (1928, 2858));
    }

    #[test]
    fn checksum_works() {
        let mem = vec![0,0,9,9,8,1,1,1,8,8,8,2,7,7,7,3,3,3,6,4,4,6,5,5,5,5,6,6];
        assert_eq!(checksum(mem), 1928);
    }
}
