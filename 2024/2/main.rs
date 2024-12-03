use std::fs;

// Learning Rust iter api
// map_windows
// filter_map
fn is_safe(line: &str) -> bool {
    // next_chunk and array_next_chunk are experimental.
    // going pair-wise manually for the lack of patience

    let nums = line
        .split(' ')
        .map(|n| n.parse::<i32>())
        .collect::<Result<Vec<i32>, _>>()
        .expect("cannot parse line");

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
    return true;
}

fn main() {
    let input = fs::read_to_string("input").unwrap();
    let r: Vec<bool> = input.lines().map(is_safe).collect();
    let cnt = r.iter().filter(|b| **b).count();
    println!("one:");
    println!("{:?}", cnt);
    println!("two:");
}
