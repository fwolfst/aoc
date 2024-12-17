use std::env;
use std::fs;

// LEARN OOPish rust
struct Guardian {
    world: Vec<Vec<bool>>,
    pos_x: i32, // struct Point2D if needed
    pos_y: i32,
    orientation: (i32, i32),
    places_i_ve_been_to: Vec<Vec<bool>>
}

impl Guardian {
    pub fn turn(&mut self) {
        //self.orientation ... next
    }
    pub fn in_front(self) -> (i32, i32) {
        (self.pos_x + self.orientation.0, self.pos_y + self.orientation.1)
    }
    // look in front, then either walk forward if possible,
    // turn "right", or vanish (leave bounds of map).
    // return true iff not vanishing
    pub fn act(&mut self) -> bool {
        // look in front, walk or turn or vanish
        true
    }
}

// "cargo run samples.txt"
fn main() {
    let args: Vec<String> = env::args().collect();

    let input_file = if args.len() > 1 {
        args[1].clone()
    } else {
        "input".to_string()
    };

    let input = fs::read_to_string(&input_file).unwrap();

    //   <--  o  --> x
    let map : Vec<Vec<bool>> = input
        .lines()
        .map(|line| { line.chars().map(|c| c != '.').collect() })
        .collect();

    let mut pos_x: i32 = 0;
    let mut pos_y: i32 = 0;

    // LEARN Iterator::position
    for (y, line) in input.lines().enumerate() {
        for (x, chr) in line.chars().enumerate() {
            if chr == '^' {
                pos_x = x as i32;
                pos_y = y as i32;
                break;
            }
        }
    }

    dbg!(&map);

    let mut guardian = Guardian {
        world: map,
        pos_x: pos_x,
        pos_y: pos_y,
        orientation: (0,-1),
        places_i_ve_been_to: Vec::<Vec<bool>>::new()
    };

    // while(guardian.act()) {
    //    // Nothing to do here. Count sheep?
    // }

    let mut r: usize = guardian.places_i_ve_been_to.iter().map(|row| row.iter().filter(|visited| *visited == &true).count()).sum();

    println!("one:");
    println!("{:?}", r);

    println!("two:");
    println!("{:?}", r);
}
