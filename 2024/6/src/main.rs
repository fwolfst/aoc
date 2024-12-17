use std::env;
use std::fs;
use std::process::exit;

static ORIENTATIONS : [(i32, i32); 4] = [ ( 0,-1), // NORTH
                        ( 1, 0),  // EAST
                        ( 0, 1),  // SOUTH
                        (-1, 0),  // WEST
    ];

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
        let oridx = ORIENTATIONS.iter().position(|o| o == &self.orientation).unwrap();
        if oridx == 3 {
            self.orientation = ORIENTATIONS[0];
        } else {
            self.orientation = ORIENTATIONS[oridx + 1];
        }
    }

    pub fn in_front(&self) -> (i32, i32) {
        (self.pos_x + self.orientation.0, self.pos_y + self.orientation.1)
    }

    // look in front, then either walk forward if possible,
    // turn "right", or vanish (leave bounds of map).
    // return true iff not vanishing
    pub fn act(&mut self) -> bool {
        //println!("  X: {} {} -> {} {}", self.pos_x, self.pos_y, self.orientation.0, self.orientation.1);
        let a_step_ahead = self.in_front();

        if a_step_ahead.0 < 0 || a_step_ahead.1 < 0  ||
            a_step_ahead.1 == self.world.len() as i32 || a_step_ahead.0 == self.world[0].len() as i32 {
            return false;
        }

        if self.world[a_step_ahead.1 as usize][a_step_ahead.0 as usize] == false {
            self.pos_x = a_step_ahead.0;
            self.pos_y = a_step_ahead.1;
            self.places_i_ve_been_to[self.pos_y as usize][self.pos_x as usize] = true;
        } else {
            self.turn();
        }

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
    // true -> occupied
    let map : Vec<Vec<bool>> = input
        .lines()
        .map(|line| { line.chars().map(|c| c == '#').collect() })
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
    let width = map[0].len();
    let empty_map : Vec<Vec<bool>> = vec![vec![false; width]; map.len()]; //Vec::<Vec<bool>>::new()

    let mut guardian = Guardian {
        world: map,
        pos_x: pos_x,
        pos_y: pos_y,
        orientation: (0,-1),
        places_i_ve_been_to: empty_map
    };

    let mut i = 0;
    while guardian.act() {
        i += 1;
        // prevent endless loops
        if i > 80000 {
            println!("looks a bit endless");
            exit(1);
        }
    }

    let mut r: usize = guardian.places_i_ve_been_to.iter().map(|row| row.iter().filter(|visited| *visited == &true).count()).sum();
    r += 1;

    println!("one:");
    println!("{:?}", r);

    r = 0;
    println!("two:");
    println!("{:?}", r);
}
