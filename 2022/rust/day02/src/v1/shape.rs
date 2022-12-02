use std::cmp::Ordering;

#[derive(Debug, Eq, Clone, Copy)]
pub enum Shape {
    Rock,
    Paper,
    Scissors,
}

impl Shape {
    pub fn from(char: &str) -> Shape {
        match char {
            "A" | "X" => Shape::Rock,
            "B" | "Y" => Shape::Paper,
            "C" | "Z" => Shape::Scissors,
            _ => panic!("Unable to parse Shape: {}", char),
        }
    }
}

impl Ord for Shape {
    fn cmp(&self, other: &Self) -> Ordering {
        match (self, other) {
            (Shape::Rock, Shape::Scissors)
            | (Shape::Scissors, Shape::Paper)
            | (Shape::Paper, Shape::Rock) => Ordering::Greater,
            _ => {
                if self.eq(other) {
                    Ordering::Equal
                } else {
                    Ordering::Less
                }
            }
        }
    }
}

impl PartialOrd for Shape {
    fn partial_cmp(&self, other: &Self) -> Option<Ordering> {
        Some(self.cmp(other))
    }
}

impl PartialEq for Shape {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (Shape::Rock, Shape::Rock)
            | (Shape::Paper, Shape::Paper)
            | (Shape::Scissors, Shape::Scissors) => true,
            _ => false,
        }
    }
}
