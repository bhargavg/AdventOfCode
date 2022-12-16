mod crate_mover;
use crate_mover::CrateMover;

mod move_instruction;

pub(crate) fn part1(input: &str) -> String {
    let mut mover = input.parse::<CrateMover>().unwrap();
    mover.run_move_one_by_one();
    mover.get_stack_top_entries().collect()
}

pub(crate) fn part2(input: &str) -> String {
    let mut mover = input.parse::<CrateMover>().unwrap();
    mover.run_move_all_at_once();
    mover.get_stack_top_entries().collect()
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
        assert_eq!(part1(INPUT), "CMZ");
    }

    #[test]
    fn test_part2_example() {
        assert_eq!(part2(INPUT), "MCD");
    }
}
