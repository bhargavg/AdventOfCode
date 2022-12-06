use std::str::FromStr;

use super::crate_mover::CrateMover;
use advent_of_code::Solution;

pub struct Day05 {}

impl Day05 {
    pub fn new() -> Self {
        Self {}
    }
}

impl Solution for Day05 {
    fn problem_number(&self) -> i32 {
        5
    }

    fn part1(&self, input: &str) -> String {
        let mut mover = CrateMover::from_str(input).unwrap();
        mover.run_move_one_by_one();
        mover.get_stack_top_entries().collect()
    }

    fn part2(&self, input: &str) -> String {
        let mut mover = CrateMover::from_str(input).unwrap();
        mover.run_move_all_at_once();
        mover.get_stack_top_entries().collect()
    }
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
    fn test_part1_example() {
        let day05 = Day05::new();
        assert_eq!(day05.part1(INPUT), "CMZ");
    }

    #[test]
    fn test_part2_example() {
        let day05 = Day05::new();
        assert_eq!(day05.part2(INPUT), "MCD");
    }
}
