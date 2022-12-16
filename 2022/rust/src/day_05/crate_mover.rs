use std::str::FromStr;

use super::move_instruction::MoveInstruction;

pub(crate) struct CrateMover {
    stacks: Vec<Vec<char>>,
    instructions: Vec<MoveInstruction>,
}

impl FromStr for CrateMover {
    type Err = String;

    fn from_str(s: &str) -> Result<Self, Self::Err> {
        let (raw_stacks, raw_instructions) = s.split_once("\n\n").unwrap();
        let stacks = parse_stacks(raw_stacks);
        let instructions = parse_move_instruction(raw_instructions);

        Ok(CrateMover {
            stacks,
            instructions,
        })
    }
}

impl CrateMover {
    pub fn get_stack_top_entries(&self) -> impl Iterator<Item = &char> {
        self.stacks.iter().filter_map(|stack| stack.last())
    }

    pub fn run_move_one_by_one(&mut self) {
        for instruction in &self.instructions {
            let idx = self.stacks[instruction.from_stack_idx].len() - instruction.move_items_count;
            let from_stack = self.stacks[instruction.from_stack_idx]
                .drain(idx..)
                .rev()
                .collect::<Vec<char>>();
            self.stacks[instruction.to_stack_idx].extend(from_stack);
        }
    }

    pub fn run_move_all_at_once(&mut self) {
        for instruction in &self.instructions {
            let idx = self.stacks[instruction.from_stack_idx].len() - instruction.move_items_count;
            let from_stack = self.stacks[instruction.from_stack_idx]
                .drain(idx..)
                .collect::<Vec<char>>();
            self.stacks[instruction.to_stack_idx].extend(from_stack);
        }
    }
}

fn parse_stacks(input: &str) -> Vec<Vec<char>> {
    let mut iter = input.lines().rev();

    let stacks_count = parse_stacks_count(iter.next().unwrap());

    let mut stacks = vec![Vec::<char>::new(); stacks_count];

    for raw_line in iter {
        for (idx, &char) in parse_stack_entries(raw_line).iter().enumerate() {
            if char.is_alphanumeric() {
                stacks[idx].push(char);
            }
        }
    }

    stacks
}

fn parse_stacks_count(indices_line: &str) -> usize {
    indices_line
        .split_whitespace()
        .last()
        .unwrap()
        .parse()
        .unwrap()
}

fn parse_stack_entries(stack_line: &str) -> Vec<char> {
    stack_line
        .chars()
        .collect::<Vec<_>>()
        .chunks(4)
        .map(|chunk| chunk.get(1).unwrap().to_owned())
        .collect()
}

fn parse_move_instruction(input: &str) -> Vec<MoveInstruction> {
    input
        .lines()
        .filter_map(|line| MoveInstruction::from_str(line).ok())
        .collect()
}

#[cfg(test)]
mod tests {
    use super::*;

    const INPUT: &str = r"    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2
";

    #[test]
    fn test_parsing() {
        let mover = CrateMover::from_str(INPUT);

        assert!(mover.is_ok(), "Unable to create CrateMover");

        let mover = mover.unwrap();

        let expected_stacks: Vec<Vec<char>> = vec![
            String::from("ZN").chars().collect(),
            String::from("MCD").chars().collect(),
            String::from("P").chars().collect(),
        ];

        assert_eq!(mover.stacks, expected_stacks);

        let expected_instructions = vec![
            MoveInstruction {
                move_items_count: 1,
                from_stack_idx: 1,
                to_stack_idx: 0,
            },
            MoveInstruction {
                move_items_count: 3,
                from_stack_idx: 0,
                to_stack_idx: 2,
            },
            MoveInstruction {
                move_items_count: 2,
                from_stack_idx: 1,
                to_stack_idx: 0,
            },
            MoveInstruction {
                move_items_count: 1,
                from_stack_idx: 0,
                to_stack_idx: 1,
            },
        ];
        assert_eq!(mover.instructions, expected_instructions);
    }
}
