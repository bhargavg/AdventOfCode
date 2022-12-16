use std::{num::ParseIntError, str::FromStr};

use itertools::Itertools;

#[derive(Debug, PartialEq)]
pub(crate) struct MoveInstruction {
    pub(crate) move_items_count: usize,
    pub(crate) from_stack_idx: usize,
    pub(crate) to_stack_idx: usize,
}

impl FromStr for MoveInstruction {
    type Err = ParseIntError;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let components = s
            .split_whitespace()
            .skip(1)
            .step_by(2)
            .collect_tuple::<(&str, &str, &str)>()
            .unwrap();

        Ok(MoveInstruction {
            move_items_count: components.0.parse::<usize>()?,
            from_stack_idx: components.1.parse::<usize>()? - 1,
            to_stack_idx: components.2.parse::<usize>()? - 1,
        })
    }
}
