use std::{cmp, collections::HashSet};

use self::{command::Command, position::Position};

mod command;
mod direction;
mod position;

pub(crate) fn part1(input: &str) -> String {
    let mut head = Position::default();
    let mut tail = Position::default();

    let mut visited = HashSet::<Position>::new();
    visited.insert(tail);

    for command in parse(input) {
        for _ in 0..command.steps {
            head.move_in_direction(&command.dir);

            if compute_distance(&tail, &head) > 1 {
                let delta = compute_tail_move(&tail, &head);
                tail.x += delta.x;
                tail.y += delta.y;

                visited.insert(tail);
            }
        }
    }

    visited.len().to_string()
}

pub(crate) fn part2(input: &str) -> String {
    const NUM_TAILS: usize = 9;

    let mut knots = vec![Position::default(); NUM_TAILS + 1];
    let mut visited = HashSet::<Position>::new();
    visited.insert(knots[NUM_TAILS]);

    for command in parse(input) {
        for _ in 0..command.steps {
            knots[0].move_in_direction(&command.dir);

            for idx in 1..=NUM_TAILS {
                if compute_distance(&knots[idx], &knots[idx - 1]) > 1 {
                    let delta = compute_tail_move(&knots[idx], &knots[idx - 1]);
                    knots[idx].x += delta.x;
                    knots[idx].y += delta.y;
                }
            }

            visited.insert(knots[NUM_TAILS]);
        }
    }

    visited.len().to_string()
}

fn parse(input: &str) -> Vec<Command> {
    input.lines().filter_map(|line| line.parse().ok()).collect()
}

fn compute_distance(from: &Position, to: &Position) -> i32 {
    let delta_x = (to.x - from.x).abs() as i32;
    let delta_y = (to.y - from.y).abs() as i32;

    cmp::max(delta_x, delta_y)
}

fn compute_tail_move(from: &Position, to: &Position) -> Position {
    let mut delta_x = to.x - from.x;
    let mut delta_y = to.y - from.y;

    if delta_x.abs() <= 2 && delta_y.abs() <= 2 {
        delta_x = delta_x.clamp(-1, 1);
        delta_y = delta_y.clamp(-1, 1);
    } else if delta_x.abs() == 2 && delta_y == 0 {
        delta_x = delta_x.clamp(-1, 1);
    } else if delta_x == 0 && delta_y.abs() == 2 {
        delta_y = delta_y.clamp(-1, 1);
    }

    Position {
        x: delta_x,
        y: delta_y,
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_part_1_example() {
        let input = "R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2";
        assert_eq!(part1(input), "13");
    }

    #[test]
    fn test_part_2_example() {
        let input = "R 5
U 8
L 8
D 3
R 17
D 10
L 25
U 20";
        assert_eq!(part2(input), "36");
    }
}
