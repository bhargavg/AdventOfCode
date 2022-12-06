use std::cmp::Ordering;

use super::shape::Shape;

#[derive(Debug)]
pub enum Outcome {
    Win,
    Loose,
    Draw,
}

impl Outcome {
    pub fn from(char: &str) -> Outcome {
        match char {
            "X" => Outcome::Loose,
            "Y" => Outcome::Draw,
            "Z" => Outcome::Win,
            _ => panic!("Unable to parse Outcome: {}", char),
        }
    }

    pub fn from_play(player1: &Shape, player2: &Shape) -> Outcome {
        match player1.cmp(player2) {
            Ordering::Greater => Outcome::Win,
            Ordering::Equal => Outcome::Draw,
            Ordering::Less => Outcome::Loose,
        }
    }
}
