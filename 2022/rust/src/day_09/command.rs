use std::str::FromStr;

use super::direction::Direction;

pub(crate) struct Command {
    pub(crate) dir: Direction,
    pub(crate) steps: i32,
}

impl FromStr for Command {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (raw_dir, raw_steps) = s
            .split_once(' ')
            .ok_or(format!("Unable to parse command: {s}"))?;

        Ok(Command {
            dir: raw_dir.parse()?,
            steps: raw_steps
                .parse()
                .map_err(|_| format!("Unable to parse steps: {s}"))?,
        })
    }
}
