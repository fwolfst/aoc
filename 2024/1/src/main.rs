use std::fs;

// Learning Rust String API
//
// String#split_whitespace (iter)
// String#lines (iter)
// String#split
// String#matches
//
// parse -> into i32
fn main() {
    let contents = fs::read_to_string("1.input").unwrap();
    //println!("{contents}");

    let mut nums_left: Vec<i32> = Vec::new();
    let mut nums_right: Vec<i32> = Vec::new();

    for line in contents.lines() {
        let mut nums_iter = line.split_whitespace();
        nums_left.push(nums_iter.next().unwrap().parse().unwrap());
        nums_right.push(nums_iter.next().unwrap().parse().unwrap());
    }

    //println!("{:?}", nums_left);
    nums_left.sort();
    nums_right.sort();

    assert!(nums_left.len() == nums_right.len());

    let mut i = 0;
    let mut sum = 0;
    while i < nums_left.len() {
        sum += (nums_left[i] - nums_right[i]).abs();
        i += 1;
    }
    println!("1:");
    println!("{:?}", sum);

    sum = 0;
    for num in nums_left.iter() {
       let count: i32 = nums_right.iter().filter(|&n| n == num).count() as i32;
       sum += num * count;
    }
    println!("2:");
    println!("{:?}", sum);
}
