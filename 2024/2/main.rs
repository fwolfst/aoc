use std::fs;

fn unsafe_at(nums: Vec<i32>) -> usize {
    let ascending : bool = nums[0] < nums[1];
    let good_range = if ascending { 1..=3 } else { -3..=-1 };

    let mut nums_iter = nums.iter();
    let mut left = nums_iter.next().unwrap();

    // iter -> all / any / take_while
    for (pos, right) in nums_iter.enumerate() {
        //println!("{right} {left}");
        if !good_range.contains(&(right - left)) {
            return pos + 1;
        }
        left = right; // copy?
    }

    0
}

// Learning Rust iter api
// map_windows
// filter_map
fn is_safe(line: &str) -> bool {
    // next_chunk and array_next_chunk are experimental.
    // going pair-wise manually for the lack of patience
    let nums = num_from_line(line);

    //let mut skip = 0;

    // Let em CPUs burn
    for i in 0..nums.len() {
        let mut shortnums = nums.clone();
        shortnums.remove(i);
        if unsafe_at(shortnums) == 0 { // see the optimization possibility here
            return true;
        }
    }
    
    false
}

fn num_from_line(line: &str) -> Vec<i32> {
    return line
        .split(' ')
        .map(|n| n.parse::<i32>())
        .collect::<Result<Vec<i32>, _>>()
        .expect("cannot parse line");
}

fn safe(nums: Vec<i32>) -> bool {
    let ascending : bool = nums[0] < nums[1];
    let good_range = if ascending { 1..=3 } else { -3..=-1 };

    let mut nums_iter = nums.iter();
    let mut left = nums_iter.next().unwrap();

    // iter -> all / any / take_while
    for right in nums_iter {
        //println!("{right} {left}");
        if !good_range.contains(&(right - left)) {
            return false;
        }
        left = right; // copy?
    }
    true
}

fn is_safer(line: &str) -> bool {
    // next_chunk and array_next_chunk are experimental.
    // going pair-wise manually for the lack of patience

    let nums = num_from_line(line);
    safe(nums)
}

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let r: Vec<bool> = input.lines().map(is_safer).collect();
    let cnt = r.iter().filter(|b| **b).count();
    println!("one:");
    println!("{:?}", cnt);

    let r: Vec<bool> = input.lines().map(is_safe).collect();
    let cnt = r.iter().filter(|b| **b).count();
    println!("two:");
    println!("{:?}", cnt);
}
