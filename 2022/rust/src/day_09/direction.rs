use std::str::FromStr;

pub(crate) enum Direction {
    Right,
    Left,
    Up,
    Down,
}

impl FromStr for Direction {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        match s {
            "R" => Ok(Direction::Right),
            "L" => Ok(Direction::Left),
            "U" => Ok(Direction::Up),
            "D" => Ok(Direction::Down),
            _ => Err(format!("Unable to parse direction: {s}")),
        }
    }
}
