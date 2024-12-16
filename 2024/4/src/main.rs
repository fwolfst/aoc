use std::env;
use std::fs;

// unused
fn is_xmas() -> bool {
    return false;
}

// Checks if xmas can occur in direction (in bounds)
fn in_bounds(x: i32, y: i32, dir: (i32, i32), width: i32, height: i32) -> bool {
    return (0..width).contains(&(x + dir.0 * 3)) && (0..height).contains(&(y + dir.1 * 3));
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

    let values: Vec<Vec<char>> = input.lines().map(|l| l.chars().collect()).collect::<Vec<Vec<char>>>();

    let width = values.len();
    let height = values[0].len();

    //    -1
    // -1  x  +1
    //    +1
    let directions = [
        [ 1, 0],  // EAST,
        [ 1, 1],  // SOUTH-EAST
        [ 0, 1],  // SOUTH
        [-1, 1],  // SOUTH-WEST
        [-1, 0],  // WEST
        [-1,-1],  // NORTH-WEST
        [ 0,-1],  // NORTH
        [ 1,-1],  // NORTH-EAST
    ];

    // good ideas need to be written down.
    let xmas = ['X', 'M', 'A', 'S'];
    let mut r = 0;

    // list comprehension anyone?
    for (x, row) in values.iter().enumerate() {
        for (y, value) in row.iter().enumerate() {
           if value == &'X' {
               //dbg!(x, y, value);
               for dir in directions {
                    // this is certainly exactly how you should program in Rust
                    if in_bounds(x.try_into().unwrap(), y.try_into().unwrap(), dir.into(), width.try_into().unwrap(), height.try_into().unwrap()) {
                        if values[(x as i32 + dir[0] * 1) as usize][(y as i32 + dir[1] * 1) as usize] == 'M' &&
                            // and this how you'd solve the puzzle
                            values[(x as i32 + dir[0] * 2) as usize][(y as i32 + dir[1] * 2) as usize] == 'A' &&
                                values[(x as i32 + dir[0] * 3) as usize][(y as i32 + dir[1] * 3) as usize] == 'S' {
                            r += 1;
                        }
                    }
               }
           }
        }
    }

    println!("one:");
    println!("{:?}", r);

    // OMG this feels so wrong
    r = 0;
    for x in (1..width - 1) {
        for y in (1..height - 1) {
            if values[y][x] == 'A' {
                if (values[y-1][x-1] == 'S' && values[y+1][x+1] == 'M')
                    || (values[y-1][x-1] == 'M' && values[y+1][x+1] == 'S') {
                    if (values[y-1][x+1] == 'S' && values[y+1][x-1] == 'M')
                        || (values[y-1][x+1] == 'M' && values[y+1][x-1] == 'S') {
                            r += 1;
                    }

                }
            }
        }
    }
    println!("two:");
    println!("{:?}", r);
}
