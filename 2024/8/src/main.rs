use std::collections::HashMap;
use std::env;
use itertools::Itertools;
use std::fs;

fn debug_map(map: &Vec<Vec<Vec<char>>>) {
    for row in map.iter() {
        for col in row.iter() {
            if col.is_empty() {
                print!(".");
            }
            else {
                print!("{}", col.iter().count());//next().unwrap_or(&'?'));
            }
        }
        println!();
    }
}

/// LEARN "documentation tests"
/// `rustdoc --test src/main.rs`
/// # Examples
/// ```rust
/// let r = 1;
/// assert_eq!(r, 3); // (will fail)
/// ```
fn solve(input: &str) -> (i32, i32) {
    let mut frequency_emitter_locations = HashMap::<char, Vec<(i32,i32)>>::new();

    for (y, line) in input.lines().enumerate() {
        for (x, chr) in line.chars().enumerate() {
            if chr != '.' {
                frequency_emitter_locations
                    .entry(chr)
                    .or_insert_with(|| Vec::new())
                    .push((x as i32,y as i32));
            }
        }
    }

    let height = input.lines().count() as i32;
    let width = input.lines().next().unwrap_or("").len() as i32;

    // by index
    let width_range = 0..width;
    let height_range = 0..height;

    let mut antinodes1 : Vec<Vec<Vec<char>>> = vec![vec![vec![]; width as usize]; height as usize];
    let mut antinodes2 : Vec<Vec<Vec<char>>> = vec![vec![vec![]; width as usize]; height as usize];

    for (frqncy, positions) in frequency_emitter_locations.iter() {
        // for each combination in positions
        for two_emitters in positions.iter().permutations(2) {
            let (x1,y1) = two_emitters[0];
            let (x2,y2) = two_emitters[1];

            antinodes2[*y1 as usize][*x1 as usize].push(*frqncy);

            let vector = ((x2 - x1), (y2 - y1));
            let mut cursor = (two_emitters[0].0 - vector.0, two_emitters[0].1 - vector.1);
            while width_range.contains(&cursor.0) && height_range.contains(&cursor.1) {
                antinodes2[cursor.1 as usize][cursor.0 as usize].push(*frqncy);
                cursor.0 -= vector.0;
                cursor.1 -= vector.1;
            }

            // I suspect that there is a possibility of a third and fourth point in between is
            // actually not included in the example on purpose. Or does it need to be outside?
            let antinode = (two_emitters[0].0 - vector.0, two_emitters[0].1 - vector.1);
            if width_range.contains(&antinode.0) && height_range.contains(&antinode.1) {
                antinodes1[antinode.1 as usize][antinode.0 as usize].push(*frqncy);
            }
        }
    }

    debug_map(&antinodes2);

    let solution1 = antinodes1
        .iter()
        .map(|row| row.iter().filter(|col| col.iter().len() > 0 ).count() as i32)
        .sum::<i32>()
        ;
        //.map(|row| row.iter().map(|col| col.iter().len()).sum::<usize>())
        //.sum::<usize>() as i32

    let solution2 = antinodes2
        .iter()
        .map(|row| row.iter().filter(|col| col.iter().len() > 0 ).count() as i32)
        .sum::<i32>()
        ;


    (solution1, solution2)
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
    use indoc::indoc;

    #[test]
    fn it_works() {
        let sample = indoc! {
            "............
            ........0...
            .....0......
            .......0....
            ....0.......
            ......A.....
            ............
            ............
            ........A...
            .........A..
            ............
            ............"
        };

        assert_eq!(solve(sample), (14, 34));
    }
}
