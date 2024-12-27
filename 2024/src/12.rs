use std::env;
use std::fs;

fn parse(input: &str) -> Vec<Vec<char>> {
    input
        .lines()
        .map(|line| line.chars().map(|c| c).collect())
        .collect()
}

#[derive(Debug)]
struct Field {
    perimeter: usize,
    field_type: char,
    points: Vec<(i32,i32)>,
}

impl Field {
    fn score(&self) -> usize {
        self.perimeter * self.points.len()
    }
}

#[derive(Debug)]
struct Point {
    x: i32,
    y: i32,
}

fn in_bounds(x: i32, y: i32, world: &Vec<Vec<char>>) -> bool {
    x >= 0 && y >= 0 && y < world.len() as i32 && x < world[0].len() as i32
}

fn grow_field(point: Point, field: &mut Field, world: &Vec<Vec<char>>, visited_map: &mut Vec<Vec<bool>>) {
    if world[point.y as usize][point.x as usize] == field.field_type {
        visited_map[point.y as usize][point.x as usize] = true;
        field.points.push((point.x, point.y));
    }

    let neighbours : Vec<_> = [(0,1), (0,-1), (1,0), (-1,0)]
        .iter()
        .map(|(dx,dy)| (point.x + dx, point.y + dy))
        .collect();
    // IMPROVE filter those not yet part of the field

    for (px, py) in neighbours.iter() {
        if !in_bounds(*px, *py, world) {
            field.perimeter += 1;
        }
        else if world[*py as usize][*px as usize] != field.field_type {
            field.perimeter += 1;
        } else if field.points.contains(&(*px,*py)){
            // nothing
        } else {
            grow_field(Point { x: *px, y: *py }, field, world, visited_map);
        }
    }
}

fn solve(input: &str) -> (usize, usize) {
    let world = parse(input);

    let width = world[0].len();
    let height = world.len();

    let mut visited_map : Vec<Vec<bool>> = vec![vec![false; width]; height];
    
    let mut fields : Vec<Field> = vec![];
    for y in 0..height {
        for x in 0..width {
            if !visited_map[y][x] {
                let point = Point {
                    x: x as i32,
                    y: y as i32,
                };
                let mut field = Field {
                    perimeter: 0,
                    field_type: world[y][x],
                    points: vec![],
                };
                grow_field(point, &mut field, &world, &mut visited_map);
                fields.push(field);
            }
        }
    }

    dbg!(&fields);

    let r1 = fields.iter().map(|f| f.score()).sum();
    let mut r2 = 0;

    (r1, r2)
}

fn main() {
    let args: Vec<String> = env::args().collect();

    let input_file = if args.len() > 2 {
        args[2].clone()
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
    fn solves_correctly() {
        let sample = indoc! {
            "AAAA
             BBCD
             BBCC
             EEEC"
        };

        assert_eq!(solve(sample).0, 140);
    }
}
